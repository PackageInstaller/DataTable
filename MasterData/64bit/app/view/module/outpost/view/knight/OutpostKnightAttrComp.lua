local OutpostKnightAttrComp = class("OutpostKnightAttrComp", require("app.fairyGUI.outpost.UI_OutpostKnightAttrComp"))

function OutpostKnightAttrComp:updateAttr(arg_1_1)
	self.m_nameTxt:setText(arg_1_1.name)
	self.m_valueTxt:setText(arg_1_1.value)
	self.m_attrIcon:setIcon(g.core.common.Path:getAttrIconByName(arg_1_1.icon))
end

return OutpostKnightAttrComp
