local GetGuildRequestsCommand = class("GetGuildRequestsCommand", pm.SimpleCommand)

function GetGuildRequestsCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(60003, {
		id = arg_1_1:getBody()
	}, 60004, function(arg_2_0)
		local var_2_0 = {}
		local var_2_1 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.request_list) do
			local var_2_2 = ChatMsg.New(ChatConst.ChannelGuild, {
				player = Player.New(iter_2_1.player),
				content = iter_2_1.content,
				timestamp = iter_2_1.timestamp
			})

			var_2_0[var_2_2.player.id] = var_2_2

			table.insert(var_2_1, var_2_2)
		end

		getProxy(GuildProxy):setRequestList(var_2_0)
		self:sendNotification(GAME.GUILD_GET_REQUEST_LIST_DONE, var_2_1)

		return
	end)

	return
end

return GetGuildRequestsCommand
