local var_0_0 = g.core.config.furniture_info
local FurnitureSubItemCell = class("FurnitureSubItemCell", require("app.fairyGUI.furniture.UI_FurnitureSubItemCell"))

function FurnitureSubItemCell:ctor()
	self.getSharedTrans(self, "listCardAUiRightIn01", "CombineBagList", self)
end

function FurnitureSubItemCell:updateView(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._furnitureId = arg_2_1.id or 0

	local var_2_0 = arg_2_1.num

	self.m_emptyController:setSelectedIndex(arg_2_1.num <= 0 and 1 or 0)

	local var_2_1 = var_0_0.get(self._furnitureId)

	if var_2_1 then
		self.m_comfortNumTxt:setText(var_2_1.comfort)
		self.m_furnitureName:setText(var_2_1.name)
		self.m_numTxt:setText(var_2_0)
		self.m_furnitureIcon:setURL(g.core.common.Path:getFurnitureIconByResId(var_2_1.icon), true)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			id = self._furnitureId
		}
	})
	self:_clearNewItemFlag()
end

function FurnitureSubItemCell:_clearNewItemFlag()
	if g.core.model.User.bagData:getNewData(g.core.common.Goods.TYPE_FURNITURE, self._furnitureId) then
		g.core.model.User.bagData:clearNewData(g.core.common.Goods.TYPE_FURNITURE, self._furnitureId)
	end
end

return FurnitureSubItemCell
