local var_0_0 = class("GetGuildInfoCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if not getProxy(GuildProxy):getRawData() and not getProxy(GuildProxy).isFetchMainInfo then
		pg.ConnectionMgr.GetInstance():Send(5, {
			type = 0
		}, 60000, function(arg_2_0)
			getProxy(GuildProxy).isFetchMainInfo = true

			arg_1_0:sendNotification(GAME.GET_GUILD_INFO_DONE)

			return
		end)
	else
		arg_1_0:sendNotification(GAME.GET_GUILD_INFO_DONE)
	end

	return
end

return var_0_0
