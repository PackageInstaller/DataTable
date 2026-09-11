local var_0_0 = singletonClass("GameTimer")
local var_0_1 = 0
local var_0_2 = 0
local var_0_3 = 0
local var_0_4
local var_0_5
local var_0_6

function var_0_0:SetNextDayFreshTime(arg_1_1)
	print("nextDayFreshTime_ newTime", var_0_1, arg_1_1)

	if var_0_1 ~= arg_1_1 then
		var_0_1 = arg_1_1

		self:StartCountNextDay()
	end
end

function var_0_0.GetNextDayFreshTime(arg_2_0)
	return var_0_1
end

function var_0_0:StartCountNextDay()
	self:StopCountNextDay()

	var_0_4 = Timer.New(function()
		if manager.time:GetServerTime() > var_0_1 then
			self:StopCountNextDay()
			PlayerAction.RequestNewDayData()
		end
	end, 1, -1)

	var_0_4:Start()
end

function var_0_0.StopCountNextDay(arg_5_0)
	if var_0_4 then
		var_0_4:Stop()

		var_0_4 = nil
	end
end

function var_0_0:SetNextWeekFreshTime(arg_6_1)
	print("nextWeekFreshTime_ newTime", var_0_2, arg_6_1)

	if var_0_2 ~= arg_6_1 then
		var_0_2 = arg_6_1

		self:StartCountNextWeek()
	end
end

function var_0_0.GetNextWeekFreshTime(arg_7_0)
	return var_0_2
end

function var_0_0:StartCountNextWeek()
	self:StopCountNextWeek()

	var_0_5 = Timer.New(function()
		if manager.time:GetServerTime() > var_0_2 then
			self:StopCountNextWeek()
			PlayerAction.RequestNewDayData()
		end
	end, 1, -1)

	var_0_5:Start()
end

function var_0_0.StopCountNextWeek(arg_10_0)
	if var_0_5 then
		var_0_5:Stop()

		var_0_5 = nil
	end
end

function var_0_0:SetNextMonthFreshTime(arg_11_1)
	print("nextMonthFreshTime_ newTime", var_0_3, arg_11_1)

	if var_0_3 ~= arg_11_1 then
		var_0_3 = arg_11_1

		self:StartCountNextMonth()
	end
end

function var_0_0.GetNextMonthFreshTime(arg_12_0)
	return var_0_3
end

function var_0_0:StartCountNextMonth()
	self:StopCountNextMonth()

	var_0_6 = Timer.New(function()
		if manager.time:GetServerTime() > var_0_3 then
			self:StopCountNextMonth()
			PlayerAction.RequestNewDayData()
		end
	end, 1, -1)

	var_0_6:Start()
end

function var_0_0.StopCountNextMonth(arg_15_0)
	if var_0_6 then
		var_0_6:Stop()

		var_0_6 = nil
	end
end

function var_0_0:Dispose()
	print("GameTimer Dispose")

	var_0_1 = 0

	self:StopCountNextDay()
end

return var_0_0
