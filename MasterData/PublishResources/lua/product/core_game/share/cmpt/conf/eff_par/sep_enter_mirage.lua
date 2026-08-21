require("skill_effect_param_base")
_class("SkillEffectEnterMirageParam", SkillEffectParamBase)
SkillEffectEnterMirageParam = SkillEffectEnterMirageParam

function SkillEffectEnterMirageParam:Constructor(t)
  self._trapRefreshID = t.trapRefreshID
  self._inheritAttribute = {}
  if t.inheritAttribute ~= nil and type(t.inheritAttribute) == "table" then
    self._inheritAttribute = t.inheritAttribute
  end
  self._useAttribute = t.useAttribute or 0
  self._inheritElement = t.inheritElement or false
end

function SkillEffectEnterMirageParam:GetEffectType()
  return SkillEffectType.EnterMirage
end

function SkillEffectEnterMirageParam:GetTrapRefreshID()
  return self._trapRefreshID
end

function SkillEffectEnterMirageParam:GetInheritAttribute()
  return self._inheritAttribute
end

function SkillEffectEnterMirageParam:GetUseAttribute()
  return self._useAttribute
end

function SkillEffectEnterMirageParam:GetInheritElement()
  return self._inheritElement
end
