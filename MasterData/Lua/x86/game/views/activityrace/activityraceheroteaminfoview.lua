local ActivityRaceHeroTeamInfoView = class("ActivityRaceHeroTeamInfoView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function ActivityRaceHeroTeamInfoView:OnEnter()
	manager.ui:SetMainCamera("hero")

	if self.params_.isEnter then
		if self.filterView_ then
			self.filterView_:Reset()
		end

		self.params_.isEnter = false
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	SetActive(self.infoBtn_.gameObject, true)

	if self.heroAvatarView_ then
		self.heroAvatarView_:OnEnter()
	end

	self:GetHeroTeam()

	self.trialHeroList_ = GetTrialHeroList(self.params_.stageType, self.params_.stageID, self.params_.activityID)

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in pairs(self:GetHeroList()) do
		if HeroCfg[iter_1_1].race == ActivityRaceCfg[self.params_.activityID].race_id then
			table.insert(var_1_0, {
				trialID = 0,
				id = iter_1_1,
				type = HeroConst.HERO_DATA_TYPE.DEFAULT
			})
		end
	end

	local var_1_1 = {}
	local var_1_2 = BattleStageTools.GetRestrictHeroList(self.params_.stageType, self.params_.stageID)

	if type(var_1_2) == "table" then
		if var_1_2[self.params_.selectHeroPos][1] then
			var_1_0 = {}
		end

		for iter_1_2, iter_1_3 in pairs(var_1_2) do
			if iter_1_3[1] ~= 0 and HeroCfg[iter_1_3[1]] and table.keyof(HeroCfg.get_id_list_by_private[0], iter_1_3[1]) then
				table.insert(var_1_0, {
					id = iter_1_3[1],
					trialID = iter_1_3[2],
					type = HeroConst.HERO_DATA_TYPE.CUSTOM
				})
				table.insert(var_1_1, iter_1_3[2])
			end
		end
	end

	self.filterView_:SetHeroDataList(var_1_0)

	self.selectID_, self.selectTrialID_ = self:GetDefaultHeroData()

	self:SelectHero(self.selectID_, self.selectTrialID_)
	self.heroHeadList_:StartScroll(#self.heroDataList_, table.keyof(self.heroDataList_, self.selectID_))
end

return ActivityRaceHeroTeamInfoView
