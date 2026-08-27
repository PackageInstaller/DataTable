local base = require("Game.ActivityDeliverySimulator.Entity.DeliverySimulatorInteractEntityBase")
local GoodsSpawnEntity = class("GoodsSpawnEntity", base)

function GoodsSpawnEntity:ctor(goodsSpawnId, interactObj, dsCtrl)
  self.goodsSpawnCfg = ConfigData.delivery_goods_spawn[goodsSpawnId]
  self.dsCtrl = dsCtrl
end

function GoodsSpawnEntity:InitInteractEntityUI(mainWindow)
  self.GoodsSpawnUIItem = mainWindow:CreateGoodsSpawnUIItem()
  self.GoodsSpawnUIItem:UpdateUIPos(self.interactRangeCollider.transform.position)
  self.dsCtrl._bind.HighLighting:AddHighLightTarget(self.gameObject)
end

function GoodsSpawnEntity:Reset()
  self.lastPickedTime = nil
  self.GoodsSpawnUIItem:SwitchState(true)
  self:OnUpDate()
end

function GoodsSpawnEntity:CouldPickUp()
  if self.lastPickedTime == nil then
    return true
  end
  if Time.time - self.lastPickedTime > self:GetReplenishmentTime() then
    return true
  end
  return false
end

function GoodsSpawnEntity:LostGoods()
  self.dsCtrl._bind.HighLighting:RemoveHighLightTarget(self.gameObject)
  self.lastPickedTime = Time.time
  self.GoodsSpawnUIItem:SwitchState(false)
  self.GoodsSpawnUIItem:PlayPickUpAnim()
  local goods = {}
  goods.sprite = self:GetGoodsIconSprite()
  setmetatable(goods, {
    __index = self.goodsSpawnCfg
  })
  return goods
end

function GoodsSpawnEntity:Replenishment()
  self.dsCtrl._bind.HighLighting:AddHighLightTarget(self.gameObject)
  self.GoodsSpawnUIItem:PlayReplenishmentAnim()
end

function GoodsSpawnEntity:GetReplenishmentTime()
  return self.goodsSpawnCfg.replenishment_time
end

function GoodsSpawnEntity:GetGoodsWeight()
  return self.goodsSpawnCfg.weight
end

function GoodsSpawnEntity:GetGoodsIconSprite()
  local atlas = self.dsCtrl:GetDeliveryAtlas()
  return AtlasUtil.GetResldSprite(atlas, self.goodsSpawnCfg.icon)
end

function GoodsSpawnEntity:OnPlayerTrigger(dsPlayerEntity, dsCtrl, isEnterOrExit)
  dsCtrl:UpdateCurrentGoodsSpawnEntity(self, isEnterOrExit)
  if isEnterOrExit then
    self.GoodsSpawnUIItem:PlayTouchAnim()
  else
    self.GoodsSpawnUIItem:PlayExitAnim()
  end
end

function GoodsSpawnEntity:OnUpDate()
  if self.GoodsSpawnUIItem ~= nil then
    self.GoodsSpawnUIItem:UpdateUIPos(self.interactRangeCollider.transform.position)
  end
  if self.lastPickedTime == nil then
    return
  end
  local currentReplenishmentTime = Time.time - self.lastPickedTime
  self.GoodsSpawnUIItem:UpdateGoodsSpawnProgress(currentReplenishmentTime / self:GetReplenishmentTime())
  if currentReplenishmentTime >= self:GetReplenishmentTime() then
    self.lastPickedTime = nil
    self:Replenishment()
    self.GoodsSpawnUIItem:SwitchState(true)
  end
end

function GoodsSpawnEntity:Picked()
  self.lastPickedTime = Time.time
end

function GoodsSpawnEntity:OnDelete()
  self.dsCtrl._bind.HighLighting:RemoveHighLightTarget(self.gameObject)
  self.goodsSpawnCfg = nil
  self.dsCtrl = nil
end

return GoodsSpawnEntity
