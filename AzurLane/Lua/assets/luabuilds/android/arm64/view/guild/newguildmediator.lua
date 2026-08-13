class = var_0_10000

local var_0_0 = "NewGuildMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.OPEN_GUILD_LIST = "NewGuildMediator:OPEN_GUILD_LIST"
var_0_1.CREATE = "NewGuildMediator:CREATE"
var_0_1.OPEN_PUBLIC_GUILD = "NewGuildMediator:OPEN_PUBLIC_GUILD"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1 = var_1.getData(var_1_0)
	local var_1_2 = arg_1_0.viewComponent

	var_3.setPlayer(var_1_2, var_1_1)
	arg_1_0:bind(var_0_1.OPEN_PUBLIC_GUILD, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_2_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_2_1(var_2_0, var_2_2, var_2_10005.PUBLIC_GUILD)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_GUILD_LIST, function(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_3_2 = var_2_10004.New
		local var_3_3 = {}

		JoinGuildLayer = var_2_10007
		var_3_3.viewComponent = var_2_10007
		JoinGuildMediator = var_2_10007
		var_3_3.mediator = var_2_10007

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.CREATE, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.CREATE_GUILD, arg_4_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GuildProxy = var_1_10002
	var_5_0[1] = var_1_10002.NEW_GUILD_ADDED
	PlayerProxy = var_2
	var_5_0[2] = var_2.UPDATED
	GAME = var_2
	var_5_0[3] = var_2.CREATE_GUILD_DONE
	GAME = var_2
	var_5_0[4] = var_2.REMOVE_LAYERS

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1
	local var_6_3 = arg_6_1.getBody(var_6_2)

	GuildProxy = var_6_0

	local var_6_5

	if var_6_1 == var_6_0.NEW_GUILD_ADDED then
		local var_6_4 = arg_6_0

		var_6_5 = arg_6_0.sendNotification
		GAME = var_1_10007

		local var_6_6 = var_1_10007.GO_SCENE

		SCENE = var_1_10008

		var_6_5(var_6_4, var_6_6, var_1_10008.GUILD)
	else
		PlayerProxy = var_6_5

		if var_6_1 == var_6_5.UPDATED then
			local var_6_7 = arg_6_0.viewComponent

			var_4.setPlayer(var_6_7, var_6_3)
		else
			GAME = var_4

			if var_6_1 == var_4.CREATE_GUILD_DONE then
				local var_6_8 = arg_6_0.viewComponent

				var_4.ClosePage(var_6_8)
			else
				GAME = var_4

				if var_6_1 == var_4.REMOVE_LAYERS then
					local var_6_9 = var_6_3.context.mediator

					JoinGuildMediator = var_6_2

					if var_6_9 == var_6_2 then
						local var_6_10 = arg_6_0.viewComponent

						var_4.startCreate(var_6_10)
					end
				end
			end
		end
	end

	return
end

return var_0_1
