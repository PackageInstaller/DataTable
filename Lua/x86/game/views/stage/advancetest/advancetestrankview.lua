local var_0_0 = class("AdvanceTestRankView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/AdvancetestingUI/AtestingRankUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.rankTypeConst_ = AdvanceTestData:GetRankTypeConst()

	arg_3_0:InitUI()

	arg_3_0.subTypeToggleController_ = arg_3_0.conExCollection_:GetController("subType")
	arg_3_0.tabController_ = arg_3_0.toggleConEx:GetController("tab")
	arg_3_0.tabNumController_ = arg_3_0.toggleConEx:GetController("num")
	arg_3_0.itemGo_ = {
		arg_3_0.m_easyBtn.gameObject,
		arg_3_0.m_nomalBtn.gameObject,
		arg_3_0.m_hardBtn.gameObject,
		arg_3_0.m_spe4Btn.gameObject,
		arg_3_0.m_spe5Btn.gameObject,
		arg_3_0.m_spe6Btn.gameObject
	}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.itemGo_) do
		local var_3_0 = ""
		local var_3_1 = {
			"TEST_CHALLENGE_SS",
			"TEST_CHALLENGE_SSS",
			"TEST_CHALLENGE_OMEGA"
		}

		if iter_3_0 <= 3 then
			var_3_0 = string.format(GetTips("TEST_CHALLENGE_TIPS_6"), GetTips(var_3_1[iter_3_0]))
		else
			var_3_0 = string.format(GetTips("TEST_CHALLENGE_TIPS_6"), GetTips("TEST_CHALLENGE_SPE"))
		end

		local var_3_2 = iter_3_1.transform:Find("select_on/Textselect")
		local var_3_3 = var_3_2 and var_3_2:GetComponent("Text")

		if var_3_3 then
			var_3_3.text = var_3_0
		end

		local var_3_4 = iter_3_1.transform:Find("upselect/Textupselect")
		local var_3_5 = var_3_4 and var_3_4:GetComponent("Text")

		if var_3_5 then
			var_3_5.text = var_3_0
		end
	end

	arg_3_0.clickIndex_ = {}
	arg_3_0.commonPortrait_ = CommonHeadPortrait.New(arg_3_0.headItem_)

	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.RefreshUIHandler_ = handler(arg_4_0, arg_4_0.Refresh)
	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, AdvanceTestRankItem)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_allBtn, nil, function()
		if AdvanceTestData:GetCurRankType() ~= arg_5_0.rankTypeConst_.ALL then
			RankAction.QueryActivityRank(arg_5_0.activityID, arg_5_0.stageType)
		end

		AdvanceTestData:SetCurRankType(arg_5_0.rankTypeConst_.ALL)
		arg_5_0:Refresh()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_guildBtn, nil, function()
		if AdvanceTestData:GetCurRankType() ~= arg_5_0.rankTypeConst_.GUILD then
			RankAction.QueryGuildActivityRank(arg_5_0.activityID, arg_5_0.stageType)
		end

		AdvanceTestData:SetCurRankType(arg_5_0.rankTypeConst_.GUILD)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("advanceTestReward", {
			activityID = arg_5_0.activityID
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_easyBtn, nil, function()
		arg_5_0:OnClickSubType(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_nomalBtn, nil, function()
		arg_5_0:OnClickSubType(2)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_hardBtn, nil, function()
		arg_5_0:OnClickSubType(3)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_spe4Btn, nil, function()
		arg_5_0:OnClickSubType(4)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_spe5Btn, nil, function()
		arg_5_0:OnClickSubType(5)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_spe6Btn, nil, function()
		arg_5_0:OnClickSubType(6)
	end)
end

function var_0_0.OnClickSubType(arg_15_0, arg_15_1)
	local var_15_0 = AdvanceTestData:GetCurRankType()
	local var_15_1 = arg_15_0.clickIndex_[arg_15_1]

	if arg_15_0.index ~= var_15_1 then
		if var_15_0 == arg_15_0.rankTypeConst_.ALL then
			RankAction.QueryActivityRank(arg_15_0.activityID, arg_15_1)
		elseif var_15_0 == arg_15_0.rankTypeConst_.GUILD then
			RankAction.QueryGuildActivityRank(arg_15_0.activityID, arg_15_1)
		end
	end

	arg_15_0.index = var_15_1
	arg_15_0.stageType = arg_15_1

	arg_15_0:Refresh()
end

function var_0_0.OnTop(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0.activityID = arg_17_0.params_.activityID

	local var_17_0 = ActivityData:GetActivityData(arg_17_0.activityID)

	arg_17_0.startTime_ = var_17_0.startTime
	arg_17_0.stopTime_ = var_17_0.stopTime

	local var_17_1 = AdvanceTestCfg.get_id_list_by_activity_id[AdvanceTestData:GetCacheActivityID()]

	for iter_17_0 = 1, #arg_17_0.itemGo_ do
		SetActive(arg_17_0.itemGo_[iter_17_0], false)
	end

	for iter_17_1 = 1, #arg_17_0.itemGo_ do
		if var_17_1[iter_17_1] then
			local var_17_2 = AdvanceTestCfg[var_17_1[iter_17_1]]

			SetActive(arg_17_0.itemGo_[var_17_2.stage_type], true)

			arg_17_0.clickIndex_[var_17_2.stage_type] = iter_17_1
		end
	end

	arg_17_0.stageType = arg_17_0.params_.stageType
	arg_17_0.index = arg_17_0.clickIndex_[arg_17_0.params_.stageType]

	manager.notify:RegistListener(ADVANCE_TEST_RANK_UPGRADE, arg_17_0.RefreshUIHandler_)
	RankAction.QueryActivityRank(arg_17_0.activityID, arg_17_0.stageType)
	arg_17_0:RefreshGuildRankGo()
	arg_17_0:AddTimer()
end

function var_0_0.OnExit(arg_18_0)
	arg_18_0.pos_ = arg_18_0.list_:GetScrolledPosition()

	arg_18_0:StopTimer()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(ADVANCE_TEST_RANK_UPGRADE, arg_18_0.RefreshUIHandler_)
	AdvanceTestData:SetCurRankType(arg_18_0.rankTypeConst_.ALL)
end

function var_0_0.Refresh(arg_19_0)
	if AdvanceTestData:GetCurRankType() == arg_19_0.rankTypeConst_.ALL then
		local var_19_0 = RankData:GetActivityRank(arg_19_0.activityID, arg_19_0.stageType)

		arg_19_0.rankList = var_19_0 and var_19_0.rankList or {}

		if var_19_0 then
			local var_19_1, var_19_2 = var_19_0:GetCurRankDes()

			arg_19_0.m_rank.text = var_19_1
			arg_19_0.m_score.text = var_19_2
		else
			arg_19_0.m_rank.text = ""
			arg_19_0.m_score.text = ""
		end

		SetActive(arg_19_0.m_rewardBtn, true)
		arg_19_0.tabController_:SetSelectedState("all")
	else
		local var_19_3 = RankData:GetGuildActivityRank(arg_19_0.activityID, arg_19_0.stageType)

		arg_19_0.rankList = var_19_3 and var_19_3.rankList or {}

		if var_19_3 then
			local var_19_4, var_19_5 = var_19_3:GetCurRankDes()

			arg_19_0.m_rank.text = var_19_4
			arg_19_0.m_score.text = var_19_5
		else
			arg_19_0.m_rank.text = ""
			arg_19_0.m_score.text = ""
		end

		SetActive(arg_19_0.m_rewardBtn, false)
		arg_19_0.tabController_:SetSelectedState("club")
	end

	arg_19_0.list_:StartScroll(#arg_19_0.rankList)

	if arg_19_0.pos_ then
		arg_19_0.list_:SetScrolledPosition(arg_19_0.pos_)
	end

	local var_19_6 = PlayerData:GetPlayerInfo()

	arg_19_0.commonPortrait_:RenderHead(var_19_6 and var_19_6.portrait)
	arg_19_0.commonPortrait_:RenderFrame(var_19_6.icon_frame)
	arg_19_0.subTypeToggleController_:SetSelectedState(arg_19_0.stageType)
end

function var_0_0.IndexItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.rankList[arg_20_1]

	arg_20_2:Refresh(var_20_0, arg_20_0.stageType)
end

function var_0_0.Dispose(arg_21_0)
	arg_21_0.commonPortrait_:Dispose()

	if arg_21_0.list_ then
		arg_21_0.list_:Dispose()

		arg_21_0.list_ = nil
	end

	var_0_0.super.Dispose(arg_21_0)
end

function var_0_0.AddTimer(arg_22_0)
	arg_22_0:StopTimer()

	arg_22_0.m_leftTimeText.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(arg_22_0.stopTime_, nil, true)
	arg_22_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > arg_22_0.stopTime_ then
			return
		end

		arg_22_0.m_leftTimeText.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(arg_22_0.stopTime_, nil, true)
	end, 1, -1)

	arg_22_0.timer_:Start()
end

function var_0_0.StopTimer(arg_24_0)
	if arg_24_0.timer_ then
		arg_24_0.timer_:Stop()

		arg_24_0.timer_ = nil
	end
end

function var_0_0.RefreshGuildRankGo(arg_25_0)
	if GuildData:GetGuildInfo().id == nil then
		arg_25_0.tabNumController_:SetSelectedState("01")
	else
		arg_25_0.tabNumController_:SetSelectedState("02")
	end
end

function var_0_0.OnRankUpdate(arg_26_0)
	arg_26_0:Refresh()
end

return var_0_0
