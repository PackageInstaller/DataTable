local var_0_0 = class("Dorm3dRoomUnlockWindowMediator", import("view.base.ContextMediator"))

var_0_0.ON_UNLOCK_DORM_ROOM = "Dorm3dRoomUnlockWindowMediator.ON_UNLOCK_DORM_ROOM"
var_0_0.ON_UNLOCK_ROOM_INVITE = "Dorm3dRoomUnlockWindowMediator.ON_UNLOCK_ROOM_INVITE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_UNLOCK_DORM_ROOM, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.APARTMENT_ROOM_UNLOCK, {
			roomId = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_UNLOCK_ROOM_INVITE, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:sendNotification(GAME.APARTMENT_ROOM_INVITE_UNLOCK, {
			roomId = arg_3_1,
			groupId = arg_3_2
		})

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_4_0)
	arg_4_0.handleDic = {
		[GAME.APARTMENT_ROOM_UNLOCK_DONE] = function(arg_5_0, arg_5_1)
			local var_5_0 = arg_5_1:getBody()

			arg_5_0.viewComponent:closeView()

			return
		end,
		[GAME.APARTMENT_ROOM_INVITE_UNLOCK_DONE] = function(arg_6_0, arg_6_1)
			local var_6_0 = arg_6_1:getBody()

			arg_6_0.viewComponent:closeView()

			return
		end
	}

	return
end

function var_0_0.remove(arg_7_0)
	return
end

return var_0_0
