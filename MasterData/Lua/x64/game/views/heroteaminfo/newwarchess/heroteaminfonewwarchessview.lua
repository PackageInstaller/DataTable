local HeroTeamInfoNewWarChessView = class("HeroTeamInfoNewWarChessView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function HeroTeamInfoNewWarChessView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function HeroTeamInfoNewWarChessView:RefreshHeroDataList()
	local var_2_0 = {}
	local var_2_1 = {}

	self.trialHeroList_ = NewWarChessData:GetHeroIDList()

	for iter_2_0, iter_2_1 in pairs(self.trialHeroList_) do
		table.insert(var_2_0, {
			id = HeroStandardSystemCfg[iter_2_1].hero_id,
			trialID = iter_2_1,
			type = HeroConst.HERO_DATA_TYPE.TRIAL,
			heroViewProxy = self:GetHeroViewProxy(HeroConst.HERO_DATA_TYPE.TRIAL)
		})
		table.insert(var_2_1, iter_2_1)
	end

	for iter_2_2, iter_2_3 in pairs(self.heroViewProxyDic_) do
		iter_2_3:SetTempHeroList(var_2_1)
	end

	self.filterView_:SetHeroIdList(var_2_0)
end

function HeroTeamInfoNewWarChessView:GetDefaultHeroData()
	local var_3_0 = SectionSelectHeroTools.GetCurSelectHeroData()

	if var_3_0 and var_3_0.id ~= 0 then
		return var_3_0
	end

	local var_3_1 = self.heroTeam_[self.params_.selectHeroPos] or 0

	if var_3_1 == 0 then
		for iter_3_0, iter_3_1 in ipairs(self.heroDataList_) do
			if not self:IsInTeam(iter_3_1.id, iter_3_1.trialID) and NewWarChessData:GetHeroHp(iter_3_1.id) > 0 then
				return iter_3_1
			end
		end
	end

	if var_3_1 == 0 then
		for iter_3_2, iter_3_3 in pairs(self.heroDataList_) do
			if NewWarChessData:GetHeroHp(iter_3_3.id) > 0 then
				return iter_3_3
			end
		end
	end

	return {
		trialID = 0,
		id = var_3_1,
		type = HeroConst.HERO_DATA_TYPE.DEFAULT,
		heroViewProxy = self:GetHeroViewProxy(HeroConst.HERO_DATA_TYPE.DEFAULT)
	}
end

function HeroTeamInfoNewWarChessView:HeadRenderer(arg_4_1, arg_4_2)
	local var_4_0 = self.heroDataList_[arg_4_1].id
	local var_4_1 = self.heroDataList_[arg_4_1].trialID

	arg_4_2:SetSectionHeroData(self.heroDataList_[arg_4_1], self.trialHeroList_)
	arg_4_2:SetSelected(arg_4_2.heroId_ == self.selectHeroData_.id and arg_4_2.trialID_ == self.selectHeroData_.trialID)
	arg_4_2:RegisterClickListener(function()
		if self.backFlag_ then
			return
		end

		if NewWarChessData:GetHeroHp(arg_4_2.heroId_) <= 0 then
			ShowTips("ACTIVITY_NEW_WARCHESS_HERO_DIE")

			return
		end

		self:SelectHero(self.heroDataList_[arg_4_1])
	end)
	arg_4_2:SetInTeamFlag(self:IsInTeam(var_4_0, var_4_1))

	local var_4_2, var_4_3 = self.sectionProxy_:CustomGetHeroHP(nil, arg_4_2.heroId_)

	arg_4_2:RefreshHpValue(var_4_3)
	arg_4_2:SetHp(true)

	if var_4_2 <= 0 then
		arg_4_2:SetLocking(true)
	else
		arg_4_2:SetLocking(false)
	end
end

return HeroTeamInfoNewWarChessView
