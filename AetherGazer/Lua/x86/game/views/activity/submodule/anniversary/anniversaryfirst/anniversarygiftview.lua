local var_0_0 = class("AnniversaryGiftView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0:UpdateItem()

	arg_2_0.onSubmitResponse = handler(arg_2_0, arg_2_0.RefreshBtnState)

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_2_0.onSubmitResponse)
end

function var_0_0.OnExit(arg_3_0)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_3_0.onSubmitResponse)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.button_, nil, function()
		TaskAction:SubmitTask(arg_4_0.taskID_)
	end)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.UpdateItem(arg_7_0)
	local var_7_0 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_2_0_ANNIVERSARY_EXTRA_TASK][1]

	arg_7_0.taskID_ = var_7_0

	local var_7_1 = AssignmentCfg[var_7_0]
	local var_7_2 = TaskData2:GetTask(var_7_0)

	if var_7_2 == nil then
		return
	end

	arg_7_0.cntText_.text = string.format("%s/%s", var_7_2.progress > var_7_1.need and var_7_1.need or var_7_2.progress, var_7_1.need)
	arg_7_0.sliderImage_.fillAmount = var_7_2.progress / var_7_1.need

	arg_7_0:RefreshBtnState()
end

function var_0_0.RefreshBtnState(arg_8_0)
	local var_8_0 = arg_8_0.taskID_
	local var_8_1 = AssignmentCfg[var_8_0]
	local var_8_2 = TaskData2:GetTask(var_8_0)

	if var_8_2.complete_flag == 0 then
		if var_8_2.progress >= var_8_1.need then
			arg_8_0.controller_:SetSelectedState("complete")
		else
			arg_8_0.controller_:SetSelectedState("uncomplate")
		end
	elseif var_8_2.complete_flag >= 1 then
		arg_8_0.controller_:SetSelectedState("finish")
	end
end

return var_0_0
