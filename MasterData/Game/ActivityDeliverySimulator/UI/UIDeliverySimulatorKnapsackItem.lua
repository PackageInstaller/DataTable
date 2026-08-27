local base = UIBaseNode
local UIDeliverySimulatorKnapsackItem = class("UIDeliverySimulatorKnapsackItem", base)
local UIDeliverySimulatorKnapsackGoodsItem = require("Game.ActivityDeliverySimulator.UI.UIDeliverySimulatorKnapsackGoodsItem")

function UIDeliverySimulatorKnapsackItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.goodsItemPool = UIItemPool.New(UIDeliverySimulatorKnapsackGoodsItem, self.ui.obj_goodsItem, false)
end

function UIDeliverySimulatorKnapsackItem:InitDeliverySimulatorKnapsackItem(weight, maxCapacity, overloadLevel)
  self.goodsDic = {}
  self:UpdateDeliverySimulatorKnapsackCapacity(weight, maxCapacity, overloadLevel)
end

function UIDeliverySimulatorKnapsackItem:UpdateDeliverySimulatorKnapsackItem(goodsList, maxCapacity, overloadLevel)
  self:UpdateGoodsList(goodsList)
  self:UpdateWeightProgress(maxCapacity, overloadLevel)
end

function UIDeliverySimulatorKnapsackItem:UpdateDeliverySimulatorKnapsackCapacity(weight, maxCapacity, overloadLevel)
  self:UpdateWeightProgress(weight, maxCapacity, overloadLevel)
end

function UIDeliverySimulatorKnapsackItem:UpdateWeightProgress(weight, maxCapacity, overloadLevel)
  self.ui.capacitySilder.value = weight / maxCapacity
  self.ui.tex_CapacityNum.text = string.format("%s/%s", weight, maxCapacity)
end

function UIDeliverySimulatorKnapsackItem:AddKnapsackGoods(goods)
  local goodsItem = self.goodsDic[goods.goods_spawn_id]
  if goodsItem == nil then
    goodsItem = self.goodsItemPool:GetOne()
    goodsItem:InitDeliverySimulatorKnapsackGoodsItem(goods.sprite, goods.price)
    goodsItem:AddOne(true)
    self.goodsDic[goods.goods_spawn_id] = goodsItem
  else
    if goodsItem.count == 0 then
      goodsItem:OnShow()
    end
    goodsItem:AddOne(true)
  end
  AudioManager:PlayAudioById(8010)
end

function UIDeliverySimulatorKnapsackItem:HideAllGoodsItem()
  if self.goodsDic == nil then
    return
  end
  for goods_spawn_id, goodsItem in pairs(self.goodsDic) do
    goodsItem:PlayHideAnim()
  end
end

function UIDeliverySimulatorKnapsackItem:ClearGoods()
  self.goodsItemPool:HideAll()
end

function UIDeliverySimulatorKnapsackItem:OnDelete()
  self.goodsList = nil
  self.goodsItemPool:DeleteAll()
  self.goodsItemPool = nil
end

return UIDeliverySimulatorKnapsackItem
