local var_0_0 = class("ActivityNoobTaskItem", ReduxView)
local var_0_1 = {
	"lock",
	"receive",
	"go",
	"complete"
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.stateCon_ = ControllerUtil.GetController(arg_1_0.transform_, "state")
	arg_1_0.rewardItems_ = {}
end

function var_0_0.Dispose(arg_2_0)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_2_0.onSubmitTaskResponseHandle_)

	for iter_2_0, iter_2_1 in pairs(arg_2_0.rewardItems_) do
		iter_2_1:Dispose()
	end

	arg_2_0.rewardItems_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.goBtn_, nil, function()
		local var_4_0 = AssignmentCfg[arg_3_0.taskID_]

		JumpTools.JumpToPage2(var_4_0.source)
	end)
	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		TaskAction:SubmitTask(arg_3_0.taskID_)
	end)

	arg_3_0.onSubmitTaskResponseHandle_ = handler(arg_3_0, arg_3_0.onSubmitTaskResponse)

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_3_0.onSubmitTaskResponseHandle_)
end

function var_0_0.onSubmitTaskResponse(arg_6_0)
	ActivityNoobAction.RefreshAccumulateRedPoint()
	manager.notify:Invoke(NEWBIE_TASK_UPDATE)
	SendMessageManagerToSDK("task_finish", {
		taskId = arg_6_0.taskID_
	})
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.taskID_ = arg_7_1

	arg_7_0:RefreshTitle()
	arg_7_0:RefreshProgress()
	arg_7_0:RefreshState()
	arg_7_0:RefreshReward(arg_7_1)
end

function var_0_0.RefreshTitle(arg_8_0)
	arg_8_0.titleText_.text = GetI18NText(AssignmentCfg[arg_8_0.taskID_].desc)
end

function var_0_0.RefreshProgress(arg_9_0)
	local var_9_0 = AssignmentCfg[arg_9_0.taskID_].need
	local var_9_1 = TaskData2:GetTask(arg_9_0.taskID_).progress or 0

	if var_9_0 < var_9_1 then
		var_9_1 = var_9_0
	end

	arg_9_0.needText_.text = string.format("/%s", var_9_0)
	arg_9_0.progressText_.text = var_9_1
	arg_9_0.progressSlider_.value = var_9_1 / var_9_0
end

function var_0_0.RefreshReward(arg_10_0, arg_10_1)
	local var_10_0 = AssignmentCfg[arg_10_1].reward

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = clone(ItemTemplateData)

		var_10_1.id = iter_10_1[1]
		var_10_1.number = iter_10_1[2]

		function var_10_1.clickFun(arg_11_0)
			ShowPopItem(POP_ITEM, {
				arg_11_0.id,
				arg_11_0.number
			})
		end

		if arg_10_0.rewardItems_[iter_10_0] == nil then
			local var_10_2 = Object.Instantiate(arg_10_0.itemGo_, arg_10_0.rewardParent_)

			SetActive(var_10_2, true)

			arg_10_0.rewardItems_[iter_10_0] = CommonItemView.New(var_10_2)
		end

		arg_10_0.rewardItems_[iter_10_0]:SetData(var_10_1)
	end

	for iter_10_2 = #var_10_0 + 1, #arg_10_0.rewardItems_ do
		arg_10_0.rewardItems_[iter_10_2]:Show(false)
	end
end

function var_0_0.RefreshState(arg_12_0)
	local var_12_0 = arg_12_0:GetItemState()

	arg_12_0.stateCon_:SetSelectedState(var_12_0)
end

function var_0_0.GetItemState(arg_13_0)
	local var_13_0 = AssignmentCfg[arg_13_0.taskID_]
	local var_13_1 = ActivityNoobData:GetUnlockPhase()
	local var_13_2 = TaskData2:GetTask(arg_13_0.taskID_)
	local var_13_3 = var_13_2.progress or 0

	if var_13_1 < var_13_0.phase then
		arg_13_0.curState_ = var_0_1[1]
	elseif var_13_2.complete_flag >= 1 then
		arg_13_0.curState_ = var_0_1[4]
	elseif var_13_3 < var_13_0.need then
		arg_13_0.curState_ = var_0_1[3]
	else
		arg_13_0.curState_ = var_0_1[2]
	end

	return arg_13_0.curState_
end

return var_0_0
