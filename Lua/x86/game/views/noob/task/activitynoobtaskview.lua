local var_0_0 = class("ActivityNoobTaskView", ReduxView)
local var_0_1 = 601

function var_0_0.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/System/Activitynewbie/NewbieTaskUI_new")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:BindCfgUI()

	arg_1_0.taskItemList_ = LuaList.New(handler(arg_1_0, arg_1_0.RefreshTaskItem), arg_1_0.taskItemScroll_, ActivityNoobTaskItem)
	arg_1_0.phaseList_ = LuaList.New(handler(arg_1_0, arg_1_0.RefreshPhaseItem), arg_1_0.phaseItemScroll_, ActivityNoobPhaseItem)
	arg_1_0.progressList_ = LuaList.New(handler(arg_1_0, arg_1_0.RefreshProgressItem), arg_1_0.progressItemScroll_, ActivityNoobTaskProgressItem)
	arg_1_0.noobTaskUpdateHandler_ = handler(arg_1_0, arg_1_0.NoobTaskUpdate)
	arg_1_0.clickPhaseHandler_ = handler(arg_1_0, arg_1_0.OnClickPhase)
	arg_1_0.AccumulateReceiveHandler_ = handler(arg_1_0, arg_1_0.OnNoobAccumulateReceive)
	arg_1_0.onSubmitTaskResponseHandle_ = handler(arg_1_0, arg_1_0.onSubmitTaskResponse)

	manager.notify:RegistListener(NEWBIE_TASK_UPDATE, arg_1_0.noobTaskUpdateHandler_)
	manager.notify:RegistListener(NOOB_ACCUMULATE_RECEIVE, arg_1_0.AccumulateReceiveHandler_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_1_0.onSubmitTaskResponseHandle_)
	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.Dispose(arg_2_0)
	manager.notify:RemoveListener(NEWBIE_TASK_UPDATE, arg_2_0.noobTaskUpdateHandler_)
	manager.notify:RemoveListener(NOOB_ACCUMULATE_RECEIVE, arg_2_0.AccumulateReceiveHandler_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_2_0.onSubmitTaskResponseHandle_)
	arg_2_0.taskItemList_:Dispose()

	arg_2_0.taskItemList_ = nil

	arg_2_0.phaseList_:Dispose()

	arg_2_0.phaseList_ = nil

	arg_2_0.progressList_:Dispose()

	arg_2_0.progressList_ = nil
	arg_2_0.noobTaskUpdateHandler_ = nil
	arg_2_0.clickPhaseHandler_ = nil
	arg_2_0.AccumulateReceiveHandler_ = nil

	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.allReceiveController_ = ControllerUtil.GetController(arg_3_0.transform_, "name")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveAllBtn_, nil, function()
		local var_5_0 = TaskTools:GetNoobReadyList(arg_4_0.taskType_, arg_4_0.curPhase_)

		TaskAction:SubmitTaskList(var_5_0, var_0_1)
	end)
end

function var_0_0.onSubmitTaskResponse(arg_6_0)
	ActivityNoobAction.RefreshAccumulateRedPoint()
	manager.notify:Invoke(NEWBIE_TASK_UPDATE)
end

function var_0_0.SetIsBack(arg_7_0, arg_7_1)
	arg_7_0.isBack = arg_7_1
end

function var_0_0.SetData(arg_8_0)
	if not arg_8_0.isBack then
		arg_8_0.curPhase_ = arg_8_0:GetCurPhase()

		ActivityNoobData:CacheSelectedPhase(arg_8_0.curPhase_)
	else
		arg_8_0.curPhase_ = ActivityNoobData:GetSelectedPhase()
	end

	arg_8_0.taskType_ = NoobVersionCfg[ActivityNewbieTools.GetVersionID()].noob_task_type
	arg_8_0.isBack = false

	arg_8_0:NoobTaskUpdate()
end

function var_0_0.RefreshPhase(arg_9_0)
	local var_9_0 = #TaskTools:GetNoobPhaseTask(arg_9_0.taskType_)

	arg_9_0.phaseList_:StartScroll(var_9_0, arg_9_0.curPhase_)
end

function var_0_0.GetCurPhase(arg_10_0)
	local var_10_0 = ActivityNoobData:GetUnlockPhase()

	for iter_10_0 = 1, var_10_0 do
		local var_10_1 = TaskData2:GetSortedPhaseTaskList(arg_10_0.taskType_, iter_10_0)

		for iter_10_1, iter_10_2 in pairs(var_10_1) do
			if AssignmentCfg[iter_10_2.id].need > iter_10_2.progress or iter_10_2.complete_flag == 0 then
				return iter_10_0
			end
		end
	end

	return var_10_0
end

function var_0_0.RefreshPhaseItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:SetData(arg_11_0.taskType_, arg_11_1)
	arg_11_2:SetClickHandler(arg_11_0.clickPhaseHandler_)
	arg_11_2:SetSelect(arg_11_0.curPhase_)
end

function var_0_0.OnClickPhase(arg_12_0, arg_12_1)
	if arg_12_0.curPhase_ == arg_12_1 then
		return
	end

	arg_12_0.curPhase_ = arg_12_1

	ActivityNoobData:CacheSelectedPhase(arg_12_0.curPhase_)
	arg_12_0:RefreshTask()
	arg_12_0:RefreshRecivedAll()

	local var_12_0 = arg_12_0.phaseList_:GetItemList()

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		iter_12_1:SetSelect(arg_12_1)
	end
end

function var_0_0.RefreshTask(arg_13_0)
	arg_13_0.taskList_ = TaskTools:GetNoobTaskSortList(arg_13_0.taskType_, arg_13_0.curPhase_)

	arg_13_0.taskItemList_:StartScroll(#arg_13_0.taskList_)
end

function var_0_0.RefreshTaskItem(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2:SetData(arg_14_0.taskList_[arg_14_1].id)
end

function var_0_0.RefreshProgress(arg_15_0, arg_15_1)
	local var_15_0 = ActivityNoobData:GetUnlockPhase()
	local var_15_1 = TaskTools:GetNoobCompletedList(arg_15_0.taskType_)
	local var_15_2 = 0

	for iter_15_0 = 1, var_15_0 do
		var_15_2 = var_15_2 + (var_15_1[iter_15_0] or 0)
	end

	arg_15_0.progressCfg_ = ActivityNewbieTools.GetNoobPorgressRewardList()
	arg_15_0.completedTaskNum_ = var_15_2

	local var_15_3 = arg_15_0.progressCfg_[#arg_15_0.progressCfg_][1]

	arg_15_0.progressText_.text = string.format("%s/%s", arg_15_0.completedTaskNum_, var_15_3)

	if arg_15_1 == true then
		arg_15_0.progressList_:Refresh()
	else
		arg_15_0.progressList_:StartScroll(#arg_15_0.progressCfg_)
	end
end

function var_0_0.RefreshProgressItem(arg_16_0, arg_16_1, arg_16_2)
	arg_16_2:SetData(arg_16_1, arg_16_0.progressCfg_[arg_16_1], arg_16_0.completedTaskNum_)
end

function var_0_0.RefreshRecivedAll(arg_17_0)
	if #TaskTools:GetNoobReadyList(arg_17_0.taskType_, arg_17_0.curPhase_) > 0 then
		arg_17_0.allReceiveController_:SetSelectedState("true")
	else
		arg_17_0.allReceiveController_:SetSelectedState("false")
	end
end

function var_0_0.OnNoobAccumulateReceive(arg_18_0)
	arg_18_0:RefreshProgress(true)
end

function var_0_0.SetActive(arg_19_0, arg_19_1)
	SetActive(arg_19_0.gameObject_, arg_19_1)
end

function var_0_0.NoobTaskUpdate(arg_20_0)
	arg_20_0:RefreshTask()
	arg_20_0:RefreshProgress()
	arg_20_0:RefreshPhase()
	arg_20_0:RefreshRecivedAll()
end

return var_0_0
