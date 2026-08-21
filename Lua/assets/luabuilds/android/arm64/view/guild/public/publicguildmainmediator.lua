local var_0_0 = class("PublicGuildMainMediator", import("...base.ContextMediator"))

var_0_0.ON_COMMIT = "PublicGuildMainMediator:ON_COMMIT"
var_0_0.UPGRADE_TECH = "PublicGuildMainMediator:UPGRADE_TECH"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_COMMIT, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.PUBLIC_GUILD_COMMIT_DONATE, {
			id = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.UPGRADE_TECH, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.PULIC_GUILD_UPGRADE_TECH, {
			id = arg_3_1
		})

		return
	end)
	arg_1_0.viewComponent:SetPublicGuild((getProxy(GuildProxy):GetPublicGuild()))
	arg_1_0.viewComponent:SetPlayer(getProxy(PlayerProxy):getData())

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		GAME.PUBLIC_GUILD_COMMIT_DONATE_DONE,
		GAME.PUBLIC_GUILD_REFRESH_DONATE_LIST_DONE,
		PlayerProxy.UPDATED,
		GAME.PULIC_GUILD_UPGRADE_TECH_DONE,
		GAME.GET_PUBLIC_GUILD_USER_DATA_DONE
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.PUBLIC_GUILD_COMMIT_DONATE_DONE then
		arg_5_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_1.awards)
		arg_5_0.viewComponent:OnUpdateDonateList()
	elseif var_5_0 == GAME.PUBLIC_GUILD_REFRESH_DONATE_LIST_DONE then
		arg_5_0.viewComponent:OnUpdateDonateList()
	elseif var_5_0 == PlayerProxy.UPDATED then
		arg_5_0.viewComponent:OnPlayerUpdate(var_5_1)
	elseif var_5_0 == GAME.PULIC_GUILD_UPGRADE_TECH_DONE then
		arg_5_0.viewComponent:OnTechGroupUpdate(var_5_1.id)
	elseif var_5_0 == GAME.GET_PUBLIC_GUILD_USER_DATA_DONE then
		arg_5_0.viewComponent:SetPublicGuild((getProxy(GuildProxy):GetPublicGuild()))
		arg_5_0.viewComponent:RefreshAll()
	end

	return
end

return var_0_0
