local OutpostKnightAttrCell = class("OutpostKnightAttrCell", require("app.fairyGUI.outpost.UI_OutpostKnightAttrCell"))

function OutpostKnightAttrCell:updateAttr(arg_1_1)
	self.m_name:setText(arg_1_1.name)
	self.m_value:setText(arg_1_1.value)
end

return OutpostKnightAttrCell
