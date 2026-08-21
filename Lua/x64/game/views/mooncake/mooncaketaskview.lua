local var_0_0 = class("MoonCakeTaskView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeTaskUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.needAdaptRight_ = true

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.scrollView_, MoonCakeTaskItem)
	arg_4_0.taskUpdateHandler_ = handler(arg_4_0, arg_4_0.UpdateData)
	arg_4_0.allReceiveController_ = ControllerUtil.GetController(arg_4_0.transform_, "allReceive")
	arg_4_0.selectController_ = ControllerUtil.GetController(arg_4_0.stage1PanelTrans_, "select")
	arg_4_0.stageController_ = ControllerUtil.GetController(arg_4_0.transform_, "stage")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.allReceiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_6_0 = {}

		for iter_6_0, iter_6_1 in ipairs(arg_5_0.taskDataList_) do
			if iter_6_1.progress < AssignmentCfg[iter_6_1.id].need or iter_6_1.complete_flag >= 1 then
				break
			end

			var_6_0[#var_6_0 + 1] = iter_6_1.id
		end

		TaskAction:SubmitTaskList(var_6_0)
	end)
	arg_5_0:AddBtnListener(arg_5_0.activityTaskBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if arg_5_0.taskType_ == 1 then
			return
		end

		arg_5_0:RefreshUI(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.playTaskBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if arg_5_0.taskType_ == 2 then
			return
		end

		arg_5_0:RefreshUI(2)
	end)
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.taskUpdateHandler_ = nil

	arg_9_0.scrollHelper_:Dispose()

	arg_9_0.scrollHelper_ = nil

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.activityID_ = arg_10_0.params_.activityID
	arg_10_0.stage_ = arg_10_0.params_.stage

	arg_10_0.stageController_:SetSelectedIndex(arg_10_0.stage_ - 1)

	arg_10_0.taskActivityIDList_ = ActivityCfg[arg_10_0.activityID_].sub_activity_list

	arg_10_0:RefreshUI(1)
	arg_10_0:RegistEventListener(OSIRIS_TASK_UPDATE, arg_10_0.taskUpdateHandler_)
	arg_10_0:BindRedPoint()
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0.taskType_ = nil

	arg_11_0:RemoveAllEventListener()
	arg_11_0:UnBindRedPoint()
end

function var_0_0.RefreshUI(arg_12_0, arg_12_1)
	arg_12_0.taskType_ = arg_12_1

	arg_12_0.selectController_:SetSelectedIndex(arg_12_1 - 1)

	arg_12_0.taskActivityID_ = arg_12_0.taskActivityIDList_[arg_12_0.taskType_]
	arg_12_0.taskDataList_ = TaskData2:GetActivityTaskSortList(arg_12_0.taskActivityID_)

	arg_12_0.scrollHelper_:StartScroll(#arg_12_0.taskDataList_)
	arg_12_0:RefreshReceiveBtn()
end

function var_0_0.RefreshReceiveBtn(arg_13_0)
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.taskDataList_) do
		if iter_13_1.progress >= AssignmentCfg[iter_13_1.id].need and iter_13_1.complete_flag < 1 then
			var_13_0 = 1

			break
		end
	end

	arg_13_0.allReceiveController_:SetSelectedIndex(var_13_0)
end

function var_0_0.IndexItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.taskDataList_[arg_14_1].id

	arg_14_2:SetData(var_14_0, arg_14_0.taskActivityID_)
end

function var_0_0.UpdateData(arg_15_0)
	arg_15_0:RefreshUI(arg_15_0.taskType_)

	if arg_15_0.tempReceiveTaskID_ then
		local var_15_0 = AssignmentCfg[arg_15_0.tempReceiveTaskID_]

		arg_15_0.tempReceiveTaskID_ = nil

		local var_15_1 = var_15_0.reward

		arg_15_0.dropRewardList_ = {}

		local var_15_2 = {}

		for iter_15_0, iter_15_1 in ipairs(var_15_1) do
			if iter_15_1[1] == 30051 or iter_15_1[1] == 30052 then
				table.insert(var_15_2, {
					item_info = {
						id = iter_15_1[1],
						num = iter_15_1[2]
					},
					use_list = {}
				})
			end
		end

		CommonAction.TryToUseItem(var_15_2)
	end
end

function var_0_0.BindRedPoint(arg_16_0)
	if arg_16_0.stage_ == 1 then
		local var_16_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_16_0.taskActivityIDList_[1])

		manager.redPoint:bindUIandKey(arg_16_0.activityTaskBtn_.transform, var_16_0)

		local var_16_1 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_16_0.taskActivityIDList_[2])

		manager.redPoint:bindUIandKey(arg_16_0.playTaskBtn_.transform, var_16_1)
	else
		local var_16_2 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_16_0.taskActivityIDList_[1])

		manager.redPoint:bindUIandKey(arg_16_0.activityTaskBtn_.transform, var_16_2)
	end
end

function var_0_0.UnBindRedPoint(arg_17_0)
	if arg_17_0.stage_ == 1 then
		local var_17_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_17_0.taskActivityIDList_[1])

		manager.redPoint:unbindUIandKey(arg_17_0.activityTaskBtn_.transform, var_17_0)

		local var_17_1 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_17_0.taskActivityIDList_[2])

		manager.redPoint:unbindUIandKey(arg_17_0.playTaskBtn_.transform, var_17_1)
	else
		local var_17_2 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_17_0.taskActivityIDList_[1])

		manager.redPoint:unbindUIandKey(arg_17_0.activityTaskBtn_.transform, var_17_2)
	end
end

return var_0_0
