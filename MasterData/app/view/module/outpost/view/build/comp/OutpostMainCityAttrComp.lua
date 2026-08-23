local OutpostMainCityAttrComp = class("OutpostMainCityAttrComp", require("app.fairyGUI.outpost.UI_OutpostMainCityAttrComp"))

function OutpostMainCityAttrComp:updateAttrComp(arg_1_1, arg_1_2)
	self.m_curNumTxt:setText(arg_1_1)
	self.m_nextNumTxt:setText(arg_1_2)

	if arg_1_1 == arg_1_2 then
		self.m_singleModeController:setSelectedIndex(1)
	else
		self.m_singleModeController:setSelectedIndex(0)
	end
end

return OutpostMainCityAttrComp
