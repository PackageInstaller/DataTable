local var_0_0 = class("PuzzleNewTaskItem", ReduxView)
local var_0_1 = import("game.tools.JumpTools")

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
	arg_2_0.taskProgress = TaskData2:GetTask(arg_2_1).progress
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

	arg_4_0.controller_ = arg_4_0.controllerEx_:GetController("status")
	arg_4_0.typeController_ = ControllerUtil.GetController(arg_4_0.transform_, "type")
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		TaskAction:SubmitTaskList({
			arg_5_0.taskID_
		})
	end)
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = AssignmentCfg[arg_7_0.taskID_]

	arg_7_0.contentText_.text = var_7_0.desc

	arg_7_0:RefreshReward()
	arg_7_0:RefreshType()
	arg_7_0:RefreshProgress()
end

function var_0_0.RefreshReward(arg_8_0)
	if arg_8_0.commonItem_ == nil then
		arg_8_0.commonItem_ = CommonItemView.New(arg_8_0.rewardItemGo_, true)
	end

	arg_8_0.rewardCfg_ = AssignmentCfg[arg_8_0.taskID_].reward[1]

	local var_8_0 = clone(ItemTemplateData)

	var_8_0.id = arg_8_0.rewardCfg_[1]
	var_8_0.number = arg_8_0.rewardCfg_[2]

	function var_8_0.clickFun(arg_9_0)
		ShowPopItem(POP_ITEM, {
			arg_9_0.id,
			arg_9_0.number
		})
	end

	arg_8_0.commonItem_:SetData(var_8_0)
end

function var_0_0.RefreshProgress(arg_10_0)
	local var_10_0 = AssignmentCfg[arg_10_0.taskID_]
	local var_10_1 = arg_10_0.taskProgress

	if arg_10_0.taskProgress > var_10_0.need then
		var_10_1 = var_10_0.need
	end

	arg_10_0.progressSlider_.value = var_10_1 / var_10_0.need
	arg_10_0.progressText_.text = string.format("%s/%s", var_10_1, var_10_0.need)

	local var_10_2 = arg_10_0.taskProgress >= var_10_0.need

	if arg_10_0.taskComplete_ == true then
		arg_10_0.controller_:SetSelectedState("received")
	elseif var_10_2 then
		arg_10_0.controller_:SetSelectedState("completed")
	else
		arg_10_0.controller_:SetSelectedState("uncomplete")
	end
end

function var_0_0.RefreshType(arg_11_0)
	if AssignmentCfg[arg_11_0.taskID_].type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		arg_11_0.typeController_:SetSelectedState("daily")
	else
		arg_11_0.typeController_:SetSelectedState("challenge")
	end
end

return var_0_0
