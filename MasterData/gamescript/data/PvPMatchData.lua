local PvPMatchData = Vue.reactive({})
PvPMatchData.playerData = nil
PvPMatchData.enermyData = nil
PvPMatchData.isMatching = false
PvPMatchData.isPvpPreparing = false
PvPMatchData.draftScoreCondition = 0
PvPMatchData.pvpBattleInfo = nil
return PvPMatchData
