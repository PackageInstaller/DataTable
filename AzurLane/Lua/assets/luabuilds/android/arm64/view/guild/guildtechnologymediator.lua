local var_0_0 = class("GuildTechnologyMediator", import("..base.ContextMediator"))

var_0_0.ON_UPGRADE = "GuildTechnologyMediator:ON_UPGRADE"
var_0_0.ON_START = "GuildTechnologyMediator:ON_START"
var_0_0.ON_CANCEL_TECH = "GuildTechnologyMediator:ON_CANCEL_TECH"
var_0_0.ON_OPEN_OFFICE = "GuildTechnologyMediator:ON_OPEN_OFFICE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_OPEN_OFFICE, function()
		arg_1_0:sendNotification(var_0_0.ON_OPEN_OFFICE)

		return
	end)
	arg_1_0:bind(var_0_0.ON_CANCEL_TECH, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.GUILD_CANCEL_TECH, {
			id = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_UPGRADE, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.GUILD_START_TECH, {
			id = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_START, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.GUILD_START_TECH_TASK, {
			id = arg_5_1
		})

		return
	end)
	arg_1_0.viewComponent:setGuild((getProxy(GuildProxy):getData()))

	return
end

function var_0_0.listNotificationInterests(arg_6_0)
	return {
		GuildProxy.GUILD_UPDATED,
		GuildProxy.DONATE_UPDTAE,
		GAME.GUILD_START_TECH_DONE,
		GuildProxy.TECHNOLOGY_START,
		GuildProxy.TECHNOLOGY_STOP,
		GAME.HANDLE_GUILD_AND_PUBLIC_GUILD_TECH_DONE
	}
end

function var_0_0.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getName()

	if var_7_0 == GuildProxy.GUILD_UPDATED then
		arg_7_0.viewComponent:UpdateGuild((arg_7_1:getBody()))
	elseif var_7_0 == GAME.GUILD_START_TECH_DONE then
		arg_7_0.viewComponent:UpdateUpgradeList()
	elseif var_7_0 == GuildProxy.DONATE_UPDTAE or var_7_0 == GuildProxy.TECHNOLOGY_START or var_7_0 == GuildProxy.TECHNOLOGY_STOP then
		arg_7_0.viewComponent:UpdateBreakOutList()
	elseif var_7_0 == GAME.HANDLE_GUILD_AND_PUBLIC_GUILD_TECH_DONE then
		arg_7_0.viewComponent:UpdateAll()
	end

	return
end

return var_0_0
