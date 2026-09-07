local ProxyRegister = class("ProxyRegister")

ProxyRegister.SecondCall = "sec"
ProxyRegister.MinuteCall = "min"
ProxyRegister.HourCall = "hour"
ProxyRegister.DayCall = "day"

function ProxyRegister:Ctor()
	self.data = {}
	self.callDic = {
		[ProxyRegister.SecondCall] = {},
		[ProxyRegister.MinuteCall] = {},
		[ProxyRegister.HourCall] = {},
		[ProxyRegister.DayCall] = {}
	}
	self.timer = CoTimer.New(function()
		self:Dispatcher()

		return
	end, 1, -1)
	self.loginMark = nil

	return
end

function ProxyRegister:AddProxy(arg_3_1, arg_3_2, ...)
	if not arg_3_2 then
		return
	end

	local var_3_0 = arg_3_1.New(...)

	table.insert(self.data, var_3_0)

	for iter_3_0, iter_3_1 in pairs(var_3_0:timeCall()) do
		table.insert(self.callDic[iter_3_0], iter_3_1)
	end

	return
end

function ProxyRegister:RgisterProxy(arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(arg_4_2) do
		self:AddProxy(unpack(iter_4_1))
	end

	for iter_4_2, iter_4_3 in ipairs(self.data) do
		arg_4_1:registerProxy(iter_4_3)
	end

	self.loginMark = {}

	return
end

function ProxyRegister:RemoveProxy(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(self.data) do
		arg_5_1:removeProxy(iter_5_1.__cname)
	end

	self.loginMark = nil

	return
end

function ProxyRegister:Start()
	self.dateMark = pg.TimeMgr.GetInstance():CurrentSTimeDesc("*t", true)

	self.timer:Start()

	return
end

function ProxyRegister:Stop()
	self.timer:Stop()

	return
end

function ProxyRegister:Dispatcher()
	local var_8_0 = {}
	local var_8_1 = pg.TimeMgr.GetInstance():CurrentSTimeDesc("*t", true)

	for iter_8_0, iter_8_1 in ipairs({
		ProxyRegister.SecondCall,
		ProxyRegister.MinuteCall,
		ProxyRegister.HourCall,
		ProxyRegister.DayCall
	}) do
		if iter_8_1 == ProxyRegister.DayCall then
			if self.dateMark[iter_8_1] ~= var_8_1[iter_8_1] then
				if self.dayProto or self.dayCount and self.dayCount <= 0 then
					var_8_0[iter_8_1] = var_8_1[iter_8_1]
					self.dateMark[iter_8_1] = var_8_1[iter_8_1]
				else
					self.dayCount = self.dayCount and self.dayCount - 1 or 30
				end
			else
				self.dayProto = nil
				self.dayCount = nil
			end
		elseif self.dateMark[iter_8_1] ~= var_8_1[iter_8_1] then
			var_8_0[iter_8_1] = var_8_1[iter_8_1]
			self.dateMark[iter_8_1] = var_8_1[iter_8_1]
		end
	end

	for iter_8_2, iter_8_3 in pairs(var_8_0) do
		for iter_8_4, iter_8_5 in ipairs(self.callDic[iter_8_2]) do
			iter_8_5(iter_8_3, var_8_1)
		end
	end

	return
end

return ProxyRegister
