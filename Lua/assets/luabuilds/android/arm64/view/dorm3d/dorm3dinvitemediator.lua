local var_0_0 = class("Dorm3dInviteMediator", import("view.base.ContextMediator"))

var_0_0.ON_DORM = "Dorm3dInviteMediator.ON_DORM"
var_0_0.ON_UNLOCK_DORM_ROOM = "Dorm3dInviteMediator.ON_UNLOCK_DORM_ROOM"
var_0_0.OPEN_ROOM_UNLOCK_WINDOW = "Dorm3dInviteMediator.OPEN_ROOM_UNLOCK_WINDOW"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_DORM, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(Dorm3dInviteMediator.ON_DORM, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_ROOM_UNLOCK_WINDOW, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dRoomUnlockWindow,
			mediator = Dorm3dRoomUnlockWindowMediator,
			data = {
				roomId = arg_3_1,
				groupId = arg_3_2
			},
			onRemoved = function()
				arg_1_0.viewComponent:ShowSelectPanel()

				return
			end
		}))

		return
	end)
	arg_1_0.viewComponent:UpdateRoom(getProxy(ApartmentProxy):getRoom(arg_1_0.contextData.roomId))

	return
end

function var_0_0.initNotificationHandleDic(arg_5_0)
	arg_5_0.handleDic = {
		[GAME.APARTMENT_ROOM_INVITE_UNLOCK_DONE] = function(arg_6_0, arg_6_1)
			local var_6_0 = arg_6_1:getBody()

			return
		end,
		[ApartmentProxy.UPDATE_ROOM] = function(arg_7_0, arg_7_1)
			local var_7_0 = arg_7_1:getBody()

			if var_7_0.id == arg_7_0.contextData.roomId then
				arg_7_0.viewComponent:UpdateRoom(var_7_0)
			end

			return
		end
	}

	return
end

return var_0_0
