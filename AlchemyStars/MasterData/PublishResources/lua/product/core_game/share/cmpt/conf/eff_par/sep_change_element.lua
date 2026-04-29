require("skill_damage_effect_param")
local EffectChangeElementType = {
  Normal = 1,
  ByCurrentTeamLeader = 2,
  RestoreMonsterCfgElement = 3,
  MAX = 99
}
_enum("EffectChangeElementType", EffectChangeElementType)
_class("SkillEffectChangeElementParam", SkillEffectParamBase)
SkillEffectChangeElementParam = SkillEffectChangeElementParam

function SkillEffectChangeElementParam:Constructor(t)
  self._element = t.element
  self._type = t.type or EffectChangeElementType.Normal
  self._changeSuperElement = t.changeSuperElement or false
end

function SkillEffectChangeElementParam:GetEffectType()
  return SkillEffectType.ChangeElement
end

function SkillEffectChangeElementParam:GetElement()
  return self._element
end

function SkillEffectChangeElementParam:GetType()
  return self._type
end

function SkillEffectChangeElementParam:IsChangeSuperElement()
  return self._changeSuperElement
end
