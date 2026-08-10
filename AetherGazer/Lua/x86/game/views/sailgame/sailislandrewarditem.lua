local var_0_0 = class("SailIslandRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.controller_ = ControllerUtil.GetController(arg_2_0.transform_, "status")
	arg_2_0.rewardItemList_ = {}
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.activityID_ = arg_3_2
	arg_3_0.taskID_ = arg_3_1.id
	arg_3_0.type_ = arg_3_1.type

	arg_3_0:RefreshUI()
end

function var_0_0.Dispose(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.rewardItemList_) do
		iter_4_1:Dispose()
	end

	arg_4_0.rewardItemList_ = nil

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if arg_5_0.type_ == SailGameConst.TASK_TYPE.BUILDING then
			SailGameAction.ReceiveTask(arg_5_0.activityID_, arg_5_0.taskID_, arg_5_0.type_)
		else
			local var_6_0 = SailGameIslandLevelCfg[arg_5_0.taskID_].level

			SailGameAction.ReceiveTask(arg_5_0.activityID_, var_6_0, arg_5_0.type_)
		end
	end)
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0:RefreshTitle()
	arg_7_0:RefreshReward()
	arg_7_0:RefreshProgress()
end

function var_0_0.RefreshTitle(arg_8_0)
	if arg_8_0.type_ == SailGameConst.TASK_TYPE.BUILDING then
		arg_8_0.contentText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_BUILD_REWARD_TIP"), SailGameBuildingCfg[arg_8_0.taskID_].name)
		arg_8_0.rewardCfg_ = SailGameBuildingCfg[arg_8_0.taskID_].reward_item_list
	else
		arg_8_0.contentText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_LEVEL_REWARD_TIP"), NumberTools.IntToRomam(SailGameIslandLevelCfg[arg_8_0.taskID_].level))
		arg_8_0.rewardCfg_ = SailGameIslandLevelCfg[arg_8_0.taskID_].reward_item_list
	end
end

function var_0_0.RefreshReward(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.rewardCfg_) do
		if arg_9_0.rewardItemList_[iter_9_0] then
			arg_9_0.rewardItemList_[iter_9_0]:SetData(iter_9_1, false)
		else
			arg_9_0.rewardItemList_[iter_9_0] = RewardPoolItem.New(arg_9_0.goRewardPanel_, iter_9_1, false)
		end
	end

	for iter_9_2 = #arg_9_0.rewardCfg_ + 1, #arg_9_0.rewardItemList_ do
		arg_9_0.rewardItemList_[iter_9_2]:Show(false)
	end
end

function var_0_0.RefreshProgress(arg_10_0)
	local var_10_0 = false
	local var_10_1 = false

	if arg_10_0.type_ == SailGameConst.TASK_TYPE.BUILDING then
		var_10_1 = SailGameData:GetRceivedBuilding(arg_10_0.activityID_)[arg_10_0.taskID_] == true
		var_10_0 = SailGameData:GetUnLockBuilding(arg_10_0.activityID_)[arg_10_0.taskID_] == true
	else
		local var_10_2 = SailGameIslandLevelCfg[arg_10_0.taskID_].level

		var_10_1 = SailGameData:GetReceivedIslandLevel(arg_10_0.activityID_)[var_10_2] == true
		var_10_0 = var_10_2 <= SailGameData:GetIslandLevel(arg_10_0.activityID_)
	end

	if var_10_1 == true then
		arg_10_0.controller_:SetSelectedState("received")
	elseif var_10_0 == true then
		arg_10_0.controller_:SetSelectedState("complete")
	else
		arg_10_0.controller_:SetSelectedState("uncomplete")
	end
end

return var_0_0
