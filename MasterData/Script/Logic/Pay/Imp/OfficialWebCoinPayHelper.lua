local OfficalWebCoinPayHelper = {}
OfficalWebCoinPayHelper.CoinRatioJp = 1
OfficalWebCoinPayHelper.CoinRatioCn = 1
OfficalWebCoinPayHelper.CoinRatioKr = 0.01
OfficalWebCoinPayHelper.CoinRatioUs = 100

function OfficalWebCoinPayHelper.IsOfficialWebCoinEnable()
  local isCn = SdkRegionHelper.IsRegionCN()
  local isJp = SdkRegionHelper.IsRegionJP()
  local isKR = SdkRegionHelper.IsRegionKR()
  local isUS = SdkRegionHelper.IsRegionUS()
  local isTW = SdkRegionHelper.IsRegionTW()
  local isRegionOK = isCn or isJp or isKR or isUS or isTW
  if isRegionOK == false then
    return false
  end
  if SdkHelper.IsChannelDmm() then
    return false
  end
  return true
end

function OfficalWebCoinPayHelper.TryOpenRechargeGuideUrl(rechargeGuideUrl)
  if rechargeGuideUrl == nil then
    return
  end
  if OfficalWebCoinPayHelper.IsOfficialWebCoinEnable() == false then
    return
  end
  CS.UnityEngine.Application.OpenURL(rechargeGuideUrl or "")
end

function OfficalWebCoinPayHelper.GetCoinRatio()
  if SdkRegionHelper.IsRegionCN() then
    return OfficalWebCoinPayHelper.CoinRatioCn
  elseif SdkRegionHelper.IsRegionKR() then
    return OfficalWebCoinPayHelper.CoinRatioKr
  elseif SdkRegionHelper.IsRegionUS() then
    return OfficalWebCoinPayHelper.CoinRatioUs
  end
  return OfficalWebCoinPayHelper.CoinRatioJp
end

function OfficalWebCoinPayHelper.GetNowWCoinAmount()
  local userInfo = PlayerData:GetUserInfo()
  if userInfo == nil then
    return 0
  end
  return userInfo.wcoin or 0
end

function OfficalWebCoinPayHelper.CanOfficalWebCoinPay(productId)
  if OfficalWebCoinPayHelper.IsOfficialWebCoinEnable() == false then
    return false
  end
  local nowNum = OfficalWebCoinPayHelper.GetNowWCoinAmount()
  if nowNum <= 0 then
    return false
  end
  local ratio = OfficalWebCoinPayHelper.GetCoinRatio()
  local productPrice = PayProductHelper.GetProductConfigPriceAmount(productId)
  local finalProductPrice = productPrice * ratio
  if nowNum < finalProductPrice then
    return false
  end
  return true
end

function OfficalWebCoinPayHelper.StartOfficialWebCoinPay(productId, out_trade_no, args, cbSuccess, cbCancel)
  SdkHelper.CloseWaiting()
  
  local function funcCanel()
    SdkHelper.OpenWaiting()
    if cbCancel ~= nil then
      cbCancel()
    end
  end
  
  local function funcOK()
    Net:SendProto("pay.wcoin_charge_result", function(json)
      if json.rc and json.rc ~= "" then
        CommonTips.OpenTips(json.msg)
        return
      end
      local payAmount = PayProductHelper.GetProductConfigPriceAmount(productId)
      local productName = PayProductHelper.GetProductConfigName(productId)
      SdkReporter.TrackBuySuccess(out_trade_no, payAmount, "officialWebCoin", productId, productName)
      if cbSuccess ~= nil then
        cbSuccess(json)
      end
    end, productId)
  end
  
  UIManager:Open("UI/Common/PayTips/TokenPayTips", args, funcOK, funcCanel)
end

return OfficalWebCoinPayHelper
