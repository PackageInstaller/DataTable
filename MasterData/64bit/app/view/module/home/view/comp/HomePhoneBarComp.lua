local HomePhoneBarComp = class("HomePhoneBarComp", require("app.fairyGUI.home.UI_HomePhoneBarComp"))

function HomePhoneBarComp:ctor()
	self._proMaxWidth = self.m_batteryLoader:getSize().width
	self._time = -1
	self._schedule = nil
end

function HomePhoneBarComp:onLoad()
	self._time = -1

	self:_updateUI()

	self._schedule = g.core.common.Scheduler:newSchedule(handler(self, self._updateTime), 30)

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BAR_INFO_CHANGE, handler(self, self._updateUI), self)
end

function HomePhoneBarComp:onUnload()
	self._time = -1

	if self._schedule then
		g.core.common.Scheduler:cancelSchedule(self._schedule)
	end

	self._schedule = nil
end

function HomePhoneBarComp:_updateUI()
	local var_4_0 = g.core.platform.PlatformProxy:getPhoneBarInfo()

	self:_updatePro(var_4_0.battery)
	self:_updateNetState(var_4_0.netState)
	self:_updateTime()
end

function HomePhoneBarComp:_updatePro(arg_5_1)
	local var_5_0 = self.m_batteryLoader:getSize()

	var_5_0.width = self._proMaxWidth * (arg_5_1 / 100)

	self.m_batteryLoader:setSize(var_5_0)

	if arg_5_1 <= 20 then
		self.m_lowBatteryController:setSelectedIndex(1)
	else
		self.m_lowBatteryController:setSelectedIndex(0)
	end
end

function HomePhoneBarComp:_updateNetState(arg_6_1)
	self.m_netStateController:setSelectedIndex(arg_6_1)
end

function HomePhoneBarComp:_updateTime()
	self._time = self._time < 0 and os.time() or self._time + 1

	local var_7_0 = os.date("%H:%M", self._time)

	self.m_timeText:setText((config.PUBLISH_REGION ~= g.core.const.ConstMgr.PlatformConst.REGION.CHINA or nil) and g.core.common.ServerTime:getTimeStringEx())
end

return HomePhoneBarComp
