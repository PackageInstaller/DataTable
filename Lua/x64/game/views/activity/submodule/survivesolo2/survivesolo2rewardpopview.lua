local var_0_0 = class("SurviveSolo2RewardPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return SurviveSolo2Tools.GetRewardPopView(arg_1_0.params_.activityId)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, SurviveSoloRewardItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:Refresh(arg_5_0.list_[arg_5_1], arg_5_0.activityID_)
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = arg_8_0.params_.activityId
	arg_8_0.list_ = ActivitySoloSlayerCfg.get_id_list_by_main_activity_id[arg_8_0.activityID_]

	arg_8_0:RefreshReward()
	arg_8_0:RefreshList()
end

function var_0_0.RefreshReward(arg_9_0)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.list_) do
		local var_9_1 = SurviveSoloData:GetData(iter_9_1)

		if var_9_1 then
			var_9_0 = var_9_0 + #var_9_1.rewards
		end
	end

	arg_9_0.rewardTxt_.text = var_9_0
	arg_9_0.allTxt_.text = "/" .. #arg_9_0.list_ * 3
end

function var_0_0.RefreshList(arg_10_0)
	table.sort(arg_10_0.list_, function(arg_11_0, arg_11_1)
		local var_11_0 = SurviveSoloData:GetData(arg_11_0)
		local var_11_1 = SurviveSoloData:GetData(arg_11_1)

		if var_11_0 and var_11_1 then
			local var_11_2 = arg_10_0:IsComplete(arg_11_0, var_11_0)

			if var_11_2 ~= arg_10_0:IsComplete(arg_11_1, var_11_1) then
				return var_11_2
			end
		end

		return arg_11_0 < arg_11_1
	end)
	arg_10_0.scrollHelper_:StartScroll(#arg_10_0.list_)
end

function var_0_0.IsComplete(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2.time
	local var_12_1 = arg_12_2.rewards
	local var_12_2 = ActivitySoloSlayerCfg[arg_12_1]

	for iter_12_0, iter_12_1 in ipairs(var_12_2.reward_item_list) do
		if var_12_0 >= iter_12_1[1] and not table.indexof(var_12_1, iter_12_1[1]) then
			return true
		end
	end

	return false
end

function var_0_0.OnSurviveSoloReward(arg_13_0)
	arg_13_0:RefreshReward()
	arg_13_0.scrollHelper_:Refresh()
end

function var_0_0.OnExit(arg_14_0)
	return
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:RemoveAllListeners()

	if arg_15_0.scrollHelper_ then
		arg_15_0.scrollHelper_:Dispose()

		arg_15_0.scrollHelper_ = nil
	end

	arg_15_0.super.Dispose(arg_15_0)
end

return var_0_0
