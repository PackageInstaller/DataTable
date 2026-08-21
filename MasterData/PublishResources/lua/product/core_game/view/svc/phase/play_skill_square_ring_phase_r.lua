require("play_skill_phase_base_r")
_class("PlaySkillSquareRingPhase", PlaySkillPhaseBase)
PlaySkillSquareRingPhase = PlaySkillSquareRingPhase

function PlaySkillSquareRingPhase:PlayFlight(TT, casterEntity, phaseParam)
  local squareRingParam = phaseParam
  local gridEffectID = squareRingParam:GetGridEffectID()
  local bestEffectTime = squareRingParam:GetBestEffectTime()
  local ringInternalTime = squareRingParam:GetRingInternalTime()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local result = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ConvertGridElement)
  local ringGridData = result:GetTargetGridArray()
  local targetGridType = result:GetTargetElementType()
  local playSkillService = self._world:GetService("PlaySkill")
  for circleIndex, gridPosArray in pairs(ringGridData) do
    for _, gridPos in ipairs(gridPosArray) do
      GameGlobal.TaskManager():CoreGameStartTask(self:SkillService()._SingleGridEffect, self:SkillService(), gridEffectID, gridPos, bestEffectTime, targetGridType)
    end
    YIELD(TT, ringInternalTime)
  end
  local finishDelayTime = squareRingParam:GetFinishDelayTime()
  YIELD(TT, finishDelayTime)
end
