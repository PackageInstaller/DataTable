local var_0_0 = {}

manager.net:Bind(11080, function(arg_1_0)
	SevenDaySkinData:InitData(arg_1_0)
end)
manager.notify:RegistListener(NEW_DAY, function()
	SevenDaySkinData:Clear()
	manager.notify:Invoke(SEVEN_DAY_SKIN_SIGN_CLEAR)
end)

function var_0_0.ReqSign(arg_3_0)
	manager.net:SendWithLoadingNew(11081, {
		activity_id = arg_3_0
	}, 11082, var_0_0.OnSignResp)
end

function var_0_0.OnSignResp(arg_4_0, arg_4_1)
	if not isSuccess(arg_4_0.result) then
		return
	end

	local var_4_0 = arg_4_1.activity_id

	SevenDaySkinData:UpdateActivityData(var_4_0, arg_4_0)

	if var_4_0 == ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW then
		NorseSurpriseGiftReceiveData:UpdateRedPointData(ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW)
	end

	manager.notify:Invoke(SEVEN_DAY_SKIN_SIGN_SUCCESS, arg_4_0)
end

return var_0_0
