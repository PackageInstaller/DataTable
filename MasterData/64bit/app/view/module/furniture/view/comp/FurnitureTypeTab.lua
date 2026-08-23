local var_0_0 = g.core.const.ConstMgr.FurnitureConst
local var_0_1 = g.core.model.User.furnitureData
local FurnitureTypeTab = class("FurnitureTypeTab", require("app.fairyGUI.furniture.UI_FurnitureTypeTab"))

function FurnitureTypeTab:ctor()
	self._cppIdxPreSelected = 0

	self.m_typeList:setVirtual()
	self.m_typeList:setItemRenderer(handler(self, self._onItemRender))
	self.m_typeList:setNumItems(#var_0_0.FURNITURE_TYPE_NAME)
	self.m_typeList:transitionShowCells("listCardAUiRightIn01", 0.06)
	self.m_typeList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onChangedListIndex))
	self.m_typeList:setSelectedIndex(self._cppIdxPreSelected)
	self:dispatchCompEvent("FURNITURE_TYPE_CELL_ON_SELECT", var_0_0.FURNITURE_INIT_INDEX)
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
end

function FurnitureTypeTab:_onTouchBegin(arg_2_1)
	arg_2_1:stopPropagation()
end

function FurnitureTypeTab:_onItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateCell(arg_3_1 + 1)
end

function FurnitureTypeTab:_onChangedListIndex()
	local var_4_0 = self.m_typeList:getSelectedIndex()

	if var_4_0 == self._cppIdxPreSelected then
		return
	end

	if self:_isExistFurnitureWithType(var_0_0.FURNITURE_TYPE_NAME[var_4_0 + 1].type) then
		self._cppIdxPreSelected = var_4_0

		self:dispatchCompEvent("FURNITURE_TYPE_CELL_ON_SELECT", var_0_0.FURNITURE_TYPE_NAME[var_4_0 + 1].type)
		self.m_typeList:setNumItems(#var_0_0.FURNITURE_TYPE_NAME)
	else
		self.m_typeList:setSelectedIndex(self._cppIdxPreSelected)
		g.core.module.ModuleManager:tip(g.core.lang:get(111054))
	end
end

function FurnitureTypeTab:onUpdateTypeTabRedPoint()
	self.m_typeList:setNumItems(#var_0_0.FURNITURE_TYPE_NAME)
end

function FurnitureTypeTab:_isExistFurnitureWithType(arg_6_1)
	return #var_0_1:getFurnitureItemDataByType(arg_6_1) > 0
end

return FurnitureTypeTab
