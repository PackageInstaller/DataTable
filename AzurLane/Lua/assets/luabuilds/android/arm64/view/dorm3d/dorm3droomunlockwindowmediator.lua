class = var_0_10000

local var_0_0 = "Dorm3dRoomUnlockWindowMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_UNLOCK_DORM_ROOM = "Dorm3dRoomUnlockWindowMediator.ON_UNLOCK_DORM_ROOM"
var_0_1.ON_UNLOCK_ROOM_INVITE = "Dorm3dRoomUnlockWindowMediator.ON_UNLOCK_ROOM_INVITE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_UNLOCK_DORM_ROOM, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.APARTMENT_ROOM_UNLOCK, {
			roomId = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_UNLOCK_ROOM_INVITE, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10006

		var_3_1(var_3_0, var_2_10006.APARTMENT_ROOM_INVITE_UNLOCK, {
			roomId = arg_3_1,
			groupId = arg_3_2
		})

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[var_1_10002.APARTMENT_ROOM_UNLOCK_DONE] = function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_1:getBody()
		local var_5_1 = arg_5_0.viewComponent

		var_3.closeView(var_5_1)

		return
	end
	GAME = var_2
	var_4_0[var_2.APARTMENT_ROOM_INVITE_UNLOCK_DONE] = function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_1:getBody()
		local var_6_1 = arg_6_0.viewComponent

		var_3.closeView(var_6_1)

		return
	end
	arg_4_0.handleDic = var_4_0

	return
end

function var_0_1.remove(arg_7_0)
	return
end

return var_0_1
