require("skill_phase_param_base")
_class("SkillPhaseSquareRingParam", SkillPhaseParamBase)
SkillPhaseSquareRingParam = SkillPhaseSquareRingParam

function SkillPhaseSquareRingParam:Constructor(t)
  self._gridEffectID = t.gridEffectID
  self._ringInternalTime = t.ringInternalTime
  self._bestEffectTime = t.bestEffectTime
  self._finishDelayTime = t.finishDelayTime
end

function SkillPhaseSquareRingParam:GetCacheTable()
  local t = {
    {
      Cfg.cfg_effect[self._gridEffectID].ResPath,
      1
    }
  }
  return t
end

function SkillPhaseSquareRingParam:GetPhaseType()
  return SkillViewPhaseType.SquareRing
end

function SkillPhaseSquareRingParam:GetGridEffectID()
  return self._gridEffectID
end

function SkillPhaseSquareRingParam:GetRingInternalTime()
  return self._ringInternalTime
end

function SkillPhaseSquareRingParam:GetBestEffectTime()
  return self._bestEffectTime
end

function SkillPhaseSquareRingParam:GetFinishDelayTime()
  return self._finishDelayTime
end
