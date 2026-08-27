local base = require("Game.ActivityDeliverySimulator.Entity.DeliverySimulatorInteractEntityBase")
local HandInEntity = class("HandInEntity", base)
local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance

function HandInEntity:ctor(handInId, interactObj, dsCtrl)
  self.dsCtrl = dsCtrl
end

function HandInEntity:OnPlayerTrigger(dsPlayerEntity, dsCtrl, isEnterOrExit)
  if isEnterOrExit then
    local goodsNumsDic = dsPlayerEntity:HandInGoods()
    self:ReceivingGoods(goodsNumsDic, dsPlayerEntity)
  end
end

function HandInEntity:ReceivingGoods(goodsNumsDic, dsPlayerEntity)
  if table.count(goodsNumsDic) > 0 then
    local effect = CS_AnimationEffectController_Ins:AddAnimationEffectByBattleEffectId(5000, dsPlayerEntity.gameObject)
    effect:Play()
    AudioManager:PlayAudioById(8011)
  end
  self.dsCtrl:SettlementPayment(goodsNumsDic)
end

function HandInEntity:OnDelete()
  self.goodsSpawnCfg = nil
  self.dsCtrl = nil
end

return HandInEntity
