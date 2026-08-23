local var_0_0 = g.core.model.User.allianceTrialData
local AllianceTrialPreviewCell = class("AllianceTrialPreviewCell", require("app.fairyGUI.allianceTrial.UI_AllianceTrialPreviewCell"))

function AllianceTrialPreviewCell:updatePreviewCell(arg_1_1)
	self.m_isBigController:setSelectedIndex(arg_1_1.grand_prize == 1 and 1 or 0)
	self.m_itemIcon:updateIcon({
		type = arg_1_1.type,
		value = arg_1_1.value,
		size = arg_1_1.size
	})
	self.m_itemNum:setText(g.core.lang:get(430411, {
		cur = var_0_0:getBoxRewardNum(arg_1_1.level, arg_1_1.id),
		max = arg_1_1.max_num
	}))
	self.m_boxTypeController:setSelectedIndex(arg_1_1.box_type)
end

return AllianceTrialPreviewCell
