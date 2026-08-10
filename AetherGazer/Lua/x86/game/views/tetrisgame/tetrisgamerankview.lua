local var_0_0 = class("TetrisGameRankView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_TetrisGameUI/TetrisGameRankUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

local var_0_1 = {
	all = 2,
	club = 1
}

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListeners()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uilistGo_, TetrisGameRankItem)
	arg_5_0.tabController_ = arg_5_0.toggleConEx:GetController("tab")
	arg_5_0.tabNumController_ = arg_5_0.toggleConEx:GetController("num")
	arg_5_0.commonPortrait_ = CommonHeadPortrait.New(arg_5_0.headItem_)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, arg_6_0.rankList_[arg_6_1])
end

function var_0_0.AddUIListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.clubBtn_, nil, function()
		if arg_7_0.index == var_0_1.club then
			return
		end

		arg_7_0:SwitchPageIfDiff(var_0_1.club)
	end)
	arg_7_0:AddBtnListener(arg_7_0.allBtn_, nil, function()
		if arg_7_0.index == var_0_1.all then
			return
		end

		arg_7_0:SwitchPageIfDiff(var_0_1.all)
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.activityID_ = arg_10_0.params_.rankActivityID

	if not arg_10_0.activityID_ then
		return
	end

	local var_10_0 = arg_10_0.params_.index or arg_10_0.index or var_0_1.all

	arg_10_0:RefreshBtnState()
	arg_10_0:SwitchPageIfDiff(var_10_0)
end

function var_0_0.OnTop(arg_11_0)
	arg_11_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnBehind(arg_13_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.RefreshBtnState(arg_15_0)
	if GuildData:GetGuildInfo().id == nil then
		arg_15_0.tabNumController_:SetSelectedState("01")
	else
		arg_15_0.tabNumController_:SetSelectedState("02")
	end
end

function var_0_0.SwitchPageIfDiff(arg_16_0, arg_16_1)
	arg_16_0.index = arg_16_1

	if arg_16_0.index == var_0_1.all then
		RankAction.QueryActivityRank(arg_16_0.activityID_)
	else
		RankAction.QueryGuildActivityRank(arg_16_0.activityID_)
	end
end

function var_0_0.OnRankUpdate(arg_17_0)
	if arg_17_0.index == var_0_1.all then
		local var_17_0 = RankData:GetActivityRank(arg_17_0.activityID_)

		arg_17_0.rankList_ = var_17_0 and var_17_0.rankList or {}
	else
		local var_17_1 = RankData:GetGuildActivityRank(arg_17_0.activityID_)

		arg_17_0.rankList_ = var_17_1 and var_17_1.rankList or {}
	end

	arg_17_0.uiList_:StartScroll(#arg_17_0.rankList_)
	arg_17_0:RefreshSelfRank()
end

function var_0_0.RefreshSelfRank(arg_18_0)
	local var_18_0 = PlayerData:GetPlayerInfo()

	arg_18_0.commonPortrait_:RenderHead(var_18_0 and var_18_0.portrait)
	arg_18_0.commonPortrait_:RenderFrame(var_18_0.icon_frame)

	arg_18_0.name_.text = var_18_0.nick

	if arg_18_0.index == var_0_1.all then
		local var_18_1 = RankData:GetActivityRank(arg_18_0.activityID_)

		if var_18_1 then
			local var_18_2, var_18_3 = var_18_1:GetCurRankDes()

			arg_18_0.rank_.text = var_18_2
			arg_18_0.score_.text = var_18_3
		else
			arg_18_0.rank_.text = ""
			arg_18_0.score_.text = ""
		end

		arg_18_0.tabController_:SetSelectedState("all")
	else
		local var_18_4 = RankData:GetGuildActivityRank(arg_18_0.activityID_)

		if var_18_4 then
			local var_18_5, var_18_6 = var_18_4:GetCurRankDes()

			arg_18_0.rank_.text = var_18_5
			arg_18_0.score_.text = var_18_6
		else
			arg_18_0.rank_.text = ""
			arg_18_0.score_.text = ""
		end

		arg_18_0.tabController_:SetSelectedState("club")
	end
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0.commonPortrait_:Dispose()

	if arg_19_0.uiList_ then
		arg_19_0.uiList_:Dispose()

		arg_19_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
