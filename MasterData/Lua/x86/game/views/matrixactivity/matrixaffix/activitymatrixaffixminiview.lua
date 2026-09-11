local ActivityMatrixAffixMiniView = class("ActivityMatrixAffixMiniView", MatrixAffixMiniView)

function ActivityMatrixAffixMiniView:UIName()
	return "UI/VolumeIIIUI/SoloRoguelike/ActivityMatrixAffixMiniUI"
end

function ActivityMatrixAffixMiniView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id
	self.regularData = {}
	self.customData = ActivityMatrixData:GetCustomAffix(self.matrix_activity_id) or {}

	self:Refresh()
end

function ActivityMatrixAffixMiniView:Refresh()
	self:RefreshRegularItems(self.regularData)
	self.stateController_:SetSelectedIndex(#self.customData == 0 and 1 or 0)
	self:RefreshCustomItems(self.customData)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_contentRect)

	local var_3_0 = 0
	local var_3_1 = 0

	for iter_3_0, iter_3_1 in ipairs(self.regularData) do
		var_3_0 = var_3_0 + ActivityAffixPoolCfg[iter_3_1].point
		var_3_1 = var_3_1 + ActivityAffixPoolCfg[iter_3_1].multiple
	end

	for iter_3_2, iter_3_3 in ipairs(self.customData) do
		var_3_0 = var_3_0 + ActivityAffixPoolCfg[iter_3_3].point
		var_3_1 = var_3_1 + ActivityAffixPoolCfg[iter_3_3].multiple
	end

	self.m_scoreLab.text = "" .. var_3_0
	self.m_retaLab.text = string.format(GetTips("MATRIX_AFFIX_RATE"), var_3_1 / 10 .. "%")
end

return ActivityMatrixAffixMiniView
