local PayIapHelper = {}

function PayIapHelper.IsDefaultUseIap()
  local defaultPay = PayHelper.GetDefaultPayType()
  if defaultPay == "iap" then
    return true
  end
  return false
end

function PayIapHelper.Buy(productId, cb, uiParams)
  local args = Json.decode(uiParams)
  local productName = args.name
  local payAmount = args.payAmount
  local shpoId = args.shopId
  local currencyType = PayHelper.GetCurrencyTypeStr()
  local sPayType = "applepay"
  if PlatformHelper.IsAndroid() then
    sPayType = "googlepay"
  end
  SdkHelper.OpenWaiting()
  Net:SendProto("pay.create_oid", function(json1)
    local isFirst = json1.is_first or 0
    local out_trade_no = json1.out_trade_no
    SdkReporter.TrackOrder(out_trade_no, payAmount, currencyType, sPayType)
    FirebaseReporter.TrackBeginCheckout(currencyType, payAmount)
    OfficialWebCoinPayHelper.TryOpenRechargeGuideUrl(json1.charge_url)
    
    local function funcPayByIap()
      local suffixProductId = productId
      if PlatformHelper.IsIPhone() and SdkChannelHelper.IsCurTwOfficial() then
        suffixProductId = "resotw_" .. productId
      end
      CS.PayLuaface.PayByIap(suffixProductId, function(isSuccess, msg)
        if not isSuccess then
          SdkReporter.TrackBuyFail(out_trade_no, payAmount, sPayType, productId, productName, isFirst)
          SdkHelper.CloseWaiting()
          return
        end
        local transactionId = PayIapMgr:GetTransactionId()
        
        local function cbSuccess(json)
          SdkHelper.CloseWaiting()
          SdkReporter.TrackBuySuccess(out_trade_no, payAmount, sPayType, productId, productName, isFirst)
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
    
    local function funcOcWebTip()
      SdkHelper.CloseWaiting()
      
      local function yesFunc()
        OfficialWebPayHelper.Buy(productId, cb, uiParams, {tipWebCoin = false})
      end
      
      if WebViewHelper.CanUseWebView() then
        UIManager:Open("UI/Japanpay/JapanPay", uiParams, yesFunc, funcPayByIap)
      else
        UIManager:Open("UI/Common/PayTips/TokenPayTipsPlus", nil, yesFunc, funcPayByIap)
      end
    end
    
    if OfficialWebCoinPayHelper.CanOfficalWebCoinPay(productId) then
      OfficialWebCoinPayHelper.StartOfficialWebCoinPay(productId, out_trade_no, uiParams, cb, funcOcWebTip)
    else
      funcOcWebTip()
    end
  end, productId, shpoId)
end

return PayIapHelper
