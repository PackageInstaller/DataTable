local var_0_0 = class("HeroClueTaskView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return HeroClueTools.GetTaskViewUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.scrollView_, HeroClueTaskItem)
	arg_4_0.taskUpdateHandler_ = handler(arg_4_0, arg_4_0.UpdateData)
	arg_4_0.allReceiveController_ = arg_4_0.controllerEx_:GetController("all")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backMask_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.allReceiveBtn_, nil, function()
		TaskTools:GetAllCanReciveTaskByActivityID(arg_5_0.taskActivityID_)
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.taskActivityID_ = arg_8_0.params_.activityID
	arg_8_0.mainActivityID_ = arg_8_0.params_.mainActivityID

	arg_8_0:RefreshUI()
	arg_8_0:RegistEventListener(OSIRIS_TASK_UPDATE, arg_8_0.taskUpdateHandler_)
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.scrollHelper_ then
		arg_10_0.scrollHelper_:Dispose()

		arg_10_0.scrollHelper_ = nil
	end

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0.taskDataList_ = TaskData2:GetActivityTaskSortList(arg_11_0.taskActivityID_)

	arg_11_0.scrollHelper_:StartScroll(#arg_11_0.taskDataList_)

	local var_11_0 = #arg_11_0.taskDataList_
	local var_11_1 = 0

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.taskDataList_) do
		local var_11_2 = iter_11_1.id
		local var_11_3 = AssignmentCfg[var_11_2]

		if iter_11_1.progress >= var_11_3.need and TaskData2:GetTaskComplete(var_11_2) then
			var_11_1 = var_11_1 + 1
		end
	end

	arg_11_0.progressText_.text = string.format("%s/%s", var_11_1, var_11_0)

	arg_11_0:RefreshAllReceive()
end

function var_0_0.IndexItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.taskDataList_[arg_12_1].id

	arg_12_2:SetData(var_12_0, arg_12_0.taskActivityID_, arg_12_1)
end

function var_0_0.UpdateData(arg_13_0)
	arg_13_0:RefreshUI()
	HeroClueAction.UpdateDrawRedPoint(arg_13_0.mainActivityID_)
end

function var_0_0.RefreshAllReceive(arg_14_0)
	local var_14_0 = TaskTools:GetCanGetActivityTaskList(arg_14_0.taskActivityID_)

	arg_14_0.allReceiveController_:SetSelectedState(tostring(#var_14_0 > 0))
end

return var_0_0
