local var_0_0 = {}

manager.net:Bind(89501, function(arg_1_0)
	ActivitySpringFestivalGive2100Data:InitData(arg_1_0)
end)
manager.notify:RegistListener(NEW_DAY, function()
	ActivitySpringFestivalGive2100Data:SetDayListInfo()
	manager.notify:Invoke(SEVEN_DAY_SKIN_SIGN_CLEAR)
end)

function var_0_0.ReqSign(arg_3_0)
	manager.net:SendWithLoadingNew(89502, {
		day = arg_3_0
	}, 89503, var_0_0.OnSign)
end

function var_0_0.OnSign(arg_4_0, arg_4_1)
	if not isSuccess(arg_4_0.result) then
		return
	end

	manager.notify:Invoke(SPRING_GIVE_SEVEN_DAY_SKIN_SIGN_SUCCESS, arg_4_0)
end

function var_0_0.UpdateRedPoint()
	ActivitySpringFestivalGive2100Data:InitRedPoint()
end

return var_0_0
