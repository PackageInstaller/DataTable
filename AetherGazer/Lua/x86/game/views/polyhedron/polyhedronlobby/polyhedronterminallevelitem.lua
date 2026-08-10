local var_0_0 = class("PolyhedronTerminalLevelItem", ReduxView)

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

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	local var_5_0 = PolyhedronTerminalLevelCfg[arg_5_1]

	if arg_5_1 <= PolyhedronData:GetTerminalLevel() then
		arg_5_0.stateController:SetSelectedIndex(1)
	else
		arg_5_0.stateController:SetSelectedIndex(0)
	end

	arg_5_0.m_levelLab.text = arg_5_1
	arg_5_0.m_des.text = GetI18NText(var_5_0.des)

	local var_5_1 = arg_5_1 - 1
	local var_5_2 = PolyhedronTerminalLevelCfg[var_5_1] and PolyhedronTerminalLevelCfg[var_5_1].point or 0
	local var_5_3 = var_5_0.point - var_5_2
	local var_5_4

	if var_5_3 ~= 0 then
		var_5_4 = string.format(GetTips("POLYHEDRON_TERMINAL_LEVEL_POINT"), var_5_3)
	end

	if var_5_0.des and var_5_0.des ~= "" then
		if var_5_4 ~= nil then
			var_5_4 = var_5_4 .. " ;"
		end

		var_5_4 = GetI18NText(var_5_4) .. GetI18NText(var_5_0.des)
	end

	arg_5_0.m_des.text = GetI18NText(var_5_4)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
