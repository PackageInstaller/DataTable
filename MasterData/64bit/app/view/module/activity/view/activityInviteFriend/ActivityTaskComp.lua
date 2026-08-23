local var_0_0 = g.core.model.User.activityInviteFriendData
local ActivityTaskComp = class("ActivityTaskComp", require("app.fairyGUI.activity.UI_ActivityTaskComp"))

function ActivityTaskComp:ctor()
	self._data = {}
	self._taskInfo = {}
	self._complete = nil

	self:_initView()
end

function ActivityTaskComp:_initView()
	self.m_statusController = self.m_routeBtn:getController("status")

	self.m_routeBtn:addClickListener(handler(self, self._onClickRouteBtn))
end

function ActivityTaskComp:updateView(arg_3_1)
	self._data = arg_3_1

	local var_3_0 = var_0_0:getTaskInfoByTaskId(arg_3_1.id)

	self._taskInfo = var_3_0
	self._complete = self._data.is_finish

	self.m_name:setText(string.gsub(var_3_0.des, "#num#", arg_3_1.target))
	self.m_num:setText(g.core.lang:get(200523, {
		curNum = arg_3_1.value,
		totalNum = arg_3_1.target
	}))

	if self._complete then
		self.m_statusController:setSelectedIndex(1)
	else
		self.m_statusController:setSelectedIndex(0)
	end
end

function ActivityTaskComp:_onClickRouteBtn()
	if self._taskInfo and self._taskInfo.route_id and not self._complete then
		g.view.entrance.ModuleGotoProxy:gotoModule(self._taskInfo.route_id)
	end
end

return ActivityTaskComp
