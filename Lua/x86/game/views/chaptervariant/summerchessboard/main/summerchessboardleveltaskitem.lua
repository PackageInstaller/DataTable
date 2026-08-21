local var_0_0 = class("SummerChessBoardLevelTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.tipsController = arg_3_0.tipsControllerEx_:GetController("showState")
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	local var_4_0 = AssignmentCfg[arg_4_1]

	arg_4_0.titleText_.text = var_4_0.desc
	arg_4_0.nameText_.text = var_4_0.name

	local var_4_1 = TaskData2:GetTask(arg_4_1)

	if var_4_0.need > var_4_1.progress then
		arg_4_0.tipsController:SetSelectedState("normal")
	else
		arg_4_0.tipsController:SetSelectedState("finish")
	end
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
