require("skill_damage_effect_param")
_class("SkillEffectParam_Escape", SkillEffectParamBase)
SkillEffectParam_Escape = SkillEffectParam_Escape

function SkillEffectParam_Escape:Constructor(t)
  self._escapeType = t.escapeType or 1
  self._escapeParam = t.escapeParam
end

function SkillEffectParam_Escape:GetEffectType()
  return SkillEffectType.Escape
end

function SkillEffectParam_Escape:GetEscapeType()
  return self._escapeType
end

function SkillEffectParam_Escape:GetEscapeParam()
  return self._escapeParam
end

local EscapeType = {
  SkillTarget = 1,
  Chess = 2,
  MAX = 9
}
_enum("EscapeType", EscapeType)
