local var_0_0 = {}

manager.net:Bind(79111, function(arg_1_0)
	LoginBonusData:InitBonusData(arg_1_0)
end)

function var_0_0.EnterState(arg_2_0)
	manager.net:SendWithLoadingNew(79112, {
		activity_id = ActivityConst.ACTIVITY_LOGIN_BONUS,
		stage = arg_2_0
	}, 79113, var_0_0.OnEnterState)
end

function var_0_0.OnEnterState(arg_3_0, arg_3_1)
	if isSuccess(arg_3_0.result) then
		LoginBonusData:UpdateIndexData(arg_3_1.stage)
	else
		ShowTips(GetTips(arg_3_0.result))
	end
end

function var_0_0.DoChoose(arg_4_0, arg_4_1)
	manager.net:SendWithLoadingNew(79114, {
		activity_id = ActivityConst.ACTIVITY_LOGIN_BONUS,
		stage = arg_4_0,
		behavior = arg_4_1
	}, 79115, var_0_0.OnChoose)
end

function var_0_0.OnChoose()
	return
end

return var_0_0
