local PvpRewardRequest, _ = System.NewClass("PvpRewardRequest", ProtoBase)

function PvpRewardRequest:OnGainAllLevelReward(careerLevelType)
  Logger.Proto("OnGainAllLevelReward careerLevelType ", careerLevelType)
  do return NetworkMgr.Instance.PvpReward.OnGainAllLevelReward, NetworkMgr.Instance.PvpReward end
  return NetworkMgr.Instance.PvpReward.OnGainAllLevelReward, NetworkMgr.Instance.PvpReward, careerLevelType
end

return PvpRewardRequest
