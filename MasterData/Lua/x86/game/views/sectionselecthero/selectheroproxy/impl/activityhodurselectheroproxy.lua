local ActivityHodurSelectHeroProxy = class("ActivityHodurSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function ActivityHodurSelectHeroProxy:GetStageData()
	local var_1_0 = BattleStageFactory.Produce(self.stageType, self.stageID, {
		activityID = self.activityID,
		chapterID = self.chapterID
	}, self.reserveParams)

	HodurSystemData:CacheStageData(var_1_0)

	return var_1_0
end

function ActivityHodurSelectHeroProxy:CustomChangeHeroTeam(arg_2_1, arg_2_2)
	ReserveTools.SetHeroList(self.reserveParams, arg_2_1, arg_2_2)
	HodurSystemData:SetChallengeTeam(arg_2_1, arg_2_2)
end

function ActivityHodurSelectHeroProxy:InitCustomParams(arg_3_1)
	self.chapterID = arg_3_1.chapterID
	self.needMimirPanel = false
	self.canChangeMimir = false
	self.needReserveProposalPanel = false
	self.canChangeReserveProposal = false
	self.needHeroHP = true
	self.forceChangePos = true
	self.canUseMultiMode = false
end

function ActivityHodurSelectHeroProxy:CustomGetTeamData()
	local var_4_0, var_4_1, var_4_2, var_4_3 = ReserveTools.GetHeroList(self.reserveParams)

	return var_4_0, var_4_1, var_4_2, var_4_3
end

function ActivityHodurSelectHeroProxy:CustomGetHeroHP(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0, var_5_1 = HodurTools.GetChapterHeroHP(self.chapterID, arg_5_3 ~= nil and arg_5_3 ~= 0 and arg_5_3 or arg_5_2)
	local var_5_2 = math.max(1, math.floor(var_5_0 / var_5_1 * 100))

	return var_5_0, (var_5_0 == 0 or nil) and 0
end

function ActivityHodurSelectHeroProxy:CheckBeforeGotoHeroInfoUI(arg_6_1)
	if not self.canChangeTeam then
		return false, "CAN_NOT_CHANGE_HERO"
	end

	if self.stageID and self.stageID ~= 0 then
		local var_6_0, var_6_1 = BattleStageTools.GetRestrictHeroList(self.stageType, self.stageID)

		if type(var_6_0) == "table" then
			if var_6_0[arg_6_1][1] == 0 then
				return false, "CAN_NOT_CHANGE_HERO"
			end

			if HeroCfg[var_6_0[arg_6_1][1]] and HeroTools.IsNPC(var_6_0[arg_6_1][1]) and (type(var_6_1) ~= "table" or var_6_1[arg_6_1] == ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID) then
				return false, "CAN_NOT_CHANGE_HERO"
			end
		end

		local var_6_2, var_6_3, var_6_4, var_6_5 = ReserveTools.GetHeroList(self.reserveParams)

		if type(var_6_3) == "table" and var_6_3[arg_6_1] then
			return false, "CAN_NOT_CHANGE_HERO"
		end
	end

	return self:CustomCheckBeforeGotoHeroInfoUI(arg_6_1)
end

return ActivityHodurSelectHeroProxy
