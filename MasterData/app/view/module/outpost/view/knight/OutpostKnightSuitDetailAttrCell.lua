local OutpostKnightSuitDetailAttrCell = class("OutpostKnightSuitDetailAttrCell", require("app.fairyGUI.outpost.UI_OutpostKnightSuitDetailAttrCell"))

function OutpostKnightSuitDetailAttrCell:updateAttr(arg_1_1)
	self.m_descTxt:setText(arg_1_1)
end

return OutpostKnightSuitDetailAttrCell
