_class("BuffLogicChangeAttackByCasterLayer", BuffLogicBase)
BuffLogicChangeAttackByCasterLayer = BuffLogicChangeAttackByCasterLayer

function BuffLogicChangeAttackByCasterLayer:Constructor(buffInstance, logicParam)
  self._layerType = logicParam.layerType
  self._mulPerLayer = logicParam.mulPerLayer or 0
end

function BuffLogicChangeAttackByCasterLayer:DoLogic()
  if not self._layerType then
    Log.fatal("### layerType is nil")
    return
  end
  local context = self._buffInstance:Context()
  if not context then
    return
  end
  local eCaster = context.casterEntity
  local cAttrCaster = eCaster:Attributes()
  local base = cAttrCaster:GetAttribute("Attack")
  if not base then
    return
  end
  local eBeneficiary = self._buffInstance:Entity()
  local layerCount = self._buffLogicService:GetBuffLayer(eCaster, self._layerType) or 0
  local val = base * self._mulPerLayer * layerCount
  self._buffLogicService:ChangeBaseAttack(eBeneficiary, self:GetBuffSeq(), ModifyBaseAttackType.AttackConstantFix, val)
  self._buffInstance.BuffLogicChangeAttackByCasterLayer_ChangeAttackType = ModifyBaseAttackType.AttackConstantFix
end

_class("BuffLogicUndoChangeAttackByCasterLayer", BuffLogicBase)
BuffLogicUndoChangeAttackByCasterLayer = BuffLogicUndoChangeAttackByCasterLayer

function BuffLogicUndoChangeAttackByCasterLayer:Constructor(buffInstance, logicParam)
end

function BuffLogicUndoChangeAttackByCasterLayer:DoLogic()
  local eBeneficiary = self._buffInstance:Entity()
  self._buffLogicService:RemoveBaseAttack(eBeneficiary, self:GetBuffSeq(), self._buffInstance.BuffLogicChangeAttackByCasterLayer_ChangeAttackType)
end
