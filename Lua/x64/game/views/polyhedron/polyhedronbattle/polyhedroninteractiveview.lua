local var_0_0 = class("PolyhedronInteractiveView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/PolyhedronBattle/PolyhedronInteractiveUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_btn, nil, function()
		PolyhedronAction.QuerySelectStagePolyhedron(arg_5_0.index)
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.index = arg_7_0.params_.index

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()

	local var_8_0 = arg_8_0.polyhedronInfo:GetGateData(arg_8_0.index)
	local var_8_1 = var_8_0.id
	local var_8_2 = var_8_0.reward_type
	local var_8_3 = PolyhedronTools.GetGateCfg(var_8_1, var_8_2)

	arg_8_0.m_des.text = GetI18NText(var_8_3.gate_des)

	local var_8_4 = arg_8_0.polyhedronInfo:GetTierId()
	local var_8_5 = var_8_4 + 1
	local var_8_6 = PolyhedronTierCfg[var_8_5]

	if var_8_6 == nil then
		local var_8_7 = PolyhedronTierCfg[var_8_4].tier

		if PolyhedronTierCfg.get_id_list_by_tier[var_8_7 + 1] then
			local var_8_8 = PolyhedronTierCfg.get_id_list_by_tier[var_8_7 + 1][1]

			var_8_6 = PolyhedronTierCfg[var_8_8]
		end
	end

	if var_8_6 then
		if var_8_3.gate_title then
			arg_8_0.m_btnLab.text = string.format(GetI18NText(var_8_3.gate_title), GetI18NText(var_8_6.tier), var_8_6.level)
		else
			arg_8_0.m_btnLab.text = GetTips("GO_UP_TO") .. GetI18NText(var_8_6.tier) .. "-" .. var_8_6.level
		end
	else
		arg_8_0.m_btnLab.text = GetTips("GO_UP_TO")
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.m_desTrs)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.m_contentTrs)
	TimeTools.StartAfterSeconds(0.1, function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.m_desTrs)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.m_contentTrs)
	end, {})
end

return var_0_0
