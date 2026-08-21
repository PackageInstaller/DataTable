local var_0_0 = class("GetGuildRequestsCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(60003, {
		id = arg_1_1:getBody()
	}, 60004, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.request_list) do
			local var_2_0 = ChatMsg.New(ChatConst.ChannelGuild, {
				player = Player.New(iter_2_1.player),
				content = iter_2_1.content,
				timestamp = iter_2_1.timestamp
			})

			;({})[var_2_0.player.id] = var_2_0

			table.insert({}, var_2_0)
		end

		getProxy(GuildProxy):setRequestList({})
		arg_1_0:sendNotification(GAME.GUILD_GET_REQUEST_LIST_DONE, {})

		return
	end)

	return
end

return var_0_0
