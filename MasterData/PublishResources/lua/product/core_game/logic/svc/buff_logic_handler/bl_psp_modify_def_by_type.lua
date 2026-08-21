_class("BuffLogicPSPModifyDefByType", BuffLogicBase)
BuffLogicPSPModifyDefByType = BuffLogicPSPModifyDefByType

function BuffLogicPSPModifyDefByType:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue or 0
  self._modifyType = logicParam.modifyType
end

function BuffLogicPSPModifyDefByType:DoLogic()
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
  local curModifyVal = self._buffLogicService:GetModifyValueByID(entity, "DefencePercentage", self:GetBuffSeq())
  addValue = addValue + curModifyVal
  self._buffLogicService:ChangeBaseDefence(entity, self:GetBuffSeq(), ModifyBaseDefenceType.DefencePercentage, addValue)
  if entity:HasPetPstID() then
    local teamEntity = entity:Pet():GetOwnerTeamEntity()
    self:UpdateTeamDefenceLogic(teamEntity)
  end
end

function BuffLogicPSPModifyDefByType:DoOverlap(logicParam)
  return self:DoLogic()
end

_class("BuffLogicUndoPSPModifyDefByType", BuffLogicBase)
BuffLogicUndoPSPModifyDefByType = BuffLogicUndoPSPModifyDefByType

function BuffLogicUndoPSPModifyDefByType:Constructor(buffInstance, logicParam)
end

function BuffLogicUndoPSPModifyDefByType:DoLogic()
  local e = self._buffInstance:Entity()
  self._buffLogicService:RemoveBaseDefence(e, self:GetBuffSeq(), ModifyBaseDefenceType.DefencePercentage)
end
