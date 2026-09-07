local Dorm3dPhotoSelectFrameMediator = class("Dorm3dPhotoSelectFrameMediator", import("view.base.ContextMediator"))

Dorm3dPhotoSelectFrameMediator.CONFIRMFRAME = "Dorm3dPhotoSelectFrameMediator:CONFIRMFRAME"

function Dorm3dPhotoSelectFrameMediator:register()
	self:bind(Dorm3dPhotoSelectFrameMediator.CONFIRMFRAME, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		self:sendNotification(Dorm3dPhotoSelectFrameMediator.CONFIRMFRAME, {
			selectFrameId = arg_2_1,
			imagePos = arg_2_2,
			imageScale = arg_2_3,
			specialPosDic = arg_2_4
		})

		return
	end)

	return
end

function Dorm3dPhotoSelectFrameMediator:listNotificationInterests()
	return {}
end

function Dorm3dPhotoSelectFrameMediator:remove()
	return
end

return Dorm3dPhotoSelectFrameMediator
