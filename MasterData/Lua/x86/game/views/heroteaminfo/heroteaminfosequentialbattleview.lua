local HeroTeamInfoSequentialBattleView = class("HeroTeamInfoSequentialBattleView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function HeroTeamInfoSequentialBattleView:OnEnter()
	self.cacheSorterExtraHeroList_ = {}

	HeroTeamInfoSequentialBattleView.super.OnEnter(self)
end

function HeroTeamInfoSequentialBattleView:GetCacheSorterExtraHeroList(arg_2_1, arg_2_2)
	if self.cacheSorterExtraHeroList_[arg_2_2] then
		return self.cacheSorterExtraHeroList_[arg_2_2]
	end

	self.cacheSorterExtraHeroList_[arg_2_2] = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE_CACHE):GetContDataTemplateById(arg_2_1):GetHeroList(arg_2_2)

	return self.cacheSorterExtraHeroList_[arg_2_2]
end

function HeroTeamInfoSequentialBattleView:ExtraSorter(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = table.keyof(SequentialBattleChapterCfg[self.params_.activityID].stage_id, self.params_.stageID)
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in pairs(self.heroTeam_) do
		var_3_1[iter_3_0] = {
			id = iter_3_1,
			trialID = self.heroTrialList_[iter_3_0]
		}
	end

	local var_3_2 = false
	local var_3_3 = false

	for iter_3_2 = 1, #SequentialBattleChapterCfg[self.params_.activityID].stage_id do
		if iter_3_2 ~= var_3_0 then
			for iter_3_3, iter_3_4 in pairs((self:GetCacheSorterExtraHeroList(self.params_.activityID, iter_3_2))) do
				local var_3_4 = iter_3_4:GetHeroID()

				if arg_3_1.id == var_3_4 then
					var_3_2 = true
				end

				if arg_3_2.id == var_3_4 then
					var_3_3 = true
				end
			end
		end
	end

	if var_3_2 ~= var_3_3 then
		return true, not not var_3_3
	end

	return HeroTeamInfoSequentialBattleView.super.ExtraSorter(self, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
end

function HeroTeamInfoSequentialBattleView:HeadRenderer(arg_4_1, arg_4_2)
	HeroTeamInfoSequentialBattleView.super.HeadRenderer(self, arg_4_1, arg_4_2)
	arg_4_2:SetHeroLock(table.keyof(self.lockHeroList_, self.heroDataList_[arg_4_1].id) ~= nil)
end

function HeroTeamInfoSequentialBattleView:OnJoinClick()
	HeroTeamInfoSequentialBattleView.super.OnJoinClick(self)
end

function HeroTeamInfoSequentialBattleView:ChangeTeam(arg_6_1, arg_6_2)
	ReserveTools.SetHeroList(self.params_.reserveParams, arg_6_1, arg_6_2)
	self.sectionProxy_:ChangeHeroTeam(arg_6_1, arg_6_2)
end

return HeroTeamInfoSequentialBattleView
