require("skill_damage_effect_param")
_class("SkillEffectMarchForwardParam", SkillEffectParamBase)
SkillEffectMarchForwardParam = SkillEffectMarchForwardParam

function SkillEffectMarchForwardParam:Constructor(t)
  self._step = t.step or 0
  self._dir = Vector2(0, 1)
  if t.dir then
    self._dir = Vector2(t.dir[1], t.dir[2])
  end
  self._maxStep = t.maxStep or 0
  self._marchBuffValueKey = t.marchBuffValueKey or "MarchStep"
  self._destroyTrapBlockIDs = t.destroyTrapBlockIDs or {}
end

function SkillEffectMarchForwardParam:GetEffectType()
  return SkillEffectType.MarchForward
end

function SkillEffectMarchForwardParam:GetDir()
  return self._dir
end

function SkillEffectMarchForwardParam:GetStep()
  return self._step
end

function SkillEffectMarchForwardParam:GetMaxMarchStep()
  return self._maxStep
end

function SkillEffectMarchForwardParam:GetMarchBuffValueKey()
  return self._marchBuffValueKey
end

function SkillEffectMarchForwardParam:GetDestroyTrapBlockIDs()
  return self._destroyTrapBlockIDs
end
