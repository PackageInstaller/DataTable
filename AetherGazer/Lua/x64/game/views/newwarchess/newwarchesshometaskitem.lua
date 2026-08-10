local var_0_0 = class("NewWarChessHomeTaskItem", ReduxView)

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

	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.transform_, "ismain")
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.taskID_ = arg_4_1

	arg_4_0:UpdateView()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		local var_6_0 = NewWarChessTaskPoolCfg[arg_5_0.taskID_].clickevent

		if var_6_0 ~= 0 then
			local var_6_1 = NewChessTools.ParseParameterLua(var_6_0)

			manager.NewChessManager:ExecutChess(NewChessConst.TIMING_INTERACT, nil, var_6_1)
			manager.NewChessManager:StartExecuteEvent()
		end
	end)
end

function var_0_0.UpdateView(arg_7_0)
	local var_7_0 = NewWarChessTaskPoolCfg[arg_7_0.taskID_]

	if var_7_0.type == NewChessConst.TASKTYPE.NORMAL then
		arg_7_0.controller_:SetSelectedState("false")
	else
		arg_7_0.controller_:SetSelectedState("true")
	end

	local var_7_1 = manager.NewChessManager.taskManager_:GetTaskInfo(arg_7_0.taskID_)

	arg_7_0.nameText_.text = var_7_0.description

	if var_7_0.hide_need == 1 then
		SetActive(arg_7_0.progressText_.gameObject, false)
	else
		SetActive(arg_7_0.progressText_.gameObject, true)

		arg_7_0.progressText_.text = var_7_1.cur .. "/" .. var_7_1.need
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.contentTrans_)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
