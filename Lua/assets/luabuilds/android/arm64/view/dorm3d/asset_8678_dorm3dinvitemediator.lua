local Dorm3dInviteMediator = class("Dorm3dInviteMediator", import("view.base.ContextMediator"))

Dorm3dInviteMediator.ON_DORM = "Dorm3dInviteMediator.ON_DORM"
Dorm3dInviteMediator.ON_UNLOCK_DORM_ROOM = "Dorm3dInviteMediator.ON_UNLOCK_DORM_ROOM"
Dorm3dInviteMediator.OPEN_ROOM_UNLOCK_WINDOW = "Dorm3dInviteMediator.OPEN_ROOM_UNLOCK_WINDOW"

function Dorm3dInviteMediator:register()
	self:bind(Dorm3dInviteMediator.ON_DORM, function(arg_2_0, arg_2_1)
		self:sendNotification(Dorm3dInviteMediator.ON_DORM, arg_2_1)

		return
	end)
	self:bind(Dorm3dInviteMediator.OPEN_ROOM_UNLOCK_WINDOW, function(arg_3_0, arg_3_1, arg_3_2)
		self:addSubLayers(Context.New({
			viewComponent = Dorm3dRoomUnlockWindow,
			mediator = Dorm3dRoomUnlockWindowMediator,
			data = {
				roomId = arg_3_1,
				groupId = arg_3_2
			},
			onRemoved = function()
				self.viewComponent:ShowSelectPanel()

				return
			end
		}))

		return
	end)
	self.viewComponent:UpdateRoom(getProxy(ApartmentProxy):getRoom(self.contextData.roomId))

	return
end

function Dorm3dInviteMediator:initNotificationHandleDic()
	self.handleDic = {
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

return Dorm3dInviteMediator
