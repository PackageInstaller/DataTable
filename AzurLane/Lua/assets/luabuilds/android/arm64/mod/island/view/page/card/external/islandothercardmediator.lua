class = var_0_10000

local var_0_0 = "IslandOtherCardMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.GIVE_CARD_LIKE = "IslandOtherCardMediator.GIVE_CARD_LIKE"
var_0_1.GIVE_CARD_LABEL = "IslandOtherCardMediator.GIVE_CARD_LABEL"
var_0_1.ADD_FRIEND = "IslandOtherCardMediator.ADD_FRIEND"
var_0_1.REMOVE_FRIEND = "IslandOtherCardMediator.REMOVE_FRIEND"
var_0_1.ADD_WHITE_LIST = "IslandOtherCardMediator.ADD_WHITE_LIST"
var_0_1.ADD_BLACK_LIST = "IslandOtherCardMediator.ADD_BLACK_LIST"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GIVE_CARD_LIKE, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.ISLAND_GIVE_CARD_LIKE, {
			userId = arg_2_1,
			callback = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.GIVE_CARD_LABEL, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10006

		var_3_1(var_3_0, var_2_10006.ISLAND_GIVE_CARD_LABEL, {
			userId = arg_3_1,
			labelId = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ADD_FRIEND, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10006

		var_4_1(var_4_0, var_2_10006.FRIEND_SEND_REQUEST, {
			id = arg_4_1,
			msg = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.REMOVE_FRIEND, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.FRIEND_DELETE, arg_5_1)

		return
	end)
	arg_1_0:bind(var_0_1.ADD_WHITE_LIST, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_6_2 = var_2_10005.ISLAND_ACCESS_OP
		local var_6_3 = {}

		IslandConst = var_2_10007
		var_6_3.op = var_2_10007.ACCESS_OP_ADD_WHITELIST
		var_6_3.list = {
			arg_6_1
		}

		var_6_1(var_6_0, var_6_2, var_6_3)

		return
	end)
	arg_1_0:bind(var_0_1.ADD_BLACK_LIST, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_7_2 = var_2_10005.ISLAND_ACCESS_OP
		local var_7_3 = {}

		IslandConst = var_2_10007
		var_7_3.op = var_2_10007.ACCESS_OP_ADD_BLACKLIST
		var_7_3.list = {
			arg_7_1
		}

		var_7_1(var_7_0, var_7_2, var_7_3)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	GAME = var_1_10002
	var_8_0[1] = var_1_10002.ISLAND_GIVE_CARD_LIKE_DONE
	GAME = var_2
	var_8_0[2] = var_2.ISLAND_GIVE_CARD_LABEL_DONE
	GAME = var_2
	var_8_0[3] = var_2.FRIEND_SEND_REQUEST_DONE
	FriendProxy = var_2
	var_8_0[4] = var_2.FRIEND_ADDED
	GAME = var_2
	var_8_0[5] = var_2.FRIEND_DELETE_DONE
	GAME = var_2
	var_8_0[6] = var_2.ISLAND_ACCESS_OP_DONE

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1
	local var_9_1 = arg_9_1.getName(var_9_0)
	local var_9_2 = arg_9_1:getBody()

	GAME = var_9_0

	if var_9_1 == var_9_0.ISLAND_GIVE_CARD_LIKE_DONE then
		local var_9_3 = arg_9_0.viewComponent

		var_4.OnGiveLikeDone(var_9_3)
	else
		GAME = var_4

		if var_9_1 == var_4.ISLAND_GIVE_CARD_LABEL_DONE then
			local var_9_4 = arg_9_0.viewComponent

			var_4.OnGiveLabelDone(var_9_4, var_9_2.labelId)
		else
			GAME = var_4

			if var_9_1 == var_4.FRIEND_SEND_REQUEST_DONE then
				local var_9_5 = arg_9_0.viewComponent

				var_4.OnAddFriendDone(var_9_5, var_9_2)
			else
				FriendProxy = var_4

				if var_9_1 == var_4.FRIEND_ADDED then
					local var_9_6 = arg_9_0.viewComponent

					var_4.OnAddFriendPass(var_9_6, var_9_2.id)
				else
					GAME = var_4

					if var_9_1 == var_4.FRIEND_DELETE_DONE then
						local var_9_7 = arg_9_0.viewComponent

						var_4.OnRemoveFriendDone(var_9_7)
					else
						GAME = var_4

						if var_9_1 == var_4.ISLAND_ACCESS_OP_DONE then
							local var_9_8 = arg_9_0.viewComponent

							var_4.OnAccessOpDone(var_9_8, var_9_2.clientOp)
						end
					end
				end
			end
		end
	end

	return
end

return var_0_1
