local var_0_0 = class("PushSnowBallRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballRewardsUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.rankTypeConst_ = AdvanceTestData:GetRankTypeConst()

	arg_3_0:InitUI()

	arg_3_0.controllerList_ = {}
	arg_3_0.scoreController_ = ControllerUtil.GetController(arg_3_0.scoreModelBtn_.transform, "toggle")
	arg_3_0.bowlingController_ = ControllerUtil.GetController(arg_3_0.bowlingModelBtn_.transform, "toggle")
	arg_3_0.bossController_ = ControllerUtil.GetController(arg_3_0.bossModelBtn_.transform, "toggle")

	table.insert(arg_3_0.controllerList_, arg_3_0.scoreController_)
	table.insert(arg_3_0.controllerList_, arg_3_0.bowlingController_)
	table.insert(arg_3_0.controllerList_, arg_3_0.bossController_)

	arg_3_0.normalTaskItemList_ = {}
	arg_3_0.hardTaskItemList_ = {}

	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.RefreshUIHandler_ = handler(arg_4_0, arg_4_0.Refresh)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.scoreModelBtn_, nil, function()
		arg_5_0:OnClickSubType(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.bowlingModelBtn_, nil, function()
		arg_5_0:OnClickSubType(2)
	end)
	arg_5_0:AddBtnListener(arg_5_0.bossModelBtn_, nil, function()
		arg_5_0:OnClickSubType(3)
	end)
end

function var_0_0.OnClickSubType(arg_9_0, arg_9_1)
	if arg_9_0.index ~= arg_9_1 then
		arg_9_0.scroll_.enabled = false
		arg_9_0.normalTaskDataList_ = PushSnowBallData:GetNormalTaskListByType(arg_9_1)
		arg_9_0.hardTaskDataList_ = PushSnowBallData:GetHardTaskListByType(arg_9_1)

		for iter_9_0, iter_9_1 in ipairs(arg_9_0.normalTaskDataList_) do
			if not arg_9_0.normalTaskItemList_[iter_9_0] then
				local var_9_0 = Object.Instantiate(arg_9_0.taskItem_, arg_9_0.normalTaskTrs_, false)
				local var_9_1 = PushSnowBallRewardItem.New(var_9_0)

				table.insert(arg_9_0.normalTaskItemList_, var_9_1)
			end

			arg_9_0.normalTaskItemList_[iter_9_0]:SetData(iter_9_0, iter_9_1)
		end

		for iter_9_2, iter_9_3 in ipairs(arg_9_0.hardTaskDataList_) do
			if not arg_9_0.hardTaskItemList_[iter_9_2] then
				local var_9_2 = Object.Instantiate(arg_9_0.taskItem_, arg_9_0.hardTaskTrs_, false)
				local var_9_3 = PushSnowBallRewardItem.New(var_9_2)

				table.insert(arg_9_0.hardTaskItemList_, var_9_3)
			end

			arg_9_0.hardTaskItemList_[iter_9_2]:SetData(iter_9_2, iter_9_3)
		end

		arg_9_0:RefreshToggle(arg_9_1)

		arg_9_0.scroll_.enabled = true
	end

	arg_9_0.index = arg_9_1
end

function var_0_0.RefreshToggle(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.controllerList_) do
		if iter_10_0 == arg_10_1 then
			iter_10_1:SetSelectedState("on")
		else
			iter_10_1:SetSelectedState("off")
		end
	end
end

function var_0_0.OnRewardedTask(arg_11_0)
	arg_11_0:Refresh()
end

function var_0_0.OnTop(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_13_0.activityID_ = arg_13_0.params_.activityID

	arg_13_0:OnClickSubType(arg_13_0.index or 1)
	arg_13_0:Refresh()
	manager.redPoint:bindUIandKey(arg_13_0.scoreModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. 1)
	manager.redPoint:bindUIandKey(arg_13_0.bowlingModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. 2)
	manager.redPoint:bindUIandKey(arg_13_0.bossModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. 3)
end

function var_0_0.OnExit(arg_14_0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(arg_14_0.scoreModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. 1)
	manager.redPoint:unbindUIandKey(arg_14_0.bowlingModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. 2)
	manager.redPoint:unbindUIandKey(arg_14_0.bossModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. 3)
end

function var_0_0.Refresh(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.normalTaskItemList_) do
		iter_15_1:RefreshUI()
	end

	for iter_15_2, iter_15_3 in ipairs(arg_15_0.hardTaskItemList_) do
		iter_15_3:RefreshUI()
	end
end

function var_0_0.Dispose(arg_16_0)
	if arg_16_0.hardTaskItemList_ then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0.hardTaskItemList_) do
			iter_16_1:Dispose()
		end

		arg_16_0.hardTaskItemList_ = nil
	end

	if arg_16_0.normalTaskItemList_ then
		for iter_16_2, iter_16_3 in ipairs(arg_16_0.normalTaskItemList_) do
			iter_16_3:Dispose()
		end

		arg_16_0.normalTaskItemList_ = nil
	end

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
