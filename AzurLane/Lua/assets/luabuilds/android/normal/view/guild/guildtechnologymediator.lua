class = var_0_10000

local var_0_0 = "GuildTechnologyMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.ON_UPGRADE = "GuildTechnologyMediator:ON_UPGRADE"
var_0_1.ON_START = "GuildTechnologyMediator:ON_START"
var_0_1.ON_CANCEL_TECH = "GuildTechnologyMediator:ON_CANCEL_TECH"
var_0_1.ON_OPEN_OFFICE = "GuildTechnologyMediator:ON_OPEN_OFFICE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_OPEN_OFFICE, function()
		local var_2_0 = arg_1_0

		var_0.sendNotification(var_2_0, var_0_1.ON_OPEN_OFFICE)

		return
	end)
	arg_1_0:bind(var_0_1.ON_CANCEL_TECH, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.GUILD_CANCEL_TECH, {
			id = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_UPGRADE, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.GUILD_START_TECH, {
			id = arg_4_1
		})

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_START, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10004

		var_5_1(var_5_0, var_2_10004.GUILD_START_TECH_TASK, {
			id = arg_5_1
		})

		return
	end)

	getProxy = var_1
	GuildProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getData(var_1_1)
	local var_1_3 = arg_1_0.viewComponent

	var_3.setGuild(var_1_3, var_1_2)

	return
end

function var_0_1.listNotificationInterests(arg_6_0)
	local var_6_0 = {}

	GuildProxy = var_1_10002
	var_6_0[1] = var_1_10002.GUILD_UPDATED
	GuildProxy = var_2
	var_6_0[2] = var_2.DONATE_UPDTAE
	GAME = var_2
	var_6_0[3] = var_2.GUILD_START_TECH_DONE
	GuildProxy = var_2
	var_6_0[4] = var_2.TECHNOLOGY_START
	GuildProxy = var_2
	var_6_0[5] = var_2.TECHNOLOGY_STOP
	GAME = var_2
	var_6_0[6] = var_2.HANDLE_GUILD_AND_PUBLIC_GUILD_TECH_DONE

	return var_6_0
end

function var_0_1.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1
	local var_7_2 = arg_7_1.getBody(var_7_1)

	GuildProxy = var_7_1

	if var_7_0 == var_7_1.GUILD_UPDATED then
		local var_7_3 = arg_7_0.viewComponent

		var_4.UpdateGuild(var_7_3, var_7_2)

		goto label_7_0
	end

	GAME = var_4

	if var_7_0 == var_4.GUILD_START_TECH_DONE then
		local var_7_4 = arg_7_0.viewComponent

		var_4.UpdateUpgradeList(var_7_4)

		goto label_7_0
	end

	GuildProxy = var_4

	if var_7_0 ~= var_4.DONATE_UPDTAE then
		GuildProxy = var_4

		if var_7_0 ~= var_4.TECHNOLOGY_START then
			GuildProxy = var_4

			if var_7_0 == var_4.TECHNOLOGY_STOP then
				local var_7_5 = arg_7_0.viewComponent

				var_4.UpdateBreakOutList(var_7_5)
			else
				GAME = var_4

				if var_7_0 == var_4.HANDLE_GUILD_AND_PUBLIC_GUILD_TECH_DONE then
					local var_7_6 = arg_7_0.viewComponent

					var_4.UpdateAll(var_7_6)
				end
			end

			::label_7_0::

			return
		end
	end
end

return var_0_1
