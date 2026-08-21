_class("UIShopGiftPackDetail", UIController)
UIShopGiftPackDetail = UIShopGiftPackDetail

function UIShopGiftPackDetail:Constructor()
  self.shopModule = self:GetModule(ShopModule)
  self.clientShop = self.shopModule:GetClientShop()
  self._giftData = self.clientShop:GetGiftPackShopData()
  self._flashSaleData = self.clientShop:GetFlashSaleShopData()
end

function UIShopGiftPackDetail:OnShow(uiParams)
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._goTips = self:GetGameObject("tips")
  self._txtTips = self:GetUIComponent("UILocalizationText", "txtTips")
  self._imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self._goLimit = self:GetGameObject("limit")
  self._goLimit:SetActive(false)
  self._txtLimit = self:GetUIComponent("UILocalizationText", "txtLimit")
  self._imgPrice = self:GetUIComponent("Image", "imgPrice")
  self._txtPrice = self:GetUIComponent("UILocalizationText", "txtPrice")
  self._sopImmediately = self:GetUIComponent("UISelectObjectPath", "sopImmediately")
  self._sopDaily = self:GetUIComponent("UISelectObjectPath", "sopDaily")
  self._goDaily = self:GetGameObject("daily")
  self.txtGetDaily = self:GetUIComponent("UILocalizationText", "txtGetDaily")
  self._btnBuy = self:GetUIComponent("Button", "btnBuy")
  self._anim = self:GetUIComponent("Animation", "uiAnim")
  self._atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self._id = uiParams[1]
  self._shopMainTabType = uiParams[2] or ShopMainTabType.Gift
  self:Flush(self._id)
end

function UIShopGiftPackDetail:Flush(id)
  self._itemData = self._giftData:GetGoodBuyId(id)
  self._txtName:SetText(self._itemData:GetName())
  self:FlushTips()
  self._imgIcon:LoadImage(self._itemData:GetIconDetail())
  local str = self._itemData:GetCountStr()
  if string.isnullorempty(str) then
    self._goLimit:SetActive(false)
  else
    self._txtLimit:SetText(str)
    self._goLimit:SetActive(true)
  end
  if self._itemData:IsMonthCard() and self._itemData:HasSoldOut() then
    local f = 0.2980392156862745
    self._txtPrice.color = Color(f, f, f)
    self._btnBuy.interactable = false
  else
    self._txtPrice.color = Color.white
    self._btnBuy.interactable = true
  end
  self:FlushPrice()
  local awardsImmediately = self._itemData:GetAwardsImmediately()
  self._sopImmediately:SpawnObjects("UIShopGiftPackGetItem", table.count(awardsImmediately))
  local lstImmediately = self._sopImmediately:GetAllSpawnList()
  for i, ui in ipairs(lstImmediately) do
    ui:Flush(awardsImmediately[i])
  end
  local awardsDaily = self._itemData:GetAwardsDaily()
  if awardsDaily and table.count(awardsDaily) > 0 then
    self._goDaily:SetActive(true)
    self._sopDaily:SpawnObjects("UIShopGiftPackGetItem", table.count(awardsDaily))
    local lstDaily = self._sopDaily:GetAllSpawnList()
    for i, ui in ipairs(lstDaily) do
      ui:Flush(awardsDaily[i])
    end
  else
    self._goDaily:SetActive(false)
  end
  if self._itemData.isWeekCard then
    self.txtGetDaily:SetText(StringTable.Get("str_pay_gain_daily", 7))
  else
    self.txtGetDaily:SetText(StringTable.Get("str_pay_gain_daily", 30))
  end
end

function UIShopGiftPackDetail:FlushTips()
  if self._itemData:IsWeekCard() then
    if self._itemData:GetBuyCount() > 0 then
      self._txtTips:SetText(StringTable.Get("str_pay_soldout"))
    else
      self._txtTips:SetText(StringTable.Get("str_pay_not_buy_yet"))
    end
  else
    local strCycleType = self._itemData:GetCycleTypeStr()
    if string.isnullorempty(strCycleType) then
      self._goTips:SetActive(false)
    else
      self._goTips:SetActive(true)
      self._txtTips:SetText(strCycleType)
    end
  end
end

function UIShopGiftPackDetail:FlushPrice()
  local function SetPrice()
    local itemtType = self._itemData:GetType()
    
    if itemtType == GiftPackType.Currency then
      self._imgPrice.gameObject:SetActive(false)
      self._txtPrice:SetText(self._itemData:GetPriceWithCurrencySymbol())
    elseif itemtType == GiftPackType.Free then
      self._imgPrice.gameObject:SetActive(false)
      self._txtPrice:SetText(StringTable.Get("str_pay_free"))
    else
      self._imgPrice.gameObject:SetActive(true)
      self._imgPrice.sprite = self._atlas:GetSprite(self._itemData:GetPriceIcon())
      self._txtPrice:SetText(self._itemData:GetPrice())
    end
  end
  
  if self._itemData:IsWeekCard() then
    if self._itemData:GetBuyCount() > 0 then
      self._imgPrice.gameObject:SetActive(false)
      self._txtPrice:SetText(StringTable.Get("str_pay_soldout"))
    else
      SetPrice()
    end
  else
    SetPrice()
  end
end

function UIShopGiftPackDetail:OnHide()
end

function UIShopGiftPackDetail:bgOnClick(go)
  self:Lock("UIShopGiftPackDetail:OnHide")
  self._anim:Play("Uieff_UIShopGiftPackDetail_Out")
  self:StartTask(function(TT)
    YIELD(TT, 667)
    self:UnLock("UIShopGiftPackDetail:OnHide")
    self:CloseDialog()
  end, self)
end

function UIShopGiftPackDetail:btnBuyOnClick(go)
  if self._itemData:IsWeekCard() and self._itemData:GetBuyCount() > 0 then
    return
  end
  local packType = self._itemData:GetType()
  if not self._itemData:CheckDayCount() then
    self:CloseDialog()
    return
  end
  if self._itemData:HasSoldOut() then
    if packType == GiftPackType.Currency then
      GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.ClickPurchaseButton, false, -1, "buy_limit_reached")
    end
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_pay_buy_limit_reached"))
    self:CloseDialog()
    return
  end
  if packType == GiftPackType.Currency then
    local midasId = self._itemData:GetMidasId()
    if string.isnullorempty(midasId) then
      GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.ClickPurchaseButton, false, -1, "midasId_is_empty")
      Log.fatal("### [Pay]midasId can't be empty")
      self:CloseDialog()
      return
    end
    self:StartTask(function(TT)
      self:Lock("UIShopGiftPackDetailRequestBuyGift")
      local ret = self.shopModule:BuyGift(TT, self._itemData:GetId())
      if ClientShop.CheckShopCode(ret) then
        self:CanCharge(midasId)
      elseif ret == SHOP_CODE.SHOP_GOODS_SELLED_OUT then
        self.clientShop:SendProtocal(TT, self._shopMainTabType)
      end
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopNew)
      self:UnLock("UIShopGiftPackDetailRequestBuyGift")
    end, self)
  elseif packType == GiftPackType.Yaojing then
    local price = self._itemData:GetPrice()
    if self.clientShop:CheckEnoughYJ(price) then
      self:RequestBuyGift()
    else
      self:CloseDialog()
    end
  elseif packType == GiftPackType.Guangpo then
    local price = self._itemData:GetPrice()
    if self.clientShop:CheckEnoughGP(price) then
      self:RequestBuyGift()
    else
      self:CloseDialog()
    end
  elseif packType == GiftPackType.Item then
    local mRole = self:GetModule(RoleModule)
    local price = self._itemData:GetPrice()
    local assetId = self._itemData:GetPriceItemId()
    local count = mRole:GetAssetCount(assetId)
    if price <= count then
      self:RequestBuyGift()
    else
      PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_pay_item_not_enough"))
    end
  elseif packType == GiftPackType.Free then
    self:RequestBuyGift()
  else
    Log.fatal("### invalid GiftPackType. packType=", packType)
  end
end

function UIShopGiftPackDetail:RequestBuyGift()
  self:StartTask(function(TT)
    self:Lock("UIShopGiftPackDetailRequestBuyGift")
    local id = self._itemData:GetId()
    local ret = self.shopModule:BuyGift(TT, id)
    if ClientShop.CheckShopCode(ret) then
      local mPay = GameGlobal.GetModule(PayModule)
      mPay:ShowUIShopRechargeGainWithoutYJ(self._itemData)
    end
    self.clientShop:SendProtocal(TT, self._shopMainTabType)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopNew)
    self:UnLock("UIShopGiftPackDetailRequestBuyGift")
    self:CloseDialog()
  end, self)
end

function UIShopGiftPackDetail:CanCharge(midasId)
  self:Lock("UIShopGiftPackDetail_CanCharge")
  GameGlobal.TaskManager():StartTask(self.CanChargeCoro, self, midasId)
end

function UIShopGiftPackDetail:CanChargeCoro(TT, midasId)
  local roleModule = GameGlobal.GetModule(RoleModule)
  if not roleModule:IsJapanZone() then
    self:StartTask(self.BuyGoodsTask, self, midasId, 1)
    self:UnLock("UIShopGiftPackDetail_CanCharge")
    return
  end
  local payModule = GameGlobal.GetModule(PayModule)
  if payModule:NeedSelectAge(TT) then
    self:ShowDialog("UISetAgeConfirmController")
    self:UnLock("UIShopGiftPackDetail_CanCharge")
    return
  end
  self:StartTask(self.BuyGoodsTask, self, midasId, 1)
  self:UnLock("UIShopGiftPackDetail_CanCharge")
end

function UIShopGiftPackDetail:BuyGoodsTask(TT, itemId, itemCount)
  local mPay = self:GetModule(PayModule)
  if IsAndroid() or IsUnityEditor() or IsPc() then
    if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
      local res, replyEvent = mPay:SendBuyGoodsRequest(TT, itemId, itemCount)
      Log.debug("UIDemoPayController:BuyGoodsTask IsAndroid start res ", res.m_result)
      if not res:GetSucc() then
        if res.m_result == PayErrorCode.PAY_ERROR_NOT_USE_MIDAS then
          PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_pay_direct_buy_need_open_switch"))
        else
          PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_pay_direct_buy_fail_try_later"))
        end
      elseif not replyEvent then
        Log.debug("UIDemoPayController:BuyGoodsTask failed no replyEvent")
      elseif res.m_result == PayErrorCode.PAY_SUCC then
        local token = replyEvent.token
        local url = replyEvent.url_params
        Log.debug("UIDemoPayController:BuyGoodsTask success token ", token, " url ", url)
        mPay:BuyGoodsByUrl(url, self._itemData)
      end
    elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
      mPay:BuyGoodsByGiftPackShopItem(self._itemData, itemCount)
    end
  elseif IsIos() then
    mPay:BuyGoodsByGiftPackShopItem(self._itemData, itemCount)
  end
end

function UIShopGiftPackDetail:_FlushDuplicateSkinTip()
  local convertID, convertCount
  local cfg = Cfg.cfg_shop_giftmarket_goods[self._itemData:GetId()]
  if cfg.IsSkin then
    local petSkin
    local awardsImmediately = self._itemData:GetAwardsImmediately()
    local petModule = GameGlobal.GetModule(PetModule)
    for _, award in ipairs(awardsImmediately) do
      local id = award:GetTemplateId()
      if petModule:IsPetSkinID(id) then
        petSkin = id
        break
      end
    end
    local obtained = false
    if petSkin then
      obtained = GameGlobal.GetModule(RoleModule):GetAssetCount(petSkin) > 0
    end
    if obtained then
      Log.info("礼包中的时装已获得:", petSkin)
      local cfgSkin = Cfg.cfg_pet_skin[petSkin - RoleAssetID.RoleAssetPetSkinBegin]
      if not cfgSkin or not cfgSkin.SkinAward then
        Log.error("err:UIShopGiftPackDetail  cfgSkin.SkinAward is null ", petSkin)
      else
        if #cfgSkin.SkinAward ~= 1 then
          Log.exception("重复时装转化配置错误,只允许转化成一种物品:", self._itemData:GetId())
        end
        convertID = cfgSkin.SkinAward[1][1]
        convertCount = cfgSkin.SkinAward[1][2]
      end
    end
  end
  if convertID and convertCount then
    local itemName = StringTable.Get(Cfg.cfg_item[convertID].Name)
    local tip = StringTable.Get("str_pay_duplicate_skin_tip", convertCount, itemName)
    self:GetGameObject("SkinTip"):SetActive(true)
    self:GetUIComponent("UILocalizationText", "SkinTipText"):SetText(tip)
    self._itemData:SetSkinConvertAward(NewRoleAsset(convertID, convertCount))
  else
    self:GetGameObject("SkinTip"):SetActive(false)
    self._itemData:SetSkinConvertAward(nil)
  end
end
