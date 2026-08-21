local var_0_0 = class("GuildRequestMediator", import("..base.ContextMediator"))

var_0_0.ACCPET = "GuildRequestMediator:ACCPET"
var_0_0.REJECT = "GuildRequestMediator:REJECT"

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(GuildProxy)

	arg_1_0.guild = var_1_0:getData()

	local var_1_1 = var_1_0:getSortRequest()

	if not var_1_1 or var_1_0.requestCount > 0 then
		arg_1_0:sendNotification(GAME.GUILD_GET_REQUEST_LIST, arg_1_0.guild.id)
		var_1_0:ResetRequestCount()
	else
		arg_1_0.viewComponent:setRequest(var_1_1)
		arg_1_0.viewComponent:initRequests()
	end

	arg_1_0:bind(var_0_0.ACCPET, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.GUIDL_REQUEST_ACCEPT, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_0.REJECT, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.GUIDL_REQUEST_REJECT, arg_3_1)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		GuildProxy.REQUEST_DELETED,
		GAME.GUILD_GET_REQUEST_LIST_DONE,
		GuildProxy.REQUEST_COUNT_UPDATED
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GuildProxy.REQUEST_DELETED then
		arg_5_0.viewComponent:deleteRequest(var_5_1)
	elseif var_5_0 == GAME.GUILD_GET_REQUEST_LIST_DONE then
		arg_5_0.viewComponent:setRequest(var_5_1)

		if not arg_5_0.viewComponent.isInit then
			arg_5_0.viewComponent.isInit = true

			arg_5_0.viewComponent:initRequests()
		else
			arg_5_0.viewComponent:SetTotalCount()
		end
	elseif var_5_0 == GuildProxy.REQUEST_COUNT_UPDATED then
		arg_5_0:sendNotification(GAME.GUILD_GET_REQUEST_LIST, arg_5_0.guild.id)
		getProxy(GuildProxy):ResetRequestCount()
	end

	return
end

return var_0_0
