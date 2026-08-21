local var_0_0 = class("JoinGuildMediator", import("..base.ContextMediator"))

var_0_0.APPLY = "JoinGuildMediator:APPLY"
var_0_0.REFRESH = "JoinGuildMediator:REFRESH"
var_0_0.SEARCH = "JoinGuildMediator:SEARCH"

function var_0_0.register(arg_1_0)
	arg_1_0:sendNotification(GAME.GUILD_LIST_REFRESH)
	arg_1_0.viewComponent:setPlayerVO((getProxy(PlayerProxy):getData()))
	arg_1_0:bind(var_0_0.APPLY, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.GUILD_APPLY, {
			id = arg_2_1,
			content = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.REFRESH, function(arg_3_0)
		arg_1_0:sendNotification(GAME.GUILD_LIST_REFRESH)

		return
	end)
	arg_1_0:bind(var_0_0.SEARCH, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.GUILD_SEARCH, arg_4_1)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		GAME.GUILD_LIST_REFRESH_DONE,
		GAME.GUILD_SEARCH_DONE,
		GAME.GUILD_APPLY_DONE,
		GAME.REMOVE_LAYERS
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()

	if var_6_0 == GAME.GUILD_LIST_REFRESH_DONE or var_6_0 == GAME.GUILD_SEARCH_DONE then
		arg_6_0.viewComponent:setGuildVOs((arg_6_1:getBody()))

		if arg_6_0.contextData.filterData then
			arg_6_0.viewComponent:filter()
		else
			arg_6_0.viewComponent:sortGuilds()
		end
	elseif var_6_0 == GAME.GUILD_APPLY_DONE then
		arg_6_0.viewComponent:CloseApply()
	end

	return
end

return var_0_0
