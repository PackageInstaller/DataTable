_class("BuffLogicChangeAttackByCaster", BuffLogicBase)
BuffLogicChangeAttackByCaster = BuffLogicChangeAttackByCaster
local ChangeAttackByCasterAttributeType = {Attack = 0}
_enum("ChangeAttackByCasterAttributeType", ChangeAttackByCasterAttributeType)

function BuffLogicChangeAttackByCaster:Constructor(buffInstance, logicParam)
  self._baseAttrType = ChangeAttackByCasterAttributeType.Attack
  self._mul = logicParam.mul or 0
  self._buffInstance.BuffLogicChangeAttackByCaster_RunCount = 0
  self._light = logicParam.light == 1
end

function BuffLogicChangeAttackByCaster:DoLogic()
  local context = self._buffInstance:Context()
  if not context then
    return
  end
  self._buffInstance.BuffLogicChangeAttackByCaster_RunCount = self._buffInstance.BuffLogicChangeAttackByCaster_RunCount + 1
  local eCaster = context.casterEntity
  local cAttrCaster = eCaster:Attributes()
  local base = 0
  if ChangeAttackByCasterAttributeType.Attack == self._baseAttrType then
    base = cAttrCaster:GetAttribute("Attack")
  end
  if not base then
    return
  end
  local val = base * self._mul * self._buffInstance.BuffLogicChangeAttackByCaster_RunCount
  local eBeneficiary = self._buffInstance:Entity()
  self._buffLogicService:ChangeBaseAttack(eBeneficiary, self:GetBuffSeq(), ModifyBaseAttackType.AttackConstantFix, val)
  self._buffInstance._ChangeAttackType = ModifyBaseAttackType.AttackConstantFix
  local owner = self._buffInstance:Entity()
  local pstID
  if owner:HasPetPstID() then
    pstID = owner:PetPstID():GetPstID()
  end
  local casterPstID
  if eCaster:HasPetPstID() then
    casterPstID = eCaster:PetPstID():GetPstID()
  end
  local result = BuffResultChangeAttackByCaster:New(eCaster:GetID(), val, self._light, pstID, casterPstID)
  return result
end

function BuffLogicChangeAttackByCaster:DoOverlap(logicParam)
  return self:DoLogic()
end

_class("BuffLogicUndoChangeAttackByCaster", BuffLogicBase)
BuffLogicUndoChangeAttackByCaster = BuffLogicUndoChangeAttackByCaster

function BuffLogicUndoChangeAttackByCaster:Constructor(buffInstance, logicParam)
  self._black = logicParam.black == 1
end

function BuffLogicUndoChangeAttackByCaster:DoLogic()
  self._buffInstance.BuffLogicChangeAttackByCaster_RunCount = 0
  local eBeneficiary = self._buffInstance:Entity()
  self._buffLogicService:RemoveBaseAttack(eBeneficiary, self:GetBuffSeq(), self._buffInstance._ChangeAttackType)
  local context = self._buffInstance:Context()
  if not context then
    return
  end
  local owner = self._buffInstance:Entity()
  local pstID
  if owner:HasPetPstID() then
  end
  local casterEntity = context.casterEntity
  local casterPstID = 0
  if casterEntity:HasPetPstID() then
    casterPstID = casterEntity:PetPstID():GetPstID()
  end
  local result = BuffResultUndoChangeAttackByCaster:New(self._black, casterPstID)
  return result
end

function BuffLogicUndoChangeAttackByCaster:DoOverlap()
end
