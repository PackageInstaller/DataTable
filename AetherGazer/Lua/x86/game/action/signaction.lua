local var_0_0 = {}

manager.net:Bind(11013, function(arg_1_0)
	SignData:InitDailySignData(arg_1_0)
	ActivityRedPoint.UpdateDailySignRedPoint()
end)
manager.net:Bind(11015, function(arg_2_0)
	SignData:InitSevenDaySignData(arg_2_0)
	ActivityRedPoint.UpdateSevenDaySignRedPoint()
end)

function var_0_0.QueryDailySign()
	local var_3_0 = {
		activity_id = ActivityConst.SIGN
	}

	manager.net:SendWithLoadingNew(11010, var_3_0, 11011, var_0_0.OnDailySignCallBack)
end

function var_0_0.OnDailySignCallBack(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		local var_4_0 = manager.time:GetDeltaToday()

		SignData:UpdateDailySign(var_4_0)
		ActivityRedPoint.UpdateDailySignRedPoint()
	end

	manager.notify:CallUpdateFunc(SIGN, arg_4_0, arg_4_1)
end

function var_0_0.QuerySevenDaySign(arg_5_0)
	local var_5_0 = {
		activity_id = arg_5_0
	}

	manager.net:SendWithLoadingNew(11010, var_5_0, 11011, var_0_0.OnSevenDaySignCallBack)
end

function var_0_0.OnSevenDaySignCallBack(arg_6_0, arg_6_1)
	if isSuccess(arg_6_0.result) then
		local var_6_0 = manager.time:GetTodayFreshTime()

		SignData:UpdateSevenDaySign(arg_6_1.activity_id, var_6_0)
		ActivityRedPoint.UpdateSevenDaySignRedPoint()
	end

	manager.notify:CallUpdateFunc(SIGN, arg_6_0, arg_6_1)
end

return var_0_0
