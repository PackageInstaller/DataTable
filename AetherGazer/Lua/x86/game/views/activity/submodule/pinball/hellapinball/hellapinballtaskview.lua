local var_0_0 = import("game.views.task.activityPointTaskCommon.ActivityPointTaskCommonModule")
local var_0_1 = class("HellaPinballTaskView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Activity_Hel/Com/Activity_Hel_RewardTrustUI"
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
	arg_2_0.levelLuaList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.levelUilist_, HellaPinballTaskCommonItem)
	arg_2_0.progressControlller_ = arg_2_0.progressControllerEx_:GetController("progress")
end

function var_0_1.SetActivityID(arg_3_0)
	arg_3_0.activityPointRewardActivityID_ = ActivityConst.ACTIVITY_HELLA_PINBALL_MAIN
end

function var_0_1.GetLevelInfo(arg_4_0)
	local var_4_0 = AssignmentCfg.get_id_list_by_activity_id[arg_4_0.activityPointRewardActivityID_]

	return PinballData:GetRoleLevel(), #var_4_0
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

function var_0_1.OnExit(arg_12_0)
	var_0_1.super.OnExit(arg_12_0)
	manager.notify:RemoveListener(OSIRISPLAYGAME_UPDATE_TASK, arg_12_0.taskUpdateHandler_)
end

function var_0_1.Dispose(arg_13_0)
	arg_13_0.taskUpdateHandler_ = nil

	arg_13_0.super.Dispose(arg_13_0)
end

function var_0_1.UpdateView(arg_14_0)
	arg_14_0.progress_ = PinballData:GetStageFinishProgress()
	arg_14_0.progressSlider_.value = arg_14_0.progress_

	if arg_14_0.progress_ < 0.42 then
		arg_14_0.progressControlller_:SetSelectedState("yellow")
	elseif arg_14_0.progress_ < 0.67 then
		arg_14_0.progressControlller_:SetSelectedState("orange")
	elseif arg_14_0.progress_ < 1 then
		arg_14_0.progressControlller_:SetSelectedState("red")
	else
		arg_14_0.progressControlller_:SetSelectedState("green")
	end

	arg_14_0.levelText_.text = math.floor(arg_14_0.progress_ * 100) .. "%"
	arg_14_0.receiveList_ = {}
	arg_14_0.showIdList_ = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.idList_) do
		local var_14_0 = ""

		arg_14_0.taskProgress = TaskData2:GetTaskProgress(iter_14_1)
		arg_14_0.taskComplete_ = TaskData2:GetTaskComplete(iter_14_1)

		if arg_14_0.taskComplete_ then
			var_14_0 = "complete"
		elseif arg_14_0.taskProgress >= AssignmentCfg[iter_14_1].need then
			var_14_0 = "receive"

			table.insert(arg_14_0.receiveList_, iter_14_1)
		else
			var_14_0 = "lock"
		end

		table.insert(arg_14_0.showIdList_, {
			id = iter_14_1,
			ind = iter_14_0,
			state = var_14_0
		})
	end

	local var_14_1 = 0

	for iter_14_2, iter_14_3 in ipairs(arg_14_0.showIdList_) do
		if iter_14_3.state == "receive" then
			var_14_1 = iter_14_2

			break
		end
	end

	if var_14_1 <= 0 then
		for iter_14_4, iter_14_5 in ipairs(arg_14_0.showIdList_) do
			if iter_14_5.state == "lock" then
				var_14_1 = iter_14_4

				break
			end
		end
	end

	arg_14_0.levelLuaList_:StartScroll(#arg_14_0.showIdList_, var_14_1)
	arg_14_0.onekeyController_:SetSelectedState(#arg_14_0.receiveList_ > 0 and "true" or "false")
end

function var_0_1.TaskUpdate(arg_15_0)
	arg_15_0:GetLevelInfo()
	arg_15_0:UpdateView()
end

function var_0_1.OnTaskListChange(arg_16_0)
	arg_16_0:TaskUpdate()
end

return var_0_1
