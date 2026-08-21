local MidasQuestType = {
  MIDAS_QUEST_TYPE_NONE = 0,
  MIDAS_QUEST_TYPE_PAY = 1,
  MIDAS_QUEST_TYPE_BUGYGOODS = 2,
  MIDAS_QUEST_TYPE_SUBSCRIBE = 3
}
_enum("MidasQuestType", MidasQuestType)
local MidasServiceType = {
  SERVICETYPE_NORMAL = 1,
  SERVICETYPE_RENEW = 2,
  SERVICETYPE_UPGRADE = 3
}
_enum("MidasServiceType", MidasServiceType)
local MidasTokenType = {
  GETTOKENTYPE_SERVER = 1,
  GETTOKENTYPE_SDK = 2,
  GETTOKENTYPE_CLIENT = 3
}
_enum("MidasTokenType", MidasTokenType)
local MidasCurrencyGoodsType = {
  MIDAS_CURRENCY_GOODS_TYPE_NONE = 0,
  MIDAS_CURRENCY_GOODS_TYPE_GIFT_PACK = 1,
  MIDAS_CURRENCY_GOODS_TYPE_SKIN = 2,
  MIDAS_CURRENCY_GOODS_TYPE_CAMPAIGN = 3
}
_enum("MidasCurrencyGoodsType", MidasCurrencyGoodsType)
_class("PayModule", GameModule)
PayModule = PayModule

function PayModule:Constructor()
  self.process = "sea"
  self.idc = "local"
  self.env = "test"
  self.idc_info = " "
  self.subscribeInfoList = {}
  self.buyGoodsInfoList = {}
  self.OfferID = H3DGCloudLuaHelper.GetOfferId()
  self.country = "JP"
  self.currencyType = "JPY"
  self._goodPriceList = {}
  self.zone_id = -1
  self.currentProduct = ""
  self.currentCount = "1"
  self.reprovideing = false
  self.language = ""
  self.questType = MidasQuestType.MIDAS_QUEST_TYPE_NONE
  self._viewerId = ""
  self._payToken = ""
  self._payTokenValid = false
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland or H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    self:RegisterObserver()
  end
  self._curBuyItem = nil
end

function PayModule:SetCurItem(item)
  self._curBuyItem = item
end

function PayModule:Dispose()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland or H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    self:UnregisterObserver()
  end
  if self._timerHolder ~= nil then
    GameGlobal.Timer():CancelEvent(self._timerHolder)
  end
end

function PayModule:Init()
  self.caller:RegisterPushHandler(CEventPushSubscribeInfoList, self.HandleSubscribeInfoUpdate, self)
  if IsPc() or IsUnityEditor() then
    self.country = "JP"
    self.currencyType = "JPY"
  else
    local gv = HelperProxy:GetInstance():GetGameVersion()
    if gv == GameVersionType.USA then
      self.country = "US"
      self.currencyType = "USD"
    elseif gv == GameVersionType.HMT then
      self.country = "HK"
      self.currencyType = "HKD"
    elseif Localization.GetCurLanguage() == LanguageType.us then
      self.country = "US"
      self.currencyType = "USD"
    elseif Localization.GetCurLanguage() == LanguageType.kr then
      self.country = "KR"
      self.currencyType = "KRW"
    else
      self.country = "JP"
      self.currencyType = "JPY"
    end
  end
  local storeChannel = SDKProxy:GetInstance():GetStoreChannel()
  if storeChannel == StoreChannel.SC_ONESTORE then
    self.country = "KR"
    self.currencyType = "KRW"
  end
  self.language = SDKProxy:GetInstance():GetCustomerLangType()
end

function PayModule:Load(TT)
  self:LoadMidasConfig(TT)
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland or H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    self:InitMidas()
  end
  self:GetInfo("mp")
  self._timerHolder = GameGlobal.Timer():AddEvent(2000, function()
    self._timerHolder = nil
    GameGlobal.GetModule(ShopModule):GetLocalPriceOnlyForLoginLoad()
  end)
end

function PayModule:LoadMidasConfig(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileLoadMidasConfig)
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  local replyEvent = CEventMobileLoadMidasConfigResult(reply.msg)
  if replyEvent == nil then
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  self.process = replyEvent.process
  self.idc = replyEvent.idc
  if IsPc() or IsUnityEditor() then
    if replyEvent.env and replyEvent.env == "test" then
      self.env = "sandbox"
    else
      self.env = replyEvent.env
    end
  else
    self.env = replyEvent.env
  end
  self.idc_info = replyEvent.idc_info
  Log.debug("[pay]### server pass zone_id : ", replyEvent.zone_id)
  if replyEvent.zone_id ~= nil then
    self.zone_id = replyEvent.zone_id
  end
end

function PayModule:StartMidas()
  Log.debug("[Pay]PayModule:StartMidas")
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland or H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    H3DGCloudLuaHelper.PayStart(self.process)
  end
  H3DGCloudLuaHelper.SetLogEnable(true)
end

function PayModule:InitMidas()
  Log.debug("[Pay]PayModule:InitMidas")
  if H3DGCloudLuaHelper.MsdkStatus ~= MSDKStatus.MS_Inland and H3DGCloudLuaHelper.MsdkStatus ~= MSDKStatus.MS_International then
    return
  end
  if IsIos() or IsAndroid() or IsPc() or IsUnityEditor() then
    local paramTable = self:GetPayParam()
    paramTable.logEnable = "True"
    local param_json = cjson.encode(paramTable)
    if IsPc() or IsUnityEditor() then
      self.idc_info = "{\"release\":{\"k_domain\":\"midas.singaporepaya.com\",\"k_domain_hb\":\"midas.singaporepaya.com\",\"k_ip_list\":[\"119.28.109.70\"]},\"sandbox\":{\"k_domain\":\"sandbox.centauriglobal.com\",\"k_domain_hb\":\"sandbox.centauriglobal.com\",\"k_ip_list\":[\"101.32.133.41\"]},\"dev\":{\"k_domain\":\"dev-api.centauriglobal.qq.com\",\"k_domain_hb\":\"dev-api.centauriglobal.qq.com\",\"k_ip_list\":[]}}"
    end
    Log.debug("[Pay]PayModule:InitMidas ", " idc " .. self.idc, " env " .. self.env, " idc_info " .. self.idc_info, " req_json " .. param_json)
    H3DGCloudLuaHelper.InitSDK(self.idc, self.env, self.idc_info, param_json)
  end
end

function PayModule:OnPayInitFinished(item_info)
  Log.debug("[PayModule] OnPayInitFinished item_info : ", item_info)
  if IsIos() or IsAndroid() then
    GameGlobal.TaskManager():StartTask(self.PreReprovideCallTask, self, nil)
  end
end

function PayModule:SetLogEnable(enable)
  H3DGCloudLuaHelper.SetLogEnable(enable)
end

function PayModule:GetCountryInfo()
  return self.country, self.currencyType
end

function PayModule:SetCountryAndCurrency(country, currencyType)
  self.country = country
  self.currencyType = currencyType
end

function PayModule:OnPayLoginExpired()
  Log.debug("PayModule:OnPayLoginExpired")
  GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.PayResult, false, -1, "midas_login_expired")
  PopupManager.Alert("UIDemoCommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "提示", "用户登录信息已过期,请重新登录", nil, "确认", function()
    self:OnPlayerLoginExpired()
  end)
end

function PayModule:OnPlayerLoginExpired()
  GameGlobal.GameLogic():BackToLogin(false)
end

function PayModule:GetInfo(req_type)
  if self.zone_id == -1 then
    Log.error("zone_id == -1")
    return
  end
  if not UIShopController.CheckIsOpen(ShopMainTabType.Recharge) then
    return
  end
  local paramTable = self:GetPayParam()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland or H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    local param_json = cjson.encode(paramTable)
    Log.debug("### [Pay]PayModule:PayModule:GetInfo req_json ", param_json)
    H3DGCloudLuaHelper.GetInfo(req_type, param_json)
  end
end

function PayModule:OnPayGetInfoFinished(type, retCode, json)
  Log.debug("### [Pay][GetInfo]OnPayGetInfoFinished success, type " .. type, " retCode " .. retCode, " json " .. json)
  if not PayModule.CheckCode(retCode) then
    return
  end
  local tJson = cjson.decode(json)
  if tJson.ret and not PayModule.CheckCode(tJson.ret) then
    return
  end
  local mp_info
  if IsPc() or IsUnityEditor() then
    mp_info = tJson
  elseif IsIos() or IsAndroid() then
    if tJson.msg then
      mp_info = tJson.msg.mp_info
    else
      mp_info = tJson.mp_info
    end
  end
  if not mp_info then
    Log.fatal("### [Pay][GetInfo]mp_info nil.")
    return
  end
  local utp_mpinfo_detail = mp_info.utp_mpinfo_detail
  if not utp_mpinfo_detail then
    Log.fatal("### [Pay][GetInfo]utp_mpinfo_detail nil.")
    return
  end
  local rank_info = utp_mpinfo_detail.rank_info
  if not rank_info or table.count(rank_info) <= 0 then
    Log.fatal("### [Pay][GetInfo]no data in rank_info.")
    return
  end
  self._dictGoodPresent = {}
  for _, item in ipairs(rank_info) do
    local buyCount = tonumber(item.num)
    local giveCount = tonumber(item.send_num)
    local hasBuy = string.isnullorempty(item.send_ext)
    self._dictGoodPresent[buyCount] = {send_num = giveCount, hasBuy = hasBuy}
  end
  local clientShop = self:GetModule(ShopModule):GetClientShop()
  local dataRechargeShop = clientShop:GetRechargeShopData()
  dataRechargeShop:UpdateGoodsPresent()
end

function PayModule:GetGoodPresents()
  return self._dictGoodPresent
end

function PayModule.CheckCode(code)
  if code == 0 then
    return true
  end
  local msg = StringTable.Get("str_pay_query_activity_info_failed")
  if code == 1 then
    msg = "--"
  end
  Log.error(string.format("%s. error code=%d", msg, code))
  return false
end

function PayModule:Recharge(item)
  self._rechargeShopItem = item
  if not UIShopController.CheckIsOpen(ShopMainTabType.Recharge) then
    return
  end
  local midasId = item:GetMidasId()
  if string.isnullorempty(midasId) then
    GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.ClickPurchaseButton, false, -1, "product_midasid_is_empty")
    ToastManager.ShowToast("[PayModule:Recharge]productId can't be empty.")
    return
  end
  local count = tostring(item:GetCount())
  if string.isnullorempty(count) then
    GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.ClickPurchaseButton, false, -1, "diamond_count_is_empty")
    ToastManager.ShowToast("[PayModule:Recharge]diamond count can't be empty.")
    return
  end
  GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.ClickPurchaseButton, true)
  self.questType = MidasQuestType.MIDAS_QUEST_TYPE_PAY
  self._last_goods_id = item:GetId()
  if IsAndroid() then
    local storeChannel = SDKProxy:GetInstance():GetStoreChannel()
    if storeChannel == StoreChannel.SC_AMAZON then
      local exchange_table = {}
      exchange_table["com.tencent.baiyeint.crystal90"] = "com.tencent.baiyeint.crystal90a"
      exchange_table["com.tencent.baiyeint.crystal500"] = "com.tencent.baiyeint.crystal500a"
      exchange_table["com.tencent.baiyeint.crystal1565"] = "com.tencent.baiyeint.crystal1565a"
      exchange_table["com.tencent.baiyeint.crystal3130"] = "com.tencent.baiyeint.crystal3130a"
      exchange_table["com.tencent.baiyeint.crystal5200"] = "com.tencent.baiyeint.crystal5200a"
      exchange_table["com.tencent.baiyeint.crystal10500"] = "com.tencent.baiyeint.crystal10500a"
      if exchange_table[midasId] ~= nil then
        midasId = exchange_table[midasId]
      end
    end
  end
  if IsIos() or IsAndroid() then
    local paramTable = self:GetPayParam()
    if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
      if IsIos() then
        paramTable.productId = midasId
        paramTable.payItem = count
      elseif IsAndroid() then
        paramTable.saveValue = count
      end
    elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
      paramTable.productId = midasId
      paramTable.payItem = count
    end
    local json = cjson.encode(paramTable)
    Log.debug("##PayModule## Recharge midas id : ", midasId)
    GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.LaunchMidasAuthentication, true)
    self:PushPayInfo(3, "pay", item:GetMidasId(), item:GetCount(), item:GetHasBuy())
    H3DGCloudLuaHelper.GamePay(json)
  elseif (IsPc() or IsUnityEditor()) and H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    self:PushPayInfo(3, "pay", item:GetMidasId(), item:GetCount(), item:GetHasBuy())
    GameGlobal.TaskManager():StartTask(self.PCBuyGoodsTask, self, midasId, 1)
  end
end

function PayModule:OnPayFinished(resultCode, resultInerCode, resultMsg)
  local retCode, innerCode, retMsg
  if type(resultCode) ~= "number" then
    Log.debug("retCode isnot number")
    retCode = resultCode.resultCode
    innerCode = resultCode.resultInerCode
    retMsg = resultCode.resultMsg
  else
    Log.debug("retCode is number")
    retCode = resultCode
    innerCode = resultInerCode
    retMsg = resultMsg
  end
  
  local function ReturnLog(str)
    local msg = ""
    if string.isnullorempty(str) then
      msg = retMsg or ""
    else
      msg = str .. "\n" .. (retMsg or "")
    end
    local code = retCode
    if not code then
      Log.fatal("### OnPayFinished resultCode is nil. msg=", msg)
      return StringTable.Get("str_pay_midas_error_0") .. (string.isnullorempty(msg) and "" or "\n" .. msg)
    end
    local codeInner = innerCode
    if string.isnullorempty(codeInner) then
      Log.fatal("### OnPayFinished resultInerCode is nil or empty. msg=", msg)
      return StringTable.Get("str_pay_midas_error_0") .. (string.isnullorempty(msg) and "" or "\n" .. msg)
    end
    Log.debug("### OnPayFinished resultCode=" .. code .. " resultInerCode=" .. codeInner .. "\n" .. msg)
    local key = "str_pay_midas_error_" .. codeInner
    local log = ""
    if IsPc() then
      log = StringTable.Get("str_pay_midas_pay_failed_parameter", codeInner)
    else
      log = StringTable.Get(key)
      local noStr = "ERR:" .. key
      if noStr == log then
        if string.isnullorempty(str) then
          log = StringTable.Get("str_pay_midas_pay_failed_parameter", codeInner)
        else
          log = str .. "\n" .. StringTable.Get("str_pay_midas_pay_failed_parameter", codeInner)
        end
      elseif string.isnullorempty(str) then
        log = StringTable.Get(key)
      else
        log = str .. "\n" .. StringTable.Get(key)
      end
    end
    return log
  end
  
  local function Hint(key, log, pay_type, midas_id, count)
    if IsAndroid() then
      if innerCode == "-2001" then
        ToastManager.ShowToast(StringTable.Get("str_pay_recharge_buy_cancel"))
        GameGlobal.UAReportChannelEvent("PurchaseCancel", {})
        self:PushPayInfo(2, pay_type, midas_id, count, true)
        return
      end
    elseif IsIos() and innerCode == "2" then
      ToastManager.ShowToast(StringTable.Get("str_pay_recharge_buy_cancel"))
      GameGlobal.UAReportChannelEvent("PurchaseCancel", {})
      self:PushPayInfo(2, pay_type, midas_id, count, true)
      return
    end
    self:PushPayInfo(0, pay_type, midas_id, count, true)
    self:AlertOk(key, log)
  end
  
  if IsPc() then
    Log.debug("PayModule:OnPayFinished on pc")
    if retCode == MidasSDKResult.SUCCESS then
      GameGlobal.TaskManager():StartTask(self.OnPcPayFinishedTask, self)
    else
      GameGlobal.UIStateManager():ShowBusy(false)
      if self.questType == MidasQuestType.MIDAS_QUEST_TYPE_PAY then
        local log = ReturnLog("")
        if self._rechargeShopItem then
          Hint("str_pay_recharge_fail", log, "pay", self._rechargeShopItem:GetMidasId(), self._rechargeShopItem:GetCount())
        else
          Hint("str_pay_recharge_fail", log, "pay", "", 0)
        end
      elseif self.questType == MidasQuestType.MIDAS_QUEST_TYPE_BUGYGOODS then
        local log = ReturnLog("")
        if self._curBuyItem then
          Hint("str_pay_direct_buy_fail", log, "buygoods", self._curBuyItem:GetMidasId(), self._curBuyItem:GetBuyCount())
        else
          Hint("str_pay_direct_buy_fail", log, "buygoods")
        end
      end
      self.questType = MidasQuestType.MIDAS_QUEST_TYPE_NONE
    end
  elseif IsUnityEditor() or IsAndroid() or IsIos() then
    if self.questType == MidasQuestType.MIDAS_QUEST_TYPE_PAY then
      if retCode == 0 then
        GameGlobal.TaskManager():StartTask(self.OnPaySuccess, self)
        self.currentCount = "1"
        self.currentProduct = ""
      else
        local log = ReturnLog("")
        if self._rechargeShopItem then
          Hint("str_pay_recharge_fail", log, "pay", self._rechargeShopItem:GetMidasId(), self._rechargeShopItem:GetCount())
        else
          Hint("str_pay_recharge_fail", log, "pay", "", 0)
        end
      end
    elseif self.questType == MidasQuestType.MIDAS_QUEST_TYPE_BUGYGOODS then
      if retCode == 0 then
        GameGlobal.TaskManager():StartTask(self.OnBuyGoodsSuccess, self)
      else
        local log = ReturnLog("")
        if self._curBuyItem then
          Hint("str_pay_direct_buy_fail", log, "buygoods", self._curBuyItem:GetMidasId(), self._curBuyItem:GetBuyCount())
        else
          Hint("str_pay_direct_buy_fail", log, "buygoods")
        end
      end
    elseif self.questType == MidasQuestType.MIDAS_QUEST_TYPE_SUBSCRIBE then
      if retCode == 0 then
        GameGlobal.TaskManager():StartTask(self.OnBuySuscribeSuccess, self)
      else
        Log.error(ReturnLog(""))
      end
    else
      Log.error(ReturnLog("invalida questType. questType=" .. self.questType))
    end
    self.questType = MidasQuestType.MIDAS_QUEST_TYPE_NONE
  end
  if retCode == 0 then
    GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.PayResult, true)
  else
    GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.PayResult, false, retCode)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MidasPayError)
  end
end

function PayModule:ShowDmmChargeTipPop()
  local strContent = StringTable.Get("str_pay_dmm_not_enough_tip")
  local strConfirm = StringTable.Get("str_pay_dmm_pay_confirm")
  local url = StringTable.Get("str_pay_dmm_charge_url")
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", strContent, function()
    SDKProxy:GetInstance():OpenUrl(url)
  end, nil, nil, nil, nil, strConfirm)
end

function PayModule:ShowDmmErrorTipPop(key)
  local strContent = StringTable.Get(key)
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", strContent)
end

function PayModule:OnPaySuccess(TT)
  local mPay = GameGlobal.GetModule(PayModule)
  mPay:GetInfo("mp")
  local clientShop = self:GetModule(ShopModule):GetClientShop()
  clientShop:SendProtocal(TT, ShopMainTabType.Recharge)
  self:RequestGetBalanceForCharge()
  if self._rechargeShopItem then
    self:PushPayInfo(1, "pay", self._rechargeShopItem:GetMidasId(), self._rechargeShopItem:GetCount(), self._rechargeShopItem:GetHasBuy())
  else
    self:PushPayInfo(1, "pay", "", 0, true)
  end
  GameGlobal.UAReportChannelEvent("Purchase", {})
end

function PayModule:PushPayInfo(type, pay_type, item_id, count, hasBuy)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventPushPayInfo)
  request.type = type
  request.pay_type = pay_type
  request.midas_id = item_id
  request.count = count
  request.first_or_not = not hasBuy
  self:Push(request)
end

function PayModule:RequestGetBalanceForCharge()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileGetBalance)
  request.is_for_charge = true
  self:Push(request)
end

function PayModule:RequestGetBalanceNormal()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileGetBalance)
  request.is_for_charge = false
  self:Push(request)
end

function PayModule:OnBuyGoodsSuccess(TT)
  if self._curBuyItem then
    if self._curBuyItem:GetCurrencyGoodsType() == MidasCurrencyGoodsType.MIDAS_CURRENCY_GOODS_TYPE_GIFT_PACK then
      self:_OnBuyGiftPackGoodsSuccess(TT)
    elseif self._curBuyItem:GetCurrencyGoodsType() == MidasCurrencyGoodsType.MIDAS_CURRENCY_GOODS_TYPE_SKIN then
      self:_OnBuySkinGoodsSuccess(TT)
    elseif self._curBuyItem:GetCurrencyGoodsType() == MidasCurrencyGoodsType.MIDAS_CURRENCY_GOODS_TYPE_CAMPAIGN then
      self:_OnBuyCampaignGoodsSuccess(TT)
    end
  end
end

function PayModule:_OnBuyGiftPackGoodsSuccess(TT)
  if self._curBuyItem then
    self:PushPayInfo(1, "buygoods", self._curBuyItem:GetMidasId(), self._curBuyItem:GetBuyCount(), true)
    self:ShowUIShopRechargeGainWithoutYJ(self._curBuyItem)
    self:GetModule(ShopModule):ClientSaledGift(self._curBuyItem:GetId())
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCurrencyBuySuccess, self._curBuyItem:GetId())
  end
  local clientShop = self:GetModule(ShopModule):GetClientShop()
  clientShop:SendProtocal(TT, ShopMainTabType.Gift)
end

function PayModule:_OnBuySkinGoodsSuccess(TT)
  if self._curBuyItem then
    self:PushPayInfo(1, "buygoods", self._curBuyItem:GetMidasId(), self._curBuyItem:GetBuyCount(), true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCurrencyBySkinSuccess)
  end
  local clientShop = self:GetModule(ShopModule):GetClientShop()
  clientShop:SendProtocal(TT, ShopMainTabType.Skins)
end

function PayModule:_OnBuyCampaignGoodsSuccess(TT)
  if self._curBuyItem then
    self:PushPayInfo(1, "buygoods", self._curBuyItem:GetMidasId(), self._curBuyItem:GetBuyCount(), true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCurrencyBuySuccess, self._curBuyItem:GetId())
  end
end

function PayModule:ShowUIShopRechargeGainWithoutYJ(item)
  local awardsImmediately = item:GetAwardsImmediately()
  if awardsImmediately and table.count(awardsImmediately) > 0 then
    local mPet = GameGlobal.GetModule(PetModule)
    local tSkin = {}
    local tItem = {}
    for i, award in ipairs(awardsImmediately) do
      local tplId = award:GetTemplateId()
      if tplId == RoleAssetID.RoleAssetDiamond then
      else
        if tplId >= RoleAssetID.RoleAssetPetSkinBegin and tplId <= RoleAssetID.RoleAssetPetSkinEnd then
          local a = RoleAsset:New()
          a.assetid = mPet:GetSkinIDFromItemID(tplId)
          a.count = award:GetCount()
          table.insert(tSkin, a)
        end
        local b = RoleAsset:New()
        b.assetid = tplId
        b.count = award:GetCount()
        table.insert(tItem, b)
      end
    end
    self:ShowUIGetRewards_PetSkin(tSkin, tItem)
  end
end

function PayModule:ShowUIGetRewards_PetSkin(tSkin, tItem)
  local index = 0
  
  local function GetNext()
    index = index + 1
    if index <= #tSkin then
      return tSkin[index]
    end
    return nil
  end
  
  local callBackFunc
  
  function callBackFunc()
    GameGlobal.UIStateManager():CloseDialog("UIPetSkinObtainController")
    self:ConfirmToUseNewSkin(tSkin[index], function()
      local nextAsset = GetNext()
      if nextAsset then
        UIActivityHelper.ShowUIGetRewards_PetSkin_Single(nextAsset, callBackFunc)
      end
    end)
  end
  
  local function SkinView()
    if table.count(tSkin) > 0 then
      UIActivityHelper.ShowUIGetRewards_PetSkin_Single(GetNext(), callBackFunc)
    end
  end
  
  if tItem and table.count(tItem) > 0 then
    GameGlobal.UIStateManager():ShowDialog("UIShopRechargeGain", tItem, SkinView)
  else
    SkinView()
  end
end

function PayModule:ConfirmToUseNewSkin(roleAsset, callback)
  local mPet = GameGlobal.GetModule(PetModule)
  local skinId = roleAsset.assetid
  local cfgSkin = Cfg.cfg_pet_skin[skinId]
  local cfgPet = Cfg.cfg_pet[cfgSkin.PetId]
  local petName = StringTable.Get(cfgPet.Name)
  local skinName = ""
  local skinType = ""
  if cfgSkin then
    skinName = StringTable.Get(cfgSkin.SkinName)
    if cfgSkin.SkinType == PetSkinFlag.PSF_NORMAL then
      skinType = StringTable.Get("str_pet_skin_fashion")
    elseif cfgSkin.SkinType == PetSkinFlag.PSF_COLLECTION then
      skinType = StringTable.Get("str_pet_skin_collect_fashion")
    end
  end
  
  local function okCb()
    if mPet:HasPet(cfgSkin.PetId) then
      GameGlobal.TaskManager():StartTask(function(TT)
        local key = "PayModuleConfirmToUseNewSkin"
        GameGlobal.UIStateManager():Lock(key)
        local res = mPet:PetSkinChange(TT, skinId)
        if res:GetSucc() then
          ToastManager.ShowToast(StringTable.Get("str_pet_skin_change_success_tips"))
        end
        GameGlobal.UIStateManager():UnLock(key)
        callback()
      end, self)
    else
      ToastManager.ShowToast(StringTable.Get("str_pet_skin_change_fail_tips"))
      callback()
    end
  end
  
  local okBtnText = StringTable.Get("str_pet_skin_change")
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, StringTable.Get("str_pet_skin_get_new_skin"), StringTable.Get("str_pet_skin_net_skin_tips", petName, skinType, skinName), okCb, nil, callback, nil, nil, okBtnText)
end

function PayModule:AlertOk(strKey, msg)
  local title = StringTable.Get(strKey)
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, title, msg)
end

function PayModule:BuyGoodsByUrl(url, item)
  if not UIShopController.CheckIsOpen(ShopMainTabType.Gift) then
    return
  end
  GameGlobal.UIStateManager():CloseDialog("UIShopGiftPackDetail")
  self._curBuyItem = item
  local paramTable = self:GetPayParam()
  self.questType = MidasQuestType.MIDAS_QUEST_TYPE_BUGYGOODS
  paramTable.goodsTokenUrl = url
  paramTable.tokenType = tostring(MidasTokenType.GETTOKENTYPE_SERVER)
  local json = cjson.encode(paramTable)
  Log.info("PayModule:BuyGoodsByUrl req_json ", json)
  self:PushPayInfo(3, "buygoods", item:GetMidasId(), item:GetBuyCount(), true)
  H3DGCloudLuaHelper.BuyGoods(json)
end

function PayModule:BuyGoodsByGiftPackShopItem(item, count)
  if not UIShopController.CheckIsOpen(ShopMainTabType.Gift) then
    return
  end
  GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.ClickPurchaseButton, true)
  GameGlobal.UIStateManager():CloseDialog("UIShopGiftPackDetail")
  self._curBuyItem = item
  self.questType = MidasQuestType.MIDAS_QUEST_TYPE_BUGYGOODS
  local midasId = item:GetMidasId()
  if IsUnityEditor() then
    GameGlobal.TaskManager():StartTask(function(TT)
      local status = AsyncOperationStatusData:New()
      local key = "FakeMidasProvide"
      GameGlobal.UIStateManager():Lock(key)
      GameGlobal.GetModule(TestRobotModule):AsyncGM_FakeMidasProvide(TT, status, midasId)
      self:OnPayFinished(0, 0, 0)
      GameGlobal.UIStateManager():UnLock(key)
    end, self)
  elseif IsPc() then
    if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
      self:PushPayInfo(3, "buygoods", item:GetMidasId(), count, true)
      GameGlobal.TaskManager():StartTask(self.PCBuyGoodsTask, self, midasId, count)
    end
  elseif IsIos() or IsAndroid() then
    local paramTable = self:GetPayParam()
    local payitem = midasId .. "*" .. item:GetPrice() .. "*" .. count
    paramTable.productId = midasId
    paramTable.payItem = payitem
    local param_json = cjson.encode(paramTable)
    Log.debug("[Pay]PayModule:BuyGoodsByProductid req_json ", param_json)
    GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.LaunchMidasAuthentication, true)
    self:PushPayInfo(3, "buygoods", item:GetMidasId(), count, true)
    H3DGCloudLuaHelper.BuyGoods(param_json)
  end
end

function PayModule:SendBuyGoodsRequest(TT, item_id, item_num)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileBuyGoods)
  request.productid = item_id
  request.num = item_num
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  local replyEvent = CEventMobileBuyGoodsResult(reply.msg)
  if replyEvent == nil then
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(replyEvent.result)
  return res, replyEvent
end

function PayModule:BuySkinGoodsByUrl(url, item)
  if not UIShopController.CheckIsOpen(ShopMainTabType.Skins) then
    return
  end
  self._curBuyItem = item
  local paramTable = self:GetPayParam()
  self.questType = MidasQuestType.MIDAS_QUEST_TYPE_BUGYGOODS
  paramTable.goodsTokenUrl = url
  paramTable.tokenType = tostring(MidasTokenType.GETTOKENTYPE_SERVER)
  local json = cjson.encode(paramTable)
  Log.info("PayModule:BuyGoodsByUrl req_json ", json)
  GameGlobal.TaskManager():StartTask(self.PreReprovideCallTask, self, function()
    self:PushPayInfo(3, "buygoods", item:GetMidasId(), item:GetBuyCount(), true)
    H3DGCloudLuaHelper.BuyGoods(json)
  end)
end

function PayModule:BuyGoodsBySkinShopItem(item, count)
  if not UIShopController.CheckIsOpen(ShopMainTabType.Skins) then
    return
  end
  GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.ClickPurchaseButton, true)
  self._curBuyItem = item
  local paramTable = self:GetPayParam()
  self.questType = MidasQuestType.MIDAS_QUEST_TYPE_BUGYGOODS
  local midasId = item:GetMidasId()
  if IsUnityEditor() then
    GameGlobal.TaskManager():StartTask(function(TT)
      local status = AsyncOperationStatusData:New()
      local key = "FakeMidasProvide"
      GameGlobal.UIStateManager():Lock(key)
      GameGlobal.GetModule(TestRobotModule):AsyncGM_FakeMidasProvide(TT, status, midasId)
      self:OnPayFinished(0, 0, 0)
      GameGlobal.UIStateManager():UnLock(key)
    end, self)
  elseif IsPc() then
    if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
      self:PushPayInfo(3, "buygoods", item:GetMidasId(), count, true)
      GameGlobal.TaskManager():StartTask(self.PCBuyGoodsTask, self, midasId, count)
    end
  elseif IsIos() or IsAndroid() then
    local payitem = midasId .. "*" .. item:GetPrice() .. "*" .. count
    paramTable.productId = midasId
    paramTable.payItem = payitem
    local param_json = cjson.encode(paramTable)
    Log.debug("[Pay]PayModule:BuyGoodsBySkinShopItem req_json ", param_json)
    GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.LaunchMidasAuthentication, true)
    GameGlobal.TaskManager():StartTask(self.PreReprovideCallTask, self, function()
      self:PushPayInfo(3, "buygoods", item:GetMidasId(), count, true)
      H3DGCloudLuaHelper.BuyGoods(param_json)
    end)
  end
end

function PayModule:BuyCampaignGoodsByUrl(url, item)
  self._curBuyItem = item
  local paramTable = self:GetPayParam()
  self.questType = MidasQuestType.MIDAS_QUEST_TYPE_BUGYGOODS
  paramTable.goodsTokenUrl = url
  paramTable.tokenType = tostring(MidasTokenType.GETTOKENTYPE_SERVER)
  local json = cjson.encode(paramTable)
  Log.info("PayModule:BuyCampaignGoodsByUrl req_json ", json)
  GameGlobal.TaskManager():StartTask(self.PreReprovideCallTask, self, function()
    self:PushPayInfo(3, "buygoods", item:GetMidasId(), item:GetBuyCount(), true)
    H3DGCloudLuaHelper.BuyGoods(json)
  end)
end

function PayModule:BuyCampaignGoods(item)
  self._curBuyItem = item
  local paramTable = self:GetPayParam()
  self.questType = MidasQuestType.MIDAS_QUEST_TYPE_BUGYGOODS
  local midasId = item:GetMidasId()
  if IsUnityEditor() then
    GameGlobal.TaskManager():StartTask(function(TT)
      local status = AsyncOperationStatusData:New()
      local key = "FakeMidasProvide"
      GameGlobal.UIStateManager():Lock(key)
      GameGlobal.GetModule(TestRobotModule):AsyncGM_FakeMidasProvide(TT, status, midasId)
      self:OnPayFinished(0, 0, 0)
      GameGlobal.UIStateManager():UnLock(key)
    end, self)
  elseif IsPc() then
    if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
      self:PushPayInfo(3, "buygoods", item:GetMidasId(), item:GetBuyCount(), true)
      GameGlobal.TaskManager():StartTask(self.PCBuyGoodsTask, self, midasId, item:GetBuyCount())
    end
  elseif IsIos() or IsAndroid() then
    local payitem = midasId .. "*" .. item:GetPrice() .. "*" .. item:GetBuyCount()
    paramTable.productId = midasId
    paramTable.payItem = payitem
    local param_json = cjson.encode(paramTable)
    Log.debug("[Pay]PayModule:BuyCampaignGoods req_json ", param_json)
    GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.LaunchMidasAuthentication, true)
    GameGlobal.TaskManager():StartTask(self.PreReprovideCallTask, self, function()
      self:PushPayInfo(3, "buygoods", midasId, item:GetBuyCount(), true)
      H3DGCloudLuaHelper.BuyGoods(param_json)
    end)
  end
end

function PayModule:GetLocalPrice(products)
  if not UIShopController.CheckIsOpen(ShopMainTabType.Recharge) then
    return
  end
  Log.debug("### GetLocalPrice ", table.tostring(products))
  if IsPc() or IsUnityEditor() then
    Log.debug("GetLocalPrice IsPc() true")
    GameGlobal.TaskManager():StartTask(self.LoadPCProductsPriceTask, self, products)
    return
  else
    Log.debug("GetLocalPrice IsPc() false")
  end
  local productsTable = {}
  for k, v in pairs(products) do
    if v ~= "" then
      productsTable[v] = "inapp"
    end
  end
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_None then
    return
  end
  local num = 0
  for k, v in pairs(productsTable) do
    Log.debug("k : ", k, "v : ", v)
    num = num + 1
  end
  if num ~= 0 then
    H3DGCloudLuaHelper.GetLocalPrice(self:GetPayChannel(), productsTable)
  end
end

function PayModule:LoadPCProductsPriceTask(TT, products)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileGetProductsInfo)
  request.channel = "os_dmm"
  request.currency_type = self.currencyType
  request.language = string.sub(self.language, 1, 2)
  request.product_ids = products
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  local replyEvent = CEventMobileGetProductsInfoResult(reply.msg)
  if replyEvent == nil then
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  self:onPayGetLocalPriceFinished(replyEvent)
end

function PayModule:onPayGetLocalPriceFinished(result)
  if IsIos() or IsAndroid() then
    local ret = self:HandleMobilePriceResult(result)
    if not ret then
      return
    end
  elseif IsPc() or IsUnityEditor() then
    local ret = self:HandlePcPriceResult(result)
    if not ret then
      return
    end
  end
  local clientShop = GameGlobal.GetModule(ShopModule):GetClientShop()
  local dataRechargeShop = clientShop:GetRechargeShopData()
  dataRechargeShop:UpdateGoodsPrice()
  local dataGiftPackShop = clientShop:GetGiftPackShopData()
  dataGiftPackShop:UpdateGoodsPrice()
  local dataSkinPackShop = clientShop:GetSkinsShopData()
  dataSkinPackShop:UpdateGoodsPrice()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PayGetLocalPriceFinished)
end

function PayModule:HandleMobilePriceResult(result)
  Log.debug("### onPayGetLocalPriceFinished result=", result)
  local resultTable = cjson.decode(result)
  if resultTable == nil then
    Log.fatal("### [PayModule] HandleMobilePriceResult result resultTable nil")
    return false
  end
  local retcode = resultTable.ret
  if not retcode then
    Log.fatal("### [PayModule]retcode nil")
    return false
  end
  if retcode ~= "0" then
    local log = "### [PayModule] request price failed. retcode=" .. retcode
    Log.fatal(log)
    return false
  end
  local products = resultTable.productInfo
  if not products then
    Log.fatal("### [PayModule] products nil.")
    return false
  end
  if table.count(products) <= 0 then
    Log.fatal("### [PayModule] no data in products.")
    return false
  end
  if not self._goodPriceList then
    self._goodPriceList = {}
  end
  for _, product in pairs(products) do
    local productId = product.productId
    if type(product.microprice) == "string" then
      product.microprice = tonumber(product.microprice) or 0
    end
    if type(product.originalPrice) == "string" then
      product.originalPrice = tonumber(product.originalPrice) or 0
    end
    if type(product.originalMicroprice) == "string" then
      product.originalMicroprice = tonumber(product.originalMicroprice) or 0
    end
    self._goodPriceList[productId] = {
      price = product.price,
      currency = product.currency,
      microprice = product.microprice,
      originalPrice = product.originalPrice,
      originalMicroprice = product.originalMicroprice
    }
  end
  return true
end

function PayModule:HandlePcPriceResult(result)
  Log.debug("###PC HandlePcPriceResult result=", result.midas_ret)
  if not result.midas_ret then
    Log.fatal("### [PayModule]PC retcode nil")
    return false
  end
  if result.midas_ret ~= 0 then
    local log = "### [PayModule]PC request price failed. retcode=" .. result.midas_ret
    Log.fatal(log)
    return false
  end
  local products = result.product_info
  if not products then
    Log.fatal("### [PayModule]PC products nil.")
    return false
  end
  if 0 >= table.count(products) then
    Log.fatal("### [PayModule]PC no data in products.")
    return false
  end
  if not self._goodPriceList then
    self._goodPriceList = {}
  end
  for _, product in pairs(products) do
    local productId = product.productId
    local log = "### [PayModule]HandlePcPriceResult productinfo productId= " .. productId .. " price " .. product.price .. " currency " .. product.currency
    Log.debug(log)
    self._goodPriceList[productId] = {
      price = product.price,
      currency = product.currency,
      microprice = product.microprice,
      originalPrice = product.originalPrice,
      originalMicroprice = product.originalMicroprice
    }
  end
  return true
end

function PayModule:GetGoodPriceList()
  return self._goodPriceList
end

function PayModule:PreReprovideCallTask(TT, func)
  if not UIShopController.CheckIsOpen(ShopMainTabType.Recharge) then
    return
  end
  if IsUnityEditor() then
    return
  end
  self.reprovideing = true
  H3DGCloudLuaHelper.Reprovide()
  for i = 1, 50 do
    if self.reprovideing == false then
      break
    end
    YIELD(TT, 100)
  end
  if func then
    func(TT)
  end
end

function PayModule:onPayReprovideFinished(retJson)
  Log.debug("[Pay]PayModule:onPayReprovideFinished called ret: ", retJson)
  self.reprovideing = false
end

function PayModule:RegisterObserver()
  Log.debug("[Pay]PayModule:RegisterObserver start")
  
  function self.OnPayInitFinishedEvent(result)
    self:OnPayInitFinished(result)
  end
  
  H3DGCloudLuaHelper.H3DPayInitCallBack.PayInitFinishedEvent = H3DGCloudLuaHelper.H3DPayInitCallBack.PayInitFinishedEvent + self.OnPayInitFinishedEvent
  
  function self.OnPayLoginExpiredEvent()
    self:OnPayLoginExpired()
  end
  
  H3DGCloudLuaHelper.H3DPayCallBack.PayLoginExpiredEvent = H3DGCloudLuaHelper.H3DPayCallBack.PayLoginExpiredEvent + self.OnPayLoginExpiredEvent
  
  function self.OnPayFinishedEvent(retCode, innerCode, retMsg)
    self:OnPayFinished(retCode, innerCode, retMsg)
  end
  
  H3DGCloudLuaHelper.H3DPayCallBack.PayFinishedEvent = H3DGCloudLuaHelper.H3DPayCallBack.PayFinishedEvent + self.OnPayFinishedEvent
  
  function self.OnPayGetInfoFinishedEvent(type, retCode, json)
    self:OnPayGetInfoFinished(type, retCode, json)
  end
  
  H3DGCloudLuaHelper.H3DPayGetInfoCallback.PayGetInfoFinishedEvent = H3DGCloudLuaHelper.H3DPayGetInfoCallback.PayGetInfoFinishedEvent + self.OnPayGetInfoFinishedEvent
  
  function self.onPayGetLocalPriceFinishedEvent(result)
    self:onPayGetLocalPriceFinished(result)
  end
  
  H3DGCloudLuaHelper.H3DPayGetLocalPriceCallback.PayGetLocalPriceFinishedEvent = H3DGCloudLuaHelper.H3DPayGetLocalPriceCallback.PayGetLocalPriceFinishedEvent + self.onPayGetLocalPriceFinishedEvent
  
  function self.onPayReprovideFinishedEvent(ret_json)
    self:onPayReprovideFinished(ret_json)
  end
  
  H3DGCloudLuaHelper.H3DPayReprovideCallback.PayReprovideFinishedEvent = H3DGCloudLuaHelper.H3DPayReprovideCallback.PayReprovideFinishedEvent + self.onPayReprovideFinishedEvent
end

function PayModule:UnregisterObserver()
  Log.debug("[Pay]PayModule:UnregisterObserver start")
  H3DGCloudLuaHelper.H3DPayInitCallBack.PayInitFinishedEvent = H3DGCloudLuaHelper.H3DPayInitCallBack.PayInitFinishedEvent - self.OnPayInitFinishedEvent
  H3DGCloudLuaHelper.H3DPayCallBack.PayLoginExpiredEvent = H3DGCloudLuaHelper.H3DPayCallBack.PayLoginExpiredEvent - self.OnPayLoginExpiredEvent
  H3DGCloudLuaHelper.H3DPayCallBack.PayFinishedEvent = H3DGCloudLuaHelper.H3DPayCallBack.PayFinishedEvent - self.OnPayFinishedEvent
  H3DGCloudLuaHelper.H3DPayGetInfoCallback.PayGetInfoFinishedEvent = H3DGCloudLuaHelper.H3DPayGetInfoCallback.PayGetInfoFinishedEvent - self.OnPayGetInfoFinishedEvent
  H3DGCloudLuaHelper.H3DPayGetLocalPriceCallback.PayGetLocalPriceFinishedEvent = H3DGCloudLuaHelper.H3DPayGetLocalPriceCallback.PayGetLocalPriceFinishedEvent - self.onPayGetLocalPriceFinishedEvent
  H3DGCloudLuaHelper.H3DPayReprovideCallback.PayReprovideFinishedEvent = H3DGCloudLuaHelper.H3DPayReprovideCallback.PayReprovideFinishedEvent - self.onPayReprovideFinishedEvent
end

function PayModule:GetPayParam()
  local authedOpenId = GameGlobal.GameLogic().msdkAuthorityInfo.open_id
  local token = ""
  local pf_value, pf_key = "", ""
  local session_ID, session_Type = self:GetSessionInfo()
  local zone_Id = self.zone_id
  local partition = zone_Id
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    local module = GameGlobal.GetModule(LoginAuthorityModule)
    token = module:GetPayToken()
    pf_value, pf_key = module:GetPfInfo()
    if IsAndroid() then
      partition = "201"
    elseif IsIos() then
      partition = "0"
    end
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    if IsIos() then
      pf_value = "wechat_abroad_wx-2001-iap-2011"
    elseif IsAndroid() then
      pf_value = "wechat_abroad_wx-2001-android-2011"
    end
    pf_key = "pfKey"
    token = "1"
  end
  local country_name, currency_name = self:GetCountryInfo()
  local paramTable = {
    offerId = self.OfferID,
    openId = authedOpenId,
    openKey = token,
    pf = pf_value,
    pfKey = pf_key,
    sessionId = session_ID,
    sessionType = session_Type,
    zoneId = zone_Id,
    goodsZoneId = string.format("%s_%s", partition, authedOpenId),
    payChannel = self:GetPayChannel()
  }
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    paramTable.country = country_name
    paramTable.currencyType = currency_name
  end
  return paramTable
end

function PayModule:GetSessionInfo()
  local sessionID = ""
  local sessionType = ""
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    sessionID = "hy_gameid"
    sessionType = "st_dummy"
  end
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    sessionID = "itopid"
    sessionType = "itop"
  end
  return sessionID, sessionType
end

function PayModule:IsShowSelectAgePanel()
  local key = self:GetSelectAgePanelKey()
  if UnityEngine.PlayerPrefs.HasKey(key) then
    return false
  end
  return true
end

function PayModule:OpenSelectAgePanel()
  local key = self:GetSelectAgePanelKey()
  UnityEngine.PlayerPrefs.SetInt(key, 1)
end

function PayModule:GetSelectAgePanelKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local ageConfirmKey = "SELECT_AGE_PANEL_KEY_1VERSION" .. pstId
  return ageConfirmKey
end

function PayModule:CanPay(TT, thePayNum)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventReqCanPay)
  request.the_pay = thePayNum
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.result)
  return res, replyEvent
end

function PayModule:NeedSelectAge(TT)
  local res, replyEvent = self:GetAgeId(TT)
  if res:GetSucc() then
    local currentSelectId = replyEvent.cfg_id
    if currentSelectId == nil or currentSelectId <= 0 then
      return true
    end
  end
  return false
end

function PayModule:GetAgeId(TT)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventReqPayId)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.result)
  return res, replyEvent
end

function PayModule:SetAgeId(TT, id)
  if not id then
    return nil, nil
  end
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventReqPayAge)
  request.cfg_id = id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.result)
  return res, replyEvent
end

function PayModule:GamePay(goods_id, item_id, diamond_count)
  self._last_goods_id = goods_id
  Log.debug("[Pay]PayModule:GamePay")
  local paramTable = self:GetPayParam()
  local payItem = ""
  local productId = ""
  if IsIos() or H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International and IsAndroid() then
    if not Cfg.cfg_buy_goods[item_id] then
      Log.error("[Pay]PayModule:GamePay cant find item_id ", item_id)
      return
    end
    local itemList = Cfg.cfg_buy_goods[item_id].ItemList
    if not itemList or #itemList < 1 then
      Log.error("[Pay]PayModule:GamePay pay config error ", item_id)
      return
    end
    payItem = itemList[1][2]
    productId = item_id
  end
  self.questType = MidasQuestType.MIDAS_QUEST_TYPE_PAY
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    if IsIos() then
      paramTable.productId = productId
      paramTable.payItem = payItem
    elseif IsAndroid() then
      paramTable.saveValue = diamond_count
    end
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    paramTable.productId = productId
    paramTable.payItem = payItem
  end
  local json = cjson.encode(paramTable)
  H3DGCloudLuaHelper.GamePay(json)
end

function PayModule:BuyGoodsByProductid(item_id, item_num)
  Log.debug("[Pay]PayModule:BuyGoodsByProductid")
  local paramTable = self:GetPayParam()
  self.questType = MidasQuestType.MIDAS_QUEST_TYPE_BUGYGOODS
  if IsUnityEditor() then
    GameGlobal.TaskManager():StartTask(function(TT)
      local status = AsyncOperationStatusData:New()
      local key = "FakeMidasProvide"
      GameGlobal.UIStateManager():Lock(key)
      GameGlobal.GetModule(TestRobotModule):AsyncGM_FakeMidasProvide(TT, status, midasId)
      self:OnPayFinished(0, 0, 0)
      GameGlobal.UIStateManager():UnLock(key)
    end, self)
  elseif IsPc() then
    if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
      GameGlobal.TaskManager():StartTask(self.PCBuyGoodsTask, self, item_id, item_num)
    end
  elseif IsIos() or IsAndroid() then
    local payitem = string.format("%s*%s*%s", item_id, Cfg.cfg_buy_goods[item_id].Price, item_num)
    paramTable.productId = item_id
    paramTable.payItem = payitem
    local param_json = cjson.encode(paramTable)
    Log.debug("[Pay]PayModule:BuyGoodsByProductid req_json ", param_json)
    H3DGCloudLuaHelper.BuyGoods(param_json)
  end
end

function PayModule:GamePayWithReprovide(item_id, diamond_count)
  Log.debug("[Pay]PayModule:GamePayWithReprovide")
  self.currentProduct = item_id
  self.currentCount = diamond_count
  self.questType = MidasQuestType.MIDAS_QUEST_TYPE_PAY
  H3DGCloudLuaHelper.Reprovide()
end

function PayModule:BuySubscribeByServiceCode(serviceCode, serviceType, autoPay)
  Log.debug("[Pay]PayModule:BuySubscribe")
  local paramTable = self:GetPayParam()
  local serviceName = ""
  self.questType = MidasQuestType.MIDAS_QUEST_TYPE_SUBSCRIBE
  if IsUnityEditor() or IsIos() then
    Log.error("PayModule:BuySubscribeByServiceCode subscribe is invalid in editor/IOS")
    return
  elseif IsAndroid() then
    paramTable.serviceCode = serviceCode
    paramTable.serviceName = serviceName
    paramTable.serviceType = tostring(serviceType)
    paramTable.autoPay = autoPay
    local json = cjson.encode(paramTable)
    Log.info("PayModule:BuySubscribeByServiceCode req_json ", json)
    H3DGCloudLuaHelper.BuySubscribe(json)
  end
end

function PayModule:BuySubscribeByProductId(productId, serviceType, autoPay)
  Log.debug("[Pay]PayModule:BuySubscribeByProductId")
  local paramTable = self:GetPayParam()
  local subInfo = Cfg.cfg_subscribe[productId]
  if not subInfo then
    Log.error("[Pay]PayModule:BuySubscribeByProductId cant find productId ", productId)
    return
  end
  local serviceCode = subInfo.ServiceCode
  local serviceName = subInfo.Name
  local payItem = subInfo.Length
  self.questType = MidasQuestType.MIDAS_QUEST_TYPE_SUBSCRIBE
  if IsUnityEditor() then
    Log.error("PayModule:BuySubscribeByProductId subscribe is invalid in editor")
    return
  elseif IsAndroid() or IsIos() then
    paramTable.serviceCode = serviceCode
    paramTable.serviceName = serviceName
    paramTable.serviceType = tostring(serviceType)
    paramTable.autoPay = autoPay
    paramTable.productId = productId
    paramTable.payItem = tostring(payItem)
    local json = cjson.encode(paramTable)
    Log.info("PayModule:BuySubscribeByProductId req_json ", json)
    H3DGCloudLuaHelper.BuySubscribe(json)
  end
end

function PayModule:OnBuySuscribeSuccess(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileBuySubscribe)
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  local replyEvent = CEventMobileBuySubscribeResult(reply.msg)
  if replyEvent == nil then
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(replyEvent.result)
  return res
end

function PayModule:HandleSubscribeInfoUpdate()
  Log.debug("[Pay]PayModule:HandleSubscribeInfoUpdate")
end

function PayModule:RequestAddDiamond(TT, count)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventTestAddDiamond)
  request.diamond_count = count
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.result)
  return res
end

function PayModule:RequestUseDiamond(TT, count)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileCostMoney)
  request.amt = count
  request.mark = "test_cost"
  request.item_name = "test_item1"
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  local replyEvent = CEventMobileCostMoneyResult(reply.msg)
  if replyEvent == nil then
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(replyEvent.result)
  return res
end

function PayModule:PCBuyGoodsTask(TT, productId, num)
  Log.debug("[Pay]PayModule:PCBuyGoodsTask productId ", productId, " num ", num)
  self.currentProduct = productId
  self.currentCount = num
  if self.env ~= "sandbox" and IsUnityEditor() then
    Log.error("[Pay]PayModule:PCBuyGoodsTask editor don't support release pay")
    return
  end
  if self:IsTestEnv() and (string.isnullorempty(self._viewerId) or not self._payTokenValid) then
    Log.info("PayModule:PCBuyGoodsTask showDialog")
    GameGlobal.UIStateManager():ShowDialog("UIPayTokenInputTest")
    return
  end
  self:PCOrderAndPayTask(TT, productId, num)
end

function PayModule:PCOrderAndPayTask(TT, productId, num)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileDmmOrder)
  request.language = string.sub(self.language, 1, 2)
  request.pay_channel = "os_dmm"
  request.region = self.country
  request.currency = self.currencyType
  local item = DMMPurchaseInfo:New()
  item.product_id = productId
  item.quantity = num
  table.insert(request.purchase_list, 1, item)
  if self:IsTestEnv() then
    request.view_id = self._viewerId
    request.pay_token = self._payToken
  else
    local authRet = INTL.INTLAPI.GetAuthResult()
    Log.debug("PayModule:PCBuyGoodsTask GetAuthResult ChannelInfo: ", authRet.ChannelInfo)
    local retJson = cjson.decode(authRet.ChannelInfo)
    if not retJson then
      Log.error("PayModule:PCBuyGoodsTask GetAuthResult failed no ChannelInfo")
      return
    end
    if not retJson.viewer_id then
      Log.error("PayModule:PCBuyGoodsTask GetAuthResult failed no viewer_id")
      return
    else
      request.view_id = retJson.viewer_id
    end
    if not retJson.onetime_token then
      Log.error("PayModule:PCBuyGoodsTask GetAuthResult failed no onetime_token")
      return
    else
      request.pay_token = retJson.onetime_token
    end
  end
  Log.debug("PayModule:PCBuyGoodsTask env ", self.env, " viewer_id ", request.view_id, " pay_token ", request.pay_token, "")
  GameGlobal.UIStateManager():ShowBusy(true)
  local reply = self:Call(TT, request)
  GameGlobal.UIStateManager():ShowBusy(false)
  if reply.res ~= CallResultType.Normal then
    Log.error("[Pay]PayModule:PCBuyGoodsTask reply error ", reply.res)
  end
  local replyEvent = CEventMobileDmmOrderResult(reply.msg)
  if replyEvent == nil then
    Log.error("[Pay]PayModule:PCBuyGoodsTask rep is nil ")
  end
  Log.debug("[Pay]PayModule:PCBuyGoodsTask succ result: ", replyEvent.result)
  if replyEvent.result == PayErrorCode.PAY_SUCC and replyEvent.pay_info then
    Log.debug("[Pay]PayModule:PCBuyGoodsTask pay_info ", replyEvent.pay_info)
    local strContent = ""
    if self.questType == MidasQuestType.MIDAS_QUEST_TYPE_PAY then
      strContent = StringTable.Get("str_pay_dmm_confirm_buy_goods", self._rechargeShopItem._price, self._rechargeShopItem._name)
    elseif self._curBuyItem then
      strContent = StringTable.Get("str_pay_dmm_confirm_buy_goods", self._curBuyItem._priceWithCurrencySymbol, self._curBuyItem._name)
    end
    self._payTokenValid = false
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", strContent, function()
      Log.debug("[Pay]PayModule:PCBuyGoodsTask buy onclick")
      GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.LaunchMidasAuthentication, true)
      GameGlobal.UIStateManager():ShowBusy(true)
      H3DGCloudLuaHelper.DMMPay(replyEvent.pay_info)
    end, nil, nil, nil, nil)
  else
    self:ShowDmmErrorTipPop("str_pay_midas_order_failed")
  end
end

function PayModule:OnPcPayFinishedTask(TT)
  Log.debug("[Pay]PayModule:OnPcPayFinishedTask")
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileQueryOrder)
  request.is_after_pay = true
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    Log.error("[Pay]PayModule:OnPcPayFinishedTask reply error ", reply.res)
    GameGlobal.UIStateManager():ShowBusy(false)
    return
  end
  local replyEvent = CEventMobileQueryOrderResult(reply.msg)
  if replyEvent == nil then
    Log.error("[Pay]PayModule:OnPcPayFinishedTask rep is nil ")
    GameGlobal.UIStateManager():ShowBusy(false)
    return
  end
  Log.debug("[Pay]PayModule:OnPcPayFinishedTask result ", replyEvent.result, " status ", replyEvent.status, " name ", replyEvent.name, " reason ", replyEvent.message)
  GameGlobal.UIStateManager():ShowBusy(false)
  if replyEvent.result == PayErrorCode.PAY_SUCC then
    if replyEvent.status == MidasOrderStatus.PAYING then
      self:ShowDmmErrorTipPop("str_pay_dmm_wait_tip")
    elseif replyEvent.status == MidasOrderStatus.UNPAY then
    elseif replyEvent.status == MidasOrderStatus.PAY_SUCCESS then
      self._payTokenValid = true
      self:ShowDmmErrorTipPop("str_pay_dmm_wait_tip")
    elseif replyEvent.status == MidasOrderStatus.PROVIDE_SUCCESS then
      self._payTokenValid = true
      if self.questType == MidasQuestType.MIDAS_QUEST_TYPE_PAY then
        Log.debug("[Pay]PayModule:OnPcPayFinishedTask succ")
        self:OnPaySuccess(TT)
        self.currentCount = "1"
        self.currentProduct = ""
      elseif self.questType == MidasQuestType.MIDAS_QUEST_TYPE_BUGYGOODS then
        self:OnBuyGoodsSuccess(TT)
      end
    elseif replyEvent.status == MidasOrderStatus.PAY_FAIL then
      if replyEvent.name == "BALANCE_NOT_ENOUGH" then
        self:ShowDmmChargeTipPop()
      else
        self:ShowDmmErrorTipPop("str_pay_midas_pay_failed")
      end
    elseif replyEvent.status == MidasOrderStatus.PROVIDE_FAIL then
      self._payTokenValid = true
      self:ShowDmmErrorTipPop("str_pay_midas_provided_failed")
    end
  end
  self.questType = MidasQuestType.MIDAS_QUEST_TYPE_NONE
end

function PayModule:SetDmmParam(viewerID, payToken)
  self._viewerId = viewerID
  self._payToken = payToken
  self._payTokenValid = true
  GameGlobal.TaskManager():StartTask(self.PCOrderAndPayTask, self, self.currentProduct, self.currentCount)
end

function PayModule:IsTestEnv()
  if (IsUnityEditor() or IsPc()) and self.env == "sandbox" then
    return true
  end
  return false
end

function PayModule:GetMidasZoneID()
  return self.zone_id
end

function PayModule:GetPayChannel()
  local storeChannel = SDKProxy:GetInstance():GetStoreChannel()
  if storeChannel == StoreChannel.SC_ONESTORE then
    return "os_onestore"
  elseif storeChannel == StoreChannel.SC_AMAZON then
    return "os_amazon"
  elseif storeChannel == StoreChannel.SC_GALAXY then
    return "os_samsung"
  end
  return "os_offical"
end

function PayModule:DebugGetParam()
  local ret = "idc : " .. self.idc .. [[

 env : ]] .. self.env .. [[

 zone_id : ]] .. self.zone_id .. [[

 open_id : ]] .. GameGlobal.GameLogic():GetOpenId()
  return ret
end
