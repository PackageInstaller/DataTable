local NewGuildMediator = class("NewGuildMediator", import("..base.ContextMediator"))

NewGuildMediator.OPEN_GUILD_LIST = "NewGuildMediator:OPEN_GUILD_LIST"
NewGuildMediator.CREATE = "NewGuildMediator:CREATE"
NewGuildMediator.OPEN_PUBLIC_GUILD = "NewGuildMediator:OPEN_PUBLIC_GUILD"

function NewGuildMediator:register()
	self.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))
	self:bind(NewGuildMediator.OPEN_PUBLIC_GUILD, function(arg_2_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.PUBLIC_GUILD)

		return
	end)
	self:bind(NewGuildMediator.OPEN_GUILD_LIST, function(arg_3_0)
		self:addSubLayers(Context.New({
			viewComponent = JoinGuildLayer,
			mediator = JoinGuildMediator
		}))

		return
	end)
	self:bind(NewGuildMediator.CREATE, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.CREATE_GUILD, arg_4_1)

		return
	end)

	return
end

function NewGuildMediator:listNotificationInterests()
	return {
		GuildProxy.NEW_GUILD_ADDED,
		PlayerProxy.UPDATED,
		GAME.CREATE_GUILD_DONE,
		GAME.REMOVE_LAYERS
	}
end

function NewGuildMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == GuildProxy.NEW_GUILD_ADDED then
		self:sendNotification(GAME.GO_SCENE, SCENE.GUILD)
	elseif var_6_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayer(var_6_1)
	elseif var_6_0 == GAME.CREATE_GUILD_DONE then
		self.viewComponent:ClosePage()
	elseif var_6_0 == GAME.REMOVE_LAYERS and var_6_1.context.mediator == JoinGuildMediator then
		self.viewComponent:startCreate()
	end

	return
end

return NewGuildMediator
