class = var_0_10000

local var_0_0 = "JoinGuildMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.APPLY = "JoinGuildMediator:APPLY"
var_0_1.REFRESH = "JoinGuildMediator:REFRESH"
var_0_1.SEARCH = "JoinGuildMediator:SEARCH"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.sendNotification

	GAME = var_1_10003

	var_1_1(var_1_0, var_1_10003.GUILD_LIST_REFRESH)

	getProxy = var_1_1
	PlayerProxy = var_1_0

	local var_1_2 = var_1_1(var_1_0)
	local var_1_3 = var_1.getData(var_1_2)
	local var_1_4 = arg_1_0.viewComponent

	var_3.setPlayerVO(var_1_4, var_1_3)
	arg_1_0:bind(var_0_1.APPLY, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.GUILD_APPLY, {
			id = arg_2_1,
			content = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.REFRESH, function(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.sendNotification

		GAME = var_2_10003

		var_3_1(var_3_0, var_2_10003.GUILD_LIST_REFRESH)

		return
	end)
	arg_1_0:bind(var_0_1.SEARCH, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.GUILD_SEARCH, arg_4_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.GUILD_LIST_REFRESH_DONE
	GAME = var_2
	var_5_0[2] = var_2.GUILD_SEARCH_DONE
	GAME = var_2
	var_5_0[3] = var_2.GUILD_APPLY_DONE
	GAME = var_2
	var_5_0[4] = var_2.REMOVE_LAYERS

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1
	local var_6_2 = arg_6_1.getBody(var_6_1)

	GAME = var_6_1

	if var_6_0 ~= var_6_1.GUILD_LIST_REFRESH_DONE then
		GAME = var_4

		if var_6_0 == var_4.GUILD_SEARCH_DONE then
			local var_6_3 = arg_6_0.viewComponent

			var_4.setGuildVOs(var_6_3, var_6_2)

			if arg_6_0.contextData.filterData then
				local var_6_4 = arg_6_0.viewComponent

				var_4.filter(var_6_4)
			else
				local var_6_5 = arg_6_0.viewComponent

				var_4.sortGuilds(var_6_5)
			end
		else
			GAME = var_4

			if var_6_0 == var_4.GUILD_APPLY_DONE then
				local var_6_6 = arg_6_0.viewComponent

				var_4.CloseApply(var_6_6)
			end
		end

		return
	end
end

return var_0_1
