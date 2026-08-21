require("skill_phase_param_base")
_class("SkillPhaseWaveGridArrayParam", SkillPhaseParamBase)
SkillPhaseWaveGridArrayParam = SkillPhaseWaveGridArrayParam

function SkillPhaseWaveGridArrayParam:Constructor(t)
  self._gridEffectID = t.gridEffectID
  self._columnInternalTime = t.columnInternalTime
  self._hitAnimName = t.hitAnimName
  self._hitEffectID = t.hitEffectID
  self._gridEffectWaitTime = t.gridEffectWaitTime
  self._hitWaitTime = t.hitWaitTime
end

function SkillPhaseWaveGridArrayParam:GetCacheTable()
  local t = {}
  if self._gridEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._gridEffectID].ResPath,
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

function SkillPhaseWaveGridArrayParam:GetPhaseType()
  return SkillViewPhaseType.WaveGridArray
end

function SkillPhaseWaveGridArrayParam:GetGridEffectID()
  return self._gridEffectID
end

function SkillPhaseWaveGridArrayParam:GetColumnInternalTime()
  return self._columnInternalTime
end

function SkillPhaseWaveGridArrayParam:GetHitAnimName()
  return self._hitAnimName
end

function SkillPhaseWaveGridArrayParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseWaveGridArrayParam:GetGridWaitEffectTime()
  return self._gridEffectWaitTime
end

function SkillPhaseWaveGridArrayParam:GetHitWaitTime()
  return self._hitWaitTime
end
