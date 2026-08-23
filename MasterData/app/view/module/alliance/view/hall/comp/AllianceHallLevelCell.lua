local AllianceHallLevelCell = class("AllianceHallLevelCell", require("app.fairyGUI.alliance.UI_AllianceHallLevelCell"))

function AllianceHallLevelCell:updateLevelCell(arg_1_1, arg_1_2)
	self.m_showBgController:setSelectedIndex(1 - arg_1_1 % 2)
	self.m_level:setText(g.core.lang:get(2052, {
		level = arg_1_1
	}))
	self.m_num1:setText(arg_1_2[1].num_amend)
	self.m_num2:setText(arg_1_2[2].num_amend)
end

return AllianceHallLevelCell
