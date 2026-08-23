local FurnitureComfortBuffCell = class("FurnitureComfortBuffCell", require("app.fairyGUI.furniture.UI_FurnitureComfortBuffCell"))

function FurnitureComfortBuffCell:updateCell(arg_1_1)
	self.m_comfortTxt:setText(arg_1_1.comfort)
	self.m_attributeCell:updateCell(arg_1_1.attribute_type, arg_1_1.attribute_value)
end

return FurnitureComfortBuffCell
