local SettingDefine = {}
SettingDefine.LoginRewardType = {PC = "PC", MOBILE = "MOBILE"}
SettingDefine.LoginRewardType2StatsTypeDict = {
  [SettingDefine.LoginRewardType.PC] = CommonDefine.PlayerStatsType.OSLoginReward_PC,
  [SettingDefine.LoginRewardType.MOBILE] = CommonDefine.PlayerStatsType.OSLoginReward_MOBILE
}
return SettingDefine
