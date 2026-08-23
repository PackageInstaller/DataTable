local var_0_0 = g.core.common.Path
local FurnitureComfortBuffBubbleCell = class("FurnitureComfortBuffBubbleCell", require("app.fairyGUI.furniture.UI_FurnitureComfortBuffBubbleCell"))

function FurnitureComfortBuffBubbleCell:updateCell(arg_1_1, arg_1_2, arg_1_3)
	self.m_nTxt:setText(arg_1_2)
	self.m_addTxt:setText(arg_1_3)
	self.m_attributeIconLoader:setURL(var_0_0:getAttrIcon(arg_1_1, true), true)
end

return FurnitureComfortBuffBubbleCell
