require("skill_phase_param_base")
_class("SkillPhaseTrainConvertElementParam", SkillPhaseParamBase)
SkillPhaseTrainConvertElementParam = SkillPhaseTrainConvertElementParam

function SkillPhaseTrainConvertElementParam:Constructor(t)
  self._gridEffectID = t.gridEffectID
  self._gridIntervalTime = t.gridIntervalTime
  self._bestConvertTime = t.bestConvertTime
  self._finishDelayTime = t.finishDelayTime
end

function SkillPhaseTrainConvertElementParam:GetCacheTable()
  local t = {}
  if self._gridEffectID and self._gridEffectID > 0 then
    t[#t + 1] = {
      Cfg.cfg_effect[self._gridEffectID].ResPath,
      1
    }
  end
  return t
end

function SkillPhaseTrainConvertElementParam:GetPhaseType()
  return SkillViewPhaseType.TrainConvertElement
end

function SkillPhaseTrainConvertElementParam:GetGridEffectID()
  return self._gridEffectID
end

function SkillPhaseTrainConvertElementParam:GetGridIntervalTime()
  return self._gridIntervalTime
end

function SkillPhaseTrainConvertElementParam:GetBestEffectTime()
  return self._bestEffectTime
end

function SkillPhaseTrainConvertElementParam:GetFinishDelayTime()
  return self._finishDelayTime
end
