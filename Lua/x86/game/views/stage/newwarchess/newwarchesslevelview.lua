local var_0_0 = class("NewWarChessLevelView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/NewWarChess/NewWarChessEntryUI"
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

	arg_4_0.newChessList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, NewWarChessLevelItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = NewWarChessLevelCfg.get_id_list_by_activity[arg_5_0.subActivityIDList_[arg_5_1]][1]

	arg_5_2:SetData(var_5_0)
	arg_5_2:SetEventListener()
end

function var_0_0.AddUIListener(arg_6_0)
	return
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.activityID_ = arg_7_0.params_.ActivityID
	arg_7_0.subActivityIDList_ = ActivityCfg[arg_7_0.activityID_].sub_activity_list

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.NEWWARCHESS_MOVEPOINT_PACKAGE]) do
		if ItemCfg[iter_7_1].time[2][1] == arg_7_0.activityID_ then
			table.insert(var_7_0, iter_7_1)
		end
	end

	local var_7_1 = {
		BACK_BAR,
		HOME_BAR
	}

	for iter_7_2, iter_7_3 in pairs(var_7_0) do
		table.insert(var_7_1, iter_7_3)
	end

	manager.windowBar:SwitchBar(var_7_1)

	for iter_7_4, iter_7_5 in pairs(var_7_0) do
		manager.windowBar:SetBarCanAdd(iter_7_5, true)
	end

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.newChessList_:StartScroll(#arg_8_0.subActivityIDList_)

	local var_8_0 = arg_8_0.newChessList_:GetItemList()

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		iter_8_1:SetEventListener()
		iter_8_1:CreatTimer()
	end

	arg_8_0.tipsText_.text = string.format(GetTips("ACTIVITY_NEW_WARCHESS_RECOVER"), NewChessTools.GetNewWarChessGameSetting("new_warchess_recover", arg_8_0.activityID_)[1])
end

function var_0_0.OnNewWarChessLevelInfoUpdate(arg_9_0)
	arg_9_0.newChessList_:Refresh()
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()

	local var_10_0 = arg_10_0.newChessList_:GetItemList()

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		iter_10_1:RemoveEventListener()
		iter_10_1:StopTimer()
	end
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.newChessList_ then
		arg_11_0.newChessList_:Dispose()

		arg_11_0.newChessList_ = nil
	end

	arg_11_0.super.Dispose(arg_11_0)
end

return var_0_0
