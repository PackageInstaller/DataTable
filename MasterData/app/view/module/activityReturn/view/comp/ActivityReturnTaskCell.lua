local ActivityReturnTaskCell = class("ActivityReturnTaskCell", require("app.fairyGUI.activityReturn.UI_ActivityReturnTaskCell"))

function ActivityReturnTaskCell:ctor()
	self._data = nil

	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
	self.m_btn:addClickListener(handler(self, self._onBtnClick))
end

function ActivityReturnTaskCell:updateTaskCell(arg_2_1)
	self._data = arg_2_1

	self.m_name:setText(self._data.cfg.task_name)
	self.m_descText:setText(self._data.cfg.task_des)
	self.m_curProgressText:setText(self._data.cur.num)
	self.m_destinNumText:setText(g.core.lang:get(201028, {
		num = self._data.max
	}))
	self.m_awardList:setNumItems(#self._data.awards)
	self.m_drawStateController:setSelectedIndex(self._data.state)
end

function ActivityReturnTaskCell:_onAwardItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._data.awards[arg_3_1 + 1])
end

function ActivityReturnTaskCell:_onBtnClick()
	if self._data.state == 0 then
		g.view.entrance.ModuleGotoProxy:gotoModule(self._data.cfg.route_id)
	elseif self._data.state == 1 then
		self:dispatchCompEvent("getTaskAward", {
			task = self._data
		})
	elseif self._data.state == 2 then
		-- block empty
	end
end

return ActivityReturnTaskCell
