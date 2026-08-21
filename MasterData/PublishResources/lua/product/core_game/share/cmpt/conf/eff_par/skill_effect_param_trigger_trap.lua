require("skill_effect_param_base")
_class("SkillEffectParamTriggerTrap", SkillEffectParamBase)
SkillEffectParamTriggerTrap = SkillEffectParamTriggerTrap

function SkillEffectParamTriggerTrap:Constructor(t)
  self._trapID = {}
  if t.trapID then
    for _, id in ipairs(t.trapID) do
      self._trapID[id] = true
    end
  end
  self._trapType = t.trapType
  self._triggerType = t.triggerType or SkillEffectTriggerTrapType.Range
end

function SkillEffectParamTriggerTrap:GetEffectType()
  return SkillEffectType.TriggerTrap
end

function SkillEffectParamTriggerTrap:GetTrapID()
  return self._trapID
end

function SkillEffectParamTriggerTrap:IsTriggerTrap(trapID, trapType)
  return self._trapID[trapID] or trapType == self._trapType
end

function SkillEffectParamTriggerTrap:GetTriggerType()
  return self._triggerType
end

local SkillEffectTriggerTrapType = {
  Self = 1,
  Range = 2,
  ChainPath = 3
}
_enum("SkillEffectTriggerTrapType", SkillEffectTriggerTrapType)
