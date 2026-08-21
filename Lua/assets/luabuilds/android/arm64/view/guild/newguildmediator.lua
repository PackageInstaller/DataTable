local var_0_0 = class("NewGuildMediator", import("..base.ContextMediator"))

var_0_0.OPEN_GUILD_LIST = "NewGuildMediator:OPEN_GUILD_LIST"
var_0_0.CREATE = "NewGuildMediator:CREATE"
var_0_0.OPEN_PUBLIC_GUILD = "NewGuildMediator:OPEN_PUBLIC_GUILD"

function var_0_0.register(arg_1_0)
	arg_1_0.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))
	arg_1_0:bind(var_0_0.OPEN_PUBLIC_GUILD, function(arg_2_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.PUBLIC_GUILD)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_GUILD_LIST, function(arg_3_0)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = JoinGuildLayer,
			mediator = JoinGuildMediator
		}))

		return
	end)
	arg_1_0:bind(var_0_0.CREATE, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.CREATE_GUILD, arg_4_1)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		GuildProxy.NEW_GUILD_ADDED,
		PlayerProxy.UPDATED,
		GAME.CREATE_GUILD_DONE,
		GAME.REMOVE_LAYERS
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == GuildProxy.NEW_GUILD_ADDED then
		arg_6_0:sendNotification(GAME.GO_SCENE, SCENE.GUILD)
	elseif var_6_0 == PlayerProxy.UPDATED then
		arg_6_0.viewComponent:setPlayer(var_6_1)
	elseif var_6_0 == GAME.CREATE_GUILD_DONE then
		arg_6_0.viewComponent:ClosePage()
	elseif var_6_0 == GAME.REMOVE_LAYERS and var_6_1.context.mediator == JoinGuildMediator then
		arg_6_0.viewComponent:startCreate()
	end

	return
end

return var_0_0
