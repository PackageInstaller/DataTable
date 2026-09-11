local ActivitySwimsuitSelectHeroProxy = class("ActivitySwimsuitSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function ActivitySwimsuitSelectHeroProxy:InitCustomParams(arg_1_1)
	self.needComboSkillPanel = false
	self.needMimirPanel = false
	self.needReserveProposalPanel = false
end

function ActivitySwimsuitSelectHeroProxy:GetHeroTeamInfoRoute()
	return "/swimsuitBattleTeamInfo"
end

function ActivitySwimsuitSelectHeroProxy:CustomGetTeamData()
	local var_3_0, var_3_1, var_3_2, var_3_3 = ReserveTools.GetHeroList(self.reserveParams, true)

	return var_3_0, var_3_1, var_3_2, var_3_3
end

return ActivitySwimsuitSelectHeroProxy
