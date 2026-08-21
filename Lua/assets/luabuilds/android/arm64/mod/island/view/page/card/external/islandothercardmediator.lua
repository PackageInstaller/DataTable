local var_0_0 = class("IslandOtherCardMediator", import("view.base.ContextMediator"))

var_0_0.GIVE_CARD_LIKE = "IslandOtherCardMediator.GIVE_CARD_LIKE"
var_0_0.GIVE_CARD_LABEL = "IslandOtherCardMediator.GIVE_CARD_LABEL"
var_0_0.ADD_FRIEND = "IslandOtherCardMediator.ADD_FRIEND"
var_0_0.REMOVE_FRIEND = "IslandOtherCardMediator.REMOVE_FRIEND"
var_0_0.ADD_WHITE_LIST = "IslandOtherCardMediator.ADD_WHITE_LIST"
var_0_0.ADD_BLACK_LIST = "IslandOtherCardMediator.ADD_BLACK_LIST"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GIVE_CARD_LIKE, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.ISLAND_GIVE_CARD_LIKE, {
			userId = arg_2_1,
			callback = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.GIVE_CARD_LABEL, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:sendNotification(GAME.ISLAND_GIVE_CARD_LABEL, {
			userId = arg_3_1,
			labelId = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ADD_FRIEND, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:sendNotification(GAME.FRIEND_SEND_REQUEST, {
			id = arg_4_1,
			msg = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.REMOVE_FRIEND, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.FRIEND_DELETE, arg_5_1)

		return
	end)
	arg_1_0:bind(var_0_0.ADD_WHITE_LIST, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.ISLAND_ACCESS_OP, {
			op = IslandConst.ACCESS_OP_ADD_WHITELIST,
			list = {
				arg_6_1
			}
		})

		return
	end)
	arg_1_0:bind(var_0_0.ADD_BLACK_LIST, function(arg_7_0, arg_7_1)
		arg_1_0:sendNotification(GAME.ISLAND_ACCESS_OP, {
			op = IslandConst.ACCESS_OP_ADD_BLACKLIST,
			list = {
				arg_7_1
			}
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_8_0)
	return {
		GAME.ISLAND_GIVE_CARD_LIKE_DONE,
		GAME.ISLAND_GIVE_CARD_LABEL_DONE,
		GAME.FRIEND_SEND_REQUEST_DONE,
		FriendProxy.FRIEND_ADDED,
		GAME.FRIEND_DELETE_DONE,
		GAME.ISLAND_ACCESS_OP_DONE
	}
end

function var_0_0.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == GAME.ISLAND_GIVE_CARD_LIKE_DONE then
		arg_9_0.viewComponent:OnGiveLikeDone()
	elseif var_9_0 == GAME.ISLAND_GIVE_CARD_LABEL_DONE then
		arg_9_0.viewComponent:OnGiveLabelDone(var_9_1.labelId)
	elseif var_9_0 == GAME.FRIEND_SEND_REQUEST_DONE then
		arg_9_0.viewComponent:OnAddFriendDone(var_9_1)
	elseif var_9_0 == FriendProxy.FRIEND_ADDED then
		arg_9_0.viewComponent:OnAddFriendPass(var_9_1.id)
	elseif var_9_0 == GAME.FRIEND_DELETE_DONE then
		arg_9_0.viewComponent:OnRemoveFriendDone()
	elseif var_9_0 == GAME.ISLAND_ACCESS_OP_DONE then
		arg_9_0.viewComponent:OnAccessOpDone(var_9_1.clientOp)
	end

	return
end

return var_0_0
