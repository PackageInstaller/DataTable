local var_0_0 = {}

manager.net:Bind(12045, function(arg_1_0)
	DailyFatigueData:InitData(arg_1_0)
	manager.redPoint:setTip(RedPointConst.DAILY_FATIGUE, (DailyFatigueData:GetRedCount()))
end)
manager.notify:RegistListener(NEW_DAY, function()
	DailyFatigueData:Clear()
	manager.redPoint:setTip(RedPointConst.DAILY_FATIGUE, 0)
end)

function var_0_0.ReqGetFatigue(arg_3_0)
	manager.net:SendWithLoadingNew(12046, {
		type = arg_3_0
	}, 12047, var_0_0.OnReqResp)
end

function var_0_0:OnReqResp(arg_4_1)
	if not isSuccess(self.result) then
		return
	end

	DailyFatigueData:SetData(arg_4_1.type, true)
	manager.redPoint:setTip(RedPointConst.DAILY_FATIGUE, (DailyFatigueData:GetRedCount()))
	manager.notify:CallUpdateFunc(GET_FATIGUE_SUCCESS, arg_4_1.type)
end

return var_0_0
