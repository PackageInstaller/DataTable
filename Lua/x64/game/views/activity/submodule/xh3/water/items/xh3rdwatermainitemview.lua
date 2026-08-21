local var_0_0 = class("XH3rdWaterMainItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "status")
	arg_3_0.typeController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "type")
	arg_3_0.commonItem_ = CommonItem.New(arg_3_0.rewardItem_)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0.commonItem_:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, {
			arg_5_0.id,
			arg_5_0.number
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_4_0.activityId_) then
			return
		end

		TaskAction:SubmitTask(arg_4_0.assignmentId_)
	end)
end

function var_0_0.AddEventListeners(arg_7_0)
	return
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.index_ = arg_8_1
	arg_8_0.assignmentId_ = arg_8_2
	arg_8_0.assignmentCfg_ = AssignmentCfg[arg_8_2]
	arg_8_0.activityId_ = arg_8_3

	arg_8_0:UpdateView()
end

function var_0_0.UpdateView(arg_9_0)
	if arg_9_0.assignmentCfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		arg_9_0.typeController_:SetSelectedState("daily")
	elseif arg_9_0.assignmentCfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_CHALLENGE then
		arg_9_0.typeController_:SetSelectedState("challenge")
	else
		arg_9_0.typeController_:SetSelectedState("daily")
	end

	arg_9_0.desc_.text = arg_9_0.assignmentCfg_.desc

	local var_9_0 = TaskData2:GetTask(arg_9_0.assignmentId_)
	local var_9_1 = 0

	if var_9_0 then
		var_9_1 = var_9_0.progress
	end

	if var_9_1 > arg_9_0.assignmentCfg_.need then
		var_9_1 = arg_9_0.assignmentCfg_.need
	end

	arg_9_0.slider_.value = math.min(1, var_9_1 / arg_9_0.assignmentCfg_.need)
	arg_9_0.progress_.text = var_9_1 .. "/" .. arg_9_0.assignmentCfg_.need

	local var_9_2 = formatReward(arg_9_0.assignmentCfg_.reward[1])
	local var_9_3 = rewardToItemTemplate(var_9_2)

	arg_9_0.commonItem_:RefreshData(var_9_3)

	if not ActivityData:GetActivityIsOpen(arg_9_0.activityId_) then
		arg_9_0.statusController_:SetSelectedState("gray")
	elseif var_9_0 ~= nil and TaskData2:GetTaskComplete(arg_9_0.assignmentId_) then
		arg_9_0.statusController_:SetSelectedState("received")
	elseif var_9_1 >= arg_9_0.assignmentCfg_.need then
		arg_9_0.statusController_:SetSelectedState("complete")
	else
		arg_9_0.statusController_:SetSelectedState("unfinish")
	end
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:AddEventListeners()
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_12_0)
	return
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.commonItem_ then
		arg_13_0.commonItem_:Dispose()

		arg_13_0.commonItem_ = nil
	end

	arg_13_0.data_ = nil

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
