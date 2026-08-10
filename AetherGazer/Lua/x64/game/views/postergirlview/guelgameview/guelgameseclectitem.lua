local var_0_0 = class("GuelGameSeclectItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.stateControlller = arg_1_0.characterControllerexcollection_:GetController("state")
	arg_1_0.selControlller = arg_1_0.characterControllerexcollection_:GetController("sel")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		if arg_2_0.callback then
			arg_2_0.callback()
		end
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.data = arg_4_1

	if arg_4_1.color then
		arg_4_0.colorControlller:SetSelectedState(arg_4_1.color)
	else
		arg_4_0.colorControlller:SetSelectedState("none")
	end
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.SetClickCallback(arg_6_0, arg_6_1)
	arg_6_0.callback = arg_6_1
end

function var_0_0.UpdateSelect(arg_7_0, arg_7_1)
	arg_7_0.selControlller:SetSelectedState(arg_7_1 and "on" or "off")
end

function var_0_0.UpdateCamp(arg_8_0, arg_8_1)
	local var_8_0 = {
		"normal",
		"selectD",
		"selectM"
	}

	arg_8_0.stateControlller:SetSelectedState(var_8_0[arg_8_1] and var_8_0[arg_8_1] or var_8_0[1])

	if arg_8_1 ~= 1 then
		arg_8_0.ani_:Play("characterSelect", 0, 0)
	end
end

function var_0_0.OnExit(arg_9_0)
	var_0_0.super.OnExit(arg_9_0)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
