local var_0_0 = g.core.common.Path
local FurnitureAttributeCell = class("FurnitureAttributeCell", require("app.fairyGUI.furniture.UI_FurnitureAttributeCell"))

function FurnitureAttributeCell:updateCell(arg_1_1, arg_1_2)
	local var_1_0, var_1_1 = g.core.lang:getAttr(arg_1_1, arg_1_2, true)

	self.m_nameTxt:setText((g.core.lang:get(2071, {
		name = var_1_0
	})))
	self.m_nTxt:setText(var_1_1)
	self.m_attributeIconLoader:setURL(var_0_0:getAttrIcon(arg_1_1, true), true)
end

return FurnitureAttributeCell
