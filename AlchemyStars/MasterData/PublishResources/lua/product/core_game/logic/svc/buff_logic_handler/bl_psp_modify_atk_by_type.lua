_class("BuffLogicPSPModifyAtkByType", BuffLogicBase)
BuffLogicPSPModifyAtkByType = BuffLogicPSPModifyAtkByType

function BuffLogicPSPModifyAtkByType:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue or 0
  self._modifyType = logicParam.modifyType
end

function BuffLogicPSPModifyAtkByType:DoLogic()
  local entity = self._buffInstance:Entity()
  if not entity:Attributes() then
    return false
  end
  local battleSvc = self._world:GetService("Battle")
  local count = battleSvc:GetCountByModifyType(self._modifyType)
  if not count then
    return
  end
  local addValue = self._mulValue * count
  local curModifyVal = self._buffLogicService:GetModifyValueByID(entity, "AttackPercentage", self:GetBuffSeq())
  addValue = addValue + curModifyVal
  self._buffLogicService:ChangeBaseAttack(entity, self:GetBuffSeq(), ModifyBaseAttackType.AttackPercentage, addValue)
end

function BuffLogicPSPModifyAtkByType:DoOverlap(logicParam)
  return self:DoLogic()
end

_class("BuffLogicUndoPSPModifyAtkByType", BuffLogicBase)
BuffLogicUndoPSPModifyAtkByType = BuffLogicUndoPSPModifyAtkByType

function BuffLogicUndoPSPModifyAtkByType:Constructor(buffInstance, logicParam)
end

function BuffLogicUndoPSPModifyAtkByType:DoLogic()
  local e = self._buffInstance:Entity()
  self._buffLogicService:RemoveBaseAttack(e, self:GetBuffSeq(), ModifyBaseAttackType.AttackPercentage)
end
