local var_0_0 = class("StrategyMatrixMapNode", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.node_id = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.typeController = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "event")
	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.selectController = ControllerUtil.GetController(arg_3_0.transform_, "select")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_btn, nil, function()
		local var_5_0 = arg_4_0:GetMatrixPhaseData():GetPhase()
		local var_5_1 = arg_4_0.state

		if var_5_0 == 1 and StrategyMatrixConst.NODE_STATE.SELECT == var_5_1 then
			if arg_4_0.callback_ then
				arg_4_0.callback_(arg_4_0.node_id)
			end

			return
		end

		if var_5_0 == 2 and StrategyMatrixConst.NODE_STATE.CURRENT == var_5_1 then
			if arg_4_0.callback_ then
				arg_4_0.callback_(arg_4_0.node_id)
			end

			return
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.matrix_activity_id = arg_6_1
	arg_6_0.event_id = arg_6_2.event_id
	arg_6_0.state = arg_6_2.state

	local var_6_0 = StrategyMatrixEventTemplateCfg[arg_6_0.event_id]

	if var_6_0 then
		local var_6_1 = var_6_0.event_type

		arg_6_0.typeController:SetSelectedIndex(var_6_1 - 1)

		arg_6_0.m_name.text = GetI18NText(var_6_0.name)
	end

	arg_6_0.stateController:SetSelectedIndex(arg_6_0.state - 1)

	if StrategyMatrixConst.NODE_STATE.INVALID == arg_6_0.state or StrategyMatrixConst.NODE_STATE.STATELESS == arg_6_0.state then
		manager.effect:SetGrey(arg_6_0.m_icon, true)
	else
		manager.effect:SetGrey(arg_6_0.m_icon, false)
	end
end

function var_0_0.SetSelect(arg_7_0, arg_7_1)
	arg_7_0.selectController:SetSelectedIndex(arg_7_1 and 1 or 0)
end

function var_0_0.GetNodeId(arg_8_0)
	return arg_8_0.node_id
end

function var_0_0.RegistCallBack(arg_9_0, arg_9_1)
	arg_9_0.callback_ = arg_9_1
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.GetMatrixPhaseData(arg_11_0)
	return StrategyMatrixData:GetMatrixPhaseData(arg_11_0.matrix_activity_id)
end

function var_0_0.GetTierID(arg_12_0)
	return StrategyMatrixData:GetTierID(arg_12_0.matrix_activity_id)
end

return var_0_0
