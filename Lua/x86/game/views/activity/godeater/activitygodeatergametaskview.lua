local var_0_0 = class("ActivityGodEaterGameTaskView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Bounty/V4_2_GodEaterUI_Bounty_MainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()

	arg_3_0.list_ = {}

	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.uiList_ = LuaList.New(handler(arg_4_0, arg_4_0.RefreshItem), arg_4_0.uilistUilist_, GodEaterTaskItem)
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.activityID_ = arg_5_0.param_ and arg_5_0.param_.activity_id or ActivityConst.ACTIVITY_GODEATER_MAIN_KEY

	local var_5_0 = ActivityData:GetActivityData(arg_5_0.activityID_)

	arg_5_0.startTime_ = var_5_0.startTime
	arg_5_0.stopTime_ = var_5_0.stopTime

	manager.redPoint:bindUIandKey(arg_5_0.rewardbtnBtn_.transform, RedPointConst.ACTIVITY_GODEATER_TASK_REWARD_2)
	arg_5_0:StopTimer()
	arg_5_0:RefreshTaskList()
	arg_5_0:RefreshTimeText()

	arg_5_0.timer = Timer.New(function()
		if manager.time:GetServerTime() > arg_5_0.stopTime_ then
			JumpTools.OpenPageByJump("/ActivityGodEaterGameMainView", {
				activity_id = ActivityConst.ACTIVITY_GODEATER_MAIN_KEY
			})
			ShowTips(GetTips("TIME_OVER"))

			return
		end

		arg_5_0:RefreshTimeText()
	end, 1)

	arg_5_0.timer:Start()
end

function var_0_0.StopTimer(arg_7_0)
	if arg_7_0.timer then
		arg_7_0.timer:Stop()

		arg_7_0.timer = nil
	end
end

function var_0_0.OnTaskListChange(arg_8_0)
	arg_8_0:RefreshTaskList()
	GodEaterAction.UpdateRedPoint()
end

function var_0_0.RefreshTaskList(arg_9_0)
	arg_9_0.list_ = {}

	local var_9_0 = TaskTools:GetTaskIDList(TaskConst.TASK_TYPE.ACTIVITY_GOD_EATER_1) or {}
	local var_9_1 = TaskTools:GetTaskIDList(TaskConst.TASK_TYPE.ACTIVITY_GOD_EATER_3)

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		table.insert(var_9_0, iter_9_1)
	end

	local var_9_2 = arg_9_0:SortTaskList(var_9_0)

	for iter_9_2, iter_9_3 in ipairs(var_9_2) do
		local var_9_3 = AssignmentCfg[iter_9_3]

		if var_9_3 and var_9_3.phase <= GodEaterData.hubLv then
			table.insert(arg_9_0.list_, iter_9_3)
		end
	end

	arg_9_0.uiList_:StartScroll(#arg_9_0.list_)
end

function var_0_0.SortTaskList(arg_10_0, arg_10_1)
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		local var_10_3 = TaskData2:GetTask(iter_10_1)
		local var_10_4 = AssignmentCfg[iter_10_1]

		if var_10_3 and var_10_3.complete_flag == 1 then
			table.insert(var_10_2, iter_10_1)
		elseif var_10_3 and var_10_4.need <= (var_10_3.progress or 0) then
			table.insert(var_10_1, iter_10_1)
		else
			table.insert(var_10_0, iter_10_1)
		end
	end

	local function var_10_5(arg_11_0, arg_11_1)
		local var_11_0 = GodEaterTool.GetTaskType(arg_11_0)
		local var_11_1 = GodEaterTool.GetTaskType(arg_11_1)

		if var_11_0 ~= var_11_1 then
			return var_11_1 < var_11_0
		end

		return arg_11_0 < arg_11_1
	end

	table.sort(var_10_0, var_10_5)
	table.sort(var_10_1, var_10_5)
	table.sort(var_10_2, var_10_5)
	table.insertto(var_10_1, var_10_0)
	table.insertto(var_10_1, var_10_2)

	return var_10_1
end

function var_0_0.OnTop(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("GOD_EATER_GAME_TIPS_2")
end

function var_0_0.RefreshItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.list_[arg_13_1]

	arg_13_2:SetData(var_13_0)
end

function var_0_0.RefreshTimeText(arg_14_0)
	arg_14_0.textimeText_.text = manager.time.WrapTimeStrWithTips(manager.time:GetLostTimeStrWith2Unit(arg_14_0.stopTime_))
end

function var_0_0.AddUIListeners(arg_15_0)
	arg_15_0:AddBtnListener(arg_15_0.rewardbtnBtn_, nil, function()
		GodEaterTool.GotoMilestone(ActivityConst.ACTIVITY_GODEATER_MAIN_KEY)
	end)
end

function var_0_0.OnBehind(arg_17_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_18_0)
	manager.windowBar:HideBar()
	arg_18_0:StopTimer()
	arg_18_0:RemoveTween()
	manager.redPoint:unbindUIandKey(arg_18_0.rewardbtnBtn_.transform, RedPointConst.ACTIVITY_GODEATER_TASK_REWARD_2)
end

function var_0_0.RemoveTween(arg_19_0)
	return
end

function var_0_0.Dispose(arg_20_0)
	var_0_0.super.Dispose(arg_20_0)

	if arg_20_0.uiList_ then
		arg_20_0.uiList_:Dispose()

		arg_20_0.uiList_ = nil
	end
end

return var_0_0
