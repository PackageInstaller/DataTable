local var_0_0 = class("AreaBattleRankView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivityAreaBattleData:GetPrefabByActivityID(arg_1_0.params_.mainActivityID) .. "NormalfightingRankUI"
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
	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.SetListItem), arg_4_0.list_, AreaBattleRankItem)
	arg_4_0.commonPortrait_ = CommonHeadPortrait.New(arg_4_0.headItem_)
	arg_4_0.nothingController_ = arg_4_0.conExCollection_:GetController("stage")
end

function var_0_0.SetListItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.rankData[arg_5_1]

	arg_5_2:SetData(var_5_0, arg_5_1, 2)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.clubBtn_, nil, function()
		arg_6_0:SwitchPageIfDiff(1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.allBtn_, nil, function()
		arg_6_0:SwitchPageIfDiff(2)
	end)
end

function var_0_0.SwitchPage(arg_9_0, arg_9_1)
	if arg_9_0.tabConState_ == nil then
		arg_9_0.tabConState_ = {
			"club",
			"all"
		}
	end

	arg_9_0.tabController_:SetSelectedState(arg_9_0.tabConState_[arg_9_1])

	arg_9_0.curPage_ = arg_9_1
	arg_9_0.rankData = arg_9_0:GetListFromIndex(arg_9_1)

	arg_9_0:UpdateView()
end

function var_0_0.SwitchPageIfDiff(arg_10_0, arg_10_1)
	if arg_10_0.curPage_ ~= arg_10_1 then
		arg_10_0:SwitchPage(arg_10_1)
	end
end

function var_0_0.UpdateView(arg_11_0)
	arg_11_0.list:StartScroll(#arg_11_0.rankData)
	SetActive(arg_11_0.rewardBtn_.gameObject, arg_11_0.curPage_ == 2)

	local var_11_0 = RankData[arg_11_0.curPage_ == 1 and "GetGuildActivityRank" or "GetActivityRank"](RankData, arg_11_0.activityID)

	if var_11_0 then
		local var_11_1, var_11_2 = var_11_0:GetCurRankDes()

		arg_11_0.gradeTxt_.text = var_11_2
		arg_11_0.rankTxt_.text = var_11_1
	else
		arg_11_0.gradeTxt_.text = ""
		arg_11_0.rankTxt_.text = ""
	end

	arg_11_0.nothingController_:SetSelectedState(arg_11_0.challengeStage == 0 and "challenge" or "refresh")
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.isInit_ = false

	local var_12_0 = arg_12_0.params_.activityID

	arg_12_0.activityID = ActivityCfg[var_12_0].sub_activity_list[1]
	arg_12_0.nameTxt_.text = PlayerData:GetPlayerInfo().nick

	arg_12_0.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
	arg_12_0.commonPortrait_:RenderFrame(PlayerData:GetPlayerInfo().icon_frame)
	RankAction.QueryActivityRank(arg_12_0.activityID)

	local var_12_1 = true

	if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
		var_12_1 = false
	end

	arg_12_0.tabNumController_:SetSelectedState(var_12_1 and "02" or "01")

	if var_12_1 then
		RankAction.QueryGuildActivityRank(arg_12_0.activityID)
	end
end

function var_0_0.GetListFromIndex(arg_13_0, arg_13_1)
	if arg_13_1 == 1 then
		local var_13_0 = RankData:GetGuildActivityRank(arg_13_0.activityID)

		return var_13_0 and var_13_0.rankList or {}
	else
		local var_13_1 = RankData:GetActivityRank(arg_13_0.activityID)

		return var_13_1 and var_13_1.rankList or {}
	end
end

function var_0_0.OnExit(arg_14_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnRankUpdate(arg_16_0)
	if not arg_16_0.isInit_ then
		arg_16_0:SwitchPage(2)

		arg_16_0.isInit_ = true
	end
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0.commonPortrait_:Dispose()

	if arg_17_0.list then
		arg_17_0.list:Dispose()

		arg_17_0.list = nil
	end

	var_0_0.super.Dispose(arg_17_0)
	Object.Destroy(arg_17_0.gameObject_)
end

return var_0_0
