local Dorm3dRoomUnlockWindowMediator = class("Dorm3dRoomUnlockWindowMediator", import("view.base.ContextMediator"))

Dorm3dRoomUnlockWindowMediator.ON_UNLOCK_DORM_ROOM = "Dorm3dRoomUnlockWindowMediator.ON_UNLOCK_DORM_ROOM"
Dorm3dRoomUnlockWindowMediator.ON_UNLOCK_ROOM_INVITE = "Dorm3dRoomUnlockWindowMediator.ON_UNLOCK_ROOM_INVITE"

function Dorm3dRoomUnlockWindowMediator:register()
	self:bind(Dorm3dRoomUnlockWindowMediator.ON_UNLOCK_DORM_ROOM, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.APARTMENT_ROOM_UNLOCK, {
			roomId = arg_2_1
		})

		return
	end)
	self:bind(Dorm3dRoomUnlockWindowMediator.ON_UNLOCK_ROOM_INVITE, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.APARTMENT_ROOM_INVITE_UNLOCK, {
			roomId = arg_3_1,
			groupId = arg_3_2
		})

		return
	end)

	return
end

function Dorm3dRoomUnlockWindowMediator:initNotificationHandleDic()
	self.handleDic = {
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

function Dorm3dRoomUnlockWindowMediator:remove()
	return
end

return Dorm3dRoomUnlockWindowMediator
