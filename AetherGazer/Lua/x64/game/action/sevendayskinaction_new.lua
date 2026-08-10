local var_0_0 = {}

manager.net:Bind(11097, function(arg_1_0)
	SevenDaySkinData_New:InitData(arg_1_0)
end)
manager.notify:RegistListener(NEW_DAY, function()
	SevenDaySkinData_New:Clear()
	manager.notify:Invoke(SEVEN_DAY_SKIN_SIGN_CLEAR)
end)

function var_0_0.ReqSign(arg_3_0, arg_3_1)
	manager.net:SendWithLoadingNew(11098, {
		activity_id = arg_3_0,
		id_list = arg_3_1
	}, 11099, var_0_0.OnSign)
end

function var_0_0.OnSign(arg_4_0, arg_4_1)
	if not isSuccess(arg_4_0.result) then
		return
	end

	local var_4_0 = arg_4_1.activity_id

	SevenDaySkinData_New:UpdateActivityData(var_4_0, arg_4_1)
	manager.notify:Invoke(SEVEN_DAY_SKIN_SIGN_SUCCESS, arg_4_0)
end

function var_0_0.ReqReSign(arg_5_0, arg_5_1)
	manager.net:SendWithLoadingNew(11100, {
		activity_id = arg_5_0,
		id = arg_5_1
	}, 11101, var_0_0.OnReSign)
end

function var_0_0.OnReSign(arg_6_0, arg_6_1)
	if not isSuccess(arg_6_0.result) then
		return
	end

	local var_6_0 = arg_6_1.activity_id

	SevenDaySkinData_New:UpdateActivityData(var_6_0, arg_6_1)
	SevenDaySkinData_New:UpdateUnlockTimes(var_6_0)
	manager.notify:Invoke(SEVEN_DAY_SKIN_SIGN_SUCCESS, arg_6_0)
end

function var_0_0.ReceiveGiftSHero(arg_7_0)
	manager.net:SendWithLoadingNew(11106, {
		activity_id = arg_7_0
	}, 11107, var_0_0.OnReceiveGiftSHero)
end

function var_0_0.OnReceiveGiftSHero(arg_8_0, arg_8_1)
	if not isSuccess(arg_8_0.result) then
		return
	end

	local var_8_0 = arg_8_1.activity_id

	SevenDaySkinData_New:UpdateActivityDataByGiftReward(var_8_0)
	manager.notify:Invoke(SEVEN_DAY_SKIN_RECEIVE_SHERO_SUCCESS, arg_8_0)
end

return var_0_0
