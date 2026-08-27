local RequestPreview = {}
local cs_MicaSDKManager = CS.MicaSDKManager

function RequestPreview:RequestReview()
  if Consts.GameChannelType.IsPnSdk() then
    cs_MicaSDKManager.Instance:AppReview()
    return
  end
  local channelId = cs_MicaSDKManager.Instance.channelId
  if GameSystemInfo.Platform == GameSystemInfo.PlatformType.iOS then
    CS.UnityExtension.RequestIOSPreview()
  else
    if channelId == Consts.GameChannelType.Bilibili or channelId == Consts.GameChannelType.BilibiliKol or channelId == Consts.GameChannelType.BilibiliGray or channelId == Consts.GameChannelType.BilibiliQATest then
    end
    if GameSystemInfo.Platform == GameSystemInfo.PlatformType.Android and Consts.GameChannelType.IsOversea() then
      cs_MicaSDKManager.Instance:AppReview()
    else
    end
  end
end

function RequestPreview:TryRequestReview(rewardElemList)
  if PlayerDataCenter.allLtrData:IsDrawHeroRankCountAboveZero() then
    return
  end
  local isNeed = false
  for _, rewardData in pairs(rewardElemList) do
    if rewardData.heroData ~= nil and rewardData.heroData:GetHeroDefaultRank() == 6 then
      isNeed = true
      break
    end
  end
  if not isNeed then
    return
  else
    PlayerDataCenter.allLtrData.drawHeroRankCount = 1
  end
  if isGameDev then
    print("打算弹评价")
  end
  self:RequestReview()
end

return RequestPreview
