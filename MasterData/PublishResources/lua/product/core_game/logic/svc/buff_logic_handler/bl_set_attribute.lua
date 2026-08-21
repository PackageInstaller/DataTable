AttributeMultiModifyType = {
  MultiModifyBool_AND = 1,
  MultiModifyValue_Last = 2,
  MultiModifyValue_Add = 3,
  MultiModifyValue_Mul = 4,
  MultiModifyValue_Max = 5,
  MultiModifyValue_Min = 6,
  MultiModifyValue_AddMinMax = 7,
  MultiModifyValue_Complex = 8
}
_enum("AttributeMultiModifyType", AttributeMultiModifyType)
_class("BuffLogicSetAttribute", BuffLogicBase)
BuffLogicSetAttribute = BuffLogicSetAttribute

function BuffLogicSetAttribute:Constructor(buffInstance, logicParam)
  self._name = logicParam.name
  self._modifyType = logicParam.modifyType
  self._defaultValue = logicParam.defaultValue or 0
  self._skillHolderName = logicParam.skillHolderName
end

function BuffLogicSetAttribute:DoLogic()
  local entity = self._buffInstance:Entity()
  if self._skillHolderName then
    local skillHolderID = entity:GetSkillHolder(self._skillHolderName)
    if not skillHolderID then
      Log.error("BuffLogicSetAttribute must create skill holder, holder name =", self._skillHolderName)
      return
    end
    entity = self._world:GetEntityByID(skillHolderID)
  end
  if not entity:HasAttributes() then
    entity:AddAttributes()
  end
  local attributes = entity:Attributes()
  local modifier = self:CreateModifier(self._modifyType, self._defaultValue)
  attributes:SetAttribute(self._name, modifier)
end

function BuffLogicSetAttribute:CreateModifier(type, value)
  if type == AttributeMultiModifyType.MultiModifyBool_AND then
    return MultModifyBool_AND:New(value)
  elseif type == AttributeMultiModifyType.MultiModifyValue_Last then
    return MultModifyValue_Last:New(value)
  elseif type == AttributeMultiModifyType.MultiModifyValue_Add then
    return MultModifyValue_Add:New(value)
  elseif type == AttributeMultiModifyType.MultiModifyValue_Mul then
    return MultModifyValue_Mul:New(value)
  elseif type == AttributeMultiModifyType.MultiModifyValue_Max then
    return MultModifyValue_Max:New(value)
  elseif type == AttributeMultiModifyType.MultiModifyValue_Min then
    return MultModifyValue_Min:New(value)
  elseif type == AttributeMultiModifyType.MultiModifyValue_AddMinMax then
    return MultModifyValue_AddMinMax:New(value)
  elseif type == AttributeMultiModifyType.MultiModifyValue_Complex then
    return MultModifyValue_Complex:New(value)
  end
  return IModifyValue:New(value)
end
