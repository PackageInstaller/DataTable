local PolyhedronInteractiveView = class("PolyhedronInteractiveView", ReduxView)

function PolyhedronInteractiveView:UIName()
	return "Widget/System/PolyhedronBattle/PolyhedronInteractiveUI"
end

function PolyhedronInteractiveView:UIParent()
	return manager.ui.uiMain.transform
end

function PolyhedronInteractiveView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronInteractiveView:InitUI()
	self:BindCfgUI()
end

function PolyhedronInteractiveView:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		PolyhedronAction.QuerySelectStagePolyhedron(self.index)
	end)
end

function PolyhedronInteractiveView:OnEnter()
	self.index = self.params_.index

	self:RefreshUI()
end

function PolyhedronInteractiveView:RefreshUI()
	self.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()

	local var_8_0 = self.polyhedronInfo:GetGateData(self.index)
	local var_8_1 = PolyhedronTools.GetGateCfg(var_8_0.id, var_8_0.reward_type)

	self.m_des.text = GetI18NText(var_8_1.gate_des)

	local var_8_2 = self.polyhedronInfo:GetTierId()
	local var_8_3 = PolyhedronTierCfg[var_8_2 + 1]

	if PolyhedronTierCfg[var_8_2 + 1] == nil then
		if PolyhedronTierCfg.get_id_list_by_tier[PolyhedronTierCfg[var_8_2].tier + 1] then
			var_8_3 = PolyhedronTierCfg[PolyhedronTierCfg.get_id_list_by_tier[PolyhedronTierCfg[var_8_2].tier + 1][1]]
		end
	end

	self.m_btnLab.text = var_8_3 and (var_8_1.gate_title and string.format(GetI18NText(var_8_1.gate_title), GetI18NText(var_8_3.tier), var_8_3.level) or GetTips("GO_UP_TO") .. GetI18NText(var_8_3.tier) .. "-" .. var_8_3.level) or GetTips("GO_UP_TO")

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_desTrs)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_contentTrs)
	TimeTools.StartAfterSeconds(0.1, function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_desTrs)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_contentTrs)
	end, {})
end

return PolyhedronInteractiveView
