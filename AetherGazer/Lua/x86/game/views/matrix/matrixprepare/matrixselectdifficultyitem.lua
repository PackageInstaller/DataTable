local var_0_0 = class("MatrixSelectDifficultyItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
	arg_1_0:AddUIListener()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController_ = ControllerUtil.GetController(arg_2_0.m_controller, "state")
	arg_2_0.difficultyController_ = ControllerUtil.GetController(arg_2_0.m_controller, "difficulty")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.m_clickBtn, nil, function()
		if arg_3_0.clickFunc then
			arg_3_0.clickFunc()
		end
	end)
end

function var_0_0.Refresh(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.stateController_:SetSelectedIndex(arg_5_2 and 1 or 0)
	arg_5_0.difficultyController_:SetSelectedIndex(arg_5_1 - 1)

	if arg_5_1 == 1 then
		arg_5_0.difficultText_.text = GetTips("HARDLEVEL_EASY")
	else
		arg_5_0.difficultText_.text = GetTips("HARDLEVEL_HARD")
	end
end

function var_0_0.RegistCallBack(arg_6_0, arg_6_1)
	arg_6_0.clickFunc = arg_6_1
end

return var_0_0
