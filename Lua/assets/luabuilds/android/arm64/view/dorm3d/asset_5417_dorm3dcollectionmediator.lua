local Dorm3dCollectionMediator = class("Dorm3dCollectionMediator", import("view.base.ContextMediator"))

Dorm3dCollectionMediator.DO_TALK = "Dorm3dCollectionMediator.DO_TALK"

function Dorm3dCollectionMediator:register()
	self:bind(Dorm3dCollectionMediator.DO_TALK, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(Dorm3dRoomMediator.OTHER_DO_TALK, {
			isReplay = true,
			talkId = arg_2_1,
			callback = arg_2_2
		})
		self.viewComponent:closeView()

		return
	end)
	self.viewComponent:SetRoom(self.contextData.roomId)

	return
end

function Dorm3dCollectionMediator:initNotificationHandleDic()
	self.handleDic = {}

	return
end

function Dorm3dCollectionMediator:remove()
	return
end

return Dorm3dCollectionMediator
