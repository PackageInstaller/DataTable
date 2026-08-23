local var_0_1 = g.core.common.Goods
local RebornFurnitureCell = class("RebornFurnitureCell", require("app.fairyGUI.reborn.UI_RebornItemCell"))

function RebornFurnitureCell:ctor()
	self._id = 0

	self.m_itemComp:setTouchable(false)

	self.m_buttonController = self:getController("button")
end

function RebornFurnitureCell:updateCell(arg_2_1, arg_2_2)
	if arg_2_1 ~= self._id then
		self._id = arg_2_1

		self.m_itemComp:updateIcon({
			size = 0,
			type = var_0_1.TYPE_FURNITURE,
			value = arg_2_1
		})
	end

	self:setSelected(arg_2_2)
end

function RebornFurnitureCell:getFurnitureId()
	return self._id
end

return RebornFurnitureCell
