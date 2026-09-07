local GetPublicGuildUserDataCommand = class("GetPublicGuildUserDataCommand", pm.SimpleCommand)

function GetPublicGuildUserDataCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	seriesAsync({
		function(arg_2_0)
			self:CreatePublicGuild(arg_2_0)

			return
		end,
		function(arg_3_0)
			self:InitPublicGuild(arg_3_0)

			return
		end
	}, function()
		self:sendNotification(GAME.HANDLE_GUILD_AND_PUBLIC_GUILD_TECH)
		self:sendNotification(GAME.GET_PUBLIC_GUILD_USER_DATA_DONE)

		return
	end)

	return
end

function GetPublicGuildUserDataCommand:CreatePublicGuild(arg_5_1)
	pg.ConnectionMgr.GetInstance():Send(20, {
		type = 0
	}, 21, function(arg_6_0)
		getProxy(GuildProxy):AddPublicGuild((PublicGuild.New(arg_6_0)))
		arg_5_1()

		return
	end)

	return
end

function GetPublicGuildUserDataCommand:InitPublicGuild(arg_7_1)
	pg.ConnectionMgr.GetInstance():Send(60102, {
		type = 0
	}, 60103, function(arg_8_0)
		getProxy(GuildProxy):GetPublicGuild():InitUser(arg_8_0.user_info)
		arg_7_1()

		return
	end)

	return
end

return GetPublicGuildUserDataCommand
