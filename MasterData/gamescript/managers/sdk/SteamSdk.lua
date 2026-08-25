local Z1Const = CS.FrameWork.Z1Const
local SteamSdk = System.NewClass("SteamSdk", Manager)

function SteamSdk:Awake()
  self.orderCount = 0
  if not self:IsNativeSteamSdk() then
    return
  end
  self.loopTickers = {}
  self:RegisterCallback()
  self:Report(string.format("[steam]IsSteam:%s, IsInitialized:%s ", self:IsSteam(), self:IsInitialized()))
  if self:IsNativeSteamSdk() and self:IsInitialized() then
    self:Report(string.format("[steam]persona name %s", CS.SteamSdkSupprt.GetPersonaName()))
    self:Report(string.format("[steam]user id %s", CS.SteamSdkSupprt.GetSteamID()))
    self:Report(string.format("[steam]curr lang %s", CS.SteamSdkSupprt.GetCurrentGameLanguage()))
    self:Report(string.format("[steam]web ticket id %s", CS.SteamSdkSupprt.GetAuthTicket()))
  end
end

function SteamSdk:RegisterCallback()
  CS.SteamSdkSupprt.SetOnTicketRespones(System.fn(self, self.OnTicketRespones))
  CS.SteamSdkSupprt.SetOnTxnAuthorizationRespones(System.fn(self, self.OnTxnAuthorizationRespones))
end

function SteamSdk:IsNativeSteamSdk()
  return false
end

function SteamSdk:IsSteam()
  return Z1Const and Z1Const.IsSteam and Z1Const.IsSteam()
end

function SteamSdk:IsInitialized()
  return CS.SteamSdkSupprt and CS.SteamSdkSupprt.IsInitialized and CS.SteamSdkSupprt.IsInitialized()
end

function SteamSdk:GetSteamName()
  if not self:IsInitialized() then
    return
  end
  do return end
  return CS.SteamSdkSupprt.GetPersonaName, self
end

function SteamSdk:GetSteamID()
  if not self:IsInitialized() then
    return
  end
  do return end
  return CS.SteamSdkSupprt.GetSteamID, self
end

function SteamSdk:GetSteamWebTicket(co)
  if not self:IsInitialized() then
    return
  end
  if self.ticket then
    return self.ticket
  end
  self:RegisterCallback()
  CS.SteamSdkSupprt:GetSteamWebTicket()
  if co then
    self.waitingCo = co
    do return end
    return Coroutine.Yield, CS.SteamSdkSupprt
  end
end

function SteamSdk:GetSteamLang()
  if not self:IsInitialized() then
    return
  end
  local lang = CS.Steamworks.SteamApps.GetCurrentGameLanguage()
  if "schinese" == lang then
    return "CN"
  elseif "tchinese" == lang then
    return "TW"
  else
    return "EN"
  end
end

function SteamSdk:OnTicketRespones(ticket)
  if 0 == #ticket then
    self:GetSteamWebTicket(self.waitingCo)
    return
  end
  self.ticket = ticket
  local expireTime = 120
  self.binder:BindTimer(expireTime, 0, nil, function()
    self.ticket = nil
  end)
  if self.waitingCo then
    Coroutine.Resume(self.waitingCo, self.ticket)
  end
  self.waitingCo = nil
  self:Report(string.format("[steam]OnTicketRespones : %s", ticket))
end

function SteamSdk:CreateOrder(chargeItemId, itemCount)
  local order = {}
  order.steamid = self:GetSteamID()
  order.appid = CS.SteamSdkSupprt.GetSteamAppId()
  order.itemid = chargeItemId
  order.itemcount = itemCount or 1
  order.language = self:GetISOLang()
  local chargeCfg = ShopDataUtils.GetChargeCfgById(chargeItemId) or {}
  order.description = LT.Text(chargeCfg.Name or "")
  ProtoManager.Instance:ReqServer("GameRequest", "CreateOrder", function(data)
    Logger.Info("========== 请求创建服务器订单成功 ==========\n", table.tostring(data or {}))
    self:LoopReqOrderReward(data.orderId)
  end, function(data)
    Logger.Info("========== 请求创建服务器订单失败 ==========\n", table.tostring(data or {}))
  end, order)
  local frequentTime = 3
  local alertOrderCount = 3
  self.binder:BindTimer(frequentTime, 0, nil, function()
    self.orderCount = 0
  end)
  self.orderCount = self.orderCount + 1
  if alertOrderCount <= self.orderCount then
    Alert.Show(10620)
  end
  self:Report(string.format("[steam]CreateOrder : %s", chargeItemId))
end

function SteamSdk:OnTxnAuthorizationRespones(respones)
  respones = respones or {}
  if respones.m_ulOrderID then
    self:ReqOrderReward(respones.m_ulOrderID)
  end
  self:Report(string.format("[steam txn respones] %s %s %s %s", respones, respones.m_unAppID or "nil", respones.m_ulOrderID or "nil", respones.m_bAuthorized or "nil"))
end

function SteamSdk:LoopReqOrderReward(orderId)
  if not orderId then
    return
  end
  local loopTicker = TimerManager.Instance:CreateTimer(3, 100, nil, function()
    if orderId then
      self:ReqOrderReward(orderId)
    end
  end)
  self.loopTickers[orderId] = loopTicker
end

function SteamSdk:ReqOrderReward(orderId)
  local reqData = {}
  reqData.orderId = orderId
  ProtoManager.Instance:ReqServer("GameRequest", "OrderReward", function(data)
    Logger.Info("========== 请求发奖成功 ==========\n", table.tostring(data or {}))
    TimerManager.Instance:StopTimer(self.loopTickers[orderId])
    self.loopTickers[orderId] = nil
  end, function(data)
    Logger.Info("========== 请求发奖失败 ==========\n", table.tostring(data or {}))
  end, reqData)
end

local ISOLang = {
  arabic = "ar",
  bulgarian = "bg",
  schinese = "zh-CN",
  tchinese = "zh-TW",
  czech = "cs",
  danish = "da",
  dutch = "nl",
  english = "en",
  finnish = "fi",
  french = "fr",
  german = "de",
  greek = "el",
  hungarian = "hu",
  italian = "it",
  japanese = "ja",
  koreana = "ko",
  norwegian = "no",
  polish = "pl",
  portuguese = "pt",
  brazilian = "pt-BR",
  romanian = "ro",
  russian = "ru",
  spanish = "es",
  latam = "es-419",
  swedish = "sv",
  thai = "th",
  turkish = "tr",
  ukrainian = "uk",
  vietnamese = "vn"
}

function SteamSdk:GetISOLang()
  local lang = CS.SteamSdkSupprt.GetCurrentGameLanguage()
  return ISOLang[lang] or "en"
end

function SteamSdk:Report(content)
  print(content)
  Logger.ReportApusInfo(content)
end

return SteamSdk
