_class("UIActivityReturnSystemBoard", UICustomWidget)
UIActivityReturnSystemBoard = UIActivityReturnSystemBoard

function UIActivityReturnSystemBoard:_GetComponents()
  self._stateObj = {
    {
      self:GetGameObject("bg_normal"),
      self:GetGameObject("bg_limit_normal"),
      self:GetGameObject("title_gift_normal")
    },
    {
      self:GetGameObject("bg_soldout"),
      self:GetGameObject("bg_limit_soldout"),
      self:GetGameObject("title_gift_soldout")
    }
  }
  self._pressObj = {
    {
      self:GetGameObject("bg_click_normal")
    },
    {
      self:GetGameObject("bg_click_pressed")
    }
  }
  self._limitObj = {
    {
      self:GetGameObject("limit")
    }
  }
  self._freeObj = {
    {
      self:GetGameObject("title_gift_free")
    },
    {
      self:GetGameObject("title_gift_cost")
    }
  }
  self._textGiftName = {
    self:GetUIComponent("UILocalizationText", "txtGiftName_free"),
    self:GetUIComponent("UILocalizationText", "txtGiftName_cost"),
    self:GetUIComponent("UILocalizationText", "txtGiftName_soldout")
  }
  self._textGiftPrice = {
    self:GetUIComponent("UILocalizationText", "txtGiftPrice_free"),
    self:GetUIComponent("UILocalizationText", "txtGiftPrice_cost"),
    self:GetUIComponent("UILocalizationText", "txtGiftPrice_soldout")
  }
  self._txtLimit = self:GetUIComponent("UILocalizationText", "txtLimit")
  self._buyBtn = self:GetUIComponent("Button", "buyBtn")
  self._red = self:GetGameObject("red")
end

function UIActivityReturnSystemBoard:OnShow()
  self._isOpen = true
  self:_GetComponents()
  self:_SetPressEvent()
end

function UIActivityReturnSystemBoard:OnHide()
  self._isOpen = false
end

function UIActivityReturnSystemBoard:SetData(campaign, component, gift_id, callback)
  self._campaign = campaign
  self._component = component
  self._giftId = gift_id
  self._callback = callback
  self._buyCount, self._saleCount = self._component:GetGiftBuyCount(self._giftId)
  self:_SetBg()
  self:_SetState()
  self:_SetPress()
  self:_SetLimit()
  self:_SetFree()
  self:_SetBuyBtn()
  self:_SetText()
end

function UIActivityReturnSystemBoard:_SetBg()
  local normalBg = {
    [1050001] = "shop_libao_back_1000",
    [1050002] = "shop_libao_back_1001",
    [1050003] = "shop_libao_back_1002"
  }
  local pressBg = {
    [1050001] = "shop_libao_back_1000_sel",
    [1050002] = "shop_libao_back_1001_sel",
    [1050003] = "shop_libao_back_1002_sel"
  }
  local soldoutBg = {
    [1050001] = "shop_libao_back_1000_sod",
    [1050002] = "shop_libao_back_1001_sod",
    [1050003] = "shop_libao_back_1002_sod"
  }
  local bg_click_normal = self:GetUIComponent("RawImageLoader", "bg_click_normal")
  bg_click_normal:LoadImage(normalBg[self._giftId])
  local bg_click_pressed = self:GetUIComponent("RawImageLoader", "bg_click_pressed")
  bg_click_pressed:LoadImage(pressBg[self._giftId])
  local bg_soldout = self:GetUIComponent("RawImageLoader", "bg_soldout")
  bg_soldout:LoadImage(soldoutBg[self._giftId])
end

function UIActivityReturnSystemBoard:_SetState()
  self._state = self._buyCount < self._saleCount and 1 or 2
  UIWidgetHelper.SetObjGroupShow(self._stateObj, self._state)
end

function UIActivityReturnSystemBoard:_SetPress()
  UIWidgetHelper.SetObjGroupShow(self._pressObj, 1)
end

function UIActivityReturnSystemBoard:_SetLimit()
  self._limit = self._saleCount ~= SpecialNum.MysteryGoodsUnlimitedNum and 1 or 2
  UIWidgetHelper.SetObjGroupShow(self._limitObj, self._limit)
  local n2m = string.format(" %s/%s", self._saleCount - self._buyCount, self._saleCount)
  local strLimit = string.format(StringTable.Get("str_pay_purchase_limitation_normal", n2m))
  self._txtLimit:SetText(strLimit)
end

function UIActivityReturnSystemBoard:_SetFree()
  local good = self._component:GetGoodCfgById(self._giftId)
  local saleType = good.SaleType
  self._free = saleType == 0 and 1 or 2
  UIWidgetHelper.SetObjGroupShow(self._freeObj, self._free)
  local red = self._buyCount < self._saleCount and saleType == 0
  self._red:SetActive(red)
end

function UIActivityReturnSystemBoard:_SetBuyBtn()
  self._buyBtn.interactable = self._buyCount < self._saleCount
end

function UIActivityReturnSystemBoard:_SetText()
  local gift = self._component:GetGiftCfgById(self._giftId)
  local name = gift.Name[1]
  for _, v in pairs(self._textGiftName) do
    v:SetText(StringTable.Get(name))
  end
  local price = self._component:GetGiftPriceForShowById(self._giftId)
  local good = self._component:GetGoodCfgById(self._giftId)
  if good.SaleType == 0 then
    price = StringTable.Get("str_pay_recharge_label_3")
  end
  for _, v in pairs(self._textGiftPrice) do
    v:SetText(price)
  end
end

function UIActivityReturnSystemBoard:OnBuyResult(res)
  if res:GetSucc() then
    local rewards = self._component:GetGiftExtraAwardById(self._giftId)
    UIActivityHelper.ShowUIGetRewards(rewards)
  else
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, self._callback, nil)
  end
end

function UIActivityReturnSystemBoard:BuyBtnOnClick(go)
  self._giftNum = 1
  if self._buyBtn.interactable then
    Log.info("UIActivityReturnSystemBoard:BuyBtnOnClick")
    self:ShowDialog("UIActivityGiftPackDetail", self._campaign, self._component, self._giftId, self._giftNum, function(res)
      self:OnBuyResult(res)
    end)
  end
end

function UIActivityReturnSystemBoard:_SetPressEvent()
  local obj = self:GetGameObject("buyBtn")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(obj), UIEvent.Press, function(go)
    UIWidgetHelper.SetObjGroupShow(self._pressObj, 2)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(obj), UIEvent.Release, function(go)
    UIWidgetHelper.SetObjGroupShow(self._pressObj, 1)
  end)
end
