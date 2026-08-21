require("skill_damage_effect_param")
_class("SkillEffectParam_IsolateConvert", SkillEffectParamBase)
SkillEffectParam_IsolateConvert = SkillEffectParam_IsolateConvert

function SkillEffectParam_IsolateConvert:Constructor(t)
  self._pattern = t.pattern or {
    1,
    2,
    3,
    4,
    1,
    2,
    3,
    4
  }
  if type(self._pattern) ~= "table" or #self._pattern < 8 then
    Log.exception(self._className, "请检查pattern参数")
  end
end

function SkillEffectParam_IsolateConvert:GetEffectType()
  return SkillEffectType.IsolateConvert
end

function SkillEffectParam_IsolateConvert:GetPattern()
  return self._pattern
end
