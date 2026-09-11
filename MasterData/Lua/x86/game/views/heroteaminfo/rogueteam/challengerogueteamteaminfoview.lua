local ChallengeRogueTeamTeamInfoView = class("ChallengeRogueTeamTeamInfoView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function ChallengeRogueTeamTeamInfoView:UIName()
	return "Widget/System/Formation/FormationChallengeRogueTeamHeroUI"
end

function ChallengeRogueTeamTeamInfoView:RefreshUI()
	self.super.RefreshUI(self)

	if self.multiModeActiveController_ then
		self.multiModeActiveController_:SetSelectedState(self.canUseMultiMode_ and not ChallengeRogueTeamTools.IsDemonBattle() and "on" or "off")
	end
end

function ChallengeRogueTeamTeamInfoView:GetHeroList()
	local var_3_0 = {}
	local var_3_1 = ChallengeRogueTeamData:GetHeroList()

	if ChallengeRogueTeamTools.IsDemonBattle() then
		local var_3_2, var_3_3 = ChallengeRogueTeamData:UIGetSelectEventOption()
		local var_3_4 = RogueTeamRoomCfg[ChallengeRogueTeamData:GetOptionData(var_3_3).jumpRoomID]

		if var_3_4.room_type == ChallengeRogueTeamConst.NODE_TYPE.BATTLE_DEMON then
			for iter_3_0, iter_3_1 in ipairs(var_3_4.params) do
				if var_3_1[iter_3_1[1]] then
					var_3_0[iter_3_1[1]] = HeroData:GetHeroData(iter_3_1[1])
				end
			end

			var_3_0 = HeroTools.Sort(var_3_0, true)
		end
	elseif table.length(var_3_1) > 0 or table.length((ChallengeRogueTeamData:GetUnlockTrailHeroList())) > 0 or ChallengeRogueTeamData:HeroGetLockState() then
		var_3_0 = HeroTools.Sort(var_3_1)
	else
		for iter_3_2, iter_3_3 in pairs(HeroData:GetHeroList()) do
			if not var_3_1[iter_3_3.id] then
				var_3_0[iter_3_3.id] = iter_3_3
			end
		end

		var_3_0 = HeroTools.Sort(var_3_0)
	end

	return var_3_0
end

function ChallengeRogueTeamTeamInfoView:CheckTrailListContain(arg_4_1, arg_4_2)
	local var_4_0 = 0

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		if iter_4_1.id == arg_4_2 then
			var_4_0 = iter_4_0

			return true, iter_4_0
		end
	end

	return false, var_4_0
end

function ChallengeRogueTeamTeamInfoView:HeadRenderer(arg_5_1, arg_5_2)
	local var_5_0 = self.heroDataList_[arg_5_1].id
	local var_5_1 = self.heroDataList_[arg_5_1].trialID

	arg_5_2:SetSectionHeroData(self.heroDataList_[arg_5_1])
	arg_5_2:SetSelected(arg_5_2.heroId_ == self.selectHeroData_.id and arg_5_2.trialID_ == self.selectHeroData_.trialID)
	arg_5_2:RegisterClickListener(function()
		if self.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE then
			self:SingleModeSelectHero(self.heroDataList_[arg_5_1])
		else
			self:MultiModeChangeTeam(self.heroDataList_[arg_5_1])
		end
	end)
	arg_5_2:SetInTeamFlag(self:IsInTeam(var_5_0, var_5_1))
	arg_5_2:SetHeroLock(table.keyof(self.lockHeroList_, var_5_0) ~= nil or table.keyof(self.lockHeroList_, var_5_1) ~= nil)
	arg_5_2:SetHp(math.ceil(ChallengeRogueTeamData:GetHeroData(var_5_0, nil, true).hpPercent / 100))
	arg_5_2:RefreshHpValue(math.ceil(ChallengeRogueTeamData:GetHeroData(var_5_0, nil, true).hpPercent / 100))
	arg_5_2:SetChallengeRogueTeamModify()

	if self.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE then
		arg_5_2:SetMultiPos(false)
	else
		arg_5_2:SetMultiPos(self:IsInTeam(var_5_0, var_5_1))
	end
end

function ChallengeRogueTeamTeamInfoView:GetTrialHeroList()
	local var_7_0 = {}
	local var_7_1 = ChallengeRogueTeamData:GetHeroList()
	local var_7_2 = ChallengeRogueTeamData:GetUnlockTrailHeroList()

	if ChallengeRogueTeamTools.IsDemonBattle() then
		local var_7_3, var_7_4 = ChallengeRogueTeamData:UIGetSelectEventOption()
		local var_7_5 = RogueTeamRoomCfg[ChallengeRogueTeamData:GetOptionData(var_7_4).jumpRoomID]

		if var_7_5.room_type == ChallengeRogueTeamConst.NODE_TYPE.BATTLE_DEMON then
			for iter_7_0, iter_7_1 in ipairs(var_7_5.params) do
				local var_7_6, var_7_7 = self:CheckTrailListContain(var_7_2, iter_7_1[1])

				if var_7_6 then
					table.insert(var_7_0, var_7_7)
				end
			end
		end
	elseif table.length(var_7_1) > 0 or table.length(var_7_2) > 0 or ChallengeRogueTeamData:HeroGetLockState() then
		for iter_7_2, iter_7_3 in pairs(var_7_2) do
			table.insert(var_7_0, iter_7_2)
		end
	else
		for iter_7_4, iter_7_5 in pairs(ChallengeRogueTeamData:GetTrialHeroList()) do
			if not var_7_1[iter_7_5] then
				table.insert(var_7_0, iter_7_5)
			end
		end
	end

	return var_7_0
end

function ChallengeRogueTeamTeamInfoView:ProcessProxyParams()
	self.heroDataType_ = HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM
	self.params_.sectionProxy = self.params_.sectionProxy or SectionSelectHeroTools.GetProxy(self.params_, self.reserveParams_, self.heroDataType_)
	self.sectionProxy_ = self.params_.sectionProxy
	self.heroViewProxy_ = self.sectionProxy_:GetHeroViewProxy()
	self.heroViewProxyDic_ = {}
	self.heroViewProxyDic_[self.heroDataType_] = self.heroViewProxy_
end

function ChallengeRogueTeamTeamInfoView:ChangeTeam(arg_9_1, arg_9_2)
	ChallengeRogueTeamTeamInfoView.super.ChangeTeam(self, arg_9_1, arg_9_2)
end

function ChallengeRogueTeamTeamInfoView:OnChangeTeamSuccess()
	self:Back(1, {
		isSorted = true
	})
end

function ChallengeRogueTeamTeamInfoView:OnInfoBtnClick(arg_11_1, arg_11_2)
	local var_11_0 = {
		isEnter = true
	}

	if not arg_11_1 then
		::label_11_0::

		local var_11_1

		if self.selectHeroData_.trialID ~= 0 then
			var_11_1 = self.selectHeroData_.trialID or self.selectHeroData_.id
		end
	end

	var_11_0.hid = var_11_1

	if not arg_11_2 then
		::label_11_1::

		local var_11_2

		if self.selectHeroData_.trialID ~= 0 then
			var_11_2 = HeroConst.HERO_DATA_TYPE.TRIAL or self.heroDataType_
		end
	end

	var_11_0.type = var_11_2
	var_11_0.heroViewProxy = self.selectHeroData_.heroViewProxy
	var_11_0.tempHeroList = self:GetValidTrailList()

	self:Go("/newHero", var_11_0)
end

function ChallengeRogueTeamTeamInfoView:OnExit()
	ChallengeRogueTeamTeamInfoView.super.OnExit(self)
end

function ChallengeRogueTeamTeamInfoView:GetHeroViewProxy(arg_13_1)
	self.heroViewProxyDic_[arg_13_1] = self.heroViewProxyDic_[arg_13_1] or HeroViewDataProxy.New(arg_13_1)

	if arg_13_1 == HeroConst.HERO_DATA_TYPE.TRIAL then
		self.heroViewProxyDic_[arg_13_1].isChallengeRogue = true
	end

	return self.heroViewProxyDic_[arg_13_1]
end

function ChallengeRogueTeamTeamInfoView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ROGUE_TEAM_HERO_DESC")
end

function ChallengeRogueTeamTeamInfoView:GetHeroInfoViewClass()
	return ChallengeRogueTeamSectionHeroInfoView
end

return ChallengeRogueTeamTeamInfoView
