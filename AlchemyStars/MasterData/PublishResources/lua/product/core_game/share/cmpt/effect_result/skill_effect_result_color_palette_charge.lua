require("skill_effect_result_base")
_class("SkillEffectResultColorPaletteCharge", SkillEffectResultBase)
SkillEffectResultColorPaletteCharge = SkillEffectResultColorPaletteCharge

function SkillEffectResultColorPaletteCharge:Constructor(pieceType, entityID)
  self._pieceType = pieceType
end

function SkillEffectResultColorPaletteCharge:GetEffectType()
  return SkillEffectType.ColorPaletteCharge
end

function SkillEffectResultColorPaletteCharge:GetPieceType()
  return self._pieceType
end
