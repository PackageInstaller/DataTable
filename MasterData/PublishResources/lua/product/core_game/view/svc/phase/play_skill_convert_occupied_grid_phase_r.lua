require("play_skill_phase_base_r")
_class("PlaySkillConvertOccupiedGrid", PlaySkillPhaseBase)
PlaySkillConvertOccupiedGrid = PlaySkillConvertOccupiedGrid

function PlaySkillConvertOccupiedGrid:PlayFlight(TT, casterEntity, phaseParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.ConvertOccupiedGridElement)
  if not resultArray then
    return
  end
  local gridEffectID = phaseParam:GetGridEffectID()
  local bestEffectTime = phaseParam:GetBestEffectTime()
  local taskIds = {}
  for _, result in ipairs(resultArray) do
    local gridPosArray = result:GetTargetGridArray()
    local targetGridType = result:GetTargetElementType()
    for _, gridPos in ipairs(gridPosArray) do
      local id = GameGlobal.TaskManager():CoreGameStartTask(self:SkillService()._SingleGridEffect, self:SkillService(), gridEffectID, gridPos, bestEffectTime, targetGridType)
      taskIds[#taskIds + 1] = id
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIds) do
    YIELD(TT)
  end
end
