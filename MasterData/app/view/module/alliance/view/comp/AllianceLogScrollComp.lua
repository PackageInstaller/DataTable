local var_0_0 = g.core.model.User.allianceData
local AllianceLogScrollComp = class("AllianceLogScrollComp", require("app.fairyGUI.alliance.UI_AllianceLogScrollComp"))

function AllianceLogScrollComp:ctor()
	self._speed = self:getWidth() / 200
	self._width = 200
end

function AllianceLogScrollComp:_scrollLog()
	local var_2_0 = self.m_log1:getX() - self._speed

	self.m_log1:setX(var_2_0)

	if var_2_0 + self.m_log1:getWidth() < 0 then
		self:changeLog(1)
	end

	local var_2_1 = self.m_log2:getX() - self._speed

	self.m_log2:setX(var_2_1)

	if var_2_1 + self.m_log2:getWidth() < 0 then
		self:changeLog(2)
	end
end

function AllianceLogScrollComp:onLoad()
	self.m_hasLogController:setSelectedIndex(0)
end

function AllianceLogScrollComp:checkLog()
	self.m_log1:setX(-1 - self.m_log1:getWidth())
	self.m_log2:setX(-1 - self.m_log2:getWidth())

	self._scheduleLog = self._scheduleLog or self:newSchedule(handler(self, self._scrollLog))
end

function AllianceLogScrollComp:changeLog(arg_5_1)
	self.m_hasLogController:setSelectedIndex(1)

	local var_5_0 = var_0_0:getBoxData():getLog()

	if var_5_0 then
		self["m_log" .. arg_5_1]:setX(self["m_log" .. 3 - arg_5_1]:getX() + self["m_log" .. 3 - arg_5_1]:getWidth() + self._width)
		self["m_log" .. arg_5_1]:setText(g.core.lang:getByString(var_5_0.boxInfo.send_des, {
			name = var_5_0.user_name,
			num = var_5_0.box_num
		}))
	else
		local var_5_1 = self["m_log" .. arg_5_1]

		self["m_log" .. arg_5_1]:setX(self["m_log" .. 3 - arg_5_1]:getX() + self["m_log" .. 3 - arg_5_1]:getWidth() + self._width)
		var_5_1:setText(g.core.lang:get(428519))
	end
end

function AllianceLogScrollComp:stopSchedule()
	if self._scheduleLog then
		self:cancelSchedule(self._scheduleLog)

		self._scheduleLog = nil
	end
end

function AllianceLogScrollComp:onUnload()
	self:stopSchedule()
end

return AllianceLogScrollComp
