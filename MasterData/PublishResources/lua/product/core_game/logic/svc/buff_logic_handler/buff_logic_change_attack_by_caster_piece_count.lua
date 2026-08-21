_class("BuffLogicChangeAttackByCasterPieceCount", BuffLogicBase)
BuffLogicChangeAttackByCasterPieceCount = BuffLogicChangeAttackByCasterPieceCount

function BuffLogicChangeAttackByCasterPieceCount:Constructor(buffInstance, logicParam)
  self._mul = logicParam.mul or 0
  self._element = logicParam.element or {}
end

function BuffLogicChangeAttackByCasterPieceCount:DoLogic()
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
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local posList = boardServiceLogic:GetGridPosByPieceType(self._element)
  local pieceCount = table.count(posList)
  local val = base * self._mul * pieceCount
  local eBeneficiary = self._buffInstance:Entity()
  self._buffLogicService:ChangeBaseAttack(eBeneficiary, self:GetBuffSeq(), ModifyBaseAttackType.AttackConstantFix, val)
  self._buffInstance._ChangeAttackType = ModifyBaseAttackType.AttackConstantFix
end

_class("BuffLogicUndoChangeAttackByCasterPieceCount", BuffLogicBase)
BuffLogicUndoChangeAttackByCasterPieceCount = BuffLogicUndoChangeAttackByCasterPieceCount

function BuffLogicUndoChangeAttackByCasterPieceCount:Constructor(buffInstance, logicParam)
end

function BuffLogicUndoChangeAttackByCasterPieceCount:DoLogic()
  local eBeneficiary = self._buffInstance:Entity()
  self._buffLogicService:RemoveBaseAttack(eBeneficiary, self:GetBuffSeq(), self._buffInstance._ChangeAttackType)
end
