_class("PlayKillTargetsInstruction", BaseInstruction)
PlayKillTargetsInstruction = PlayKillTargetsInstruction

function PlayKillTargetsInstruction:Constructor(paramList)
end

function PlayKillTargetsInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local resultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultList = resultContainer:GetEffectResultsAsArray(SkillEffectType.KillTargets)
  local deadTaskArray = {}
  local monsterShowR = self._world:GetService("MonsterShowRender")
  if resultList then
    for i, result in ipairs(resultList) do
      local deadTargetIDs = result:GetTargetList()
      for _, id in ipairs(deadTargetIDs) do
        local e = self._world:GetEntityByID(id)
        local curDeadTaskID = TaskManager:GetInstance():CoreGameStartTask(monsterShowR._DoOneMonsterDead, monsterShowR, e)
        deadTaskArray[#deadTaskArray + 1] = curDeadTaskID
      end
    end
  end
end
