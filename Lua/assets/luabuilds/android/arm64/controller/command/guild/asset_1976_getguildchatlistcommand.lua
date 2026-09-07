local GetGuildChatListCommand = class("GetGuildChatListCommand", pm.SimpleCommand)

function GetGuildChatListCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(GuildProxy)
	local var_1_2 = var_1_1:getData()

	if not var_1_2 then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(60100, {
		count = GuildConst.CHAT_LOG_MAX_COUNT
	}, 60101, function(arg_2_0)
		var_1_1.isGetChatMsg = true

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.chat_list or {}) do
			var_1_1:addMsg((var_1_2:warpChatInfo(iter_2_1)))
		end

		self:sendNotification(GAME.GET_GUILD_CHAT_LIST_DONE)

		return
	end)

	return
end

return GetGuildChatListCommand
