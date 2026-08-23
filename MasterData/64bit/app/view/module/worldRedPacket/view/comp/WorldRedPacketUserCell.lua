local WorldRedPacketUserCell = class("WorldRedPacketUserCell", require("app.fairyGUI.worldRedPacket.UI_WorldRedPacketUserCell"))

function WorldRedPacketUserCell:updateCell(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.m_stateController:setSelectedIndex(arg_1_4 and 1 or 0)
	self.m_userName:setText(arg_1_2.name)
	self.m_awardNum:setText(g.core.lang:get(109066, {
		num = arg_1_3
	}))
	self.m_userIcon:updateAsUser(arg_1_2)
	self.m_awardIcon:setURL(arg_1_1.icon_mini)
end

return WorldRedPacketUserCell
