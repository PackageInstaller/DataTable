local var_0_0 = class("XH1stSeamItemView", ReduxView)

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

	arg_3_0.itemController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "item")
	arg_3_0.itemtypeController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "itemtype")
	arg_3_0.commonItem_ = CommonItem.New(arg_3_0.commonItemGo_)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0.commonItem_:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, {
			arg_5_0.id,
			arg_5_0.number
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		local var_6_0 = AssignmentCfg[arg_4_0.assignmentId_]

		JumpTools.JumpToPage2(var_6_0.source)
	end)
	arg_4_0:AddBtnListener(arg_4_0.getBtn_, nil, function()
		TaskAction:SubmitTask(arg_4_0.assignmentId_)
	end)
end

function var_0_0.AddEventListeners(arg_8_0)
	return
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.index_ = arg_9_1
	arg_9_0.assignmentId_ = arg_9_2
	arg_9_0.assignmentCfg_ = AssignmentCfg[arg_9_2]

	arg_9_0:UpdateView()
end

function var_0_0.UpdateView(arg_10_0)
	arg_10_0.titleLabel_.text = GetI18NText(arg_10_0.assignmentCfg_.desc)

	local var_10_0 = TaskData2:GetTask(arg_10_0.assignmentId_).progress

	if var_10_0 > arg_10_0.assignmentCfg_.need then
		var_10_0 = arg_10_0.assignmentCfg_.need
	end

	arg_10_0.progressBar_.value = math.min(1, var_10_0 / arg_10_0.assignmentCfg_.need)
	arg_10_0.progressLabel_.text = var_10_0 .. "/" .. arg_10_0.assignmentCfg_.need

	arg_10_0.commonItem_:RefreshData({
		id = arg_10_0.assignmentCfg_.reward[1][1],
		number = arg_10_0.assignmentCfg_.reward[1][2]
	})

	if arg_10_0.assignmentCfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		arg_10_0.itemtypeController_:SetSelectedState("daily")
	elseif arg_10_0.assignmentCfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_CHALLENGE then
		arg_10_0.itemtypeController_:SetSelectedState("challenge")
	else
		arg_10_0.itemtypeController_:SetSelectedState("daily")
	end

	if TaskData2:GetTaskComplete(arg_10_0.assignmentId_) then
		arg_10_0.itemController_:SetSelectedState("received")
	elseif var_10_0 >= arg_10_0.assignmentCfg_.need then
		arg_10_0.itemController_:SetSelectedState("complete")
	else
		arg_10_0.itemController_:SetSelectedState("normal")
	end
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:AddEventListeners()
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.commonItem_ then
		arg_14_0.commonItem_:Dispose()

		arg_14_0.commonItem_ = nil
	end

	arg_14_0.data_ = nil

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
