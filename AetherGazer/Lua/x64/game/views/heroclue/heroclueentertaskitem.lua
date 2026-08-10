local var_0_0 = class("HeroClueEnterTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitController()
	arg_2_0:InitReward()
end

function var_0_0.InitController(arg_3_0)
	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.typeController_ = ControllerUtil.GetController(arg_3_0.transform_, "type")
end

function var_0_0.InitReward(arg_4_0)
	arg_4_0.rewardItem_ = CommonItemView.New(arg_4_0.rewardItemGo_, true)
	arg_4_0.itemData_ = clone(ItemTemplateData)

	function arg_4_0.itemData_.clickFun(arg_5_0)
		ShowPopItem(POP_ITEM, {
			arg_5_0.id,
			arg_5_0.number
		})
	end
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

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.activityID_ = arg_8_2
	arg_8_0.taskID_ = arg_8_1
	arg_8_0.taskProgress_ = TaskData2:GetTask(arg_8_1).progress
	arg_8_0.taskComplete_ = TaskData2:GetTaskComplete(arg_8_1)

	arg_8_0:RefreshUI()
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.rewardItem_:Dispose()
	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0:RefreshReward()
	arg_10_0:RefreshProgress()
	arg_10_0:RefreshType()
	arg_10_0:RefreshDesc()
end

function var_0_0.RefreshReward(arg_11_0)
	local var_11_0 = AssignmentCfg[arg_11_0.taskID_].reward or {}

	arg_11_0.itemData_.id = var_11_0[1][1]
	arg_11_0.itemData_.number = var_11_0[1][2]

	arg_11_0.rewardItem_:SetData(arg_11_0.itemData_)
	arg_11_0.rewardItem_:RefreshGray(arg_11_0.taskComplete_ == true)
end

function var_0_0.RefreshProgress(arg_12_0)
	local var_12_0 = AssignmentCfg[arg_12_0.taskID_]
	local var_12_1 = arg_12_0.taskProgress_

	if arg_12_0.taskProgress_ > var_12_0.need then
		var_12_1 = var_12_0.need
	end

	if arg_12_0.slider_ then
		arg_12_0.slider_.value = var_12_1 / var_12_0.need
	end

	if arg_12_0.progress_ then
		arg_12_0.progress_.text = string.format("%s/%s", var_12_1, var_12_0.need)
	end

	local var_12_2 = arg_12_0.taskProgress_ >= var_12_0.need

	if arg_12_0.taskComplete_ == true then
		arg_12_0.statusController_:SetSelectedState("received")
	elseif var_12_2 then
		arg_12_0.statusController_:SetSelectedState("complete")
	else
		arg_12_0.statusController_:SetSelectedState("unfinish")
	end
end

function var_0_0.RefreshType(arg_13_0)
	if arg_13_0.typeController_ then
		if AssignmentCfg[arg_13_0.taskID_].type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
			arg_13_0.typeController_:SetSelectedState("normal")
		else
			arg_13_0.typeController_:SetSelectedState("challenge")
		end
	end
end

function var_0_0.RefreshDesc(arg_14_0)
	local var_14_0 = AssignmentCfg[arg_14_0.taskID_]

	arg_14_0.desc_.text = var_14_0.desc
end

return var_0_0
