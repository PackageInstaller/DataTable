local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("ChallengeRogueTeamTeamInfoView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Formation/FormationChallengeRogueTeamHeroUI"
end

function var_0_1.RefreshUI(arg_2_0)
	arg_2_0.super.RefreshUI(arg_2_0)

	local var_2_0 = ChallengeRogueTeamTools.IsDemonBattle()

	if arg_2_0.multiModeActiveController_ then
		arg_2_0.multiModeActiveController_:SetSelectedState(arg_2_0.canUseMultiMode_ and not var_2_0 and "on" or "off")
	end
end

function var_0_1.GetHeroList(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = ChallengeRogueTeamData:GetHeroList()
	local var_3_2 = ChallengeRogueTeamData:GetUnlockTrailHeroList()

	if ChallengeRogueTeamTools.IsDemonBattle() then
		local var_3_3, var_3_4 = ChallengeRogueTeamData:UIGetSelectEventOption()
		local var_3_5 = ChallengeRogueTeamData:GetOptionData(var_3_4).jumpRoomID
		local var_3_6 = RogueTeamRoomCfg[var_3_5]

		if var_3_6.room_type == ChallengeRogueTeamConst.NODE_TYPE.BATTLE_DEMON then
			for iter_3_0, iter_3_1 in ipairs(var_3_6.params) do
				if var_3_1[iter_3_1[1]] then
					var_3_0[iter_3_1[1]] = HeroData:GetHeroData(iter_3_1[1])
				end
			end

			var_3_0 = HeroTools.Sort(var_3_0, true)
		end
	elseif table.length(var_3_1) > 0 or table.length(var_3_2) > 0 or ChallengeRogueTeamData:HeroGetLockState() then
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

function var_0_1.CheckTrailListContain(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = 0

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		if iter_4_1.id == arg_4_2 then
			var_4_0 = iter_4_0

			return true, var_4_0
		end
	end

	return false, var_4_0
end

function var_0_1.HeadRenderer(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.heroDataList_[arg_5_1].id
	local var_5_1 = arg_5_0.heroDataList_[arg_5_1].trialID

	arg_5_2:SetSectionHeroData(arg_5_0.heroDataList_[arg_5_1])
	arg_5_2:SetSelected(arg_5_2.heroId_ == arg_5_0.selectHeroData_.id and arg_5_2.trialID_ == arg_5_0.selectHeroData_.trialID)
	arg_5_2:RegisterClickListener(function()
		if arg_5_0.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE then
			arg_5_0:SingleModeSelectHero(arg_5_0.heroDataList_[arg_5_1])
		else
			arg_5_0:MultiModeChangeTeam(arg_5_0.heroDataList_[arg_5_1])
		end
	end)
	arg_5_2:SetInTeamFlag(arg_5_0:IsInTeam(var_5_0, var_5_1))
	arg_5_2:SetHeroLock(table.keyof(arg_5_0.lockHeroList_, var_5_0) ~= nil or table.keyof(arg_5_0.lockHeroList_, var_5_1) ~= nil)
	arg_5_2:SetHp(math.ceil(ChallengeRogueTeamData:GetHeroData(var_5_0, nil, true).hpPercent / 100))
	arg_5_2:RefreshHpValue(math.ceil(ChallengeRogueTeamData:GetHeroData(var_5_0, nil, true).hpPercent / 100))
	arg_5_2:SetChallengeRogueTeamModify()

	if arg_5_0.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE then
		arg_5_2:SetMultiPos(false)
	else
		arg_5_2:SetMultiPos(arg_5_0:IsInTeam(var_5_0, var_5_1))
	end
end

function var_0_1.GetTrialHeroList(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = ChallengeRogueTeamData:GetHeroList()
	local var_7_2 = ChallengeRogueTeamData:GetUnlockTrailHeroList()

	if ChallengeRogueTeamTools.IsDemonBattle() then
		local var_7_3, var_7_4 = ChallengeRogueTeamData:UIGetSelectEventOption()
		local var_7_5 = ChallengeRogueTeamData:GetOptionData(var_7_4).jumpRoomID
		local var_7_6 = RogueTeamRoomCfg[var_7_5]

		if var_7_6.room_type == ChallengeRogueTeamConst.NODE_TYPE.BATTLE_DEMON then
			for iter_7_0, iter_7_1 in ipairs(var_7_6.params) do
				local var_7_7, var_7_8 = arg_7_0:CheckTrailListContain(var_7_2, iter_7_1[1])

				if var_7_7 then
					table.insert(var_7_0, var_7_8)
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

function var_0_1.ProcessProxyParams(arg_8_0)
	arg_8_0.heroDataType_ = HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM

	if not arg_8_0.params_.sectionProxy then
		arg_8_0.params_.sectionProxy = SectionSelectHeroTools.GetProxy(arg_8_0.params_, arg_8_0.reserveParams_, arg_8_0.heroDataType_)
	end

	arg_8_0.sectionProxy_ = arg_8_0.params_.sectionProxy
	arg_8_0.heroViewProxy_ = arg_8_0.sectionProxy_:GetHeroViewProxy()
	arg_8_0.heroViewProxyDic_ = {}
	arg_8_0.heroViewProxyDic_[arg_8_0.heroDataType_] = arg_8_0.heroViewProxy_
end

function var_0_1.ChangeTeam(arg_9_0, arg_9_1, arg_9_2)
	var_0_1.super.ChangeTeam(arg_9_0, arg_9_1, arg_9_2)
end

function var_0_1.OnChangeTeamSuccess(arg_10_0)
	arg_10_0:Back(1, {
		isSorted = true
	})
end

function var_0_1.OnInfoBtnClick(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:Go("/newHero", {
		isEnter = true,
		hid = arg_11_1 or arg_11_0.selectHeroData_.trialID ~= 0 and arg_11_0.selectHeroData_.trialID or arg_11_0.selectHeroData_.id,
		type = arg_11_2 or arg_11_0.selectHeroData_.trialID ~= 0 and HeroConst.HERO_DATA_TYPE.TRIAL or arg_11_0.heroDataType_,
		heroViewProxy = arg_11_0.selectHeroData_.heroViewProxy,
		tempHeroList = arg_11_0:GetValidTrailList()
	})
end

function var_0_1.OnExit(arg_12_0)
	var_0_1.super.OnExit(arg_12_0)
end

function var_0_1.GetHeroViewProxy(arg_13_0, arg_13_1)
	if not arg_13_0.heroViewProxyDic_[arg_13_1] then
		arg_13_0.heroViewProxyDic_[arg_13_1] = HeroViewDataProxy.New(arg_13_1)
	end

	if arg_13_1 == HeroConst.HERO_DATA_TYPE.TRIAL then
		arg_13_0.heroViewProxyDic_[arg_13_1].isChallengeRogue = true
	end

	return arg_13_0.heroViewProxyDic_[arg_13_1]
end

function var_0_1.OnTop(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ROGUE_TEAM_HERO_DESC")
end

function var_0_1.GetHeroInfoViewClass(arg_15_0)
	return ChallengeRogueTeamSectionHeroInfoView
end

return var_0_1
