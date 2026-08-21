local var_0_0 = import("game.views.task.activityPointTaskCommon.ActivityPointTaskCommonModule")
local var_0_1 = class("RogueCardGameRecordView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Activity_JokerCard/JokerCard_Com/Activity_JokerCard_RewardTrustUI"
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0:SetActivityID()

	arg_2_0.idList_ = arg_2_0:GetLevelIDList()
	arg_2_0.receiveList_ = {}
	arg_2_0.showIdList_ = {}
	arg_2_0.curLv_ = 0
	arg_2_0.maxLv_ = 0
	arg_2_0.onekeyController_ = arg_2_0.mainControllerEx_:GetController("onekey")
	arg_2_0.taskUpdateHandler_ = handler(arg_2_0, arg_2_0.TaskUpdate)
	arg_2_0.levelLuaList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.levelUilist_, RogueCardGameRecordTaskItem)
end

function var_0_1.SetActivityID(arg_3_0)
	arg_3_0.activityPointRewardActivityID_ = ActivityConst.ACTIVITY_ROGUECARD_5_0
end

function var_0_1.GetLevelInfo(arg_4_0)
	local var_4_0 = arg_4_0:GetLevelIDList()

	return TaskTools.GetTaskNumInfo(ActivityConst.ACTIVITY_ROGUECARD_5_0), #var_4_0
end

function var_0_1.GetLevelIDList(arg_5_0)
	return AssignmentCfg.get_id_list_by_activity_id[arg_5_0.activityPointRewardActivityID_]
end

function var_0_1.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.receiveBtn_, nil, function()
		arg_6_0:OnOnceBtnClick()
	end)
end

function var_0_1.OnOnceBtnClick(arg_8_0)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.showIdList_) do
		local var_8_1 = AssignmentCfg[iter_8_1.id]
		local var_8_2 = TaskData2:GetTaskComplete(iter_8_1.id)

		if TaskData2:GetTaskProgress(iter_8_1.id) >= var_8_1.need and not var_8_2 then
			table.insert(var_8_0, iter_8_1.id)
		end
	end

	if #var_8_0 > 0 then
		TaskAction:SubmitTaskList(var_8_0)
	end
end

function var_0_1.OnEnter(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_9_0.curLv_, arg_9_0.maxLv_ = arg_9_0:GetLevelInfo()

	if arg_9_0.progressImg_ then
		arg_9_0.progressImg_.fillAmount = arg_9_0.curLv_ / arg_9_0.maxLv_
	end

	arg_9_0:UpdateView()
	arg_9_0:BindRedPoint()
	arg_9_0:UpdateBar()
end

function var_0_1.UpdateBar(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_10_0:Back()
	end)
end

function var_0_1.OnTop(arg_12_0)
	arg_12_0:UpdateTimeTxt()
	arg_12_0:StopUpdateTimer()

	arg_12_0.updateTimer = Timer.New(function()
		arg_12_0:UpdateTimeTxt()
	end, 1, -1)

	arg_12_0.updateTimer:Start()
	var_0_1.super.OnTop(arg_12_0)
end

function var_0_1.StopUpdateTimer(arg_14_0)
	if arg_14_0.updateTimer then
		arg_14_0.updateTimer:Stop()

		arg_14_0.updateTimer = nil
	end
end

function var_0_1.UpdateTimeTxt(arg_15_0)
	local var_15_0 = os.time()
	local var_15_1 = os.difftime(var_15_0, os.time(os.date("!*t", var_15_0)))
	local var_15_2 = os.date("!*t", var_15_0 + var_15_1)

	arg_15_0.dayText_.text = string.format("%s/%s", var_15_2.month, var_15_2.day)
	arg_15_0.timeText_.text = manager.time:GetTwelveHourClockTimeText()
end

function var_0_1.OnExit(arg_16_0)
	arg_16_0:StopUpdateTimer()
	var_0_1.super.OnExit(arg_16_0)
	manager.notify:RemoveListener(OSIRISPLAYGAME_UPDATE_TASK, arg_16_0.taskUpdateHandler_)
end

function var_0_1.Dispose(arg_17_0)
	arg_17_0.taskUpdateHandler_ = nil

	arg_17_0.super.Dispose(arg_17_0)
end

function var_0_1.UpdateView(arg_18_0)
	arg_18_0.levelText_.text = arg_18_0.curLv_ .. "/" .. arg_18_0.maxLv_
	arg_18_0.receiveList_ = {}
	arg_18_0.showIdList_ = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.idList_) do
		local var_18_0 = ""

		arg_18_0.taskProgress = TaskData2:GetTaskProgress(iter_18_1)
		arg_18_0.taskComplete_ = TaskData2:GetTaskComplete(iter_18_1)

		if arg_18_0.taskComplete_ then
			var_18_0 = "complete"
		elseif arg_18_0.taskProgress >= AssignmentCfg[iter_18_1].need then
			var_18_0 = "receive"

			table.insert(arg_18_0.receiveList_, iter_18_1)
		else
			var_18_0 = "lock"
		end

		table.insert(arg_18_0.showIdList_, {
			id = iter_18_1,
			ind = iter_18_0,
			state = var_18_0
		})
	end

	local var_18_1 = 0

	for iter_18_2, iter_18_3 in ipairs(arg_18_0.showIdList_) do
		if iter_18_3.state == "receive" then
			var_18_1 = iter_18_2

			break
		end
	end

	if var_18_1 <= 0 then
		for iter_18_4, iter_18_5 in ipairs(arg_18_0.showIdList_) do
			if iter_18_5.state == "lock" then
				var_18_1 = iter_18_4

				break
			end
		end
	end

	arg_18_0.levelLuaList_:StartScroll(#arg_18_0.showIdList_, var_18_1)
	arg_18_0.onekeyController_:SetSelectedState(#arg_18_0.receiveList_ > 0 and "true" or "false")
end

function var_0_1.TaskUpdate(arg_19_0)
	arg_19_0:GetLevelInfo()
	arg_19_0:UpdateView()
end

function var_0_1.OnTaskListChange(arg_20_0)
	arg_20_0:TaskUpdate()
end

return var_0_1
