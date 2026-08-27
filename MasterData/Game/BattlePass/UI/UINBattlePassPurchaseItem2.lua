local UINBattlePassPurchaseItem2 = class("UINBattlePassPurchaseItem2", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")

function UINBattlePassPurchaseItem2:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnBtnPassBuyClicked)
  self.ui.baseItem:SetActive(false)
  self.baseRewardPool = UIItemPool.New(UINBaseItemWithCount, self.ui.baseItem)
end

function UINBattlePassPurchaseItem2:InitPassPurchaseItem2(purchaseType, passInfo, buyEvent, hasDiscount)
  self.purchaseType = purchaseType
  self.passInfo = passInfo
  self.buyEvent = buyEvent
  local color = self.passInfo.passCfg.color
  color = Color.New(color[1] / 255, color[2] / 255, color[3] / 255)
  self.ui.img_Line.color = color
  self.ui.imgBG1.color = color
  self.ui.imgBG.color = color
  self.ui.obj_Discount:SetActive(hasDiscount)
  self.ui.obj_Price:SetActive(not hasDiscount)
  self:InitPassReward()
  local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
  local payId1 = BattlePassEnum.GetPassPayId(BattlePassEnum.BuyQuality.Ultimate, self.passInfo.passCfg)
  local priceStr1 = payCtrl:GetPayPriceShow(payId1)
  local payId2 = BattlePassEnum.GetPassPayId(BattlePassEnum.BuyQuality.SupplyUltimate, self.passInfo.passCfg)
  local priceStr2 = payCtrl:GetPayPriceShow(payId2)
  self.ui.tex_Price.text = priceStr1
  self.ui.tex_Discount.text = priceStr1
  self.ui.tex_DisPrice.text = priceStr2
  self:RefreshCurrentBoxNum()
end

function UINBattlePassPurchaseItem2:InitPassReward()
  local passCfg = self.passInfo.passCfg
  for index, itemId in pairs(passCfg.ultimate_reward_ids) do
    if itemId ~= passCfg.condition_para1 then
      local itemCount = passCfg.ultimate_reward_nums[index]
      local itemCfg = ConfigData.item[itemId]
      if itemCfg == nil then
        error("item cfg is null,id:" .. tostring(itemId))
      else
        local baseItem = self.baseRewardPool:GetOne()
        baseItem:InitItemWithCount(itemCfg, itemCount)
      end
    end
  end
end

function UINBattlePassPurchaseItem2:RefreshCurrentBoxNum()
  local isResidentBp = self.passInfo:IsResidentBP()
  self.ui.BoxOwnNumBg:SetActive(isResidentBp)
  if isResidentBp then
    local itemNum = PlayerDataCenter:GetItemCount(ConstGlobalItem.ResidentBpGift, false)
    local itemName = ConfigData:GetItemName(ConstGlobalItem.ResidentBpGift)
    self.ui.Tex_BoxNumOwn:SetIndex(0, tostring(itemNum), itemName)
  end
end

function UINBattlePassPurchaseItem2:OnBtnPassBuyClicked()
  if self.buyEvent ~= nil then
    self.buyEvent(self.passInfo.id, self.purchaseType)
  end
end

function UINBattlePassPurchaseItem2:OnDelete()
  base.OnDelete(self)
end

return UINBattlePassPurchaseItem2
