require("skill_phase_param_base")
_class("SkillPhaseWaveGridTransformParam", SkillPhaseParamBase)
SkillPhaseWaveGridTransformParam = SkillPhaseWaveGridTransformParam

function SkillPhaseWaveGridTransformParam:Constructor(t)
  self._crossGridEffectID = t.crossGridEffectID
  self._otherGridEffectID = t.otherGridEffectID
  self._columnInternalTime = t.columnInternalTime
  self._hitAnimName = t.hitAnimName
  self._hitEffectID = t.hitEffectID
  self._gridEffectWaitTime = t.gridEffectWaitTime
  self._hitWaitTime = t.hitWaitTime
  self._effDefaultScale = t.effDefaultScale
  self._effLayerScale = t.effLayerScale
end

function SkillPhaseWaveGridTransformParam:GetCacheTable()
  local t = {}
  if self._crossGridEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._crossGridEffectID].ResPath,
      1
    })
  end
  if 0 < self._otherGridEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._otherGridEffectID].ResPath,
      1
    })
  end
  if 0 < self._hitEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    })
  end
  return t
end

function SkillPhaseWaveGridTransformParam:GetPhaseType()
  return SkillViewPhaseType.WaveGridTransform
end

function SkillPhaseWaveGridTransformParam:GetCrossGridEffectID()
  return self._crossGridEffectID
end

function SkillPhaseWaveGridTransformParam:GetOtherGridEffectID()
  return self._otherGridEffectID
end

function SkillPhaseWaveGridTransformParam:GetColumnInternalTime()
  return self._columnInternalTime
end

function SkillPhaseWaveGridTransformParam:GetHitAnimName()
  return self._hitAnimName
end

function SkillPhaseWaveGridTransformParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseWaveGridTransformParam:GetGridWaitEffectTime()
  return self._gridEffectWaitTime
end

function SkillPhaseWaveGridTransformParam:GetHitWaitTime()
  return self._hitWaitTime
end

function SkillPhaseWaveGridTransformParam:GetEffDefaultScale()
  return self._effDefaultScale
end

function SkillPhaseWaveGridTransformParam:GetEffLayerScale()
  return self._effLayerScale
end
