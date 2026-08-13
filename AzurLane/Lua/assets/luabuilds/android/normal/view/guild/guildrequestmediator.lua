class = var_0_10000

local var_0_0 = "GuildRequestMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.ACCPET = "GuildRequestMediator:ACCPET"
var_0_1.REJECT = "GuildRequestMediator:REJECT"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)

	arg_1_0.guild = var_1.getData(var_1_0)

	if not var_1:getSortRequest() or var_1.requestCount > 0 then
		local var_1_1 = arg_1_0
		local var_1_2 = arg_1_0.sendNotification

		GAME = var_1_10005

		var_1_2(var_1_1, var_1_10005.GUILD_GET_REQUEST_LIST, arg_1_0.guild.id)
		var_1:ResetRequestCount()
	else
		local var_1_3 = arg_1_0.viewComponent

		var_3.setRequest(var_1_3, var_2)

		local var_1_4 = arg_1_0.viewComponent

		var_3.initRequests(var_1_4)
	end

	arg_1_0:bind(var_0_1.ACCPET, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.GUIDL_REQUEST_ACCEPT, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_1.REJECT, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.GUIDL_REQUEST_REJECT, arg_3_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GuildProxy = var_1_10002
	var_4_0[1] = var_1_10002.REQUEST_DELETED
	GAME = var_2
	var_4_0[2] = var_2.GUILD_GET_REQUEST_LIST_DONE
	GuildProxy = var_2
	var_4_0[3] = var_2.REQUEST_COUNT_UPDATED

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1
	local var_5_2 = arg_5_1.getBody(var_5_1)

	GuildProxy = var_5_1

	if var_5_0 == var_5_1.REQUEST_DELETED then
		local var_5_3 = arg_5_0.viewComponent

		var_4.deleteRequest(var_5_3, var_5_2)
	else
		GAME = var_4

		local var_5_5

		if var_5_0 == var_4.GUILD_GET_REQUEST_LIST_DONE then
			local var_5_4 = arg_5_0.viewComponent

			var_5_5.setRequest(var_5_4, var_5_2)

			if not arg_5_0.viewComponent.isInit then
				var_5_5 = arg_5_0.viewComponent
				var_5_5.isInit = true

				local var_5_6 = arg_5_0.viewComponent

				var_5_5.initRequests(var_5_6)
			else
				local var_5_7 = arg_5_0.viewComponent

				var_5_5.SetTotalCount(var_5_7)
			end
		else
			GuildProxy = var_5_5

			if var_5_0 == var_5_5.REQUEST_COUNT_UPDATED then
				local var_5_8 = arg_5_0
				local var_5_9 = arg_5_0.sendNotification

				GAME = var_1_10006

				var_5_9(var_5_8, var_1_10006.GUILD_GET_REQUEST_LIST, arg_5_0.guild.id)

				getProxy = var_5_9
				GuildProxy = var_5_8

				local var_5_10 = var_5_9(var_5_8)

				var_4.ResetRequestCount(var_5_10)
			end
		end
	end

	return
end

return var_0_1
