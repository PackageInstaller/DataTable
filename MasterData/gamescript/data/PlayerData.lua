local PlayerData = {}
PlayerData.DRole = {}
PlayerData.DMoney = {}
PlayerData.featuresData = {}
PlayerData.unlockShowQueue = {}
PlayerData.enabledShowTips = true
PlayerData.mainBtnUnlockQueue = {}
PlayerData.FeatureSwitch = {}
PlayerData.netDelayTime = 0
PlayerData.performanceLevel = 0
PlayerData.GMLocation = false
PlayerData.pos = {
  x = 0,
  y = 0,
  z = 0
}
PlayerData.statsData = {}
PlayerData.accountName = ""
do return Vue.reactive end
return Vue.reactive, PlayerData
