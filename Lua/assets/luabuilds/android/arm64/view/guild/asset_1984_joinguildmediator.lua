local JoinGuildMediator = class("JoinGuildMediator", import("..base.ContextMediator"))

JoinGuildMediator.APPLY = "JoinGuildMediator:APPLY"
JoinGuildMediator.REFRESH = "JoinGuildMediator:REFRESH"
JoinGuildMediator.SEARCH = "JoinGuildMediator:SEARCH"

function JoinGuildMediator:register()
	self:sendNotification(GAME.GUILD_LIST_REFRESH)
	self.viewComponent:setPlayerVO((getProxy(PlayerProxy):getData()))
	self:bind(JoinGuildMediator.APPLY, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.GUILD_APPLY, {
			id = arg_2_1,
			content = arg_2_2
		})

		return
	end)
	self:bind(JoinGuildMediator.REFRESH, function(arg_3_0)
		self:sendNotification(GAME.GUILD_LIST_REFRESH)

		return
	end)
	self:bind(JoinGuildMediator.SEARCH, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.GUILD_SEARCH, arg_4_1)

		return
	end)

	return
end

function JoinGuildMediator:listNotificationInterests()
	return {
		GAME.GUILD_LIST_REFRESH_DONE,
		GAME.GUILD_SEARCH_DONE,
		GAME.GUILD_APPLY_DONE,
		GAME.REMOVE_LAYERS
	}
end

function JoinGuildMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()

	if var_6_0 == GAME.GUILD_LIST_REFRESH_DONE or var_6_0 == GAME.GUILD_SEARCH_DONE then
		self.viewComponent:setGuildVOs((arg_6_1:getBody()))

		if self.contextData.filterData then
			self.viewComponent:filter()
		else
			self.viewComponent:sortGuilds()
		end
	elseif var_6_0 == GAME.GUILD_APPLY_DONE then
		self.viewComponent:CloseApply()
	end

	return
end

return JoinGuildMediator
