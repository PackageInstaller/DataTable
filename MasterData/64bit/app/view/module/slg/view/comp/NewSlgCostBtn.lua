local NewSlgCostBtn = class("NewSlgCostBtn", require("app.fairyGUI.newSlg.UI_NewSlgCommonCostBtn"))

function NewSlgCostBtn:updateCost(arg_1_1, arg_1_2, arg_1_3)
	self.m_itemIcon:setURL(arg_1_1.icon_mini)

	if not arg_1_3 then
		self.m_costTxt:setText(arg_1_2)
	else
		self.m_costTxt:setText(arg_1_2 .. "/" .. arg_1_3)

		if arg_1_3 < arg_1_2 then
			self.m_resEnoughController:setSelectedIndex(1)
		else
			self.m_resEnoughController:setSelectedIndex(0)
		end
	end
end

return NewSlgCostBtn
