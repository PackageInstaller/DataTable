require("base_ins_r")
_class("PlayDestroyTrapByStageIndexInstruction", BaseInstruction)
PlayDestroyTrapByStageIndexInstruction = PlayDestroyTrapByStageIndexInstruction

function PlayDestroyTrapByStageIndexInstruction:Constructor(paramList)
  self._donotPlayDie = paramList.donotPlayDie
  self._noResult = paramList.noResult
  self._delay = 1
  if paramList.delay ~= nil then
    self._delay = tonumber(paramList.delay)
  end
end

function PlayDestroyTrapByStageIndexInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local eTrap = casterEntity
  if not self._noResult then
    local routineCmpt = casterEntity:SkillRoutine():GetResultContainer()
    if not routineCmpt then
      return
    end
    local stageIndex = phaseContext:GetCurDamageResultStageIndex()
    local resultArray = routineCmpt:GetEffectResultsAsArray(SkillEffectType.DestroyTrap, stageIndex)
    if not resultArray then
      return
    end
    local index = phaseContext:GetCurResultIndexByType(SkillEffectType.DestroyTrap)
    local result = resultArray[index]
    if not result then
      return
    end
    local eID = result:GetEntityID()
    eTrap = world:GetEntityByID(eID)
    if not eTrap then
      return
    end
  end
  local trapServiceRender = world:GetService("TrapRender")
  if self._delay == 1 then
    trapServiceRender:PlayTrapDieSkill(TT, {eTrap}, self._donotPlayDie)
  elseif self._delay == 0 then
    local dieTaskID = TaskManager:GetInstance():CoreGameStartTask(trapServiceRender.PlayTrapDieSkill, trapServiceRender, {eTrap}, self._donotPlayDie)
    phaseContext:AddPhaseTask(dieTaskID)
  end
end
