local var_0_0 = class("ZumaRankView", ReduxView)
local var_0_1 = {
	ALL = 1,
	GUILD = 2
}

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaRankUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.curRankType_ = var_0_1.ALL

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, ActivityAttributeArenaRankItem)
	arg_4_0.tabController_ = arg_4_0.toggleConEx:GetController("tab")
	arg_4_0.tabNumController_ = arg_4_0.toggleConEx:GetController("num")
	arg_4_0.commonPortrait_ = CommonHeadPortrait.New(arg_4_0.headItem_)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.clubBtn_, nil, function()
		arg_5_0:SwitchPageIfDiff(var_0_1.GUILD)
	end)
	arg_5_0:AddBtnListener(arg_5_0.allBtn_, nil, function()
		arg_5_0:SwitchPageIfDiff(var_0_1.ALL)
	end)
end

function var_0_0.IndexItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:RefreshUI(arg_8_0.rankList_[arg_8_1])
end

function var_0_0.QueryRankData(arg_9_0)
	RankAction.QueryActivityRank(arg_9_0.activityID_)
	arg_9_0.tabNumController_:SetSelectedState("01")
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.activityID_ = arg_10_0.params_.rank_activity_id

	arg_10_0:QueryRankData()
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0:RefreshSelfRank()
	arg_11_0:RefreshList()
end

function var_0_0.SwitchPageIfDiff(arg_12_0, arg_12_1)
	if arg_12_0.curRankType_ ~= arg_12_1 then
		arg_12_0:SwitchPage(arg_12_1)
	end
end

function var_0_0.SwitchPage(arg_13_0, arg_13_1)
	arg_13_0.curRankType_ = arg_13_1

	arg_13_0:RefreshSelfRank()
	arg_13_0:RefreshList()
end

function var_0_0.RefreshSelfRank(arg_14_0)
	local var_14_0 = PlayerData:GetPlayerInfo()

	arg_14_0.commonPortrait_:RenderHead(var_14_0 and var_14_0.portrait)
	arg_14_0.commonPortrait_:RenderFrame(var_14_0.icon_frame)

	arg_14_0.name_.text = var_14_0.nick

	if arg_14_0.curRankType_ == var_0_1.ALL then
		local var_14_1 = RankData:GetActivityRank(arg_14_0.activityID_)

		if var_14_1 then
			local var_14_2, var_14_3 = var_14_1:GetCurRankDes()

			arg_14_0.rank_.text = var_14_2
			arg_14_0.score_.text = var_14_3
		else
			arg_14_0.rank_.text = ""
			arg_14_0.score_.text = ""
		end

		arg_14_0.tabController_:SetSelectedState("all")
	else
		local var_14_4 = RankData:GetGuildActivityRank(arg_14_0.activityID_)

		if var_14_4 then
			local var_14_5, var_14_6 = var_14_4:GetCurRankDes()

			arg_14_0.rank_.text = var_14_5
			arg_14_0.score_.text = var_14_6
		else
			arg_14_0:RefreshNone()
		end

		arg_14_0.tabController_:SetSelectedState("club")
	end
end

function var_0_0.RefreshNone(arg_15_0)
	arg_15_0.rank_.text = GetTips("MATRIX_RANK_NO_RANK")
	arg_15_0.score_.text = GetTips("MATRIX_RANK_NO_INFO")
end

function var_0_0.RefreshList(arg_16_0)
	if arg_16_0.curRankType_ == var_0_1.ALL then
		local var_16_0 = RankData:GetActivityRank(arg_16_0.activityID_)

		arg_16_0.rankList_ = var_16_0 and var_16_0.rankList or {}
	else
		local var_16_1 = RankData:GetGuildActivityRank(arg_16_0.activityID_)

		arg_16_0.rankList_ = var_16_1 and var_16_1.rankList or {}
	end

	arg_16_0.scrollHelper_:StartScroll(#arg_16_0.rankList_)
end

function var_0_0.OnTop(arg_17_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_18_0)
	arg_18_0.scrollHelper_:StartScroll(0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0:RemoveAllListeners()
	arg_19_0.commonPortrait_:Dispose()

	arg_19_0.commonPortrait_ = nil

	arg_19_0.scrollHelper_:Dispose()

	arg_19_0.scrollHelper_ = nil

	var_0_0.super.Dispose(arg_19_0)
end

function var_0_0.OnRankUpdate(arg_20_0)
	arg_20_0:RefreshUI()
end

return var_0_0
