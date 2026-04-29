require("skill_effect_param_base")
_class("SkillEffectParamColorPaletteCharge", SkillEffectParamBase)
SkillEffectParamColorPaletteCharge = SkillEffectParamColorPaletteCharge

function SkillEffectParamColorPaletteCharge:Constructor(t)
end

function SkillEffectParamColorPaletteCharge:GetEffectType()
  return SkillEffectType.ColorPaletteCharge
end
