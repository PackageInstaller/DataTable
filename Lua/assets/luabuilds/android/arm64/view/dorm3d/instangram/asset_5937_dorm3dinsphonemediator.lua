local Dorm3dInsPhoneMediator = class("Dorm3dInsPhoneMediator", import("view.base.ContextMediator"))

Dorm3dInsPhoneMediator.ON_DORM = "Dorm3dInsPhoneMediator.ON_DORM"
Dorm3dInsPhoneMediator.MARK_READ = "Dorm3dInsPhoneMediator.MARK_READ"

function Dorm3dInsPhoneMediator:register()
	self:bind(Dorm3dInsPhoneMediator.ON_DORM, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.DORM3D_ROOM, {
			isVideoTalk = true,
			roomId = arg_2_1.roomId,
			groupIds = arg_2_1.groupIds,
			specialId = arg_2_1.specialId
		})

		return
	end)
	self:bind(Dorm3dInsPhoneMediator.MARK_READ, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.DORM3D_INS_PHONE_OP, {
			groupId = arg_3_1.groupId,
			id = arg_3_1.id
		})

		return
	end)

	return
end

function Dorm3dInsPhoneMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.DORM3D_INS_PHONE_OP_DONE] = function(arg_5_0)
			self.viewComponent:Flush()

			return
		end
	}

	return
end

return Dorm3dInsPhoneMediator
