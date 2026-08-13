class = var_0_10000

local var_0_0 = "SendCmdCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	assert = var_1_10003

	var_1_10003(var_1_0.cmd, "cmd should exist")

	local var_1_1 = var_1_0.cmd
	local var_1_2 = var_1_0.arg1

	pg = var_5

	local var_1_3 = var_5.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 11100, {
		cmd = var_1_0.cmd,
		arg1 = var_1_0.arg1,
		arg2 = var_1_0.arg2,
		arg3 = var_1_0.arg3,
		arg4 = var_1_0.arg4
	}, 11101, function(arg_2_0)
		print = var_2_10001

		var_2_10001("response: " .. arg_2_0.msg)

		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_4

		var_2_1(var_2_0, var_4.SEND_CMD_DONE, arg_2_0.msg)

		return
	end)

	return
end

return var_0_1
