require("skill_effect_result_base")
_class("SkillEffectResultSacrificeTraps", SkillEffectResultBase)
SkillEffectResultSacrificeTraps = SkillEffectResultSacrificeTraps

function SkillEffectResultSacrificeTraps:GetEffectType()
  return SkillEffectType.SacrificeTraps
end

function SkillEffectResultSacrificeTraps:Constructor(trapIDs)
  self._trapIDs = trapIDs
end

function SkillEffectResultSacrificeTraps:GetTrapIDs()
  return self._trapIDs
end
