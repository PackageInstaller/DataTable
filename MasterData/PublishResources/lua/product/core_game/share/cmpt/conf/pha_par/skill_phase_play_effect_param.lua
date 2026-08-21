require("skill_phase_param_base")
SkillPlayEffectType = {
  Grid = 0,
  HealthShield = 1,
  CasterTransform = 2
}
_enum("SkillPlayEffectType", SkillPlayEffectType)
_class("SkillPhasePlayEffectParam", SkillPhaseParamBase)
SkillPhasePlayEffectParam = SkillPhasePlayEffectParam

function SkillPhasePlayEffectParam:Constructor(t)
  self._effectID = t.effectID
  self._position = t.position
  self._effectType = t.effectType or SkillPlayEffectType.Grid
  if t.rotation then
    local r = t.rotation
    self._quaternionDir = Quaternion.AngleAxis(r.angle, Vector3(r.axis.x, r.axis.y, r.axis.z))
  end
  if t.translation then
    local tran = t.translation
    self._translationQuaternion = Quaternion.AngleAxis(tran.angle, Vector3(tran.axis.x, tran.axis.y, tran.axis.z))
    self._translationOffset = tran.offset
  end
end

function SkillPhasePlayEffectParam:GetPhaseType()
  return SkillViewPhaseType.PlayEffect
end

function SkillPhasePlayEffectParam:GetEffectID()
  return self._effectID
end

function SkillPhasePlayEffectParam:GetEffectPosition()
  return self._position
end

function SkillPhasePlayEffectParam:GetPlayEffectType()
  return self._effectType
end

function SkillPhasePlayEffectParam:GetQuaternionDir()
  return self._quaternionDir
end

function SkillPhasePlayEffectParam:GetTranslationQuaternion()
  return self._translationQuaternion
end

function SkillPhasePlayEffectParam:GetTranslationOffset()
  return self._translationOffset
end

function SkillPhasePlayEffectParam:GetCacheTable()
  local t = {}
  table.insert(t, {
    Cfg.cfg_effect[self._effectID].ResPath,
    1
  })
  return t
end
