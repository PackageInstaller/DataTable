local DBGTeamData = Vue.reactive({})
DBGTeamData.teams = {}
DBGTeamData.teamsUnlock = {}
DBGTeamData.lastSelectTeam = 0
DBGTeamData.recommendedSchoolID = 0
DBGTeamData.specialKeeperSkill = nil
DBGTeamData.clearForbiddenAwakers = false
return DBGTeamData
