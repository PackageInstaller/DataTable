local PayHelper = {}
PayGV = require("Logic/Pay/PayGV")
WxPayHelper = require("Logic/Pay/Wx/WxPayHelper")
PayHaoPlayHelper = require("Logic/Pay/HaoPlay/PayHaoPlayHelper")
PayDmmHelper = require("Logic/Pay/DMM/PayDmmHelper")
PayIapMgr = require("Logic/Pay/PayIapMgr")
PayIapHelper = require("Logic/Pay/IAP/PayIapHelper")
PayGooglehelper = require("Logic/Pay/Google/PayGoogleHelper")
PayProductHelper = require("Logic/Pay/Product/PayProductHelper")
CommonPayHelper = require("Logic/Pay/Common/CommonPayHelper")
OfficialWebPayHelper = require("Logic/Pay/Imp/OfficialWebPayHelper")
OfficialWebCoinPayHelper = require("Logic/Pay/Imp/OfficialWebCoinPayHelper")
CnOfficialWebPcPayHelper = require("Logic/Pay/Imp/CnOfficialWebPcPayHelper")
CnBiliPcPayHelper = require("Logic/Pay/Imp/CnBiliPcPayHelper")
PayUjoyHelper = require("Logic/Pay/Ujoy/PayUjoyHelper")
SteamPayHelper = require("Logic/Pay/Steam/SteamPayHelper")
PayHelper.EPayPlatform = {
  Default = 0,
  IOS = 1,
  Android = 2,
  Channel = 3
}
PayHelper.isInitCsMgr = false

function PayHelper.InitCsMgr()
  if PayHelper.isInitCsMgr then
    return
  end
  PayHelper.isInitCsMgr = true
  local factory = CacheAndGetFactory("ValuableFactory")
  local list = CsHelper.NewLuaListStr()
  for k, v in pairs(factory) do
    if PlatformHelper.IsIPhone() and SdkChannelHelper.IsCurTwOfficial() then
      list:Add("resotw_" .. k)
    else
      list:Add(k)
    end
  end
  if PayHelper.CSPayLuaface().InitMgr ~= nil then
    print("[Pay]Start Init PayMgr")
    CS.PayLuaface.InitMgr(list:GetCsList())
  end
  WxPayHelper.Init()
  ChannelPayMgr:Init()
end

function PayHelper.GetProductList()
  local factory = CacheAndGetFactory("ValuableFactory")
  local list = CsHelper.NewLuaListStr()
  for k, v in pairs(factory) do
    list:Add(k)
  end
  return list:GetCsList()
end

function PayHelper.CSPayLuaface()
  return CS.PayLuaface
end

function PayHelper.BuyV2(productId, cb)
  local strProductId = productId
  if type(productId) ~= "string" then
    strProductId = tostring(productId)
  end
  local name = PayProductHelper.GetProductConfigName(strProductId)
  local priceStr = PayProductHelper.GetProductDisplayPrice(strProductId, true)
  local payAmount = PayProductHelper.GetProductConfigPriceAmount(strProductId)
  local shopId = PayProductHelper.GetProductConfigShopId(strProductId)
  local uiParams = Json.encode({
    name = name,
    price = priceStr,
    itemId = productId,
    shopId = shopId,
    payAmount = payAmount
  })
  PayHelper.Buy(strProductId, cb, uiParams)
end

function PayHelper.Buy(productId, cb, uiParams)
  local args = Json.decode(uiParams)
  local productName = args.name
  local payAmount = args.payAmount
  local shpoId = args.shopId
  local currencyType = PayHelper.GetCurrencyTypeStr()
  if PayProductHelper.IsProductBuyTypeItem(productId) then
    PayHelper.ReqDefaultBuy(function(json)
      pcall(cb, json)
    end, args.itemId, args.shopId)
    return
  end
  if SdkChannelHelper.IsCurJPOfficialWeb() or SdkChannelHelper.IsCurTwOfficialWeb() then
    OfficialWebPayHelper.Buy(productId, cb, uiParams)
    return
  end
  if SdkHelper.IsChannelHaoPlay() then
    PayHaoPlayHelper.Buy(productId, shpoId, cb)
    return
  end
  if SdkHelper.IsChannelDmm() then
    PayDmmHelper.Buy(productId, cb, uiParams)
    return
  end
  if PayGooglehelper.IsUseGooglePay() then
    PayGooglehelper.Buy(productId, cb, uiParams)
    return
  end
  if SdkChannelHelper.IsCurSteam() then
    SteamPayHelper.Buy(productId, cb, uiParams)
    return
  end
  if PayIapHelper.IsDefaultUseIap() then
    PayIapHelper.Buy(productId, cb, uiParams)
    return
  end
  if CnBiliPcPayHelper.IsUse() then
    CnBiliPcPayHelper.Buy(productId, cb, uiParams)
    return
  end
  if CnOfficialWebPcPayHelper.IsUseCnOfficialWebPcPay() then
    CnOfficialWebPcPayHelper.Buy(productId, cb, uiParams)
    return
  end
  if PayUjoyHelper.IsUseUjoyPay() then
    PayUjoyHelper.Buy(productId, cb, uiParams)
    return
  end
  if PlayerData:CheckoutPurchase({payAmount = payAmount}) == false then
    return
  end
  if ChannelPayMgr:IsUseChannelPay() then
    ChannelPayMgr:Buy(productId, cb, uiParams)
    return
  end
  if PayHelper.IsUseCommonPay() then
    CommonPayHelper.Buy(productId, cb, uiParams)
  elseif PayHelper.IsPayPlatformDefault() then
    PayHelper.ReqDefaultBuy(function(json)
      pcall(cb, json)
    end, args.itemId, args.shopId)
  elseif PayHelper.IsPayPlatformChannel() then
    if SdkHelper.IsChannelBilibili() then
      Net:SendProto("pay.biligame_order_str", function(json)
        local isFirst = json.is_first or 0
        local orignData = json.origin_data
        local out_trade_no = orignData.out_trade_no
        SdkReporter.TrackOrder(out_trade_no, payAmount, currencyType, "bilibili")
        orignData.subject = productName
        orignData.body = productName
        orignData.sign = json.sign
        local jsonStr = Json.encode(orignData)
        print_r("[Pay]pay.biligame_order_str recv jsonStr=" .. jsonStr)
        
        local function sdkPay()
          PayHelper.CallChannelPay(function(isSuccess)
            if not isSuccess then
              SdkReporter.TrackBuyFail(out_trade_no, payAmount, "bilibili", productId, productName, isFirst)
              return
            end
            SdkReporter.TrackBuySuccess(out_trade_no, payAmount, "bilibili", productId, productName, isFirst)
            PayHelper.ReqQueryOID(out_trade_no, cb, args)
          end, jsonStr)
        end
        
        local function onCancel()
          SdkHelper.CloseWaiting()
          sdkPay()
        end
        
        if OfficialWebCoinPayHelper.CanOfficalWebCoinPay(productId) then
          OfficialWebCoinPayHelper.StartOfficialWebCoinPay(productId, out_trade_no, uiParams, cb, onCancel)
        else
          sdkPay()
        end
      end, productId, shpoId)
    else
      PayHelper.BuyWithAndroid(productId, cb, uiParams)
    end
  elseif PayHelper.IsPayPlatformAndroid() then
    PayHelper.BuyWithAndroid(productId, cb, uiParams)
  elseif PayHelper.IsPayPlatformIOS() then
    SdkHelper.OpenWaiting()
    Net:SendProto("pay.create_oid", function(json1)
      local isFirst = json1.is_first or 0
      local out_trade_no = json1.out_trade_no
      SdkReporter.TrackOrder(out_trade_no, payAmount, currencyType, "applepay")
      
      local function funcSdkBuy()
        CS.PayLuaface.Buy(productId, function(isSuccess, msg)
          if not isSuccess then
            SdkReporter.TrackBuyFail(out_trade_no, payAmount, "applepay", productId, productName, isFirst)
            SdkHelper.CloseWaiting()
            return
          end
          local transactionId = PayIapMgr:GetTransactionId()
          
          local function cbSuccess(json)
            SdkHelper.CloseWaiting()
            SdkReporter.TrackBuySuccess(out_trade_no, payAmount, "applepay", productId, productName, isFirst)
            PayIapMgr:ConfirmPendingPurchase()
            pcall(cb, json)
          end
          
          local function cbFail(json)
            SdkHelper.CloseWaiting()
            PayIapMgr:OnIosChargeRefreshFailed(json)
          end
          
          Net:SendProto("pay.ios_charge_refresh", cbSuccess, msg, out_trade_no, transactionId, cbFail)
        end)
      end
      
      if OfficialWebCoinPayHelper.CanOfficalWebCoinPay(productId) then
        OfficialWebCoinPayHelper.StartOfficialWebCoinPay(productId, out_trade_no, uiParams, cb, funcSdkBuy)
      else
        funcSdkBuy()
      end
    end, productId, shpoId, "ios")
  end
end

function PayHelper.BuyWithAndroid(productId, cb, uiParams)
  local args = Json.decode(uiParams)
  local shpoId = args.shopId
  
  local function funcNormalPay()
    UIManager:Open("UI/Common/PayTips/PayTips", uiParams, function()
      Debug.Log("[Pay]UI/Common/PayTips/PayTips Confirm")
      PayHelper.ReqPayOrder(productId, function(json)
        pcall(cb, json)
      end, args)
    end)
  end
  
  local function funcWebCoinCancel()
    SdkHelper.CloseWaiting()
    funcNormalPay()
  end
  
  if OfficialWebCoinPayHelper.CanOfficalWebCoinPay(productId) then
    local function funcOk(json1)
      local out_trade_no = json1.out_trade_no
      
      OfficialWebCoinPayHelper.StartOfficialWebCoinPay(productId, out_trade_no, uiParams, cb, funcWebCoinCancel)
    end
    
    Net:SendProto("pay.create_oid", funcOk, productId, shpoId, "and")
  else
    funcNormalPay()
  end
end

function PayHelper.ValidateBuy(str, cb)
end

function PayHelper.CallAndroidPaySdk(productId, cb)
end

function PayHelper.CallChannelPay(callback, jsonStr)
  CS.PayLuaface.CallChannelPay(callback, jsonStr)
end

function PayHelper.ReqDefaultBuy(cb, itemId, shopId)
  Net:SendProto("shop.purchase", cb, itemId, shopId)
end

function PayHelper.ReqPayOrder(productId, cb, args)
  local productName = args.product_name
  local payAmount = args.payAmount
  local shopId = args.shopId
  local currencyType = PayHelper.GetCurrencyTypeStr()
  local channelFlag = WxPayHelper.GetChannelFlag()
  if PayGV.IsCurPayTypeAlipay() then
    print_r("[Pay]sendproto pay.order_str")
    Net:SendProto("pay.order_str", function(json)
      local isFirst = json.is_first or 0
      local out_trade_no = json.out_trade_no
      SdkReporter.TrackOrder(out_trade_no, payAmount, currencyType, "alipay")
      print_r("[Pay]recvproto pay.order_str json=", json)
      PayHelper.CallAndroidAlipay(function(json1)
        print_r("[Pay]CallAndroidAlipay Return json=", json1)
        local data = Json.decode(json1)
        local resultStatus = data.resultStatus
        if resultStatus == "6001" then
          print_r("Unity [Pay]CallAndroidAlipay Return 6001")
          SdkReporter.TrackBuyFail(out_trade_no, payAmount, "alipay", productId, productName, isFirst)
        elseif resultStatus == "9000" then
          local resultInfo = data.resultInfo
          print_r("Unity [Pay]CallAndroidAlipay Return 9000 result =" .. resultInfo)
          local result = Json.decode(resultInfo)
          local alipay_trade_app_pay_response = result.alipay_trade_app_pay_response
          local out_trade_no = alipay_trade_app_pay_response.out_trade_no
          SdkReporter.TrackBuySuccess(out_trade_no, payAmount, "alipay", productId, productName, isFirst)
          PayHelper.ReqQueryOID(out_trade_no, cb, args)
        end
      end, json.order_str)
    end, productId, shopId)
  elseif PayGV.IsCurPayTypeWx() then
    Net:SendProto("pay.wx_order_str", function(json)
      local isFirst = json.is_first or 0
      print_r("[Pay]recvproto pay.wx_order_str json=", json)
      local out_trade_no = json.out_trade_no
      SdkReporter.TrackOrder(out_trade_no, payAmount, currencyType, "weixin")
      local prepayid = json.prepay_id
      local noncestr = json.noncestr
      local timestamp = json.server_now
      local sign = json.sign
      PayHelper.CallAndroidWxPay(function(json1)
        print_r("[Pay]CallAndroidWxPay Return json=", json1)
        local data = Json.decode(json1)
        local errCode = data.errCode
        local errStr = data.errStr
        local transaction = data.transaction
        local openId = data.openId
        if errCode ~= 0 then
          print_r("[Pay]CallAndroidWxPay Failed")
          SdkReporter.TrackBuyFail(out_trade_no, payAmount, "weixin", productId, isFirst)
          return
        end
        SdkReporter.TrackBuySuccess(out_trade_no, payAmount, "weixin", productId, isFirst)
        PayHelper.ReqQueryOID(out_trade_no, cb, args)
      end, prepayid, noncestr, timestamp, sign)
    end, productId, shopId, channelFlag)
  end
end

function PayHelper.ReqQueryOID(oid, cb, args)
  Debug.Log("[SDK Pay]ReqQueryOID = oid =" .. tostring(oid))
  Net:SendProto("pay.query_oid", function(json)
    pcall(cb, json)
  end, oid)
end

function PayHelper.TryValideBuy(str, cb)
  if PayHelper.IsPayPlatformIOS() then
    PayHelper.ValidateBuy(str, cb)
  end
end

function PayHelper.CallAndroidAlipay(cb, orderInfo)
  CS.PayLuaface.CallAndroidAlipay(cb, orderInfo)
end

function PayHelper.CallAndroidWxPay(cb, prepayid, noncestr, timestamp, sign)
  CS.PayLuaface.CallAndroidWxPay(cb, prepayid, noncestr, timestamp, sign)
end

function PayHelper.GetPayPlatform()
  return CS.PayLuaface.GetPayPlatform()
end

function PayHelper.IsPayPlatformDefault()
  return PayHelper.GetPayPlatform() == PayHelper.EPayPlatform.Default
end

function PayHelper.IsPayPlatformIOS()
  return PayHelper.GetPayPlatform() == PayHelper.EPayPlatform.IOS
end

function PayHelper.IsPayPlatformAndroid()
  return PayHelper.GetPayPlatform() == PayHelper.EPayPlatform.Android
end

function PayHelper.IsPayPlatformChannel()
  return PayHelper.GetPayPlatform() == PayHelper.EPayPlatform.Channel
end

function PayHelper.GetCurrencyTypeStr()
  if SdkRegionHelper.IsRegionJP() then
    return "JPY"
  elseif SdkRegionHelper.IsRegionKR() then
    return "KRW"
  elseif SdkRegionHelper.IsRegionTW() then
    return "TWD"
  end
  return "CNY"
end

function PayHelper.IsUseCommonPay()
  local s, r = CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.IsUseCommonPay)
  if s and r ~= nil and r == 1 then
    return true
  end
  return false
end

function PayHelper.GetDefaultPayType()
  local s, r = CommonHelper.SafeCallCsFunc(CS.PayLuaface.GetDefaultPayType)
  if s == nil or r == nil then
    return ""
  end
  return r
end

function PayHelper.OnRestoreCharge(jsonStr)
  if PayGooglehelper.IsUseGooglePay() then
    PayGooglehelper.RestoreCharge(jsonStr)
  end
end

function PayHelper.OnEnterGame()
  PayDmmHelper.OnEnterGame()
end

function PayHelper.GetArgNeedRealInfo()
  if SdkAdMarkHelper.IsTypeOverseas() then
    return "0"
  else
    return "1"
  end
end

function PayHelper.GetDefaultEArgs()
  local eArgs = {tipWebCoin = true}
  return eArgs
end

return PayHelper
