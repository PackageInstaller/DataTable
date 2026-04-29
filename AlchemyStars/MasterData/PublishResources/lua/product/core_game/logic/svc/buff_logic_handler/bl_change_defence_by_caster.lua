_class("BuffLogicChangeDefenceByCaster", BuffLogicBase)
BuffLogicChangeDefenceByCaster = BuffLogicChangeDefenceByCaster
local ChangeDefenceByCasterAttributeType = {Defence = 0}
_enum("ChangeDefenceByCasterAttributeType", ChangeDefenceByCasterAttributeType)

function BuffLogicChangeDefenceByCaster:Constructor(buffInstance, logicParam)
  self._baseAttrType = ChangeDefenceByCasterAttributeType.Defence
  self._mul = logicParam.mul or 0
  self._light = logicParam.light == 1
end

function BuffLogicChangeDefenceByCaster:DoLogic()
  local context = self._buffInstance:Context()
  if not context then
    return
  end
  local eCaster = context.casterEntity
  local cAttrCaster = eCaster:Attributes()
  local base = 0
  if ChangeDefenceByCasterAttributeType.Defence == self._baseAttrType then
    base = cAttrCaster:GetAttribute("Defense")
  end
  if not base then
    return
  end
  local val = base * self._mul
  local eBeneficiary = self._buffInstance:Entity()
  self._buffLogicService:ChangeBaseDefence(eBeneficiary, self:GetBuffSeq(), ModifyBaseDefenceType.DefenceConstantFix, val)
  self._buffInstance._ChangeDefenceType = ModifyBaseDefenceType.DefenceConstantFix
  local result = BuffResultChangeDefenceByCaster:New(eCaster:GetID(), self._light)
  return result
end

function BuffLogicChangeDefenceByCaster:DoOverlap(logicParam, context)
  self._mul = self._mul + logicParam.mul
  return self:DoLogic()
end

_class("BuffLogicUndoChangeDefenceByCaster", BuffLogicBase)
BuffLogicUndoChangeDefenceByCaster = BuffLogicUndoChangeDefenceByCaster

function BuffLogicUndoChangeDefenceByCaster:Constructor(buffInstance, logicParam)
  self._black = logicParam.black == 1
end

function BuffLogicUndoChangeDefenceByCaster:DoLogic()
  local eBeneficiary = self._buffInstance:Entity()
  self._buffLogicService:RemoveBaseDefence(eBeneficiary, self:GetBuffSeq(), self._buffInstance._ChangeDefenceType)
  local context = self._buffInstance:Context()
  if not context then
    return
  end
  local result = BuffResultUndoChangeDefenceByCaster:New(context.casterEntity:GetID(), self._black)
  return result
end
