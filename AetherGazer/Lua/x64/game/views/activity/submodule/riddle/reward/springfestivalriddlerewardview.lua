local var_0_0 = class("SpringFestivalRiddleRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/Riddle/RiddleRewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.rewardUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshItem), arg_3_0.uiList_, SpringFestivalRiddleRewardItem)
end

function var_0_0.OnEnter(arg_4_0)
	local var_4_0 = arg_4_0.params_.activityID
	local var_4_1 = ActivityPointRewardCfg.get_id_list_by_activity_id[var_4_0]
	local var_4_2 = SpringFestivalRiddleData:GetReceiveList(var_4_0)
	local var_4_3 = {}
	local var_4_4 = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		if table.keyof(var_4_2, iter_4_1) then
			table.insert(var_4_4, iter_4_1)
		else
			table.insert(var_4_3, iter_4_1)
		end
	end

	table.insertto(var_4_3, var_4_4)

	arg_4_0.sortList_ = var_4_3

	arg_4_0.rewardUIList_:StartScroll(#var_4_1, 1)
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	if arg_6_0.rewardUIList_ then
		arg_6_0.rewardUIList_:Dispose()

		arg_6_0.rewardUIList_ = nil
	end

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.closeBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.RefreshItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.sortList_[arg_9_1]

	arg_9_2:SetData(arg_9_0.params_.activityID, var_9_0)
end

return var_0_0
