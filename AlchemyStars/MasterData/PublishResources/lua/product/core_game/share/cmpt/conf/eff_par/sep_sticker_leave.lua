require("skill_effect_param_base")
_class("SkillEffectParam_StickerLeave", SkillEffectParamBase)
SkillEffectParam_StickerLeave = SkillEffectParam_StickerLeave

function SkillEffectParam_StickerLeave:Constructor(t)
  self._convertColor = t.convertColor
end

function SkillEffectParam_StickerLeave:GetEffectType()
  return SkillEffectType.StickerLeave
end

function SkillEffectParam_StickerLeave:GetConvertColor()
  return self._convertColor
end
