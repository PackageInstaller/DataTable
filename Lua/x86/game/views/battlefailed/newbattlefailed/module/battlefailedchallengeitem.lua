local var_0_0 = class("BattleFailedChallengeItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddUIListener()

	arg_1_0.stateController = arg_1_0.controllerEx_:GetController("state")

	if arg_1_2 == 1 then
		arg_1_0.stateController:SetSelectedIndex(0)
	end
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		if arg_2_0.clickFunc then
			arg_2_0.clickFunc(arg_2_0.index)
		end
	end)
end

function var_0_0.OnRenderItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:Show(true)

	arg_4_0.typeImg_.sprite = arg_4_1
	arg_4_0.index = arg_4_2

	if arg_4_2 == 1 then
		arg_4_0.stateController:SetSelectedIndex(0)
	else
		arg_4_0.stateController:SetSelectedIndex(1)
	end
end

function var_0_0.RegistCallBack(arg_5_0, arg_5_1)
	arg_5_0.clickFunc = arg_5_1
end

function var_0_0.RefreshState(arg_6_0, arg_6_1)
	if arg_6_1 == arg_6_0.index then
		arg_6_0.stateController:SetSelectedIndex(0)
	else
		arg_6_0.stateController:SetSelectedIndex(1)
	end
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
