local var_0_0 = class("SendCmdCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	assert(var_1_0.cmd, "cmd should exist")
	pg.ConnectionMgr.GetInstance():Send(11100, {
		cmd = var_1_0.cmd,
		arg1 = var_1_0.arg1,
		arg2 = var_1_0.arg2,
		arg3 = var_1_0.arg3,
		arg4 = var_1_0.arg4
	}, 11101, function(arg_2_0)
		print("response: " .. arg_2_0.msg)
		arg_1_0:sendNotification(GAME.SEND_CMD_DONE, arg_2_0.msg)

		return
	end)

	return
end

return var_0_0
