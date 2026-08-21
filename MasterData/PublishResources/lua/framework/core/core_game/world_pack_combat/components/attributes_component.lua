_class("AttributesComponent", Object)
AttributesComponent = AttributesComponent

function AttributesComponent:Constructor()
  self.modifierDic = {}
end

function AttributesComponent:SetAttribute(attrName, modifier)
  self.modifierDic[attrName] = modifier
end

function AttributesComponent:SetSimpleAttribute(attrName, value)
  self.modifierDic[attrName] = IModifyValue:New(value)
end

function AttributesComponent:RemoveSimpleAttribute(attrName)
  self.modifierDic[attrName] = nil
end

function AttributesComponent:GetAttributeModifier(attrName)
  return self.modifierDic[attrName]
end

function AttributesComponent:GetAttribute(attrName)
  local modifier = self.modifierDic[attrName]
  if modifier then
    return modifier:Value()
  end
end

function AttributesComponent:Modify(attrName, newValue, modifyID, option)
  local modifier = self.modifierDic[attrName]
  if not modifier then
    Log.exception("Modify attribute not configed! ", attrName)
    return
  end
  modifier:AddModify(newValue, modifyID, option)
end

function AttributesComponent:RemoveModify(attrName, modifyID)
  local modifier = self.modifierDic[attrName]
  if modifier then
    modifier:RemoveModify(modifyID)
  end
end

function AttributesComponent:ClearModify(attrName)
  local modifier = self.modifierDic[attrName]
  if modifier then
    modifier:ClearModify()
  end
end

function AttributesComponent:CloneAttributes()
  local attributsList = {}
  for key, value in pairs(self.modifierDic) do
    local modifier = setmetatable(value, Classes[value._className])
    attributsList[key] = modifier
  end
  return attributsList
end

function AttributesComponent:SetModifierDic(attributsList)
  self.modifierDic = attributsList
end

function AttributesComponent:CalcMaxHp()
  local baseMaxHp = self:GetAttribute("MaxHP") or 0
  local maxHpConstantFix = self:GetAttribute("MaxHPConstantFix")
  local maxHpPercentage = self:GetAttribute("MaxHPPercentage")
  local result = baseMaxHp
  if maxHpConstantFix ~= nil and maxHpPercentage ~= nil then
    result = baseMaxHp * (1 + maxHpPercentage) + maxHpConstantFix
  end
  return math.ceil(result)
end

function AttributesComponent:GetDefence()
  local baseDefence = self:GetAttribute("Defense")
  local defenceConstantFix = self:GetAttribute("DefenceConstantFix")
  defenceConstantFix = defenceConstantFix or 0
  local defencePercentage = self:GetAttribute("DefencePercentage")
  defencePercentage = defencePercentage or 0
  local defence = baseDefence * (1 + defencePercentage) + defenceConstantFix
  return math.ceil(defence)
end

function AttributesComponent:GetAttack()
  local baseAttack = self:GetAttribute("Attack")
  if not baseAttack then
    return 0
  end
  local attackConstantFix = self:GetAttribute("AttackConstantFix")
  attackConstantFix = attackConstantFix or 0
  local attackPercentage = self:GetAttribute("AttackPercentage")
  attackPercentage = attackPercentage or 0
  local atk = baseAttack * (1 + attackPercentage) + attackConstantFix
  return math.ceil(atk)
end

function AttributesComponent:GetCurrentHP()
  local baseHP = self:GetAttribute("HP")
  return baseHP
end

function AttributesComponent:GetAIMobility()
  local baseAIM = self:GetAttribute("Mobility")
  local maxAIM = self:GetAttribute("MaxMobility")
  local ret = math.min(baseAIM, maxAIM)
  return math.ceil(ret)
end

function Entity:Attributes()
  return self:GetComponent(self.WEComponentsEnum.Attributes)
end

function Entity:HasAttributes()
  return self:HasComponent(self.WEComponentsEnum.Attributes)
end

function Entity:AddAttributes()
  local index = self.WEComponentsEnum.Attributes
  local component = AttributesComponent:New()
  self:AddComponent(index, component)
end

function Entity:RemoveAttributes()
  if self:HasAttributes() then
    self:RemoveComponent(self.WEComponentsEnum.Attributes)
  end
end

function Entity:ReplaceAttributes(component)
  self:ReplaceComponent(self.WEComponentsEnum.Attributes, component)
end
