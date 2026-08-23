local var_0_0 = g.core.const.ConstMgr.PeakArenaConst.BetListSortType
local var_0_1 = {
	CLOSE = 0,
	OPEN = 1
}
local PASortDropDownBox = class("PASortDropDownBox", require("app.fairyGUI.peakArena.UI_PASortDropDownBox"))

function PASortDropDownBox:ctor()
	self._sortType = var_0_0.POWER
	self._sortTypeArr = {}

	self.m_bgLoader:addClickListener(handler(self, self._onToggleSwitch))
	self.m_selectList:setIniter(self)
	self.m_selectList:doFairyBatching(true)
	self.m_selectList:setItemRenderer(handler(self, self._onTabListRenderer))
	self.m_selectList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickTabListItem))
end

function PASortDropDownBox:updateComp(arg_2_1)
	self._sortType = arg_2_1

	self.m_title:setText((self:getSortTypeName(arg_2_1)))
	self.m_openController:setSelectedIndex(var_0_1.CLOSE)
end

function PASortDropDownBox:_onToggleSwitch()
	if self.m_openController:getSelectedIndex() == var_0_1.CLOSE then
		self:_updateSortTypeList(self._sortType)
		self.m_openController:setSelectedIndex(var_0_1.OPEN)
	else
		self.m_openController:setSelectedIndex(var_0_1.CLOSE)
	end
end

function PASortDropDownBox:_onTabListRenderer(arg_4_1, arg_4_2)
	arg_4_2:setTitle((self:getSortTypeName(self._sortTypeArr[arg_4_1 + 1])))
end

function PASortDropDownBox:_onClickTabListItem(arg_5_1)
	local var_5_0 = self._sortTypeArr[arg_5_1:getDataValue() + 1]

	if self._sortType == var_5_0 then
		self.m_openController:setSelectedIndex(var_0_1.CLOSE)
	else
		self._sortType = var_5_0

		self.m_title:setText((self:getSortTypeName(var_5_0)))
		self.m_openController:setSelectedIndex(var_0_1.CLOSE)
		self:dispatchCompEvent("CHANGE_SORT_TYPE")
	end
end

function PASortDropDownBox:getSortType()
	return self._sortType
end

function PASortDropDownBox:getSortTypeName(arg_7_1)
	return g.core.lang:get(307033 + arg_7_1)
end

function PASortDropDownBox:_updateSortTypeList(arg_8_1)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(var_0_0) do
		if iter_8_1 ~= arg_8_1 then
			table.insert(var_8_0, iter_8_1)
		end
	end

	self._sortTypeArr = var_8_0

	self.m_selectList:setNumItems(#var_8_0)
	self.m_selectList:resizeToFit(#var_8_0)
end

return PASortDropDownBox
