require("skill_effect_result_base")
_class("SkillEffectResultRotateToPickup", SkillEffectResultBase)
SkillEffectResultRotateToPickup = SkillEffectResultRotateToPickup
SkillEffectResultRotateToPickup.__EFFECT_TYPE = SkillEffectType.RotateToPickup

function SkillEffectResultRotateToPickup:Constructor(newDir)
  self._newDir = newDir
end

function SkillEffectResultRotateToPickup:GetNewDir()
  return self._newDir
end

function SkillEffectResultRotateToPickup:GetEffectType()
  return SkillEffectType.RotateToPickup
end
