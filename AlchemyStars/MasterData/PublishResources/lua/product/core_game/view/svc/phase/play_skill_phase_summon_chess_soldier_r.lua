require("play_skill_phase_base_r")
_class("PlaySkillPhaseSummonChessSoldier", PlaySkillPhaseBase)
PlaySkillPhaseSummonChessSoldier = PlaySkillPhaseSummonChessSoldier

function PlaySkillPhaseSummonChessSoldier:Constructor()
end

function PlaySkillPhaseSummonChessSoldier:PlayFlight(TT, casterEntity, phaseParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultSummonArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonEverything)
  local sPlaySkillInstruction = self._world:GetService("PlaySkillInstruction")
  if nil == resultSummonArray then
    Log.debug("[Phase_Summon] 召唤失败：没有召唤结果数值（可能不需要）")
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local sEffect = world:GetService("Effect")
  local nSkillID = skillEffectResultContainer:GetSkillID()
  local listWaitTask = {}
  local posOffset = Vector2(1, 0)
  local posSummon, posBirth
  for i = 1, #resultSummonArray do
    local resultSummon = resultSummonArray[i]
    posSummon = resultSummon:GetSummonPos()
    posBirth = posSummon.x > 5 and posSummon - posOffset or posSummon + posOffset
    resultSummon:SetSummonPos(posBirth)
    local effectEntity = sEffect:CreateWorldPositionEffect(phaseParam:GetBirthEffectID(), posBirth)
    local nTaskID = GameGlobal.TaskManager():CoreGameStartTask(sPlaySkillInstruction.ShowSummonAction, sPlaySkillInstruction, self._world, resultSummon)
    table.insert(listWaitTask, nTaskID)
  end
  self:_WaitSonTask(listWaitTask)
  local summonEntity
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
    local monsterRenderPos = monsterEntity:GetRenderGridPosition()
    if monsterRenderPos == posBirth then
      summonEntity = monsterEntity
      break
    end
  end
  if not summonEntity then
    return
  end
  summonEntity:SetDirection(Vector2(0, -1))
  YIELD(TT, phaseParam:GetTurnWaitTime())
  local dir = posSummon - posBirth
  summonEntity:SetDirection(dir)
  YIELD(TT)
  local distance = Vector2.Distance(posSummon, posBirth)
  local speed = 6
  while summonEntity:HasGridMove() do
    local gridMoveComponent = summonEntity:GridMove()
    YIELD(TT)
  end
  summonEntity:SetAnimatorControllerTriggers({"Move"})
  local boardServiceRender = world:GetService("BoardRender")
  local gridPos = boardServiceRender:GetRealEntityGridPos(summonEntity)
  summonEntity:AddGridMove(speed, posSummon, gridPos)
  while summonEntity:HasGridMove() do
    YIELD(TT)
  end
  YIELD(TT)
  summonEntity:SetDirection(Vector2(0, -1))
end
