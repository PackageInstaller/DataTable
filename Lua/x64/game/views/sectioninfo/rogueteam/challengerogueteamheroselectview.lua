local var_0_0 = require("game.views.common.Filter.CommonHeroSkillAttributeFilter")
local var_0_1 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_2 = class("ChallengeRogueTeamHeroSelectView", var_0_1)

function var_0_2.UIName(arg_1_0)
	return "Widget/System/Formation/FormationChallengeRogueTeamHeroUIVariant"
end

function var_0_2.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.tabItemList_ = {}
	arg_2_0.heroList_ = LuaList.New(handler(arg_2_0, arg_2_0.HeadRenderer), arg_2_0.heroUIListGo_, ChallengeRogueTeamHeroItem)

	arg_2_0:InitSubView()
	arg_2_0:InitController()
	arg_2_0:AddUIListener()

	arg_2_0.btnController_ = arg_2_0.controller_:GetController("btn")
	arg_2_0.emptyController_ = arg_2_0.panelController_:GetController("empty")

	arg_2_0:InitTapView()
end

function var_0_2.OnEnter(arg_3_0)
	if arg_3_0.params_.isBack and arg_3_0.stopCountimeFlag_ then
		ChallengeRogueTeamAction.OnPlayingState(ChallengeRogueTeamConst.PLAYING_STATE.ENTER, function()
			arg_3_0.stopCountimeFlag_ = false
		end)
	end

	if arg_3_0.params_.isEnter then
		arg_3_0.recruitedList_ = {}
		arg_3_0.selectHeroData_ = {
			id = 0,
			trialID = 0
		}
		arg_3_0.enterScrollPosition_ = nil

		arg_3_0:ResetTap()
	else
		arg_3_0.selectHeroData_ = arg_3_0.params_.curSelectHeroData
	end

	arg_3_0.cacheBattlePower_ = {}
	arg_3_0.recruitNumLimit_ = math.max(ChallengeRogueTeamData:AttributeGetValue(8), 1)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.heroList_:GetItemList()) do
		iter_3_1:SetRecruited(false)
	end

	arg_3_0.recruitedNumText_.text = string.format(GetTips("CHALLENGE_ROGUE_RECRUITED_NUM"), arg_3_0.recruitNumLimit_)

	arg_3_0:ProcessParams()
	arg_3_0:SubViewOnEnter()
	arg_3_0:GetHeroTeam()
	arg_3_0:RefreshHeroDataList()
	arg_3_0:RefreshSelectTab()

	if not arg_3_0.params_.isEnter then
		arg_3_0:SelectHero(arg_3_0.selectHeroData_)
	else
		arg_3_0:RefreshHeroList()
	end

	if arg_3_0.enterScrollPosition_ then
		arg_3_0.heroList_:StartScrollByPosition(#arg_3_0.heroDataList_, arg_3_0.enterScrollPosition_)
	else
		arg_3_0.heroList_:StartScroll(#arg_3_0.heroDataList_, 1)
	end

	manager.rogueTeamInGameInfoBox:ShowBox()

	arg_3_0.params_.isBack = false
end

function var_0_2.ProcessProxyParams(arg_5_0)
	arg_5_0.heroDataType_ = HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM

	if not arg_5_0.params_.sectionProxy then
		arg_5_0.params_.sectionProxy = SectionSelectHeroTools.GetProxy(arg_5_0.params_, arg_5_0.reserveParams_, arg_5_0.heroDataType_)
	end

	arg_5_0.sectionProxy_ = arg_5_0.params_.sectionProxy
	arg_5_0.heroViewProxy_ = arg_5_0.sectionProxy_:GetHeroViewProxy()
	arg_5_0.heroViewProxyDic_ = {}
	arg_5_0.heroViewProxyDic_[arg_5_0.heroDataType_] = arg_5_0.heroViewProxy_
end

function var_0_2.RefreshSelectTab(arg_6_0)
	arg_6_0.tapView_:Refresh()
end

function var_0_2.HeadRenderer(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.heroDataList_[arg_7_1].id
	local var_7_1 = arg_7_0.heroDataList_[arg_7_1].trialID

	arg_7_2:SetSectionHeroData(arg_7_1, arg_7_0.heroDataList_[arg_7_1])
	arg_7_2:SetSelected(arg_7_2.heroId_ == arg_7_0.selectHeroData_.id and arg_7_2.trialID_ == arg_7_0.selectHeroData_.trialID)

	if arg_7_2.trialID_ ~= 0 then
		arg_7_2:SetRecruited(table.indexof(arg_7_0.recruitedList_, arg_7_2.trialID_))
	else
		arg_7_2:SetRecruited(table.indexof(arg_7_0.recruitedList_, arg_7_2.heroId_))
	end

	arg_7_2:RegisterClickListener(function(arg_8_0)
		if arg_7_0.recruitNumLimit_ > 1 then
			if #arg_7_0.recruitedList_ >= arg_7_0.recruitNumLimit_ and not table.indexof(arg_7_0.recruitedList_, arg_7_0.heroDataList_[arg_8_0].id) and not table.indexof(arg_7_0.recruitedList_, arg_7_0.heroDataList_[arg_8_0].trialID) then
				ShowTips("CHALLENGE_ROGUE_TEAM_RECRUIT_LIMIT")

				return
			end
		elseif not table.isEmpty(arg_7_0.recruitedList_) then
			arg_7_0:AddHeroToRecruitList(arg_7_0.selectHeroData_)
		end

		arg_7_0:AddHeroToRecruitList(arg_7_0.heroDataList_[arg_8_0])
		arg_7_0:SelectHero(arg_7_0.heroDataList_[arg_8_0])

		arg_7_0.selectHeroData_ = arg_7_0.heroDataList_[arg_8_0]

		for iter_8_0, iter_8_1 in pairs(arg_7_0.heroList_:GetItemList()) do
			if arg_7_0.selectHeroData_.trialID ~= 0 then
				if iter_8_1.trialID_ == arg_7_0.selectHeroData_.trialID then
					arg_7_0.selectItem_ = iter_8_1
				end
			elseif iter_8_1.heroId_ == arg_7_0.selectHeroData_.id then
				arg_7_0.selectItem_ = iter_8_1
			end

			if iter_8_1.trialID_ ~= 0 then
				iter_8_1:SetRecruited(table.indexof(arg_7_0.recruitedList_, iter_8_1.trialID_))
			else
				iter_8_1:SetRecruited(table.indexof(arg_7_0.recruitedList_, iter_8_1.heroId_))
			end
		end

		arg_7_0.emptyController_:SetSelectedState(tostring(arg_7_0.selectHeroData_.id == 0))
	end)
	arg_7_2:RegisterLookListener(function(arg_9_0, arg_9_1)
		arg_7_0:OnInfoBtnClick(arg_9_0, arg_9_1)
	end)
end

function var_0_2.RefreshHeroList(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.heroList_:GetItemList()) do
		iter_10_1:SetSelected("false")
	end

	arg_10_0.emptyController_:SetSelectedState("true")
end

function var_0_2.AddHeroToRecruitList(arg_11_0, arg_11_1)
	local var_11_0

	if arg_11_1.type == HeroConst.HERO_DATA_TYPE.TRIAL then
		var_11_0 = table.indexof(arg_11_0.recruitedList_, arg_11_1.trialID)
	else
		var_11_0 = table.indexof(arg_11_0.recruitedList_, arg_11_1.id)
	end

	if not var_11_0 and #arg_11_0.recruitedList_ < arg_11_0.recruitNumLimit_ then
		local var_11_1 = false

		for iter_11_0, iter_11_1 in ipairs(arg_11_0.recruitedList_) do
			local var_11_2 = HeroCfg[iter_11_1]
			local var_11_3

			if not var_11_2 then
				var_11_3 = HeroStandardSystemCfg[iter_11_1].hero_id
			else
				var_11_3 = iter_11_1
			end

			if var_11_3 == arg_11_1.id then
				var_11_1 = iter_11_0

				break
			end
		end

		if var_11_1 then
			table.remove(arg_11_0.recruitedList_, var_11_1)
		end

		table.insert(arg_11_0.recruitedList_, arg_11_1.trialID ~= 0 and arg_11_1.trialID or arg_11_1.id)
	elseif var_11_0 then
		table.remove(arg_11_0.recruitedList_, var_11_0)
	end

	if #arg_11_0.recruitedList_ > 0 then
		arg_11_0.btnController_:SetSelectedState("01")
	else
		arg_11_0.btnController_:SetSelectedState("0")
	end
end

function var_0_2.SelectHero(arg_12_0, arg_12_1)
	arg_12_0.selectHeroData_ = arg_12_1

	for iter_12_0, iter_12_1 in pairs(arg_12_0.heroList_:GetItemList()) do
		if arg_12_0.selectHeroData_.trialID ~= 0 then
			iter_12_1:SetSelected(iter_12_1.trialID_ == arg_12_0.selectHeroData_.trialID)
		else
			iter_12_1:SetSelected(iter_12_1.trialID_ == 0 and iter_12_1.heroId_ == arg_12_0.selectHeroData_.id)
		end
	end

	arg_12_0:RefreshInfoBtn()
	arg_12_0:UpdateHeroView()
	arg_12_0:RefreshJoinBtn()
end

function var_0_2.UpdateHeroView(arg_13_0)
	if arg_13_0.selectHeroData_ and arg_13_0.selectHeroData_.id ~= 0 and arg_13_0.selectHeroData_.heroViewProxy then
		local var_13_0 = arg_13_0.selectHeroData_.id
		local var_13_1 = arg_13_0.selectHeroData_.heroViewProxy:GetHeroData(var_13_0, {
			arg_13_0.selectHeroData_.trialID
		})
		local var_13_2 = arg_13_0.selectHeroData_.heroViewProxy:GetHeroUsingSkinInfo(var_13_0, {
			arg_13_0.selectHeroData_.trialID
		}).id

		arg_13_0.heroInfoView_:SetProxy(arg_13_0.selectHeroData_.heroViewProxy)
		arg_13_0.heroInfoView_:SetHeroInfo(var_13_1)
		arg_13_0.heroInfoView_:UpdateView()
	end

	arg_13_0.emptyController_:SetSelectedState(tostring(not arg_13_0.selectHeroData_ or arg_13_0.selectHeroData_.id == 0 or not arg_13_0.selectHeroData_.heroViewProxy))
end

function var_0_2.InitSubView(arg_14_0)
	arg_14_0.filterView_ = arg_14_0:GetFilterClass().New(arg_14_0.filterGo_)

	arg_14_0.filterView_:SetExtraSorter(handler(arg_14_0, arg_14_0.ExtraSorter))

	arg_14_0.autoClearFilter_ = true
	arg_14_0.heroInfoView_ = ChallengeRogueTeamSectionHeroInfoView.New(arg_14_0, arg_14_0.heroInfoGo_)
end

function var_0_2.GetHeroList(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = ChallengeRogueTeamData:GetHeroList()
	local var_15_2 = ChallengeRogueTeamData:GetUnlockTrailHeroList()

	for iter_15_0, iter_15_1 in pairs(HeroData:GetHeroList()) do
		local var_15_3 = 0

		for iter_15_2, iter_15_3 in pairs(ChallengeRogueTeamData:GetTrialHeroList()) do
			if HeroStandardSystemCfg[iter_15_3].hero_id == iter_15_1.id then
				var_15_3 = iter_15_3
			end
		end

		if not var_15_1[iter_15_1.id] and not var_15_2[var_15_3] then
			var_15_0[iter_15_1.id] = iter_15_1
		end
	end

	return (HeroTools.Sort(var_15_0))
end

function var_0_2.GetTrialHeroList(arg_16_0)
	local var_16_0 = {}
	local var_16_1 = ChallengeRogueTeamData:GetUnlockTrailHeroList()
	local var_16_2 = ChallengeRogueTeamData:GetHeroList()

	for iter_16_0, iter_16_1 in pairs(ChallengeRogueTeamData:GetTrialHeroList()) do
		if not var_16_1[iter_16_1] and not var_16_2[HeroStandardSystemCfg[iter_16_1].hero_id] then
			table.insert(var_16_0, iter_16_1)
		end
	end

	return var_16_0
end

function var_0_2.RefreshHeroDataList(arg_17_0)
	local var_17_0 = {}

	if not arg_17_0.params_.isBack then
		arg_17_0.allTrialIDList_ = {}
		arg_17_0.customHeroList_, arg_17_0.canSwitchResctrictHeroList_ = SectionSelectHeroTools.GetRestrictHeroList(arg_17_0.params_.stageType, arg_17_0.params_.stageID)
		arg_17_0.curCanSwitchRestrictHero_ = arg_17_0.canSwitchResctrictHeroList_[arg_17_0.params_.selectHeroPos] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID

		local var_17_1
		local var_17_2
		local var_17_3, var_17_4 = SectionSelectHeroTools.GetRestrictHeroPosDic(arg_17_0.params_.stageType, arg_17_0.params_.stageID)

		if arg_17_0.customHeroList_[arg_17_0.params_.selectHeroPos][1] then
			arg_17_0:ProcessCustomHeroData(var_17_0, var_17_4)
		else
			arg_17_0:ProcessOwnHeroData(var_17_0, var_17_3)
			arg_17_0:ProcessTrialHeroData(var_17_0, var_17_4)
		end

		for iter_17_0, iter_17_1 in pairs(arg_17_0.heroViewProxyDic_) do
			iter_17_1:SetTempHeroList(arg_17_0.allTrialIDList_)
		end

		arg_17_0.allHeroDataList_ = var_17_0
		arg_17_0.heroDataList_ = arg_17_0:FilterHeroDataList(arg_17_0.allHeroDataList_)
	else
		arg_17_0.heroDataList_ = arg_17_0.sortedHeroList_
	end
end

function var_0_2.FilterHeroDataList(arg_18_0, arg_18_1)
	local var_18_0 = {}

	if arg_18_0.isAll_ then
		var_18_0 = arg_18_1
	else
		for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
			local var_18_1 = HeroCfg[iter_18_1.id]
			local var_18_2 = false

			if iter_18_1.type == HeroConst.HERO_DATA_TYPE.TRIAL then
				if table.indexof(arg_18_0.recruitedList_, iter_18_1.trialID) then
					var_18_2 = true
				end
			elseif table.indexof(arg_18_0.recruitedList_, iter_18_1.id) then
				var_18_2 = true
			end

			if var_18_1.ATK_attribute[1] == arg_18_0.selectTapID_ or var_18_2 then
				table.insert(var_18_0, iter_18_1)
			end
		end
	end

	arg_18_0:SortHeroList(var_18_0)

	arg_18_0.sortedHeroList_ = deepClone(var_18_0)

	return var_18_0
end

function var_0_2.SortHeroList(arg_19_0, arg_19_1)
	table.sort(arg_19_1, function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0.type == HeroConst.HERO_DATA_TYPE.TRIAL
		local var_20_1 = arg_20_1.type == HeroConst.HERO_DATA_TYPE.TRIAL
		local var_20_2
		local var_20_3

		if var_20_0 then
			var_20_2 = table.indexof(arg_19_0.recruitedList_, arg_20_0.trialID) or 999
		else
			var_20_2 = table.indexof(arg_19_0.recruitedList_, arg_20_0.id) or 999
		end

		if var_20_1 then
			var_20_3 = table.indexof(arg_19_0.recruitedList_, arg_20_1.trialID) or 999
		else
			var_20_3 = table.indexof(arg_19_0.recruitedList_, arg_20_1.id) or 999
		end

		if var_20_2 ~= var_20_3 then
			return var_20_2 < var_20_3
		end

		if var_20_0 ~= var_20_1 and (not var_20_0 or not var_20_1) then
			return var_20_0 ~= false
		end

		local var_20_4
		local var_20_5

		if var_20_0 then
			var_20_4 = arg_19_0.cacheBattlePower_[arg_20_0.trialID] or TempHeroData:GetBattlePower(arg_20_0.trialID)
			arg_19_0.cacheBattlePower_[arg_20_0.trialID] = var_20_4
		else
			var_20_4 = arg_19_0.cacheBattlePower_[arg_20_0.id] or arg_20_0.heroViewProxy:GetBattlePower(arg_20_0.id)
			arg_19_0.cacheBattlePower_[arg_20_0.id] = var_20_4
		end

		if var_20_1 then
			var_20_5 = arg_19_0.cacheBattlePower_[arg_20_1.trialID] or TempHeroData:GetBattlePower(arg_20_1.trialID)
			arg_19_0.cacheBattlePower_[arg_20_1.trialID] = var_20_5
		else
			var_20_5 = arg_19_0.cacheBattlePower_[arg_20_1.id] or arg_20_1.heroViewProxy:GetBattlePower(arg_20_1.id)
			arg_19_0.cacheBattlePower_[arg_20_1.id] = var_20_5
		end

		if var_20_4 ~= var_20_5 then
			return var_20_5 < var_20_4
		end

		if arg_20_0.star ~= arg_20_0.star then
			return arg_20_0.star > arg_20_1.star
		end

		local var_20_6 = HeroCfg[arg_20_0.id]
		local var_20_7 = HeroCfg[arg_20_1.id]

		if var_20_6.rare ~= var_20_7.rare then
			return var_20_6.rare > var_20_7.rare
		end

		if arg_20_0.exp ~= arg_20_1.exp then
			return arg_20_0.exp > arg_20_1.ext
		end

		return arg_20_0.id < arg_20_1.id
	end)
end

function var_0_2.OnInfoBtnClick(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.stopCountimeFlag_ = true

	ChallengeRogueTeamAction.OnPlayingState(ChallengeRogueTeamConst.PLAYING_STATE.EXIT, function()
		return
	end)
	ChallengeRogueTeamData:HeroSetLockState(false)
	arg_21_0:Go("/newHero", {
		isEnter = true,
		hid = arg_21_1.tempID ~= 0 and arg_21_1.tempID or arg_21_1.id,
		type = arg_21_2 or arg_21_1.tempID ~= 0 and HeroConst.HERO_DATA_TYPE.TRIAL,
		tempHeroList = arg_21_0:GetValidTrailList(arg_21_1.tempID)
	})

	arg_21_0.enterScrollPosition_ = arg_21_0.heroList_:GetScrolledPosition()
end

function var_0_2.GetValidTrailList(arg_23_0, arg_23_1)
	local var_23_0 = {}

	if arg_23_1 ~= 0 then
		for iter_23_0, iter_23_1 in pairs(arg_23_0.allTrialIDList_) do
			local var_23_1 = HeroStandardSystemCfg[iter_23_1]

			if not HeroTools.IsNPC(var_23_1.hero_id) and not HeroTools.NeedHideInfo(var_23_1.hero_id) then
				table.insert(var_23_0, iter_23_1)
			end
		end
	end

	return var_23_0
end

function var_0_2.OnJoinClick(arg_24_0)
	if #arg_24_0.recruitedList_ < arg_24_0.recruitNumLimit_ then
		ShowMessageBox({
			isTop = true,
			content = GetTips("ROGUE_TEAM_FORGIVE_RECRUIT"),
			OkCallback = function()
				arg_24_0:RecruitHero()
			end,
			CancelCallback = function()
				return
			end
		})
	else
		arg_24_0:RecruitHero()
	end

	ChallengeRogueTeamData:HeroSetLockState(true)
end

function var_0_2.RecruitHero(arg_27_0)
	local var_27_0 = {}
	local var_27_1 = {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.recruitedList_) do
		local var_27_2 = HeroStandardSystemCfg[iter_27_1]

		if var_27_2 then
			table.insert(var_27_0, var_27_2.hero_id)
			table.insert(var_27_1, iter_27_1)
		else
			table.insert(var_27_0, iter_27_1)
			table.insert(var_27_1, 0)
		end
	end

	ChallengeRogueTeamAction.HeroRecruit(var_27_0, var_27_1, function()
		ChallengeRogueTeamData:ClearUnOperateData()
		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		arg_27_0:Back()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
	end)
end

function var_0_2.OnExit(arg_29_0)
	var_0_2.super.OnExit(arg_29_0)

	arg_29_0.params_.isEnter = false
	arg_29_0.cacheBattlePower_ = {}

	manager.rogueTeamInGameInfoBox:HideBox()
	manager.rogueTeamMapPreviewBtnBar:HideBar()
end

function var_0_2.Dispose(arg_30_0)
	arg_30_0.tapView_:Dispose()

	arg_30_0.stopCountimeFlag_ = false

	var_0_2.super.Dispose(arg_30_0)

	if arg_30_0.tabItemList_ then
		for iter_30_0, iter_30_1 in ipairs(arg_30_0.tabItemList_) do
			iter_30_1:Dispose()
		end

		arg_30_0.tabItemList_ = nil
	end

	if arg_30_0.heroList_ then
		arg_30_0.heroList_:Dispose()

		arg_30_0.heroList_ = nil
	end
end

function var_0_2.OnTop(arg_31_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ROGUE_TEAM_HERO_DESC")
	manager.rogueTeamMapPreviewBtnBar:ShowBar()
	manager.rogueTeamMapPreviewBtnBar:ShowState(ChallengeRogueTeamConst.MAP_BTN_WINDOW.OTHER)
	ChallengeRogueTeamTools.RegistWindowBarClick()
end

function var_0_2.InitTapView(arg_32_0)
	arg_32_0.tapTypeList_ = {
		HeroConst.HERO_ATTACK_TYPE.ALL,
		HeroConst.HERO_ATTACK_TYPE.PYISICS,
		HeroConst.HERO_ATTACK_TYPE.WIND,
		HeroConst.HERO_ATTACK_TYPE.FLAME,
		HeroConst.HERO_ATTACK_TYPE.THUNDER,
		HeroConst.HERO_ATTACK_TYPE.DARK,
		HeroConst.HERO_ATTACK_TYPE.LIGHT,
		HeroConst.HERO_ATTACK_TYPE.FREEZE,
		HeroConst.HERO_ATTACK_TYPE.WATER,
		HeroConst.HERO_ATTACK_TYPE.RANDOM
	}
	arg_32_0.tapView_ = var_0_0.New(arg_32_0.tapGo_)

	arg_32_0.tapView_:SetAttributeIdList(arg_32_0.tapTypeList_)
	arg_32_0.tapView_:SetSelectAttributeCallback(handler(arg_32_0, arg_32_0.OnSelectTap))
end

function var_0_2.ResetTap(arg_33_0)
	arg_33_0.selectTapID_ = 1

	arg_33_0.tapView_:Reset()
end

function var_0_2.OnSelectTap(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0.selectTapID_ = arg_34_1
	arg_34_0.isAll_ = arg_34_2
	arg_34_0.heroDataList_ = arg_34_0:FilterHeroDataList(arg_34_0.allHeroDataList_)

	arg_34_0.heroList_:StartScroll(#arg_34_0.heroDataList_)
end

return var_0_2
