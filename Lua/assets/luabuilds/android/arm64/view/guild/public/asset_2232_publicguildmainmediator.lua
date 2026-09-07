local PublicGuildMainMediator = class("PublicGuildMainMediator", import("...base.ContextMediator"))

PublicGuildMainMediator.ON_COMMIT = "PublicGuildMainMediator:ON_COMMIT"
PublicGuildMainMediator.UPGRADE_TECH = "PublicGuildMainMediator:UPGRADE_TECH"

function PublicGuildMainMediator:register()
	self:bind(PublicGuildMainMediator.ON_COMMIT, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.PUBLIC_GUILD_COMMIT_DONATE, {
			id = arg_2_1
		})

		return
	end)
	self:bind(PublicGuildMainMediator.UPGRADE_TECH, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.PULIC_GUILD_UPGRADE_TECH, {
			id = arg_3_1
		})

		return
	end)
	self.viewComponent:SetPublicGuild((getProxy(GuildProxy):GetPublicGuild()))
	self.viewComponent:SetPlayer(getProxy(PlayerProxy):getData())

	return
end

function PublicGuildMainMediator:listNotificationInterests()
	return {
		GAME.PUBLIC_GUILD_COMMIT_DONATE_DONE,
		GAME.PUBLIC_GUILD_REFRESH_DONATE_LIST_DONE,
		PlayerProxy.UPDATED,
		GAME.PULIC_GUILD_UPGRADE_TECH_DONE,
		GAME.GET_PUBLIC_GUILD_USER_DATA_DONE
	}
end

function PublicGuildMainMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.PUBLIC_GUILD_COMMIT_DONATE_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_1.awards)
		self.viewComponent:OnUpdateDonateList()
	elseif var_5_0 == GAME.PUBLIC_GUILD_REFRESH_DONATE_LIST_DONE then
		self.viewComponent:OnUpdateDonateList()
	elseif var_5_0 == PlayerProxy.UPDATED then
		self.viewComponent:OnPlayerUpdate(var_5_1)
	elseif var_5_0 == GAME.PULIC_GUILD_UPGRADE_TECH_DONE then
		self.viewComponent:OnTechGroupUpdate(var_5_1.id)
	elseif var_5_0 == GAME.GET_PUBLIC_GUILD_USER_DATA_DONE then
		self.viewComponent:SetPublicGuild((getProxy(GuildProxy):GetPublicGuild()))
		self.viewComponent:RefreshAll()
	end

	return
end

return PublicGuildMainMediator
