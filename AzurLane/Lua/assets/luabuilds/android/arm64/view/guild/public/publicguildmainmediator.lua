class = var_0_10000

local var_0_0 = "PublicGuildMainMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.ON_COMMIT = "PublicGuildMainMediator:ON_COMMIT"
var_0_1.UPGRADE_TECH = "PublicGuildMainMediator:UPGRADE_TECH"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_COMMIT, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.PUBLIC_GUILD_COMMIT_DONATE, {
			id = arg_2_1
		})

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.UPGRADE_TECH, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.PULIC_GUILD_UPGRADE_TECH, {
			id = arg_3_1
		})

		return
	end)

	getProxy = var_1
	GuildProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.GetPublicGuild(var_1_1)
	local var_1_3 = arg_1_0.viewComponent

	var_2.SetPublicGuild(var_1_3, var_1_2)

	local var_1_4 = arg_1_0.viewComponent
	local var_1_5 = var_2.SetPlayer

	getProxy = var_5
	PlayerProxy = var_1_10007

	local var_1_6 = var_5(var_1_10007)

	var_1_5(var_1_4, var_5.getData(var_1_6))

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[1] = var_1_10002.PUBLIC_GUILD_COMMIT_DONATE_DONE
	GAME = var_2
	var_4_0[2] = var_2.PUBLIC_GUILD_REFRESH_DONATE_LIST_DONE
	PlayerProxy = var_2
	var_4_0[3] = var_2.UPDATED
	GAME = var_2
	var_4_0[4] = var_2.PULIC_GUILD_UPGRADE_TECH_DONE
	GAME = var_2
	var_4_0[5] = var_2.GET_PUBLIC_GUILD_USER_DATA_DONE

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getName(var_5_0)
	local var_5_2 = arg_5_1:getBody()

	GAME = var_5_0

	local var_5_3

	if var_5_1 == var_5_0.PUBLIC_GUILD_COMMIT_DONATE_DONE then
		var_1_10006 = arg_5_0.viewComponent
		var_5_3 = var_5_3.emit
		BaseUI = var_1_10007

		var_5_3(var_1_10006, var_1_10007.ON_ACHIEVE, var_5_2.awards)

		var_1_10006 = arg_5_0.viewComponent

		var_5_3.OnUpdateDonateList(var_1_10006)
	else
		GAME = var_5_3

		if var_5_1 == var_5_3.PUBLIC_GUILD_REFRESH_DONATE_LIST_DONE then
			var_1_10006 = arg_5_0.viewComponent

			var_4.OnUpdateDonateList(var_1_10006)
		else
			PlayerProxy = var_4

			if var_5_1 == var_4.UPDATED then
				var_1_10006 = arg_5_0.viewComponent

				var_4.OnPlayerUpdate(var_1_10006, var_5_2)
			else
				GAME = var_4

				if var_5_1 == var_4.PULIC_GUILD_UPGRADE_TECH_DONE then
					var_1_10006 = arg_5_0.viewComponent

					var_4.OnTechGroupUpdate(var_1_10006, var_5_2.id)
				else
					GAME = var_4

					if var_5_1 == var_4.GET_PUBLIC_GUILD_USER_DATA_DONE then
						getProxy = var_4
						GuildProxy = var_1_10006

						local var_5_4 = var_4(var_1_10006)
						local var_5_5 = var_4.GetPublicGuild(var_5_4)
						local var_5_6 = arg_5_0.viewComponent

						var_5.SetPublicGuild(var_5_6, var_5_5)

						local var_5_7 = arg_5_0.viewComponent

						var_5.RefreshAll(var_5_7)
					end
				end
			end
		end
	end

	return
end

return var_0_1
