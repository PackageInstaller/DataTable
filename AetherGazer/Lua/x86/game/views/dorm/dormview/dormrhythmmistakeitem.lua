local var_0_0 = class("DormRhythmMistakeItem", ReduxView)

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

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.touchbtnBtn_.gameObject.transform, "state")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	if arg_4_1 then
		arg_4_0.stateController:SetSelectedState("true")
	else
		arg_4_0.stateController:SetSelectedState("false")
	end
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
