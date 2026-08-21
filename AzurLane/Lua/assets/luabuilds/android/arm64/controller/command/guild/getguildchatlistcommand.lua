local var_0_0 = class("GetGuildChatListCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(GuildProxy)

	if not getProxy(GuildProxy):getData() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(60100, {
		count = GuildConst.CHAT_LOG_MAX_COUNT
	}, 60101, function(arg_2_0)
		var_1_1.isGetChatMsg = true

		local var_2_1 = arg_2_0.chat_list or {}

		for iter_2_0, iter_2_1 in ipairs(var_2_1) do
			var_1_1:addMsg((var_0:warpChatInfo(iter_2_1)))
		end

		arg_1_0:sendNotification(GAME.GET_GUILD_CHAT_LIST_DONE)

		return
	end)

	return
end

return var_0_0
