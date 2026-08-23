local var_0_1 = g.core.model.User.anniversaryData
local AnniversaryFloorIcon = class("AnniversaryFloorIcon", require("app.fairyGUI.anniversary.UI_AnniversaryFloorIcon"))

function AnniversaryFloorIcon:ctor()
	return
end

function AnniversaryFloorIcon:updateIcon(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	arg_2_1.scaleIndex = 4

	self.m_itemIcon:updateIcon(arg_2_1)
	self.m_iconLoader:setURL(arg_2_1.icon)
	self.m_numText:setText("x" .. arg_2_1.size)
	self.m_qualityLoader:setURL("ui://base_new/pic_xmhyjc_pinzhi_" .. arg_2_1.quality + 1)
	self.m_bg:setURL(var_0_1:getActivityResource("ui_cocos", "pic_xmhy_jianglikuang.png"))
	self.m_stateController:setSelectedIndex(arg_2_2)
end

return AnniversaryFloorIcon
