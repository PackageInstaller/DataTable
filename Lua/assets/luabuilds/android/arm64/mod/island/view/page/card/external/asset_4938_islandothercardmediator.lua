local IslandOtherCardMediator = class("IslandOtherCardMediator", import("view.base.ContextMediator"))

IslandOtherCardMediator.GIVE_CARD_LIKE = "IslandOtherCardMediator.GIVE_CARD_LIKE"
IslandOtherCardMediator.GIVE_CARD_LABEL = "IslandOtherCardMediator.GIVE_CARD_LABEL"
IslandOtherCardMediator.ADD_FRIEND = "IslandOtherCardMediator.ADD_FRIEND"
IslandOtherCardMediator.REMOVE_FRIEND = "IslandOtherCardMediator.REMOVE_FRIEND"
IslandOtherCardMediator.ADD_WHITE_LIST = "IslandOtherCardMediator.ADD_WHITE_LIST"
IslandOtherCardMediator.ADD_BLACK_LIST = "IslandOtherCardMediator.ADD_BLACK_LIST"

function IslandOtherCardMediator:register()
	self:bind(IslandOtherCardMediator.GIVE_CARD_LIKE, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.ISLAND_GIVE_CARD_LIKE, {
			userId = arg_2_1,
			callback = arg_2_2
		})

		return
	end)
	self:bind(IslandOtherCardMediator.GIVE_CARD_LABEL, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.ISLAND_GIVE_CARD_LABEL, {
			userId = arg_3_1,
			labelId = arg_3_2
		})

		return
	end)
	self:bind(IslandOtherCardMediator.ADD_FRIEND, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.FRIEND_SEND_REQUEST, {
			id = arg_4_1,
			msg = arg_4_2
		})

		return
	end)
	self:bind(IslandOtherCardMediator.REMOVE_FRIEND, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.FRIEND_DELETE, arg_5_1)

		return
	end)
	self:bind(IslandOtherCardMediator.ADD_WHITE_LIST, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.ISLAND_ACCESS_OP, {
			op = IslandConst.ACCESS_OP_ADD_WHITELIST,
			list = {
				arg_6_1
			}
		})

		return
	end)
	self:bind(IslandOtherCardMediator.ADD_BLACK_LIST, function(arg_7_0, arg_7_1)
		self:sendNotification(GAME.ISLAND_ACCESS_OP, {
			op = IslandConst.ACCESS_OP_ADD_BLACKLIST,
			list = {
				arg_7_1
			}
		})

		return
	end)

	return
end

function IslandOtherCardMediator:listNotificationInterests()
	return {
		GAME.ISLAND_GIVE_CARD_LIKE_DONE,
		GAME.ISLAND_GIVE_CARD_LABEL_DONE,
		GAME.FRIEND_SEND_REQUEST_DONE,
		FriendProxy.FRIEND_ADDED,
		GAME.FRIEND_DELETE_DONE,
		GAME.ISLAND_ACCESS_OP_DONE
	}
end

function IslandOtherCardMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == GAME.ISLAND_GIVE_CARD_LIKE_DONE then
		self.viewComponent:OnGiveLikeDone()
	elseif var_9_0 == GAME.ISLAND_GIVE_CARD_LABEL_DONE then
		self.viewComponent:OnGiveLabelDone(var_9_1.labelId)
	elseif var_9_0 == GAME.FRIEND_SEND_REQUEST_DONE then
		self.viewComponent:OnAddFriendDone(var_9_1)
	elseif var_9_0 == FriendProxy.FRIEND_ADDED then
		self.viewComponent:OnAddFriendPass(var_9_1.id)
	elseif var_9_0 == GAME.FRIEND_DELETE_DONE then
		self.viewComponent:OnRemoveFriendDone()
	elseif var_9_0 == GAME.ISLAND_ACCESS_OP_DONE then
		self.viewComponent:OnAccessOpDone(var_9_1.clientOp)
	end

	return
end

return IslandOtherCardMediator
