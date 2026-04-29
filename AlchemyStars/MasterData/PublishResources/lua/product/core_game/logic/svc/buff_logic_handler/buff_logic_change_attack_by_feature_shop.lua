_class("BuffLogicChangeAttackByFeatureShop", BuffLogicBase)
BuffLogicChangeAttackByFeatureShop = BuffLogicChangeAttackByFeatureShop
local ChangeAttackByFeatureShopAttributeType = {Attack = 0}
_enum("ChangeAttackByFeatureShopAttributeType", ChangeAttackByFeatureShopAttributeType)

function BuffLogicChangeAttackByFeatureShop:Constructor(buffInstance, logicParam)
  self._baseAttrType = ChangeAttackByFeatureShopAttributeType.Attack
  self._mul = logicParam.mul or 0
  self._getParamFromFeatureCfg = logicParam.getParamFromFeatureCfg or 1
  self._maxOverCoinCount = logicParam.maxOverCoinCount or -1
  self._light = false
  if logicParam.light and logicParam.light == 1 then
    self._light = true
  end
end

function BuffLogicChangeAttackByFeatureShop:DoLogic()
  local context = self._buffInstance:Context()
  if not context then
    return
  end
  local eCaster = context.casterEntity
  local cAttrCaster = eCaster:Attributes()
  local base = 0
  if ChangeAttackByFeatureShopAttributeType.Attack == self._baseAttrType then
    base = cAttrCaster:GetAttribute("Attack")
  end
  if not base then
    return
  end
  local lsvcFeature = self._world:GetService("FeatureLogic")
  local overMaxCoinCount = lsvcFeature:GetShopOverMaxCoinCount()
  if overMaxCoinCount <= 0 then
    return
  end
  if 0 < self._maxOverCoinCount and overMaxCoinCount > self._maxOverCoinCount then
    overMaxCoinCount = self._maxOverCoinCount
  end
  local mulParam = self._mul
  if self._getParamFromFeatureCfg and self._getParamFromFeatureCfg == 1 then
    mulParam = lsvcFeature:GetShopOverMaxCoinCountAddAttackParam()
  end
  local val = base * mulParam * overMaxCoinCount
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
  local result = BuffResultChangeAttackByFeatureShop:New(eCaster:GetID(), val, self._light, pstID, casterPstID)
  return result
end

function BuffLogicChangeAttackByFeatureShop:DoOverlap(logicParam)
  return self:DoLogic()
end

_class("BuffLogicUndoChangeAttackByFeatureShop", BuffLogicBase)
BuffLogicUndoChangeAttackByFeatureShop = BuffLogicUndoChangeAttackByFeatureShop

function BuffLogicUndoChangeAttackByFeatureShop:Constructor(buffInstance, logicParam)
  self._black = false
  if logicParam.black and logicParam.black == 1 then
    self._black = true
  end
end

function BuffLogicUndoChangeAttackByFeatureShop:DoLogic()
  self._buffInstance.BuffLogicChangeAttackByFeatureShop_RunCount = 0
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
  local result = BuffResultUndoChangeAttackByFeatureShop:New(self._black, casterPstID)
  return result
end

function BuffLogicUndoChangeAttackByFeatureShop:DoOverlap()
end
