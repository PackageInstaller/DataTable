local var_0_0 = class("MatrixTerminalLevelUpgradeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Matrix/Terminal/MatrixTerminalLevelUpgradeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.desController_ = ControllerUtil.GetController(arg_4_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_maskBtn, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	local var_7_0 = arg_7_0.params_.newLv
	local var_7_1 = MatrixTerminalLevelCfg[var_7_0]

	arg_7_0.m_levelLab.text = "" .. var_7_0
	arg_7_0.m_giftLab.text = var_7_1.point

	if var_7_1.desc and var_7_1.desc ~= "" then
		arg_7_0.desController_:SetSelectedIndex(1)

		arg_7_0.m_desLab.text = GetI18NText(var_7_1.desc)
	else
		arg_7_0.desController_:SetSelectedIndex(0)
	end
end

return var_0_0
