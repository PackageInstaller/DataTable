_class("UISimpleHauteCoutureGiftPackDetail", UIController)
UISimpleHauteCoutureGiftPackDetail = UISimpleHauteCoutureGiftPackDetail

function UISimpleHauteCoutureGiftPackDetail:_GetComponents()
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._goTips = self:GetGameObject("tips")
  self._txtTips = self:GetUIComponent("UILocalizationText", "txtTips")
  self._imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self._goLimit = self:GetGameObject("limit")
  self._goLimit:SetActive(false)
  self._txtLimit = self:GetUIComponent("UILocalizationText", "txtLimit")
  self._imgPrice = self:GetUIComponent("Image", "imgPrice")
  self._txtPrice1 = self:GetUIComponent("UILocalizationText", "txtPrice1")
  self._txtPrice2 = self:GetUIComponent("UILocalizationText", "txtPrice2")
  self._sopImmediately = self:GetUIComponent("UISelectObjectPath", "sopImmediately")
  self._sopDaily = self:GetUIComponent("UISelectObjectPath", "sopDaily")
  self._goDaily = self:GetGameObject("daily")
  self._anim = self:GetUIComponent("Animation", "uiAnim")
  self._atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
end

function UISimpleHauteCoutureGiftPackDetail:OnShow(uiParams)
  self:_AttachEvents()
  self._campaign = uiParams[1]
  self._component = uiParams[2]
  self._gift2Id = uiParams[3]
  self._giftNum = uiParams[4]
  self._callback = uiParams[5]
  local cfg = Cfg.cfg_shop_common_goods[self._gift2Id]
  self._gift1Id = cfg.CurrencySkinID
  self:_GetComponents()
  self:_SetTitle()
  self:_SetTips()
  self:_SetImg()
  self:_SetLimit()
  self:_FlushPrice()
  self:_SetAwardsImmediately()
  self:_SetAwardsDaily()
end

function UISimpleHauteCoutureGiftPackDetail:OnHide()
  self:_DetachEvents()
end

function UISimpleHauteCoutureGiftPackDetail:_SetTitle()
  local cfg = Cfg.cfg_component_buy_gift({
    GiftID = self._gift2Id
  })
  if not cfg or next(cfg) == nil then
    Log.exception("cfg_component_buy_gift中找不到礼包:", self._gift2Id)
  end
  cfg = cfg[1]
  self._txtName:SetText(StringTable.Get(cfg.Name[2], cfg.ExtraAward[1][2]))
end

function UISimpleHauteCoutureGiftPackDetail:_SetTips()
  if self._component.m_component_info then
    local strCycleType = self:GetCycleTypeStr()
    self._txtTips:SetText(strCycleType)
    self._goTips:SetActive(true)
  else
    self._goTips:SetActive(false)
  end
end

function UISimpleHauteCoutureGiftPackDetail:_SetImg()
  local cfg = Cfg.cfg_shop_common_goods[self._gift2Id]
  if cfg.IconDetail then
    self._imgIcon:LoadImage(cfg.IconDetail)
  end
end

function UISimpleHauteCoutureGiftPackDetail:_SetLimit()
  local str = self:GetCountStr()
  if string.isnullorempty(str) then
    self._goLimit:SetActive(false)
  else
    self._txtLimit:SetText(str)
    self._goLimit:SetActive(true)
  end
end

function UISimpleHauteCoutureGiftPackDetail:_FlushPrice()
  local price2 = self._component:GetGiftPriceForShowById(self._gift2Id)
  local price1 = Cfg.cfg_shop_common_goods[self._gift1Id].Price
  self._txtPrice2:SetText(price2)
  self._imgPrice.sprite = self._atlas:GetSprite(self:GetPriceIcon())
  self._txtPrice1:SetText(price1)
end

function UISimpleHauteCoutureGiftPackDetail:_SetAwardsImmediately()
  local lst = self._component:GetGiftExtraAwardById(self._gift1Id)
  local awardsImmediately = {}
  for i, item in ipairs(lst) do
    local item = GiftPackShopItemAward:New(item.assetid, item.count)
    table.insert(awardsImmediately, item)
  end
  self._sopImmediately:SpawnObjects("UISimpleHauteCoutureGiftPackGetItem", table.count(awardsImmediately))
  local lstImmediately = self._sopImmediately:GetAllSpawnList()
  for i, ui in ipairs(lstImmediately) do
    ui:Flush(awardsImmediately[i])
  end
end

function UISimpleHauteCoutureGiftPackDetail:_SetAwardsDaily()
  self._goDaily:SetActive(false)
end

function UISimpleHauteCoutureGiftPackDetail:GetEndTime()
  return self._component and self._component.m_component_info.m_close_time
end

function UISimpleHauteCoutureGiftPackDetail:GetLeftSeconds()
  local mSvrTime = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = mSvrTime:GetServerTime() / 1000
  local endTime = self:GetEndTime()
  local leftSeconds = endTime - nowTime
  return leftSeconds
end

function UISimpleHauteCoutureGiftPackDetail:GetCycleTypeStr()
  local str = ""
  local leftSeconds = self:GetLeftSeconds()
  if leftSeconds <= 0 then
    str = StringTable.Get("str_pay_expired")
  elseif leftSeconds <= 60 then
    str = string.format(StringTable.Get("str_pay_left_minute", 1))
  elseif leftSeconds <= 3600 then
    local leftMinutes = math.ceil(leftSeconds / 60)
    str = string.format(StringTable.Get("str_pay_left_minute", leftMinutes))
  elseif leftSeconds <= 86400 then
    local leftHours = math.ceil(leftSeconds / 3600)
    str = string.format(StringTable.Get("str_pay_left_hour", leftHours))
  else
    local leftDays = math.ceil(leftSeconds / 86400)
    str = string.format(StringTable.Get("str_pay_left_day", leftDays))
  end
  return str
end

function UISimpleHauteCoutureGiftPackDetail:GetCountStr()
  local buyCount, saleCount = self._component:GetGiftBuyCount(self._gift1Id)
  if saleCount == SpecialNum.MysteryGoodsUnlimitedNum then
    return ""
  end
  local n2m = saleCount - buyCount .. "/" .. saleCount
  local strLimit = string.format(StringTable.Get("str_pay_purchase_limitation_normal", n2m))
  return strLimit
end

function UISimpleHauteCoutureGiftPackDetail:GetPriceIcon()
  local good = self._component:GetGoodCfgById(self._gift1Id)
  local saleType = good.SaleType
  return "toptoon_" .. saleType
end

function UISimpleHauteCoutureGiftPackDetail:BgOnClick(go)
  self:Lock("UISimpleHauteCoutureGiftPackDetail:OnHide")
  self._anim:Play("Uieff_UIActivityGiftPackDetail_Out")
  self:StartTask(function(TT)
    YIELD(TT, 667)
    self:UnLock("UISimpleHauteCoutureGiftPackDetail:OnHide")
    self:CloseDialog()
  end, self)
end

function UISimpleHauteCoutureGiftPackDetail:BtnBuy1OnClick(go)
  if self._isBuying then
    return
  end
  self:_BuyConfirmForYaojing()
end

function UISimpleHauteCoutureGiftPackDetail:BtnBuy2OnClick(go)
  if self._isBuying then
    return
  end
  self._component:BuyGift(self._gift2Id, self._giftNum, self._giftType)
  self._isBuying = true
end

function UISimpleHauteCoutureGiftPackDetail:_BuyConfirmForYaojing()
  local price = Cfg.cfg_shop_common_goods[self._gift1Id].Price
  local cfg = Cfg.cfg_component_buy_gift({
    GiftID = self._gift2Id
  })
  if not cfg or next(cfg) == nil then
    Log.exception("cfg_component_buy_gift中找不到礼包:", self._gift2Id)
  end
  cfg = cfg[1]
  local giftName = StringTable.Get(cfg.Name[2], cfg.ExtraAward[1][2])
  local strText = StringTable.Get("str_junior_skin_draw_confirm_to_buy", price, giftName)
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", strText, function(param)
    self:_GoBuyFunc()
  end, nil, nil, nil)
end

function UISimpleHauteCoutureGiftPackDetail:_GoBuyFunc()
  local price = Cfg.cfg_shop_common_goods[self._gift1Id].Price
  local shopModule = self:GetModule(ShopModule)
  local clientShop = shopModule:GetClientShop()
  if clientShop:CheckEnoughYJ(price, true, function()
  end) then
    self._component:BuyGift(self._gift1Id, self._giftNum, self._giftType)
    self._isBuying = true
  else
  end
end

function UISimpleHauteCoutureGiftPackDetail:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ActivityCurrencyBuySuccess, self._OnCurrencyBuySuccess)
  self:AttachEvent(GameEventType.ActivityNormalBuyResult, self._OnNormalBuyResult)
end

function UISimpleHauteCoutureGiftPackDetail:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.ActivityCurrencyBuySuccess, self._OnCurrencyBuySuccess)
  self:DetachEvent(GameEventType.ActivityNormalBuyResult, self._OnNormalBuyResult)
end

function UISimpleHauteCoutureGiftPackDetail:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UISimpleHauteCoutureGiftPackDetail:_OnCurrencyBuySuccess(id)
  if self._gift2Id == id then
    if self._callback then
      local res = AsyncRequestRes:New()
      res:SetSucc(true)
      self._callback(res)
    end
    self._isBuying = false
    self:BgOnClick()
  end
end

function UISimpleHauteCoutureGiftPackDetail:_OnNormalBuyResult(gift_id, res)
  if self._gift1Id == gift_id then
    if self._callback then
      self._callback(res)
    end
    self._isBuying = false
    self:BgOnClick()
  end
end
