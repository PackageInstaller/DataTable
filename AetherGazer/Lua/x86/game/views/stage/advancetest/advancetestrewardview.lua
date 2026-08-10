local var_0_0 = class("AdvanceTestRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/AdvancetestingUI/ATestingRankRewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.uiList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.uiListGo_, AdvanceTestRewardItemView)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0
	local var_7_1 = arg_7_1 == 1 and 1 or ActivityPointRewardCfg[arg_7_0.taskIdList[arg_7_1 - 1]].need + 1

	arg_7_2:SetData(var_7_1, arg_7_0.taskIdList[arg_7_1])
end

function var_0_0.OnTop(arg_8_0)
	return
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.activityID = arg_9_0.params_.activityID
	arg_9_0.taskIdList = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_9_0.activityID]

	arg_9_0.uiList_:StartScroll(#arg_9_0.taskIdList)
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.uiList_ then
		arg_11_0.uiList_:Dispose()

		arg_11_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
