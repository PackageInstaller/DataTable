local var_0_0 = class("RegressionTaskItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.isShow_ = true

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.taskID_ = arg_2_1
	arg_2_0.maxRewardNum_ = arg_2_2
	arg_2_0.taskProgress = TaskData2:GetTaskProgress(arg_2_1)
	arg_2_0.taskComplete_ = TaskData2:GetTaskComplete(arg_2_1)

	arg_2_0:RefreshUI()
	arg_2_0:RefreshProgress()

	arg_2_0.isShow_ = true
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0.isShow_ = false

	SetActive(arg_3_0.gameObject_, false)
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0:RemoveListeners()
	arg_4_0.rewardItem:Dispose()
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.gameObject_ = nil

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.itemData = clone(ItemTemplateData)
	arg_5_0.controller_ = ControllerUtil.GetController(arg_5_0.transform_, "conName")
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.receiveBtn_, nil, function()
		OperationRecorder.Record(arg_6_0.class.__cname, "receiveBtnBtn")
		TaskAction:SubmitTask(arg_6_0.taskID_)
	end)
end

function var_0_0.RemoveListeners(arg_8_0)
	arg_8_0.receiveBtn_.onClick:RemoveAllListeners()
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = AssignmentCfg[arg_9_0.taskID_]

	arg_9_0.titleText_.text = GetI18NText(var_9_0.desc)

	arg_9_0:RefreshReward()
end

function var_0_0.RefreshReward(arg_10_0)
	local var_10_0 = AssignmentCfg[arg_10_0.taskID_].reward or {}
	local var_10_1 = arg_10_0.itemData

	var_10_1.id = var_10_0[1][1]
	var_10_1.number = var_10_0[1][2]

	function var_10_1.clickFun(arg_11_0)
		ShowPopItem(POP_ITEM, {
			var_10_1.id,
			var_10_1.number
		})
	end

	arg_10_0.rewardItem = CommonItemView.New(arg_10_0.rewardGo_)

	arg_10_0.rewardItem:Show(true)
	arg_10_0.rewardItem:SetData(var_10_1)
end

function var_0_0.RefreshProgress(arg_12_0)
	local var_12_0 = AssignmentCfg[arg_12_0.taskID_]
	local var_12_1 = arg_12_0.taskProgress

	if arg_12_0.taskProgress > var_12_0.need then
		var_12_1 = var_12_0.need
	end

	arg_12_0.progressBar_.value = var_12_1 / var_12_0.need
	arg_12_0.progressText_.text = string.format("%s/%s", var_12_1, var_12_0.need)

	local var_12_2 = arg_12_0.taskProgress >= var_12_0.need

	if arg_12_0.taskComplete_ then
		arg_12_0.controller_:SetSelectedState("2")
	elseif var_12_2 then
		arg_12_0.controller_:SetSelectedState("1")
	else
		arg_12_0.controller_:SetSelectedState("0")
	end
end

function var_0_0.SetSibling(arg_13_0, arg_13_1)
	local var_13_0 = AssignmentCfg[arg_13_0.taskID_]

	if var_13_0.condition == GameSetting.task_top_type.value[1] and var_13_0.additional_parameter[1] == TaskConst.TASK_TYPE.DAILY then
		arg_13_0.transform_:SetSiblingIndex(0)
	else
		arg_13_0.transform_:SetSiblingIndex(arg_13_1)
	end
end

return var_0_0
