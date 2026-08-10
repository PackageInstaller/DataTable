local var_0_0 = class("MatrixTerminalLevelView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Matrix/Terminal/MatrixTerminalTalentPreviewUI"
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
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_maskBtn, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.id = arg_7_0.params_.id
	arg_7_0.lv = arg_7_0.params_.lv

	local var_7_0 = MatrixTerminalGiftCfg[arg_7_0.id]

	arg_7_0.m_nameLab.text = GetI18NText(var_7_0.name)
	arg_7_0.m_curLevel.text = arg_7_0.lv

	local var_7_1 = arg_7_0.lv + 1

	arg_7_0.m_nextLevel.text = var_7_1

	local var_7_2 = var_7_0.desc_list[var_7_1]

	arg_7_0.m_desLab.text = MatrixDescCfg[var_7_2] and GetI18NText(MatrixDescCfg[var_7_2].desc) or ""
end

return var_0_0
