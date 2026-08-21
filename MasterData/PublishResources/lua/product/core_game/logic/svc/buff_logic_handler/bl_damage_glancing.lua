require("buff_logic_base")
_class("BuffLogicSetDamageGlancingRate", BuffLogicBase)
BuffLogicSetDamageGlancingRate = BuffLogicSetDamageGlancingRate

function BuffLogicSetDamageGlancingRate:Constructor(instance, param)
  self._mulValue = param.mulValue
  self._maxType = param.maxType
  self._maxParam = param.maxParam
end

function BuffLogicSetDamageGlancingRate:GetMaxValue()
  if self._maxType == 1 then
    local context = self._buffInstance:Context()
    local eCaster = context.casterEntity
    local cAttrCaster = eCaster:Attributes()
    local base = cAttrCaster:GetAttribute("MaxHP") or 0
    return base * self._maxParam
  end
end

function BuffLogicSetDamageGlancingRate:DoLogic()
  local maxValue = self:GetMaxValue()
  local eBeneficiary = self._buffInstance:Entity()
  self._buffLogicService:ChangeDamageGlancingParam(eBeneficiary, self:GetBuffSeq(), self._mulValue, maxValue)
  return BuffResultSetGlancingDamage:New(self._mulValue, maxValue)
end

_class("BuffLogicRemoveGlancingDamage", BuffLogicBase)
BuffLogicRemoveGlancingDamage = BuffLogicRemoveGlancingDamage

function BuffLogicRemoveGlancingDamage:DoLogic()
  local eBeneficiary = self._buffInstance:Entity()
  self._buffLogicService:RemoveDamageGlancingParam(eBeneficiary, self:GetBuffSeq())
  return BuffResultRemoveGlancingDamage:New()
end
