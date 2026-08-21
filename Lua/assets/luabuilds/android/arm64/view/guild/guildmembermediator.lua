local var_0_0 = class("GuildMemberMediator", import("..base.ContextMediator"))

var_0_0.OPEN_DESC_INFO = "GuildMemberMediator:OPEN_DESC_INFO"
var_0_0.FIRE = "GuildMemberMediator:FIRE"
var_0_0.SET_DUTY = "GuildMemberMediator:SET_DUTY"
var_0_0.IMPEACH = "GuildMemberMediator:IMPEACH"
var_0_0.GET_RANK = "GuildMemberMediator:GET_RANK"

function var_0_0.register(arg_1_0)
	arg_1_0.viewComponent:setPlayerVO((getProxy(PlayerProxy):getData()))
	arg_1_0.viewComponent:setGuildVO(getProxy(GuildProxy):getData())
	arg_1_0:bind(var_0_0.GET_RANK, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.GUILD_GET_RANK, {
			id = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_DESC_INFO, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.FRIEND_SEARCH, {
			type = SearchFriendCommand.SEARCH_TYPE_RESUME,
			keyword = arg_3_1.id
		})

		return
	end)
	arg_1_0:bind(var_0_0.FIRE, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.GUILD_FIRE, arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_0.SET_DUTY, function(arg_5_0, arg_5_1, arg_5_2)
		arg_1_0:sendNotification(GAME.SET_GUILD_DUTY, {
			playerId = arg_5_1,
			dutyId = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.IMPEACH, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.GUILD_IMPEACH, arg_6_1)

		return
	end)
	arg_1_0.viewComponent:SetRanks((getProxy(GuildProxy):GetRanks()))

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		GuildProxy.GUILD_UPDATED,
		GAME.SET_GUILD_DUTY_DONE,
		GAME.GUILD_FIRE_DONE,
		GAME.FRIEND_SEARCH_DONE,
		GAME.GUILD_GET_RANK_DONE
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GuildProxy.GUILD_UPDATED then
		arg_8_0.viewComponent:setGuildVO(var_8_1)
		arg_8_0.viewComponent:RefreshMembers()
	elseif var_8_0 == GAME.SET_GUILD_DUTY_DONE then
		arg_8_0.viewComponent:LoadPainting(var_8_1)
	elseif var_8_0 == GAME.GUILD_FIRE_DONE then
		arg_8_0.viewComponent:ActiveDefaultMenmber()
	elseif var_8_0 == GAME.FRIEND_SEARCH_DONE then
		arg_8_0.viewComponent:ShowInfoPanel(var_8_1.list[1])
	elseif var_8_0 == GAME.GUILD_GET_RANK_DONE then
		arg_8_0.viewComponent:UpdateRankList(var_8_1.id, var_8_1.list)
	end

	return
end

return var_0_0
