class = var_0_10000

local var_0_0 = "PlayRoomInviteRefuseCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	PlayRoomProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)

	var_3.RefuseInvite(var_1_1, var_1_0)

	return
end

return var_0_1
