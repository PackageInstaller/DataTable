class = var_0_10000

local var_0_0 = "GuildGetUserInfoCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	GuildProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)

	if not var_3.getData(var_1_2) then
		return
	end

	pg = var_1_2

	local var_1_3 = var_1_2.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 60102, {
		type = 0
	}, 60103, function(arg_2_0)
		local var_2_0 = var_0
		local var_2_1 = var_1.getData(var_2_0)

		var_1.updateUserInfo(var_2_1, arg_2_0)

		local var_2_2 = var_0

		var_2.updateGuild(var_2_2, var_1)

		local var_2_3 = arg_1_0
		local var_2_4 = var_2.sendNotification

		GAME = var_4

		var_2_4(var_2_3, var_4.GUILD_GET_USER_INFO_DONE)

		return
	end)

	return
end

return var_0_1
