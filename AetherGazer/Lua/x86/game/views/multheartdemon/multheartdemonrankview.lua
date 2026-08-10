local var_0_0 = class("MultHeartDemonRankView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemon_RankUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.tabController_ = arg_4_0.toggleConEx:GetController("tab")
	arg_4_0.tabNumController_ = arg_4_0.toggleConEx:GetController("num")
	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.SetListItem), arg_4_0.list_, MultHeartDemonListItem)
	arg_4_0.commonPortrait_ = CommonHeadPortrait.New(arg_4_0.headItem_)
	arg_4_0.nothingController_ = arg_4_0.conExCollection_:GetController("stage")
end

function var_0_0.SetListItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.rankData[arg_5_1]

	arg_5_2:SetData(var_5_0, arg_5_1, 2)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.rewardBtn_, nil, function()
		JumpTools.GoToSystem("/multHeartDemonReward", {
			selectIndex = 2,
			activityId = arg_6_0.activityId
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.clubBtn_, nil, function()
		arg_6_0:SwitchPageIfDiff(1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.allBtn_, nil, function()
		arg_6_0:SwitchPageIfDiff(2)
	end)
end

function var_0_0.SwitchPage(arg_10_0, arg_10_1)
	if arg_10_0.tabConState_ == nil then
		arg_10_0.tabConState_ = {
			"club",
			"all"
		}
	end

	arg_10_0.tabController_:SetSelectedState(arg_10_0.tabConState_[arg_10_1])

	arg_10_0.curPage_ = arg_10_1
	arg_10_0.rankData = arg_10_0:GetListFromIndex(arg_10_1)

	arg_10_0:UpdateView()
end

function var_0_0.SwitchPageIfDiff(arg_11_0, arg_11_1)
	if arg_11_0.curPage_ ~= arg_11_1 then
		arg_11_0:SwitchPage(arg_11_1)
	end
end

function var_0_0.IsShowRank(arg_12_0)
	return false
end

function var_0_0.UpdateView(arg_13_0)
	arg_13_0.remainTime = ActivityData:GetActivityRefreshTime(arg_13_0.activityId)
	arg_13_0.challengeStage = MultHeartDemonData:GetDataByPara("challengeStage")

	arg_13_0.list:StartScroll(arg_13_0:IsShowRank() and 0 or #arg_13_0.rankData)
	SetActive(arg_13_0.rewardBtn_.gameObject, arg_13_0.curPage_ == 2)

	local var_13_0 = RankData[arg_13_0.curPage_ == 1 and "GetGuildCommonRank" or "GetCommonRank"](RankData, RankConst.RANK_ID.MULTHEARTDEMON)

	if var_13_0 then
		local var_13_1, var_13_2 = var_13_0:GetCurRankDes(300)

		arg_13_0.gradeTxt_.text = var_13_2
		arg_13_0.rankTxt_.text = var_13_1
	else
		arg_13_0.gradeTxt_.text = ""
		arg_13_0.rankTxt_.text = ""
	end

	arg_13_0.nothingController_:SetSelectedState(arg_13_0.challengeStage == 0 and "challenge" or "refresh")
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.isInit_ = false
	arg_14_0.activityId = arg_14_0.params_.activityId

	local var_14_0 = nullable(ActivityCfg, arg_14_0.activityId, "remark")

	if var_14_0 then
		arg_14_0.nameLabel_.text = var_14_0
	end

	arg_14_0.nameTxt_.text = PlayerData:GetPlayerInfo().nick

	arg_14_0.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
	arg_14_0.commonPortrait_:RenderFrame(PlayerData:GetPlayerInfo().icon_frame)
	RankAction.QueryCommonRank(RankConst.RANK_ID.MULTHEARTDEMON, nil, nil, 300)

	local var_14_1 = true

	if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
		var_14_1 = false
	end

	arg_14_0.tabNumController_:SetSelectedState(var_14_1 and "02" or "01")

	if var_14_1 then
		RankAction.QueryGuildCommonRank(RankConst.RANK_ID.MULTHEARTDEMON)
	end
end

function var_0_0.GetListFromIndex(arg_15_0, arg_15_1)
	if arg_15_1 == 1 then
		local var_15_0 = RankData:GetGuildCommonRank(RankConst.RANK_ID.MULTHEARTDEMON)

		return var_15_0 and var_15_0.rankList or {}
	else
		local var_15_1 = RankData:GetCommonRank(RankConst.RANK_ID.MULTHEARTDEMON)

		return var_15_1 and var_15_1.rankList or {}
	end
end

function var_0_0.OnRankUpdate(arg_16_0)
	if not arg_16_0.isInit_ then
		arg_16_0:SwitchPage(2)

		arg_16_0.isInit_ = true
	end
end

function var_0_0.OnExit(arg_17_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_18_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnMultDemonHeartUpdate(arg_19_0)
	if not arg_19_0.isInit_ then
		arg_19_0:SwitchPage(2)

		arg_19_0.isInit_ = true
	end
end

function var_0_0.Dispose(arg_20_0)
	arg_20_0.commonPortrait_:Dispose()

	if arg_20_0.list then
		arg_20_0.list:Dispose()

		arg_20_0.list = nil
	end

	var_0_0.super.Dispose(arg_20_0)
	Object.Destroy(arg_20_0.gameObject_)
end

return var_0_0
