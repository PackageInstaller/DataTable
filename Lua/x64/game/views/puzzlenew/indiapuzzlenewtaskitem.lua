local var_0_0 = class("IndiaPuzzleNewTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.rewardItems_ = {}
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.activityID_ = arg_2_2
	arg_2_0.taskID_ = arg_2_1
	arg_2_0.taskProgress = TaskData2:GetTaskProgress(arg_2_1)
	arg_2_0.taskComplete_ = TaskData2:GetTaskComplete(arg_2_1)

	arg_2_0:RefreshUI()
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0.commonItem_:Dispose()

	arg_3_0.commonItem_ = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitController()
end

function var_0_0.InitController(arg_5_0)
	arg_5_0.controller_ = ControllerUtil.GetController(arg_5_0.transform_, "state")
	arg_5_0.typeController_ = ControllerUtil.GetController(arg_5_0.transform_, "type")
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_6_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		TaskAction:SubmitTaskList({
			arg_6_0.taskID_
		})
	end)
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = AssignmentCfg[arg_8_0.taskID_]

	arg_8_0.desc_.text = var_8_0.desc

	arg_8_0:RefreshProgress()
	arg_8_0:RefreshReward()
	arg_8_0:RefreshType()
end

function var_0_0.RefreshReward(arg_9_0)
	arg_9_0.rewardCfg_ = AssignmentCfg[arg_9_0.taskID_].reward[1]

	if arg_9_0.commonItem_ == nil then
		arg_9_0.commonItem_ = CommonItemView.New(arg_9_0.rewardItem_, true)
		arg_9_0.itemData_ = clone(ItemTemplateData)

		function arg_9_0.itemData_.clickFun(arg_10_0)
			ShowPopItem(POP_ITEM, {
				arg_10_0.id,
				arg_10_0.number
			})
		end
	end

	arg_9_0.itemData_.id = arg_9_0.rewardCfg_[1]
	arg_9_0.itemData_.number = arg_9_0.rewardCfg_[2]

	arg_9_0.commonItem_:SetData(arg_9_0.itemData_)
	arg_9_0.commonItem_:RefreshGray(arg_9_0.taskComplete_ == true)
end

function var_0_0.RefreshProgress(arg_11_0)
	local var_11_0 = AssignmentCfg[arg_11_0.taskID_]
	local var_11_1 = arg_11_0.taskProgress

	if arg_11_0.taskProgress > var_11_0.need then
		var_11_1 = var_11_0.need
	end

	arg_11_0.slider_.value = var_11_1 / var_11_0.need
	arg_11_0.progress_.text = string.format("%s/%s", var_11_1, var_11_0.need)

	local var_11_2 = arg_11_0.taskProgress >= var_11_0.need

	if arg_11_0.taskComplete_ == true then
		arg_11_0.controller_:SetSelectedState("received")
	elseif var_11_2 then
		arg_11_0.controller_:SetSelectedState("complete")
	else
		arg_11_0.controller_:SetSelectedState("unfinish")
	end
end

function var_0_0.RefreshType(arg_12_0)
	if AssignmentCfg[arg_12_0.taskID_].type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		arg_12_0.typeController_:SetSelectedState("normal")
	else
		arg_12_0.typeController_:SetSelectedState("challenge")
	end
end

return var_0_0
