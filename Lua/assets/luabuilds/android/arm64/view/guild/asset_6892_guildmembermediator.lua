local GuildMemberMediator = class("GuildMemberMediator", import("..base.ContextMediator"))

GuildMemberMediator.OPEN_DESC_INFO = "GuildMemberMediator:OPEN_DESC_INFO"
GuildMemberMediator.FIRE = "GuildMemberMediator:FIRE"
GuildMemberMediator.SET_DUTY = "GuildMemberMediator:SET_DUTY"
GuildMemberMediator.IMPEACH = "GuildMemberMediator:IMPEACH"
GuildMemberMediator.GET_RANK = "GuildMemberMediator:GET_RANK"

function GuildMemberMediator:register()
	self.viewComponent:setPlayerVO((getProxy(PlayerProxy):getData()))
	self.viewComponent:setGuildVO(getProxy(GuildProxy):getData())
	self:bind(GuildMemberMediator.GET_RANK, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.GUILD_GET_RANK, {
			id = arg_2_1
		})

		return
	end)
	self:bind(GuildMemberMediator.OPEN_DESC_INFO, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.FRIEND_SEARCH, {
			type = SearchFriendCommand.SEARCH_TYPE_RESUME,
			keyword = arg_3_1.id
		})

		return
	end)
	self:bind(GuildMemberMediator.FIRE, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.GUILD_FIRE, arg_4_1)

		return
	end)
	self:bind(GuildMemberMediator.SET_DUTY, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.SET_GUILD_DUTY, {
			playerId = arg_5_1,
			dutyId = arg_5_2
		})

		return
	end)
	self:bind(GuildMemberMediator.IMPEACH, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.GUILD_IMPEACH, arg_6_1)

		return
	end)
	self.viewComponent:SetRanks((getProxy(GuildProxy):GetRanks()))

	return
end

function GuildMemberMediator:listNotificationInterests()
	return {
		GuildProxy.GUILD_UPDATED,
		GAME.SET_GUILD_DUTY_DONE,
		GAME.GUILD_FIRE_DONE,
		GAME.FRIEND_SEARCH_DONE,
		GAME.GUILD_GET_RANK_DONE
	}
end

function GuildMemberMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GuildProxy.GUILD_UPDATED then
		self.viewComponent:setGuildVO(var_8_1)
		self.viewComponent:RefreshMembers()
	elseif var_8_0 == GAME.SET_GUILD_DUTY_DONE then
		self.viewComponent:LoadPainting(var_8_1)
	elseif var_8_0 == GAME.GUILD_FIRE_DONE then
		self.viewComponent:ActiveDefaultMenmber()
	elseif var_8_0 == GAME.FRIEND_SEARCH_DONE then
		self.viewComponent:ShowInfoPanel(var_8_1.list[1])
	elseif var_8_0 == GAME.GUILD_GET_RANK_DONE then
		self.viewComponent:UpdateRankList(var_8_1.id, var_8_1.list)
	end

	return
end

return GuildMemberMediator
