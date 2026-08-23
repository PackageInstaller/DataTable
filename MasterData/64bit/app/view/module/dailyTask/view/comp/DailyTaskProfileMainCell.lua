local DailyTaskProfileMainCell = class("DailyTaskProfileMainCell", require("app.fairyGUI.dailyTask.UI_DailyTaskProfileMainCell"))

function DailyTaskProfileMainCell:ctor(arg_1_1)
	self._data = {}
	self._isExpand = false
	self._mainType = 1

	self:addClickListener(handler(self, self._onClick))
end

function DailyTaskProfileMainCell:updateItem(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self._data = arg_2_1
	self._isExpand = arg_2_1.isExpand
	self._mainType = arg_2_1.mainType

	self.m_isExpandController:setSelectedIndex(self._isExpand and 1 or 0)
	self.m_chooseStateController:setSelectedIndex(self._mainType == arg_2_3 and 1 or 0)
	self.m_isLockController:setSelectedIndex(self._data.unLockNum > 0 and 0 or 1)
	self:setTitle(arg_2_1.title .. "（" .. arg_2_1.unLockNum .. "/" .. arg_2_1.subNum .. "）")
end

function DailyTaskProfileMainCell:_onClick()
	if self._data.unLockNum == 0 then
		self.m_chooseStateController:setSelectedIndex(0)
		g.core.module.ModuleManager:tip(g.core.lang:get(106503))

		return
	end

	self._isExpand = not self._isExpand

	self:dispatchCompEvent("MainCellClick", {
		isExpand = self._isExpand,
		type = self._mainType
	})
end

return DailyTaskProfileMainCell
