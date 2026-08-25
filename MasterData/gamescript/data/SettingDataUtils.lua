local SettingDataUtils = {}

function SettingDataUtils.ReqGainAttentionCommunityReward(communityName)
  ProtoManager.Instance:ReqServer("SettingRequest", "ReqGainAttentionCommunityReward", function(data)
    Logger.Info("ReqGainAttentionCommunityReward success ", table.tostring(data))
    PlayerDataUtils.SetAttentionCommunityStatsData(communityName, 1)
  end, function(_)
    Logger.Info("ReqGainAttentionCommunityReward false")
  end, communityName)
end

function SettingDataUtils.ReqGainTranslateGratitudeReward()
  ProtoManager.Instance:ReqServer("SettingRequest", "ReqGainTranslateGratitudeReward", function(data)
    Logger.Info("ReqGainTranslateGratitudeReward success ", table.tostring(data))
    PlayerDataUtils.SetTranslateGratitudeRewardStatsData(1)
  end, function(_)
    Logger.Info("ReqGainTranslateGratitudeReward false")
  end)
end

return SettingDataUtils
