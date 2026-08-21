require("buff_logic_base")
_class("BuffLogicRecoverFromGreyHPByLayer", BuffLogicBase)
BuffLogicRecoverFromGreyHPByLayer = BuffLogicRecoverFromGreyHPByLayer

function BuffLogicRecoverFromGreyHPByLayer:Constructor(_, logicParam)
  self._ratePerLayer = tonumber(logicParam.ratePerLayer)
  self._layerType = tonumber(logicParam.layerType)
end

function BuffLogicRecoverFromGreyHPByLayer:DoLogic(_)
  local e = self:GetEntity()
  if e:HasSuperEntity() then
    e = e:GetSuperEntity()
  end
  local curMarkLayer = self._buffLogicService:GetBuffLayer(self._entity, self._layerType)
  local recoveryRate = self._ratePerLayer * curMarkLayer
  local damageInfo = self._buffLogicService:GetRecoverFromGreyHPDamageInfo(e, recoveryRate)
  if not damageInfo then
    return
  end
  local calcDamageSvc = self._world:GetService("CalcDamage")
  calcDamageSvc:AddTargetHP(e:GetID(), damageInfo)
  self._buffLogicService:ChangeGreyHP(e, damageInfo:GetChangeHP() * -1)
  local currentVal = e:BuffComponent():GetGreyHPValue(true)
  return BuffResultRecoverFromGreyHPByLayer:New(e:GetID(), damageInfo, currentVal)
end
