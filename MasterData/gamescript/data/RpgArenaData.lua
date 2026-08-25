local RpgArenaData = Vue.reactive({})
RpgArenaData.myRole = {}
RpgArenaData.opponents = {}
RpgArenaData.ranks = {}
RpgArenaData.historyCombat = {}
RpgArenaData.defendTeam = {
  0,
  0,
  0,
  0,
  0,
  0
}
RpgArenaData.combatTeam = {
  0,
  0,
  0,
  0,
  0,
  0
}
RpgArenaData.rankUpData = nil
RpgArenaData.inited = false
return RpgArenaData
