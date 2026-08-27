local UINPeriodicCardHolder = class("UINPeriodicCardHolder", UIBaseNode)
local base = UIBaseNode
local UINMonthCard = require("Game.ShopMain.UINMonthCard")
local UINPeriodicCard = require("Game.ShopMain.UINPeriodicCards.UINPeriodicCard")
local UINShopStaminaCard = require("Game.ShopMain.UINPeriodicCards.StaminaCard.UINShopStaminaCard")
local EPeriodicCardType = require("Game.DailySignIn.DailySignInEnum").EPeriodicCardType
local RefreshCardFuncDic = {
  [EPeriodicCardType.MonthCard] = function(self)
    if PlayerDataCenter.dailySignInData:GetIsMonthCardUnlock(EPeriodicCardType.WeekCard) then
      if self._periodicCardNode == nil then
        self._periodicCardNode = UINPeriodicCard.New()
        self._periodicCardNode:Init(self.ui.obj_ShopPeriodicCards)
      end
      return self._periodicCardNode
    end
    if self._monthCardNode == nil then
      self._monthCardNode = UINMonthCard.New()
      self._monthCardNode:Init(self.ui.obj_ShopMonthCard)
    end
    self._monthCardNode:InitMonthCardCfg(EPeriodicCardType.MonthCard)
    return self._monthCardNode
  end,
  [EPeriodicCardType.StaminaCard] = function(self)
    if self._staminaCardNode == nil then
      self._staminaCardNode = UINShopStaminaCard.New()
      self._staminaCardNode:Init(self.ui.uINShopStaminaCard)
    end
    self._staminaCardNode:InitMonthCardCfg(EPeriodicCardType.StaminaCard)
    return self._staminaCardNode
  end
}

function UINPeriodicCardHolder:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.obj_ShopPeriodicCards:SetActive(false)
  self.ui.obj_ShopMonthCard:SetActive(false)
  self.ui.uINShopStaminaCard:SetActive(false)
end

function UINPeriodicCardHolder:ShopCommonInit(uiShop)
  self.uiShop = uiShop
  self.shopCtrl = uiShop.shopCtrl
end

function UINPeriodicCardHolder:RefreshShopNode(shopId, pageId, autoSelectShelfId)
  UIUtil.RefreshTopResId({
    ConstGlobalItem.PaidItem,
    ConstGlobalItem.PaidSubItem
  })
  self.uiShop:RefreshHeadBar(nil)
  self:_HideAllCard()
  local shopCfg = ConfigData.shop[shopId]
  local monthCardId = shopCfg.shop_para[1]
  if monthCardId == nil then
    error("monthcard shopCfg.shop_para is nil, shopId:" .. tostring(shopId))
    return
  end
  local RefreshCardFunc = RefreshCardFuncDic[monthCardId]
  if RefreshCardFunc == nil then
    error("cant get RefreshCardFunc, monthCardId = " .. tostring(monthCardId))
    return
  end
  local cardNode = RefreshCardFunc(self)
  cardNode:Show()
  cardNode:ShopCommonInit(self.uiShop)
  cardNode:RefreshShopNode(shopId, pageId, autoSelectShelfId)
end

function UINPeriodicCardHolder:_HideAllCard()
  if self._monthCardNode then
    self._monthCardNode:Hide()
  end
  if self._periodicCardNode then
    self._periodicCardNode:Hide()
  end
  if self._staminaCardNode then
    self._staminaCardNode:Hide()
  end
end

function UINPeriodicCardHolder:OnDelete()
  if self._monthCardNode then
    self._monthCardNode:Delete()
  end
  if self._periodicCardNode then
    self._periodicCardNode:Delete()
  end
  if self._staminaCardNode then
    self._staminaCardNode:Delete()
  end
  base.OnDelete(self)
end

return UINPeriodicCardHolder
