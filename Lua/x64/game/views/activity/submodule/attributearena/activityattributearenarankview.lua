local var_0_0 = class("ActivityAttributeArenaRankView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return AttributeArenaTools.GetRankUI(arg_1_0.params_.rank_activity_id)
end

local var_0_1 = {
	ALL = 1,
	GUILD = 2
}

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.curRankType_ = var_0_1.ALL

	arg_3_0:InitUI()

	arg_3_0.commonPortrait_ = CommonHeadPortrait.New(arg_3_0.headItem_)

	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, ActivityAttributeArenaRankItem)
	arg_4_0.switchList = LuaList.New(handler(arg_4_0, arg_4_0.IndexSwitchItem), arg_4_0.switchList_, ActivityAttributeArenaRankSwitchItem)
	arg_4_0.switchItemClickHandle = handler(arg_4_0, arg_4_0.SwitchItemClick)
	arg_4_0.tabController_ = arg_4_0.toggleConEx:GetController("tab")
	arg_4_0.tabNumController_ = arg_4_0.toggleConEx:GetController("num")
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(arg_5_0.rankList_[arg_5_1])
end

function var_0_0.IndexSwitchItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, arg_6_0.index)
	arg_6_2:RegistCallBack(arg_6_0.switchItemClickHandle)
end

function var_0_0.SwitchItemClick(arg_7_0, arg_7_1)
	arg_7_0.params_.index = arg_7_1
	arg_7_0.index = arg_7_1

	RankAction.QueryActivityRank(arg_7_0.activityID_, arg_7_0.index)

	if GuildData:GetGuildInfo().id == nil then
		arg_7_0.tabNumController_:SetSelectedState("01")

		arg_7_0.curRankType_ = var_0_1.ALL
	else
		arg_7_0.tabNumController_:SetSelectedState("02")
		RankAction.QueryGuildActivityRank(arg_7_0.activityID_, arg_7_0.index)
	end

	arg_7_0.switchList:Refresh()
end

function var_0_0.AddUIListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.clubBtn_, nil, function()
		arg_8_0:SwitchPageIfDiff(var_0_1.GUILD)
	end)
	arg_8_0:AddBtnListener(arg_8_0.allBtn_, nil, function()
		arg_8_0:SwitchPageIfDiff(var_0_1.ALL)
	end)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.activityID_ = arg_11_0.params_.rank_activity_id

	if arg_11_0.params_.index then
		arg_11_0.index = arg_11_0.params_.index
	else
		arg_11_0.index = 1
	end

	RankAction.QueryActivityRank(arg_11_0.activityID_, arg_11_0.index)

	if GuildData:GetGuildInfo().id == nil then
		arg_11_0.tabNumController_:SetSelectedState("01")

		arg_11_0.curRankType_ = var_0_1.ALL
	else
		arg_11_0.tabNumController_:SetSelectedState("02")
		RankAction.QueryGuildActivityRank(arg_11_0.activityID_, arg_11_0.index)
	end

	arg_11_0.switchList:StartScroll(3)
	arg_11_0:RefreshUI()
end

function var_0_0.SwitchPageIfDiff(arg_12_0, arg_12_1)
	if arg_12_0.curRankType_ ~= arg_12_1 then
		arg_12_0.curRankType_ = arg_12_1

		arg_12_0:RefreshUI()
	end
end

function var_0_0.RefreshUI(arg_13_0)
	arg_13_0:RefreshSelfRank()
	arg_13_0:RefreshList()
end

function var_0_0.RefreshSelfRank(arg_14_0)
	local var_14_0 = PlayerData:GetPlayerInfo()

	arg_14_0.commonPortrait_:RenderHead(var_14_0 and var_14_0.portrait)
	arg_14_0.commonPortrait_:RenderFrame(var_14_0.icon_frame)

	arg_14_0.name_.text = var_14_0.nick

	if arg_14_0.curRankType_ == var_0_1.ALL then
		local var_14_1 = RankData:GetActivityRank(arg_14_0.activityID_, arg_14_0.index)

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
		local var_14_4 = RankData:GetGuildActivityRank(arg_14_0.activityID_, arg_14_0.index)

		if var_14_4 then
			local var_14_5, var_14_6 = var_14_4:GetCurRankDes()

			arg_14_0.rank_.text = var_14_5
			arg_14_0.score_.text = var_14_6
		else
			arg_14_0.rank_.text = ""
			arg_14_0.score_.text = ""
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
		local var_16_0 = RankData:GetActivityRank(arg_16_0.activityID_, arg_16_0.index)

		arg_16_0.rankList_ = var_16_0 and var_16_0.rankList or {}
	else
		local var_16_1 = RankData:GetGuildActivityRank(arg_16_0.activityID_, arg_16_0.index)

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
	manager.windowBar:HideBar()
	arg_18_0:SwitchPageIfDiff(var_0_1.ALL)
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0:RemoveAllListeners()
	arg_19_0.commonPortrait_:Dispose()
	arg_19_0.scrollHelper_:Dispose()
	arg_19_0.switchList:Dispose()
	var_0_0.super.Dispose(arg_19_0)
end

function var_0_0.OnRankUpdate(arg_20_0)
	arg_20_0:RefreshUI()
end

function var_0_0.AdaptLeft(arg_21_0)
	if arg_21_0.leftTrs_ == nil then
		arg_21_0.leftGo_ = arg_21_0:FindGo("RankUI_01/panel/left")
		arg_21_0.leftTrs_ = arg_21_0.leftGo_:GetComponent(typeof(RectTransform))
		arg_21_0.needAdaptLeft_ = false
	end

	var_0_0.super.AdaptLeft(arg_21_0)
end

function var_0_0.AdaptRight(arg_22_0)
	if arg_22_0.rightTrs_ == nil then
		arg_22_0.rightGo_ = arg_22_0:FindGo("RankUI_01/panel/right_adapt")
		arg_22_0.rightTrs_ = arg_22_0.rightGo_:GetComponent(typeof(RectTransform))
		arg_22_0.needAdaptRight_ = true
	end

	var_0_0.super.AdaptRight(arg_22_0)
end

return var_0_0
