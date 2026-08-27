local UINEventComebackShop = class("UINEventComebackShop", UIBaseNode)
local base = UIBaseNode
local UINEventComebackShopItem = require("Game.ActivityComeback.UI.UINEventComebackShopItem")

function UINEventComebackShop:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._giftPool = UIItemPool.New(UINEventComebackShopItem, self.ui.giftItem)
  self.ui.giftItem:SetActive(false)
  self.__BuyGiftCallback = BindCallback(self, self.__BuyGift)
end

function UINEventComebackShop:InitComebackShop(comebackId)
  local comebackCfg = ConfigData.activity_user_return[comebackId]
  self._pageId = comebackCfg.inPage
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
  local giftInfos = payGiftCtrl:GetShowPayGiftByPageId(self._pageId, true)
  self._giftPool:HideAll()
  for i, giftInfo in ipairs(giftInfos) do
    local item = self._giftPool:GetOne()
    item:InitComebackGift(giftInfo, self.__BuyGiftCallback)
  end
end

function UINEventComebackShop:__RefreshGiftItem()
  for i, item in ipairs(self._giftPool.listItem) do
    item:RefreshComebackShopItem()
  end
end

function UINEventComebackShop:__BuyGift(giftInfo)
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
  payGiftCtrl:SendBuyGifit(giftInfo.defaultCfg, nil, function()
    self:__RefreshGiftItem()
  end)
end

return UINEventComebackShop
