local var_0_0 = class("GetPublicGuildUserDataCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	seriesAsync({
		function(arg_2_0)
			arg_1_0:CreatePublicGuild(arg_2_0)

			return
		end,
		function(arg_3_0)
			arg_1_0:InitPublicGuild(arg_3_0)

			return
		end
	}, function()
		arg_1_0:sendNotification(GAME.HANDLE_GUILD_AND_PUBLIC_GUILD_TECH)
		arg_1_0:sendNotification(GAME.GET_PUBLIC_GUILD_USER_DATA_DONE)

		return
	end)

	return
end

function var_0_0.CreatePublicGuild(arg_5_0, arg_5_1)
	pg.ConnectionMgr.GetInstance():Send(20, {
		type = 0
	}, 21, function(arg_6_0)
		getProxy(GuildProxy):AddPublicGuild((PublicGuild.New(arg_6_0)))
		arg_5_1()

		return
	end)

	return
end

function var_0_0.InitPublicGuild(arg_7_0, arg_7_1)
	pg.ConnectionMgr.GetInstance():Send(60102, {
		type = 0
	}, 60103, function(arg_8_0)
		getProxy(GuildProxy):GetPublicGuild():InitUser(arg_8_0.user_info)
		arg_7_1()

		return
	end)

	return
end

return var_0_0
