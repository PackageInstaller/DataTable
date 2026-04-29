_class("PlayWaveSummonInstruction", BaseInstruction)
PlayWaveSummonInstruction = PlayWaveSummonInstruction

function PlayWaveSummonInstruction:Constructor(paramList)
  self.duration = tonumber(paramList.flyDuration)
  self.destroyTime = tonumber(paramList.destroyTime)
  self.taskWaitTime = tonumber(paramList.taskWaitTime)
  self.eftID = tonumber(paramList.eftID)
  self.eftPosYa = tonumber(paramList.eftPosYa)
  self.eftPosYb = tonumber(paramList.eftPosYb)
  self.monsterID1 = tonumber(paramList.monsterID1)
  self.monsterID2 = tonumber(paramList.monsterID2)
end

function PlayWaveSummonInstruction:GetCacheResource()
  local t = {}
  if self.eftID and self.eftID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.eftID].ResPath,
      1
    })
  end
  return t
end

function PlayWaveSummonInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local summonResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonEverything)
  if not summonResultArray then
    return
  end
  local listWaitTask = {}
  for i = 1, #summonResultArray do
    local resultSummon = summonResultArray[i]
    local taskID = TaskManager:GetInstance():CoreGameStartTask(self._OnSkillResultSummon, self, casterEntity, resultSummon)
    table.insert(listWaitTask, taskID)
  end
end

function PlayWaveSummonInstruction:_OnSkillResultSummon(TT, casterEntity, resultSummon)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local sPlaySkillInstruction = world:GetService("PlaySkillInstruction")
  local boardServiceRender = world:GetService("BoardRender")
  local effectService = world:GetService("Effect")
  local _start = casterEntity:View():GetGameObject().transform.position:Clone()
  _start.y = self.eftPosYa
  local _end
  local eftEntity = effectService:CreatePositionEffect(self.eftID, _start)
  if not eftEntity:HasView() then
    YIELD(TT)
  end
  local eftTansform = eftEntity:View():GetGameObject().transform
  _end = boardServiceRender:GridPos2RenderPos(resultSummon:GetGridPos())
  _end.y = self.eftPosYb
  local disx = math.abs(_end.x - _start.x)
  local disy = math.abs(_end.y - _start.y)
  local power = math.sqrt(disx + disy)
  eftTansform:DOJump(_end, power, 1, self.duration / 1000, false)
  YIELD(TT, self.duration)
  sPlaySkillInstruction:ShowSummonAction(TT, world, resultSummon)
  YIELD(TT, self.destroyTime - self.duration)
  world:DestroyEntity(eftEntity)
end

function PlayWaveSummonInstruction:_OnWaveSummonResult(TT, casterEntity)
  local world = casterEntity:GetOwnerWorld()
  YIELD(TT, self.taskWaitTime)
  YIELD(TT)
  local monsterGroup = world:GetGroup(world.BW_WEMatchers.MonsterID)
  for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
    if not monsterEntity:HasDeadMark() then
      local monsterIDCmpt = monsterEntity:MonsterID()
      local monsterID = monsterIDCmpt:GetMonsterID()
      if monsterID == self.monsterID1 or monsterID == self.monsterID2 then
        local taskID = TaskManager:GetInstance():CoreGameStartTask(self._OnWaveSummonMonster, self, casterEntity, monsterEntity)
      end
    end
  end
end

function PlayWaveSummonInstruction:_OnWaveSummonMonster(TT, casterEntity, monsterEntity)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local sPlaySkillInstruction = world:GetService("PlaySkillInstruction")
  local boardServiceRender = world:GetService("BoardRender")
  local effectService = world:GetService("Effect")
  local _start = casterEntity:View():GetGameObject().transform.position:Clone()
  _start.y = self.eftPosYa
  local _end
  local eftEntity = effectService:CreatePositionEffect(self.eftID, _start)
  if not eftEntity:HasView() then
    YIELD(TT)
  end
  local eftTansform = eftEntity:View():GetGameObject().transform
  _end = boardServiceRender:GridPos2RenderPos(monsterEntity:GridLocation():Center())
  _end.y = self.eftPosYb
  local disx = math.abs(_end.x - _start.x)
  local disy = math.abs(_end.y - _start.y)
  local power = math.sqrt(disx + disy)
  eftTansform:DOJump(_end, power, 1, self.duration / 1000, false)
  YIELD(TT, self.duration + 10)
  world:DestroyEntity(eftEntity)
end
