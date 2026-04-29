require("skill_damage_effect_param")
_class("SkillEffectParamAddBuffByPickupBuffLayer", SkillEffectParamBase)
SkillEffectParamAddBuffByPickupBuffLayer = SkillEffectParamAddBuffByPickupBuffLayer

function SkillEffectParamAddBuffByPickupBuffLayer:Constructor(t)
  self._trapIDList = t.trapIDList
  self._addBuffList = t.addBuffList or {}
  self._checkBuffEffectType = t.checkBuffEffectType
end

function SkillEffectParamAddBuffByPickupBuffLayer:GetEffectType()
  return SkillEffectType.AddBuffByPickupBuffLayer
end

function SkillEffectParamAddBuffByPickupBuffLayer:GetTrapIDList()
  return self._trapIDList
end

function SkillEffectParamAddBuffByPickupBuffLayer:GetCheckBuffEffectType()
  return self._checkBuffEffectType
end

function SkillEffectParamAddBuffByPickupBuffLayer:GetAddBuffIDByLayer(layer)
  local addBuffID = self._addBuffList[layer]
  if not addBuffID then
    if #self._addBuffList > 0 then
      return self._addBuffList[#self._addBuffList]
    else
      return 0
    end
  end
  return addBuffID
end
