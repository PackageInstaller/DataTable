local var_0_0 = class("UserRegisterCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	assert(isa(var_1_0, User), "should be an instance of User")

	if var_1_0.type ~= 2 then
		originalPrint("用户类型错误")

		return
	end

	originalPrint("connect to gateway - " .. NetConst.GATEWAY_HOST .. ":" .. NetConst.GATEWAY_PORT)
	pg.ConnectionMgr.GetInstance():Connect(NetConst.GATEWAY_HOST, NetConst.GATEWAY_PORT, function()
		pg.ConnectionMgr.GetInstance():Send(10001, {
			account = var_1_0.arg1,
			password = var_1_0.arg2,
			mail_box = var_1_0.arg3
		}, 10002, function(arg_3_0)
			originalPrint("disconnect from gateway...")
			pg.ConnectionMgr.GetInstance():Disconnect()

			if arg_3_0.result == 0 then
				arg_1_0.facade:sendNotification(GAME.USER_REGISTER_SUCCESS, var_1_0)
			else
				arg_1_0.facade:sendNotification(GAME.USER_REGISTER_FAILED, arg_3_0.result)
			end

			return
		end, false)

		return
	end)

	return
end

return var_0_0
