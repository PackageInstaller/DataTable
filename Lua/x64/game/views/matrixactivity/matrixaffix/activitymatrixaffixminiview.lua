local var_0_0 = class("ActivityMatrixAffixMiniView", MatrixAffixMiniView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIUI/SoloRoguelike/ActivityMatrixAffixMiniUI"
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0.matrix_activity_id = arg_2_0.params_.matrix_activity_id
	arg_2_0.regularData = {}
	arg_2_0.customData = ActivityMatrixData:GetCustomAffix(arg_2_0.matrix_activity_id) or {}

	arg_2_0:Refresh()
end

function var_0_0.Refresh(arg_3_0)
	arg_3_0:RefreshRegularItems(arg_3_0.regularData)

	local var_3_0 = #arg_3_0.customData

	arg_3_0.stateController_:SetSelectedIndex(var_3_0 == 0 and 1 or 0)
	arg_3_0:RefreshCustomItems(arg_3_0.customData)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.m_contentRect)

	local var_3_1 = 0
	local var_3_2 = 0

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.regularData) do
		local var_3_3 = ActivityAffixPoolCfg[iter_3_1]

		var_3_1 = var_3_1 + var_3_3.point
		var_3_2 = var_3_2 + var_3_3.multiple
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_0.customData) do
		local var_3_4 = ActivityAffixPoolCfg[iter_3_3]

		var_3_1 = var_3_1 + var_3_4.point
		var_3_2 = var_3_2 + var_3_4.multiple
	end

	local var_3_5 = var_3_2 / 10

	arg_3_0.m_scoreLab.text = "" .. var_3_1
	arg_3_0.m_retaLab.text = string.format(GetTips("MATRIX_AFFIX_RATE"), var_3_5 .. "%")
end

return var_0_0
