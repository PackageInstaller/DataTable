require("skill_effect_result_base")
_class("SkillEffectResultTriggerTrap", SkillEffectResultBase)
SkillEffectResultTriggerTrap = SkillEffectResultTriggerTrap

function SkillEffectResultTriggerTrap:Constructor(entityID, trapID, pos)
  self._entityID = entityID
  self._trapID = trapID
  self._pos = pos
end

function SkillEffectResultTriggerTrap:GetEffectType()
  return SkillEffectType.TriggerTrap
end

function SkillEffectResultTriggerTrap:GetEntityID()
  return self._entityID
end

function SkillEffectResultTriggerTrap:GetTrapID()
  return self._trapID
end

function SkillEffectResultTriggerTrap:GetPos()
  return self._pos
end
