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
	manager.net:SendWithLoadingNew(11010, {
		activity_id = ActivityConst.SIGN
	}, 11011, var_0_0.OnDailySignCallBack)
end

function var_0_0:OnDailySignCallBack(arg_4_1)
	if isSuccess(self.result) then
		SignData:UpdateDailySign((manager.time:GetDeltaToday()))
		ActivityRedPoint.UpdateDailySignRedPoint()
	end

	manager.notify:CallUpdateFunc(SIGN, self, arg_4_1)
end

function var_0_0.QuerySevenDaySign(arg_5_0)
	manager.net:SendWithLoadingNew(11010, {
		activity_id = arg_5_0
	}, 11011, var_0_0.OnSevenDaySignCallBack)
end

function var_0_0:OnSevenDaySignCallBack(arg_6_1)
	if isSuccess(self.result) then
		SignData:UpdateSevenDaySign(arg_6_1.activity_id, (manager.time:GetTodayFreshTime()))
		ActivityRedPoint.UpdateSevenDaySignRedPoint()
	end

	manager.notify:CallUpdateFunc(SIGN, self, arg_6_1)
end

return var_0_0
