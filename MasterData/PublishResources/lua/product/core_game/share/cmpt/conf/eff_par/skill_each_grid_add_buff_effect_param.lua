require("skill_effect_param_base")
_class("SkillEffectParamEachGridAddBuff", SkillAddBuffEffectParam)
SkillEffectParamEachGridAddBuff = SkillEffectParamEachGridAddBuff

function SkillEffectParamEachGridAddBuff:Constructor(t)
  self._pieceTypes = t.pieceType
end

function SkillEffectParamEachGridAddBuff:GetPieceTypes()
  return self._pieceTypes
end

function SkillEffectParamEachGridAddBuff:GetEffectType()
  return SkillEffectType.EachGridAddBuff
end
