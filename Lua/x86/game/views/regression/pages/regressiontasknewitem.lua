local var_0_0 = class("RegressionTaskNewItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.rewardItems_ = {}
	arg_1_0.itemDataList_ = {}
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.isShow_ = true

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.ReEnter(arg_2_0, arg_2_1, arg_2_2)
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

	arg_4_0.itemDataList_ = nil

	for iter_4_0, iter_4_1 in pairs(arg_4_0.rewardItems_) do
		iter_4_1:Dispose()
	end

	arg_4_0.rewardItems_ = nil

	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.gameObject_ = nil

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.controller_ = ControllerUtil.GetController(arg_5_0.transform_, "conName")
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.goBtn_, nil, function()
		OperationRecorder.Record(arg_6_0.class.__cname, "goBtn")

		local var_7_0 = AssignmentCfg[arg_6_0.taskID_]

		JumpTools.JumpToPage2(var_7_0.source)
	end)
	arg_6_0:AddBtnListener(arg_6_0.receiveBtn_, nil, function()
		OperationRecorder.Record(arg_6_0.class.__cname, "receiveBtnBtn")
		TaskAction:SubmitTask(arg_6_0.taskID_)
	end)
end

function var_0_0.RemoveListeners(arg_9_0)
	arg_9_0.goBtn_.onClick:RemoveAllListeners()
	arg_9_0.receiveBtn_.onClick:RemoveAllListeners()
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = AssignmentCfg[arg_10_0.taskID_]

	arg_10_0.titleText_.text = GetI18NText(var_10_0.desc)

	arg_10_0:RefreshReward()
end

function var_0_0.RefreshReward(arg_11_0)
	local var_11_0 = AssignmentCfg[arg_11_0.taskID_].reward or {}

	for iter_11_0 = 1, 3 do
		local var_11_1 = var_11_0[iter_11_0]

		if not arg_11_0.itemDataList_[iter_11_0] then
			arg_11_0.itemDataList_[iter_11_0] = clone(ItemTemplateData)
			arg_11_0.itemDataList_[iter_11_0].clickFun = function(arg_12_0)
				ShowPopItem(POP_ITEM, {
					arg_12_0.id,
					arg_12_0.number
				})
			end
		end

		local var_11_2 = true

		if var_11_1 then
			arg_11_0.itemDataList_[iter_11_0].id = var_11_1[1]
			arg_11_0.itemDataList_[iter_11_0].number = var_11_1[2]
			var_11_2 = false
		end

		if arg_11_0.rewardItems_[iter_11_0] == nil then
			arg_11_0.rewardItems_[iter_11_0] = CommonItemPool.New(arg_11_0.goRewardPanel_, nil, true)
		end

		arg_11_0.rewardItems_[iter_11_0]:Show(true)

		if not var_11_2 then
			arg_11_0.rewardItems_[iter_11_0]:SetData(arg_11_0.itemDataList_[iter_11_0])
		else
			arg_11_0.rewardItems_[iter_11_0]:SetData(nil)
		end
	end

	for iter_11_1 = arg_11_0.maxRewardNum_ + 1, #arg_11_0.rewardItems_ do
		arg_11_0.rewardItems_[iter_11_1]:Show(false)
	end
end

function var_0_0.RefreshProgress(arg_13_0)
	local var_13_0 = AssignmentCfg[arg_13_0.taskID_]
	local var_13_1 = arg_13_0.taskProgress

	if arg_13_0.taskProgress > var_13_0.need then
		var_13_1 = var_13_0.need
	end

	arg_13_0.progressBar_.value = var_13_1 / var_13_0.need
	arg_13_0.progressText_.text = string.format("%s/%s", var_13_1, var_13_0.need)

	local var_13_2 = arg_13_0.taskProgress >= var_13_0.need

	if arg_13_0.taskComplete_ then
		arg_13_0.controller_:SetSelectedState("2")
	elseif var_13_2 then
		arg_13_0.controller_:SetSelectedState("1")
	else
		arg_13_0.controller_:SetSelectedState("0")
	end
end

function var_0_0.SetSibling(arg_14_0, arg_14_1)
	local var_14_0 = AssignmentCfg[arg_14_0.taskID_]

	if var_14_0.condition == GameSetting.task_top_type.value[1] and var_14_0.additional_parameter[1] == TaskConst.TASK_TYPE.DAILY then
		arg_14_0.transform_:SetSiblingIndex(0)
	else
		arg_14_0.transform_:SetSiblingIndex(arg_14_1)
	end
end

return var_0_0
