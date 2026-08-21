local var_0_0 = {}

manager.net:Bind(79401, function(arg_1_0)
	RedEnvelopeData:UpdateActivityData(arg_1_0)
	manager.notify:Invoke(SEVEN_DAY_SKIN_SIGN_CLEAR)
end)

function var_0_0.ReqSign(arg_2_0, arg_2_1, arg_2_2)
	manager.net:SendWithLoadingNew(79402, {
		activity_id = arg_2_0,
		id = arg_2_1,
		location = arg_2_2
	}, 79403, var_0_0.OnSign)
end

function var_0_0.OnSign(arg_3_0, arg_3_1)
	if not isSuccess(arg_3_0.result) then
		return
	end

	manager.notify:Invoke(ACTIVITY_RED_ENVELOPE_SIGN_SUCCESS, arg_3_1)
end

return var_0_0
