local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr.FurnitureConst
local FurnitureTypeCell = class("FurnitureTypeCell", require("app.fairyGUI.furniture.UI_FurnitureTypeCell"))

function FurnitureTypeCell:ctor()
	self.getSharedTrans(self, "listCardAUiRightIn01", "CombineBagList", self)
end

function FurnitureTypeCell:updateCell(arg_2_1)
	self._type = var_0_1.FURNITURE_TYPE_NAME[arg_2_1].type

	self.m_furnitureName:setText(g.core.lang:get(var_0_1.FURNITURE_TYPE_NAME[arg_2_1].name))
	self.m_selectIcon:setURL(var_0_0:getFurnitureTypeIcon(self._type, 1), true)
	self.m_unSelectIcon:setURL(var_0_0:getFurnitureTypeIcon(self._type, 0), true)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			furnitureType = self._type
		}
	})
end

return FurnitureTypeCell
