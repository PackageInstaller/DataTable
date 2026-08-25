local BpPrivilegeLevel = CommonDefine.BpPrivilegeLevel
local BattlePassData = Vue.reactive({})
BattlePassData.rewardMap = {}
BattlePassData.rewardList = {}
BattlePassData.level = 0
BattlePassData.exp = 0
BattlePassData.weeklyExp = 0
BattlePassData.privilegeLevel = BpPrivilegeLevel.Ordinary
BattlePassData.isChargeDLC = false
BattlePassData.startTs = 0
BattlePassData.endTs = 0
BattlePassData.tid = 0
BattlePassData.isNew = false
BattlePassData.extraLvAwardNum = 0
BattlePassData.oldExtraLvAwardNum = 0
return BattlePassData
