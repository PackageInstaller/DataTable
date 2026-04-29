_class("BuffLogicPSPChangeAtkByFettersPet", BuffLogicBase)
BuffLogicPSPChangeAtkByFettersPet = BuffLogicPSPChangeAtkByFettersPet

function BuffLogicPSPChangeAtkByFettersPet:Constructor(buffInstance, logicParam)
  self._rate = logicParam.rate or 0
end

function BuffLogicPSPChangeAtkByFettersPet:DoLogic()
  local entity = self._buffInstance:Entity()
  if not entity:Attributes() then
    return false
  end
  local fettersCmpt = entity:Fetters()
  if not fettersCmpt then
    return false
  end
  local entityID = fettersCmpt:GetFettersPetEntityID()
  local fettersPetEntity = self._world:GetEntityByID(entityID)
  if not fettersPetEntity then
    return false
  end
  local baseAtk = fettersPetEntity:Attributes():GetAttribute("Attack")
  local addValue = math.floor(self._rate * baseAtk + 0.5)
  local curModifyVal = self._buffLogicService:GetModifyValueByID(entity, "AttackConstantFix", self:GetBuffSeq())
  addValue = addValue + curModifyVal
  self._buffLogicService:ChangeBaseAttack(entity, self:GetBuffSeq(), ModifyBaseAttackType.AttackConstantFix, addValue)
end

function BuffLogicPSPChangeAtkByFettersPet:DoOverlap(logicParam)
  return self:DoLogic()
end

_class("BuffLogicUndoPSPChangeAtkByFettersPet", BuffLogicBase)
BuffLogicUndoPSPChangeAtkByFettersPet = BuffLogicUndoPSPChangeAtkByFettersPet

function BuffLogicUndoPSPChangeAtkByFettersPet:Constructor(buffInstance, logicParam)
end

function BuffLogicUndoPSPChangeAtkByFettersPet:DoLogic()
  local e = self._buffInstance:Entity()
  self._buffLogicService:RemoveBaseAttack(e, self:GetBuffSeq(), ModifyBaseAttackType.AttackConstantFix)
end
