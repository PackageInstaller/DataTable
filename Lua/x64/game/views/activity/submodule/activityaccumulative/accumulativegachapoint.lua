local var_0_0 = class("AccumulativeGachaPoint", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.controller_ = arg_1_0.lastControllerexcollection_:GetController("default0")
end

function var_0_0.SetIsDraw(arg_2_0, arg_2_1)
	if arg_2_1 then
		arg_2_0.controller_:SetSelectedState("light")
	else
		arg_2_0.controller_:SetSelectedState("normal")
	end
end

function var_0_0.SetPosX(arg_3_0, arg_3_1)
	if arg_3_0.gameObject_ then
		arg_3_0.transform_.localPosition = Vector3.New(arg_3_1, 0, 0)
	end
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
