require("skill_effect_param_base")
_class("SkillEffectParamDamageBySelectPieceCount", SkillEffectParamBase)
SkillEffectParamDamageBySelectPieceCount = SkillEffectParamDamageBySelectPieceCount

function SkillEffectParamDamageBySelectPieceCount:Constructor(t)
  self._percent = t.percent
  self._formulaID = t.formulaID
  self._baseValue = t.baseValue or self._percent
  self._changeValue = t.changeValue or 0
  self._pieceTypeList = t.pieceTypeList or {}
end

function SkillEffectParamDamageBySelectPieceCount:GetEffectType()
  return SkillEffectType.DamageBySelectPieceCount
end

function SkillEffectParamDamageBySelectPieceCount:GetDamageFormulaID()
  return self._formulaID
end

function SkillEffectParamDamageBySelectPieceCount:GetDamagePercent()
  return self._percent
end

function SkillEffectParamDamageBySelectPieceCount:GetBaseValue()
  return self._baseValue
end

function SkillEffectParamDamageBySelectPieceCount:GetChangeValue()
  return self._changeValue
end

function SkillEffectParamDamageBySelectPieceCount:GetPieceTypeList()
  return self._pieceTypeList
end
