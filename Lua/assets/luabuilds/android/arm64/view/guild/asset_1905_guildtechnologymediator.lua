local GuildTechnologyMediator = class("GuildTechnologyMediator", import("..base.ContextMediator"))

GuildTechnologyMediator.ON_UPGRADE = "GuildTechnologyMediator:ON_UPGRADE"
GuildTechnologyMediator.ON_START = "GuildTechnologyMediator:ON_START"
GuildTechnologyMediator.ON_CANCEL_TECH = "GuildTechnologyMediator:ON_CANCEL_TECH"
GuildTechnologyMediator.ON_OPEN_OFFICE = "GuildTechnologyMediator:ON_OPEN_OFFICE"

function GuildTechnologyMediator:register()
	self:bind(GuildTechnologyMediator.ON_OPEN_OFFICE, function()
		self:sendNotification(GuildTechnologyMediator.ON_OPEN_OFFICE)

		return
	end)
	self:bind(GuildTechnologyMediator.ON_CANCEL_TECH, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.GUILD_CANCEL_TECH, {
			id = arg_3_1
		})

		return
	end)
	self:bind(GuildTechnologyMediator.ON_UPGRADE, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.GUILD_START_TECH, {
			id = arg_4_1
		})

		return
	end)
	self:bind(GuildTechnologyMediator.ON_START, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.GUILD_START_TECH_TASK, {
			id = arg_5_1
		})

		return
	end)
	self.viewComponent:setGuild((getProxy(GuildProxy):getData()))

	return
end

function GuildTechnologyMediator:listNotificationInterests()
	return {
		GuildProxy.GUILD_UPDATED,
		GuildProxy.DONATE_UPDTAE,
		GAME.GUILD_START_TECH_DONE,
		GuildProxy.TECHNOLOGY_START,
		GuildProxy.TECHNOLOGY_STOP,
		GAME.HANDLE_GUILD_AND_PUBLIC_GUILD_TECH_DONE
	}
end

function GuildTechnologyMediator:handleNotification(arg_7_1)
	local var_7_0 = arg_7_1:getName()

	if var_7_0 == GuildProxy.GUILD_UPDATED then
		self.viewComponent:UpdateGuild((arg_7_1:getBody()))
	elseif var_7_0 == GAME.GUILD_START_TECH_DONE then
		self.viewComponent:UpdateUpgradeList()
	elseif var_7_0 == GuildProxy.DONATE_UPDTAE or var_7_0 == GuildProxy.TECHNOLOGY_START or var_7_0 == GuildProxy.TECHNOLOGY_STOP then
		self.viewComponent:UpdateBreakOutList()
	elseif var_7_0 == GAME.HANDLE_GUILD_AND_PUBLIC_GUILD_TECH_DONE then
		self.viewComponent:UpdateAll()
	end

	return
end

return GuildTechnologyMediator
