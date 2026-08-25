local NetworkMgr = require("Network.NetworkMgr")
local SettingRequest, Super = System.NewClass("SettingRequest", ProtoBase)

function SettingRequest:ReqShareReward()
  Logger.Proto("ReqShareReward")
  do return NetworkMgr.Instance.Setting.GainShareReward end
  return NetworkMgr.Instance.Setting.GainShareReward, NetworkMgr.Instance.Setting
end

function SettingRequest:ReqBindPhoneReward()
  Logger.Proto("ReqBindPhoneReward")
  do return NetworkMgr.Instance.Setting.GainBindPhoneReward end
  return NetworkMgr.Instance.Setting.GainBindPhoneReward, NetworkMgr.Instance.Setting
end

function SettingRequest:ReqGainAttentionCommunityReward(communityName)
  Logger.Proto("ReqGainAttentionCommunityReward: communityName=%s", communityName)
  do return NetworkMgr.Instance.Setting.GainAttentionCommunityReward, NetworkMgr.Instance.Setting end
  return NetworkMgr.Instance.Setting.GainAttentionCommunityReward, NetworkMgr.Instance.Setting, communityName
end

function SettingRequest:ReqGainTranslateGratitudeReward()
  Logger.Proto("ReqGainTranslateGratitudeReward")
  do return NetworkMgr.Instance.Setting.GainTranslateGratitudeReward end
  return NetworkMgr.Instance.Setting.GainTranslateGratitudeReward, NetworkMgr.Instance.Setting
end

function SettingRequest:ReqChangeLanguage(code)
  Logger.Proto("ReqChangeLanguage: code=%s", code)
  do return NetworkMgr.Instance.Setting.ChangeLanguage, NetworkMgr.Instance.Setting end
  return NetworkMgr.Instance.Setting.ChangeLanguage, NetworkMgr.Instance.Setting, code
end

function SettingRequest:ReqGetOSLoginReward(loginRewardType)
  Logger.Proto("ReqGetOSLoginReward: loginRewardType=%s", loginRewardType)
  do return NetworkMgr.Instance.Setting.GetOSLoginReward, NetworkMgr.Instance.Setting end
  return NetworkMgr.Instance.Setting.GetOSLoginReward, NetworkMgr.Instance.Setting, loginRewardType
end

function SettingRequest:ReqRefreshBindPhoneOrEmailState()
  Logger.Proto("ReqRefreshBindPhoneOrEmailState")
  do return NetworkMgr.Instance.Setting.OnRefreshBindPhoneOrEmailState end
  return NetworkMgr.Instance.Setting.OnRefreshBindPhoneOrEmailState, NetworkMgr.Instance.Setting
end

return SettingRequest
