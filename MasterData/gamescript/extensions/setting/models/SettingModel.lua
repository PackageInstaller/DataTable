local SettingModel = NewClass("SettingModel", BaseModel)

function SettingModel:OnReset()
end

function SettingModel:OnInit()
  self:OnReset()
end

function SettingModel:GetLoginRewardState(loginRewardType)
  local statsType = SettingDefine.LoginRewardType2StatsTypeDict[loginRewardType]
  if not statsType then
    return CommonDefine.CommonState.Running
  end
  local isReceived = PlayerDataUtils.GetBaseStatsData(statsType)
  local isPCPlatform = ApplicationUtils.IsWindowsOrEditor()
  local isCurLoginPlatform = loginRewardType == SettingDefine.LoginRewardType.PC and isPCPlatform or loginRewardType == SettingDefine.LoginRewardType.MOBILE and not isPCPlatform
  if isCurLoginPlatform then
    return isReceived and CommonDefine.CommonState.Finish or CommonDefine.CommonState.GainPrize
  else
    return isReceived and CommonDefine.CommonState.Finish or CommonDefine.CommonState.Running
  end
end

return SettingModel
