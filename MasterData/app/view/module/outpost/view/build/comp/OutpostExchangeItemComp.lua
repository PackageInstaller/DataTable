local OutpostExchangeItemComp = class("OutpostExchangeItemComp", require("app.fairyGUI.outpost.UI_OutpostExchangeItemComp"))

function OutpostExchangeItemComp:updateItemComp(arg_1_1)
	if not arg_1_1 then
		self.m_emptyController:setSelectedIndex(0)
	else
		self.m_emptyController:setSelectedIndex(1)
		self.m_itemComp:updateItemIcon(arg_1_1)
		self.m_numTxt:setText(arg_1_1.item_num)
	end
end

return OutpostExchangeItemComp
