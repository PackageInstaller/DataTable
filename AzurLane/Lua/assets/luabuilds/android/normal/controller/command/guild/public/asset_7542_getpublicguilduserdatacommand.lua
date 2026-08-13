class = var_0_10000

local var_0_0 = "GetPublicGuildUserDataCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	seriesAsync = var_1_0

	var_1_0({
		function(arg_2_0)
			local var_2_0 = arg_1_0

			var_1.CreatePublicGuild(var_2_0, arg_2_0)

			return
		end,
		function(arg_3_0)
			local var_3_0 = arg_1_0

			var_1.InitPublicGuild(var_3_0, arg_3_0)

			return
		end
	}, function()
		local var_4_0 = arg_1_0
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10002

		var_4_1(var_4_0, var_2_10002.HANDLE_GUILD_AND_PUBLIC_GUILD_TECH)

		local var_4_2 = arg_1_0
		local var_4_3 = var_0.sendNotification

		GAME = var_2

		var_4_3(var_4_2, var_2.GET_PUBLIC_GUILD_USER_DATA_DONE)

		return
	end)

	return
end

function var_0_1.CreatePublicGuild(arg_5_0, arg_5_1)
	pg = var_1_10002

	local var_5_0 = var_1_10002.ConnectionMgr.GetInstance()

	var_2.Send(var_5_0, 20, {
		type = 0
	}, 21, function(arg_6_0)
		PublicGuild = var_2_10001

		local var_6_0 = var_2_10001.New(arg_6_0)

		getProxy = var_2
		GuildProxy = var_2_10003

		local var_6_1 = var_2(var_2_10003)

		var_2.AddPublicGuild(var_6_1, var_6_0)
		arg_5_1()

		return
	end)

	return
end

function var_0_1.InitPublicGuild(arg_7_0, arg_7_1)
	pg = var_1_10002

	local var_7_0 = var_1_10002.ConnectionMgr.GetInstance()

	var_2.Send(var_7_0, 60102, {
		type = 0
	}, 60103, function(arg_8_0)
		getProxy = var_2_10001
		GuildProxy = var_2_10002

		local var_8_0 = var_2_10001(var_2_10002)
		local var_8_1 = var_1.GetPublicGuild(var_8_0)

		var_1.InitUser(var_8_1, arg_8_0.user_info)
		arg_7_1()

		return
	end)

	return
end

return var_0_1
