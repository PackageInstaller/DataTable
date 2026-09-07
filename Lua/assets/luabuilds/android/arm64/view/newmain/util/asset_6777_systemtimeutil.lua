local SystemTimeUtil = class("SystemTimeUtil")

function SystemTimeUtil:Ctor()
	return
end

function SystemTimeUtil:SetUp(arg_2_1)
	self.callback = arg_2_1

	self:Flush()

	return
end

function SystemTimeUtil:Flush()
	local var_3_0 = pg.TimeMgr.GetInstance():GetServerHour()

	if self.callback then
		self.callback(var_3_0, pg.TimeMgr.GetInstance():CurrentSTimeDesc("%M", true), var_3_0 < 12 and "AM" or "PM")
	end

	self:AddTimer((self:GetSecondsToNextMinute((pg.TimeMgr.GetInstance():GetServerTime()))))

	return
end

function SystemTimeUtil:GetSecondsToNextMinute(arg_4_1)
	local var_4_0 = math.ceil(arg_4_1 / 60) * 60 - arg_4_1

	if var_4_0 <= 0 then
		return 60
	end

	return var_4_0
end

function SystemTimeUtil:AddTimer(arg_5_1)
	self:RemoveTimer()

	self.timer = Timer.New(function()
		self:Flush()

		return
	end, arg_5_1, 1)

	self.timer:Start()

	return
end

function SystemTimeUtil:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function SystemTimeUtil:Dispose()
	self:RemoveTimer()

	return
end

return SystemTimeUtil
