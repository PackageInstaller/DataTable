class = var_0_10000

local var_0_0 = "PlayRoomInviteRefuseCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	PlayRoomProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)

	var_3.RefuseInvite(var_1_2, var_1_1)

	return
end

return var_0_1
