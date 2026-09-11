local GuildActivityTeamInfoView = class("GuildActivityTeamInfoView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function GuildActivityTeamInfoView:InitUI()
	GuildActivityTeamInfoView.super.InitUI(self)

	self.energyItem_ = GuildActivityTeamInfoEnergyItemView.New((Object.Instantiate(Asset.Load("UI/GuildActivityUI/items/energy"), self.extensionContainer_)))
end

function GuildActivityTeamInfoView:HeadRenderer(arg_2_1, arg_2_2)
	GuildActivityTeamInfoView.super.HeadRenderer(self, arg_2_1, arg_2_2)

	local var_2_0 = self.heroDataList_[arg_2_1].id
	local var_2_1 = self.heroDataList_[arg_2_1].trialID
	local var_2_2, var_2_3, var_2_4 = self:IsInTeam(self.heroDataList_[arg_2_1].id, self.heroDataList_[arg_2_1].trialID)

	arg_2_2:SetInTeamFlag(var_2_2, var_2_3)
	arg_2_2:SetEnergy(true, GuildActivityData:GetHeroFatigue(var_2_0))
	arg_2_2:SetHeroLock(table.keyof(self.lockHeroList_, var_2_0) ~= nil or table.keyof(self.lockHeroList_, var_2_1) ~= nil)
end

function GuildActivityTeamInfoView:RefreshInfoBtn()
	SetActive(self.infoBtn_.gameObject, false)
end

function GuildActivityTeamInfoView:GetFilterClass()
	return GuildActivityFilterView
end

function GuildActivityTeamInfoView:GetHeroList()
	local var_5_0 = {}
	local var_5_1 = HeroData:GetHeroList()

	for iter_5_0, iter_5_1 in ipairs(GuildActivityData:GetFightHeroList()) do
		if var_5_1[iter_5_1.id] then
			var_5_0[iter_5_1.id] = var_5_1[iter_5_1.id]
		end
	end

	return (HeroTools.Sort(var_5_0))
end

function GuildActivityTeamInfoView:UpdateHeroView()
	GuildActivityTeamInfoView.super.UpdateHeroView(self)
	self.energyItem_:SetCurrent(true)
	self.energyItem_:SetData(GameSetting.activity_club_hero_fatigue_max.value[1], GuildActivityData:GetHeroFatigue(self.selectID_))
end

function GuildActivityTeamInfoView:Dispose()
	if self.energyItem_ then
		self.energyItem_:Dispose()

		self.energyItem_ = nil
	end

	GuildActivityTeamInfoView.super.Dispose(self)
end

function GuildActivityTeamInfoView:GetHeroTeam()
	self.heroTeam_, self.lockStateList_, self.lockHeroList_, self.heroTrialList_ = GetLocalHeroTeam(self.params_.stageType, self.params_.stageID, self.params_.activityID)

	for iter_8_0, iter_8_1 in ipairs(self.heroTeam_) do
		local var_8_0 = false

		for iter_8_2, iter_8_3 in ipairs(GuildActivityData:GetFightHeroList()) do
			if iter_8_3.id == iter_8_1 then
				var_8_0 = true

				break
			end
		end

		if not var_8_0 then
			self.heroTeam_[iter_8_0] = 0
		end
	end

	for iter_8_4 = 1, 2 do
		for iter_8_5 = iter_8_4 + 1, 3 do
			if self.heroTeam_[iter_8_4] == 0 then
				self.heroTeam_[iter_8_4], self.heroTeam_[iter_8_5] = self.heroTeam_[iter_8_5], self.heroTeam_[iter_8_4]
			end
		end
	end
end

return GuildActivityTeamInfoView
