require("component_base")
_class("BuyGiftComponent", ICampaignComponent)
BuyGiftComponent = BuyGiftComponent

function BuyGiftComponent:Constructor()
  self.m_component_info = BuyGiftComponentInfo:New()
end

function BuyGiftComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = BuyGiftComponentInfo:New()
  end
  return self.m_component_info
end

function BuyGiftComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function BuyGiftComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_BUY_GIFT
end

function BuyGiftComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function BuyGiftComponent:GetGiftTypeKey(gift_type)
  local type2id = {
    [CampaignGiftType.ECGT_ADVANCED] = "str_activity_battlepass_elite",
    [CampaignGiftType.ECGT_LUXURY] = "str_activity_battlepass_deluxe",
    [CampaignGiftType.ECGT_ADDITIONALBUY] = "str_activity_battlepass_deluxe"
  }
  return type2id[gift_type]
end

function BuyGiftComponent:HandleApplyBuyGift(TT, asyncRes, gift_id, count)
  local request = BuyGiftComponentApplyBuyReq:New()
  local response = BuyGiftComponentApplyBuyRep:New()
  request.m_gift_id = gift_id
  request.m_buy_count = count
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][BuyGiftComponent] HandleApplyBuyGift ret:", asyncRes.m_result)
    return nil
  end
  asyncRes:SetSucc(true)
end

function BuyGiftComponent:CampaignComponentPushNotify(notify_data)
  if BuyGiftComponentNotifyType.BuyGiftComponentNotify_BuyStateChanged == notify_data.m_notify_type then
    local ev = NotifyBuyGiftComponentBuyStateChange:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self:OnBuyStateChanged(ev)
    else
      Log.error("[CampaignCom][BuyGiftComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function BuyGiftComponent:OnBuyStateChanged(ev)
  self.m_component_info.m_buy_gift_map = ev.m_buy_gift_map
  self.m_component_info.m_buy_state = ev.m_buy_state
end

function BuyGiftComponent:GetAllGiftIDByType(gift_type)
  local tb = {}
  for index, value in ipairs(self.m_component_info.m_campaign_gift_list) do
    if value.m_gift_type == gift_type then
      table.insert(tb, value.m_gift_id)
      Log.debug("BuyGiftComponent:GetAllGiftIDByType() gift_type = ", gift_type, ", gift_id = ", value.m_gift_id)
    end
  end
  return tb
end

function BuyGiftComponent:GetFirstGiftIDByType(gift_type)
  local list = self:GetAllGiftIDByType(gift_type)
  return list[1] or 0
end

function BuyGiftComponent:GetAllGiftMidasId()
  local tb = {}
  for index, value in ipairs(self.m_component_info.m_campaign_gift_list) do
    local midasId = self.m_component_info.m_is_us and value.m_us_midas_id or value.m_midas_id
    if not string.isnullorempty(midasId) then
      table.insert(tb, midasId)
    end
  end
  return tb
end

function BuyGiftComponent:GetGiftMidasIdById(gift_id)
  for index, value in ipairs(self.m_component_info.m_campaign_gift_list) do
    if value.m_gift_id == gift_id then
      return self.m_component_info.m_is_us and value.m_us_midas_id or value.m_midas_id
    end
  end
end

function BuyGiftComponent:GetAllGiftLocalPrice()
  local tb = self:GetAllGiftMidasId()
  local mPay = GameGlobal.GetModule(PayModule)
  mPay:GetLocalPrice(tb)
end

function BuyGiftComponent:GetGiftPriceById(gift_id)
  local midasId = self:GetGiftMidasIdById(gift_id)
  local mPay = GameGlobal.GetModule(PayModule)
  local goodPriceList = mPay:GetGoodPriceList()
  Log.debug("BuyGiftComponent:GetGiftPriceById() midasId = ", midasId, " goodPriceList = ")
  for k, v in pairs(goodPriceList) do
    Log.debug("k : ", k, "v : ", v)
  end
  return goodPriceList[midasId]
end

function BuyGiftComponent:GetGiftPriceForShowById(gift_id)
  local giftPrice = self:GetGiftPriceById(gift_id)
  return giftPrice and giftPrice.price or ""
end

function BuyGiftComponent:GetGiftPriceForBuyById(gift_id)
  local giftPrice = self:GetGiftPriceById(gift_id)
  return giftPrice and giftPrice.microprice / 1000000 or 0
end

function BuyGiftComponent:GetGiftExtraAwardById(gift_id)
  for index, value in ipairs(self.m_component_info.m_campaign_gift_list) do
    if value.m_gift_id == gift_id then
      return value.m_extra_award
    end
  end
  return {}
end

function BuyGiftComponent:GetGiftBuyCount(gift_id)
  local gift = self:GetGoodCfgById(gift_id)
  local buyCount = self.m_component_info.m_buy_gift_map[gift_id] or 0
  local saleCount = gift and gift.SaleNum or 0
  return buyCount, saleCount
end

function BuyGiftComponent:GetGiftCfgById(gift_id)
  local componentCfgId = self:GetComponentCfgId()
  local gifts = Cfg.cfg_component_buy_gift({ComponentID = componentCfgId, GiftID = gift_id})
  return gifts[1]
end

function BuyGiftComponent:GetGiftCfgShowAwardById(gift_id)
  local gift = self:GetGiftCfgById(gift_id)
  local tb = {}
  if gift then
    for i = 1, #gift.ShowIcon do
      local info = {
        ShowIcon = gift.ShowIcon[i],
        ShowDesc = gift.ShowDesc[i]
      }
      table.insert(tb, info)
    end
  end
  return tb
end

function BuyGiftComponent:GetGoodCfgById(gift_id)
  return Cfg.cfg_shop_common_goods[gift_id]
end

function BuyGiftComponent:BuyGift(gift_id, gift_num, gift_type)
  local good = self:GetGoodCfgById(gift_id)
  local saleType = good.SaleType
  if saleType == 888 then
    self:BuyGift_DirectAMidas(gift_id, gift_type)
  else
    self:BuyGift_RoleAsset(gift_id, gift_num)
  end
end

function BuyGiftComponent:BuyGift_RoleAsset(gift_id, gift_num)
  GameGlobal.TaskManager():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local ret = self:HandleApplyBuyGift(TT, res, gift_id, gift_num)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityNormalBuyResult, gift_id, res)
  end, self)
end

function BuyGiftComponent:BuyGift_DirectAMidas(gift_id, gift_type)
  local midasId = self:GetGiftMidasIdById(gift_id)
  local price = self:GetGiftPriceForBuyById(gift_id)
  local item = UIActivityPayItem:New(gift_id)
  item:SetMidasId(midasId)
  item:SetPrice(price)
  if IsPc() or IsUnityEditor() then
    if gift_type == CampaignGiftType.ECGT_SENIOR_SKIN then
      local giftCfg = self:GetGiftCfgById(gift_id)
      Log.debug("BuyGift_DirectAMidas gift_id: ", gift_id)
      if giftCfg then
        Log.debug("BuyGift_DirectAMidas giftCfg.Name:", StringTable.Get(giftCfg.Name[1]))
        item:SetName(StringTable.Get(giftCfg.Name[1]))
      end
      local showPrice = self:GetGiftPriceForShowById(gift_id)
      item:SetPriceWithCurrencySymbol(showPrice)
    elseif gift_type ~= nil then
      local typeKey = self:GetGiftTypeKey(gift_type)
      local typeName = StringTable.Get(typeKey)
      local showPrice = self:GetGiftPriceForShowById(gift_id)
      local giftName = StringTable.Get("str_activity_battlepass_n5_main_title")
      item:SetPriceWithCurrencySymbol(showPrice)
      item:SetName(giftName .. typeName)
    else
      local giftCfg = self:GetGiftCfgById(gift_id)
      Log.debug("BuyGift_DirectAMidas gift_id: ", gift_id)
      if giftCfg then
        Log.debug("BuyGift_DirectAMidas giftCfg.Name:", StringTable.Get(giftCfg.Name[1]))
        item:SetName(StringTable.Get(giftCfg.Name[1]))
      end
      local showPrice = self:GetGiftPriceForShowById(gift_id)
      item:SetPriceWithCurrencySymbol(showPrice)
    end
  end
  if string.isnullorempty(midasId) then
    GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.ClickPurchaseButton, false, -1, "midasId_is_empty")
    Log.fatal("### [Pay]midasId can't be empty")
    return
  end
  GameGlobal.TaskManager():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local ret = self:HandleApplyBuyGift(TT, res, item:GetId(), item:GetBuyCount())
    if res:GetSucc() then
      self:CanCharge(item)
    end
  end, self)
end

function BuyGiftComponent:CanCharge(item)
  GameGlobal.UIStateManager():Lock("BuyGiftComponent:CanCharge")
  GameGlobal.TaskManager():StartTask(self.CanChargeCoro, self, item)
end

function BuyGiftComponent:CanChargeCoro(TT, item)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local payModule = GameGlobal.GetModule(PayModule)
  if roleModule:IsJapanZone() and payModule:NeedSelectAge(TT) then
    GameGlobal.UIStateManager():ShowDialog("UISetAgeConfirmController")
  else
    GameGlobal.TaskManager():StartTask(self.BuyGoodsTask, self, item)
  end
  GameGlobal.UIStateManager():UnLock("BuyGiftComponent:CanCharge")
end

function BuyGiftComponent:BuyGoodsTask(TT, item)
  local mPay = GameGlobal.GetModule(PayModule)
  if IsAndroid() or IsUnityEditor() or IsPc() then
    if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
      local res, replyEvent = mPay:SendBuyGoodsRequest(TT, item:GetMidasId(), item:GetBuyCount())
      Log.debug("BuyGiftComponent:BuyGoodsTask IsAndroid start res ", res.m_result)
      if not res:GetSucc() then
        if res.m_result == PayErrorCode.PAY_ERROR_NOT_USE_MIDAS then
          PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_pay_direct_buy_need_open_switch"))
        else
          PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_pay_direct_buy_fail_try_later"))
        end
      elseif not replyEvent then
        Log.debug("BuyGiftComponent:BuyGoodsTask failed no replyEvent")
      elseif res.m_result == PayErrorCode.PAY_SUCC then
        local token = replyEvent.token
        local url = replyEvent.url_params
        Log.debug("BuyGiftComponent:BuyGoodsTask success token ", token, " url ", url)
        mPay:BuyCampaignGoodsByUrl(url, item)
      end
    elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
      mPay:BuyCampaignGoods(item)
    end
  elseif IsIos() then
    mPay:BuyCampaignGoods(item)
  end
end
