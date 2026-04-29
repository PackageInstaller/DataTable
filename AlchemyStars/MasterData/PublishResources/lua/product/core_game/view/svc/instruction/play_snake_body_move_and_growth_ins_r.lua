_class("PlaySnakeBodyMoveAndGrowthInstruction", BaseInstruction)
PlaySnakeBodyMoveAndGrowthInstruction = PlaySnakeBodyMoveAndGrowthInstruction

function PlaySnakeBodyMoveAndGrowthInstruction:Constructor(paramList)
  self._bodyEffectID = tonumber(paramList.bodyEffectID)
end

function PlaySnakeBodyMoveAndGrowthInstruction:GetCacheResource()
  local t = {}
  table.insert(t, {
    Cfg.cfg_effect[self._bodyEffectID].ResPath,
    1
  })
  return t
end

function PlaySnakeBodyMoveAndGrowthInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local playSkillInstructionSvc = self._world:GetService("PlaySkillInstruction")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SnakeBodyMoveAndGrowth)
  if not resultArray then
    return
  end
  local result = resultArray[#resultArray]
  if result:IsCasterDead() then
    local sMonsterShowRender = self._world:GetService("MonsterShowRender")
    sMonsterShowRender:_DoOneMonsterDead(TT, casterEntity)
    return
  end
  local bodyNewPos = result:GetBodyNewPos()
  local bodyOldPos = result:GetBodyOldPos()
  local newBody = result:GetNewBodyArea()
  local oldBody = result:GetOldBodyArea()
  local newBodyPosList = self:GetBodyPosList(newBody, bodyNewPos)
  local oldBodyPosList = self:GetBodyPosList(oldBody, bodyOldPos)
  local bodyEffectList = self:GetBodyEffect(casterEntity)
  local speed = playSkillInstructionSvc:GetMoveSpeed(casterEntity)
  for index, id in ipairs(bodyEffectList) do
    local bodyEffectEntity = self._world:GetEntityByID(id)
    local effectPos = bodyEffectEntity:GetRenderGridPosition()
    local bodyIndex = self:GetBodyIndex(effectPos, oldBodyPosList)
    local newEffectPos = newBodyPosList[bodyIndex]
    local taskID = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      playSkillInstructionSvc:PlayEntityMove(TT, bodyEffectEntity, effectPos, newEffectPos, speed)
      local lastPos
      if index == 1 then
        lastPos = bodyNewPos
      else
        lastPos = newBodyPosList[bodyIndex - 1]
      end
      local dir = lastPos - newEffectPos
      bodyEffectEntity:SetDirection(dir)
    end)
  end
  local headNewPos = result:GetHeadNewPos()
  playSkillInstructionSvc:PlayEntityMove(TT, casterEntity, bodyOldPos, bodyNewPos, speed)
  local dir = headNewPos - bodyNewPos
  casterEntity:SetDirection(dir)
  local newBodyPos = result:GetNewBodyPos()
  if newBodyPos then
    local effectSvc = self._world:GetService("Effect")
    local entity = effectSvc:CreateGridEffectWithEffectHolder(self._bodyEffectID, newBodyPos, casterEntity)
    local dir = newBodyPosList[#newBodyPosList - 1] - newBodyPos
    entity:SetDirection(dir)
  end
end

function PlaySnakeBodyMoveAndGrowthInstruction:GetBodyIndex(pos, bodyPosList)
  for i, v in ipairs(bodyPosList) do
    if v.x == pos.x and v.y == pos.y then
      return i
    end
  end
end

function PlaySnakeBodyMoveAndGrowthInstruction:GetBodyEffect(casterEntity)
  local bodyEffectList = {}
  if casterEntity:HasEffectHolder() then
    local effectHolderCmpt = casterEntity:EffectHolder()
    local effectDictList = effectHolderCmpt:GetEffectIDEntityDic()
    for effectID, entityIDList in pairs(effectDictList) do
      if effectID == self._bodyEffectID then
        for i, id in ipairs(entityIDList) do
          table.insert(bodyEffectList, id)
        end
        break
      end
    end
  end
  return bodyEffectList
end

function PlaySnakeBodyMoveAndGrowthInstruction:GetBodyPosList(bodyArea, pos)
  local bodyPosList = {}
  for i, offset in ipairs(bodyArea) do
    local newPos = Vector2(offset.x + pos.x, pos.y + offset.y)
    table.insert(bodyPosList, newPos)
  end
  return bodyPosList
end
