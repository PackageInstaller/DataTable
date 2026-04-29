_class("UIShopSkinsItem", UICustomWidget)
UIShopSkinsItem = UIShopSkinsItem

function UIShopSkinsItem:OnShow(uiParams)
  self.shopModule = self:GetModule(ShopModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self.clientShop = self.shopModule:GetClientShop()
  self._data = self.clientShop:GetSkinsShopData()
  self:InitWidget()
end

function UIShopSkinsItem:SetOutTimeClickFunc(clickFunc)
  self._overTimeClickFunc = clickFunc
end

function UIShopSkinsItem:InitWidget()
  self.discount = self:GetGameObject("discount")
  self.txtDiscount = self:GetUIComponent("UILocalizationText", "txtDiscount")
  self.price = self:GetGameObject("price")
  self.priceDiscount = self:GetGameObject("priceDiscount")
  self.txtPrice = self:GetUIComponent("UILocalizationText", "txtPrice")
  self.imgPrice = self:GetUIComponent("Image", "imgPrice")
  self.txtPriceRaw = self:GetUIComponent("UILocalizationText", "txtPriceRaw")
  self.txtPriceDiscount = self:GetUIComponent("UILocalizationText", "txtPriceDiscount")
  self.imgPriceRaw = self:GetUIComponent("Image", "imgPriceRaw")
  self.otherText = self:GetUIComponent("UILocalizationText", "otherText")
  self._imgBg = self:GetUIComponent("Image", "imgBg")
  self._imgIcon = self:GetUIComponent("RawImageLoader", "ImgIcon")
  self._restTimeAreaGo = self:GetGameObject("RestTimeArea")
  self._restTimeText = self:GetUIComponent("UILocalizationText", "RestTimeText")
  self._logo = self:GetUIComponent("RawImageLoader", "Logo")
  self._petName = self:GetUIComponent("UILocalizationText", "PetName")
  self._skinName1 = self:GetUIComponent("UILocalizationText", "SkinName1")
  self._skinName2 = self:GetUIComponent("UILocalizationText", "SkinName2")
  self._skinName3 = self:GetUIComponent("UILocalizedTMP", "SkinName3")
  self._skinName4 = self:GetUIComponent("UILocalizationText", "SkinName4")
  self._skinName5 = self:GetUIComponent("UILocalizationText", "SkinName5")
  self._uiBase1 = self:GetGameObject("uiBase1")
  self._flagAreaGo = self:GetGameObject("FlagArea")
  self._specialFlagAreaGo = self:GetGameObject("SpecialFlagArea")
  self._uiSpecial4 = self:GetGameObject("uiSpecial4")
  self._uiSpecial5 = self:GetGameObject("uiSpecial5")
  self._eff3 = self:GetUIComponent("RectTransform", "eff3")
  self._eff4 = self:GetUIComponent("RectTransform", "eff4")
  self._flagText = self:GetUIComponent("UILocalizationText", "FlagText")
  self._btnPrice = self:GetUIComponent("Image", "btnPrice")
  self._gotAreaGo = self:GetGameObject("GotArea")
  self.imgNew = self:GetGameObject("imgNew")
  self.imgNew:SetActive(false)
  self._binderSkin = self:GetGameObject("binderSkin")
  self._zg_price = self:GetUIComponent("UILocalizationText", "zg_price")
  self._binder_yj_img = self:GetUIComponent("Image", "yj_img")
  self._yj_price = self:GetUIComponent("UILocalizationText", "yj_price")
  self._saleDownTimeGo = self:GetGameObject("saleDownTimeGo")
  self._saleDownTimeTex = self:GetUIComponent("UILocalizationText", "saleDownTimeTex")
  self._atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self._atlasBg = self:GetAsset("UIShop.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.UpdateSkinsItemPrice, self.FlushPrice)
end

function UIShopSkinsItem:OnHide()
  self:DetachEvent(GameEventType.UpdateSkinsItemPrice, self.FlushPrice)
  self:CancelEvent()
  if self._saleDownTimer then
    GameGlobal.RealTimer():CancelEvent(self._saleDownTimer)
  end
end

function UIShopSkinsItem:CancelEvent()
  if self._event then
    GameGlobal.RealTimer():CancelEvent(self._event)
    self._event = nil
  end
end

function UIShopSkinsItem:SetData()
end

function UIShopSkinsItem:BgOnClick(go)
  if self:_IsOverTime() then
    if self._overTimeClickFunc then
      self._overTimeClickFunc()
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopNew)
    return
  end
  if self._itemData:IsSeniorSkin() then
    self:CheckSkin()
  else
    self:ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUT_SHOP_DETAIL, self._itemData)
  end
  self.shopModule:CancelNewMark(MarketType.Shop_SkinMarket, self._itemData:GetId())
  local binderItem = self._itemData:GetBinderSkin()
  if binderItem ~= nil then
    self.shopModule:CancelNewMark(MarketType.Shop_SkinMarket, binderItem:GetId())
    binderItem:SetNew(false)
  end
  self._itemData:SetNew(false)
  local tempData = self._data:GetGoodById(self._itemData:GetId())
  tempData:SetNew(false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopNew)
  self:FlushNew()
end

function UIShopSkinsItem:_IsOverTime()
  local stopTime = self._itemData:GetEndTime()
  if stopTime <= 0 then
    return false
  end
  local nowTime = math.floor(self._svrTimeModule:GetServerTime() / 1000)
  local remainingTime = stopTime - nowTime
  return remainingTime <= 0
end

function UIShopSkinsItem:Flush(id)
  self:CancelEvent()
  self._itemData = self._data:GetGoodById(id)
  if not self._itemData then
    return
  end
  self._skinId = self._itemData:GetSkinId()
  local skinCfg = Cfg.cfg_pet_skin[self._skinId]
  if not skinCfg then
    return
  end
  local petCfg = Cfg.cfg_pet[skinCfg.PetId]
  if not petCfg then
    return
  end
  if skinCfg.SkinType == 1 then
    self._imgBg.sprite = self._atlasBg:GetSprite("shop_shizhuang_di01")
  elseif skinCfg.SkinType == 2 then
    self._imgBg.sprite = self._atlasBg:GetSprite("shop_shizhuang_di01")
  elseif skinCfg.SkinType == 3 then
    self._imgBg.sprite = self._atlasBg:GetSprite("shop_shizhuang_di02")
  elseif skinCfg.SkinType == 4 then
    self._imgBg.sprite = self._atlasBg:GetSprite("shop_shizhuang_di06")
  elseif skinCfg.SkinType == 5 then
    self._imgBg.sprite = self._atlasBg:GetSprite("shop_shizhuang_di06")
  else
    self._imgBg.sprite = self._atlasBg:GetSprite("shop_shizhuang_di01")
  end
  self._skinName1:SetText(StringTable.Get(skinCfg.SkinName))
  self._skinName2:SetText(StringTable.Get(skinCfg.SkinName))
  self._skinName3:SetText(StringTable.Get(skinCfg.SkinName))
  self._skinName4:SetText(StringTable.Get(skinCfg.SkinName))
  self._skinName5:SetText(StringTable.Get(skinCfg.SkinName))
  if skinCfg.SkinShopCG ~= nil then
    self._imgIcon:LoadImage(skinCfg.SkinShopCG)
  end
  self._uiBase1:SetActive(skinCfg.SkinType == 1)
  self._flagAreaGo:SetActive(skinCfg.SkinType == 2)
  self._specialFlagAreaGo:SetActive(skinCfg.SkinType == 3)
  self._uiSpecial4:SetActive(skinCfg.SkinType == 4)
  self._uiSpecial5:SetActive(skinCfg.SkinType == 5)
  self._eff3.gameObject:SetActive(skinCfg.SkinType == 3)
  self._eff4.gameObject:SetActive(skinCfg.SkinType == 4)
  self._eff4.gameObject:SetActive(skinCfg.SkinType == 5)
  self._restTimeAreaGo:SetActive(self:IsShowRemainingTime())
  self:_OnValueRemainingTime()
  self:_OnValueSaleDownRemainingTime()
  local nameStr = StringTable.Get(petCfg.Name)
  if skinCfg.UnlockSkinID then
    local otherSkinCfg = Cfg.cfg_pet_skin[skinCfg.UnlockSkinID]
    if otherSkinCfg then
      local otherPetCfg = Cfg.cfg_pet[otherSkinCfg.PetId]
      if otherPetCfg then
        nameStr = nameStr .. "/" .. StringTable.Get(otherPetCfg.Name)
      end
    end
  end
  self._petName:SetText(nameStr)
  self._logo:LoadImage(petCfg.Logo)
  self:FlushDiscount()
  self:FlushPrice()
  self:FlushNew()
end

function UIShopSkinsItem:FlushDiscount()
  local discount = self._itemData:GetDiscountEx(true)
  if discount then
    local discountStr = StringTable.Get("str_pay_discount_percent", string.format("<size=36>%s</size>", discount))
    self.discount:SetActive(true)
    self.txtDiscount:SetText(discountStr)
  else
    self.discount:SetActive(false)
  end
end

function UIShopSkinsItem:FlushPrice()
  local isSeniorSkin = self._itemData:IsSeniorSkin()
  self.price:SetActive(false)
  self.priceDiscount:SetActive(false)
  self._binderSkin:SetActive(false)
  self.otherText.gameObject:SetActive(false)
  if isSeniorSkin then
    self.price.gameObject:SetActive(false)
    self.imgPrice.gameObject:SetActive(false)
    self.otherText:SetText(StringTable.Get("str_pay_goto"))
    self.otherText.gameObject:SetActive(true)
    self._gotAreaGo:SetActive(false)
  elseif self._itemData:HasSoldOut() then
    self._gotAreaGo:SetActive(true)
  else
    self._gotAreaGo:SetActive(false)
    local itemtType = self._itemData:GetType()
    self.imgPriceRaw.gameObject:SetActive(false)
    self.imgPrice.gameObject:SetActive(false)
    if itemtType == GiftPackType.Currency then
      self.price:SetActive(true)
      self.price.gameObject:SetActive(true)
      self.txtPrice:SetText(self._itemData:GetPriceWithCurrencySymbol())
    elseif itemtType == GiftPackType.Free then
      self.price.gameObject:SetActive(false)
      self.imgPrice.gameObject:SetActive(false)
      self.otherText:SetText(StringTable.Get("str_pay_free"))
      self.otherText.gameObject:SetActive(true)
    else
      local binderItem = self._itemData:GetBinderSkin()
      if binderItem ~= nil then
        self._binderSkin:SetActive(true)
        self._binder_yj_img.sprite = self._atlas:GetSprite(self._itemData:GetPriceIcon())
        self._yj_price:SetText(self._itemData:GetPrice())
        local price = binderItem:GetPriceWithCurrencySymbol()
        self._zg_price:SetText(price)
      else
        local discount, discountStr = self._itemData:GetDiscount()
        if discount then
          self.priceDiscount:SetActive(true)
          self.imgPriceRaw.gameObject:SetActive(true)
          self.imgPriceRaw.sprite = self._atlas:GetSprite(self._itemData:GetPriceIcon())
          self.txtPriceRaw:SetText(self._itemData:GetPriceRaw())
          self.txtPriceDiscount:SetText(self._itemData:GetPrice())
        else
          self.price:SetActive(true)
          self.imgPrice.gameObject:SetActive(true)
          self.imgPrice.sprite = self._atlas:GetSprite(self._itemData:GetPriceIcon())
          self.price.gameObject:SetActive(true)
          self.txtPrice:SetText(self._itemData:GetPrice())
        end
      end
    end
  end
end

function UIShopSkinsItem:FlushNew()
  local isNew = self._itemData:GetNew()
  self.imgNew:SetActive(isNew)
end

function UIShopSkinsItem:IsShowRemainingTime()
  local stopTime = self._itemData:GetEndTime()
  if stopTime <= 0 then
    return false
  end
  if not self._itemData:GetIsShowLeftTime() then
    return false
  end
  if self._itemData:IsResident() then
    return false
  end
  return true
end

function UIShopSkinsItem:IsShowSaleDownRemainingTime()
  local goodid = self._itemData:GetId()
  local cfg_shop_common_goods = Cfg.cfg_shop_common_goods[goodid]
  return cfg_shop_common_goods and cfg_shop_common_goods.SellCountDown == 1
end

function UIShopSkinsItem:_ShowSaleDownRemainingTime()
  local stopTime = self._itemData:GetEndTime()
  local nowTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local remainingTime = stopTime - nowTime
  if remainingTime <= 0 then
    if self._saleDownTimer then
      GameGlobal.RealTimer():CancelEvent(self._saleDownTimer)
    end
    self._saleDownTimeGo:SetActive(false)
    remainingTime = 0
  else
    local timeStr = HelperProxy:GetInstance():Time2Tex(remainingTime)
    self._saleDownTimeTex:SetText(StringTable.Get("str_shop_skin_tab_sale_donw_time_str", timeStr))
  end
end

function UIShopSkinsItem:_OnValueSaleDownRemainingTime()
  if not self:IsShowSaleDownRemainingTime() then
    self._saleDownTimeGo:SetActive(false)
    return
  end
  self._saleDownTimeGo:SetActive(true)
  self:_ShowSaleDownRemainingTime()
  if self._saleDownTimer then
    GameGlobal.RealTimer():CancelEvent(self._saleDownTimer)
  end
  self._saleDownTimer = GameGlobal.RealTimer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:_ShowSaleDownRemainingTime()
  end)
end

function UIShopSkinsItem:_OnValueRemainingTime()
  if not self:IsShowRemainingTime() or self:IsShowSaleDownRemainingTime() then
    self._restTimeAreaGo:SetActive(false)
    return
  end
  self:_ShowRemainingTime()
  self:CancelEvent()
  self._event = GameGlobal.RealTimer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:_ShowRemainingTime()
  end)
end

function UIShopSkinsItem:_ShowRemainingTime()
  local stopTime = self._itemData:GetEndTime()
  local nowTime = self._svrTimeModule:GetServerTime() * 0.001
  local remainingTime = stopTime - nowTime
  if remainingTime <= 0 then
    self:CancelEvent()
    self._restTimeAreaGo:SetActive(false)
    remainingTime = 0
  else
    self._restTimeAreaGo:SetActive(true)
  end
  self._restTimeText:SetText(self:_GetFormatString(remainingTime))
end

function UIShopSkinsItem:_GetFormatString(stamp)
  local timeStr = self:GetFormatTimerStr(stamp)
  return timeStr
end

function UIShopSkinsItem:GetFormatTimerStr(time, id)
  local default_id = {
    day = "str_pay_left_day",
    hour = "str_pay_left_hour",
    min = "str_pay_left_minute",
    zero = "str_activity_common_less_minute"
  }
  id = id or default_id
  local timeStr = ""
  if time < 0 then
    timeStr = StringTable.Get(id_zero)
    return timeStr
  end
  local day, hour, min, second = UIActivityHelper.Time2Str(time)
  if 0 < day then
    local showDay = day
    timeStr = StringTable.Get(id.day, showDay)
  elseif 0 < hour then
    local showHour = hour
    timeStr = StringTable.Get(id.hour, showHour)
  elseif 0 < min then
    local showMin = min
    timeStr = StringTable.Get(id.min, showMin)
  else
    timeStr = StringTable.Get(id.zero)
  end
  return timeStr
end

function UIShopSkinsItem:CheckSkin()
  local goodID = self._itemData:GetId()
  local cfg = Cfg.cfg_shop_common_goods[goodID]
  if cfg.JumpID then
    local questModule = GameGlobal.GetModule(QuestModule)
    local jumpModule = questModule.uiModule
    if jumpModule == nil then
      Log.fatal("[quest] error --> uiModule is nil ! --> jumpModule")
      return
    end
    local fromParam = {}
    table.insert(fromParam, QuestType.QT_Daily)
    jumpModule:SetFromUIData(FromUIType.NormalUI, "UIQuestController", UIStateType.UIMain, fromParam)
    local jumpType = cfg.JumpID
    local jumpParams = {}
    jumpModule:SetJumpUIData(jumpType, jumpParams)
    jumpModule:Jump()
    return
  end
  if self._itemData:IsSeniorSkinReview() then
    GameGlobal.GetModule(CampaignModule):GetCurHauteCouture_Review(true, function(data)
      data:ShopGoodsOnClick()
    end)
  else
    self:ShowDialog("UIHauteCoutureDrawV2Controller")
  end
end
