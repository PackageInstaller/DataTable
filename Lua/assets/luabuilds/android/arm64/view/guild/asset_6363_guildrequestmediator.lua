local GuildRequestMediator = class("GuildRequestMediator", import("..base.ContextMediator"))

GuildRequestMediator.ACCPET = "GuildRequestMediator:ACCPET"
GuildRequestMediator.REJECT = "GuildRequestMediator:REJECT"

function GuildRequestMediator:register()
	local var_1_0 = getProxy(GuildProxy)

	self.guild = var_1_0:getData()

	local var_1_1 = var_1_0:getSortRequest()

	if not var_1_1 or var_1_0.requestCount > 0 then
		self:sendNotification(GAME.GUILD_GET_REQUEST_LIST, self.guild.id)
		var_1_0:ResetRequestCount()
	else
		self.viewComponent:setRequest(var_1_1)
		self.viewComponent:initRequests()
	end

	self:bind(GuildRequestMediator.ACCPET, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.GUIDL_REQUEST_ACCEPT, arg_2_1)

		return
	end)
	self:bind(GuildRequestMediator.REJECT, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.GUIDL_REQUEST_REJECT, arg_3_1)

		return
	end)

	return
end

function GuildRequestMediator:listNotificationInterests()
	return {
		GuildProxy.REQUEST_DELETED,
		GAME.GUILD_GET_REQUEST_LIST_DONE,
		GuildProxy.REQUEST_COUNT_UPDATED
	}
end

function GuildRequestMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GuildProxy.REQUEST_DELETED then
		self.viewComponent:deleteRequest(var_5_1)
	elseif var_5_0 == GAME.GUILD_GET_REQUEST_LIST_DONE then
		self.viewComponent:setRequest(var_5_1)

		if not self.viewComponent.isInit then
			self.viewComponent.isInit = true

			self.viewComponent:initRequests()
		else
			self.viewComponent:SetTotalCount()
		end
	elseif var_5_0 == GuildProxy.REQUEST_COUNT_UPDATED then
		self:sendNotification(GAME.GUILD_GET_REQUEST_LIST, self.guild.id)
		getProxy(GuildProxy):ResetRequestCount()
	end

	return
end

return GuildRequestMediator
