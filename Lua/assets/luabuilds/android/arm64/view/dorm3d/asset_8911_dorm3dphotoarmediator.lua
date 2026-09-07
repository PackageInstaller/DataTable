local Dorm3dPhotoARMediator = class("Dorm3dPhotoARMediator", import("view.base.ContextMediator"))

Dorm3dPhotoARMediator.SHARE_PANEL = "Dorm3dPhotoARMediator:SHARE_PANEL"
Dorm3dPhotoARMediator.Camera_Pinch_Value_Change = "Camera_Pinch_Value_Change"
Dorm3dPhotoARMediator.PLAY_SINGLE_ACTION = "Dorm3dPhotoARMediator.PLAY_SINGLE_ACTION"
Dorm3dPhotoARMediator.SCENE_CALL = "Dorm3dPhotoARMediator.SCENE_CALL"
Dorm3dPhotoARMediator.EXIT_SHARE = "Dorm3dPhotoARMediator:EXIT_SHARE"
Dorm3dPhotoARMediator.AR_PHOTO_INITED = "Dorm3dPhotoARMediator:AR_PHOTO_INITED"
Dorm3dPhotoARMediator.ACTIVE_AR_UI = "Dorm3dPhotoARMediator:ACTIVE_AR_UI"

function Dorm3dPhotoARMediator:register()
	self:bind(Dorm3dPhotoARMediator.SHARE_PANEL, function(arg_2_0, arg_2_1, arg_2_2)
		self:addSubLayers(Context.New({
			mediator = Dorm3dPhotoShareLayerMediator,
			viewComponent = Dorm3dPhotoShareLayer,
			data = {
				photoTex = arg_2_1,
				photoData = arg_2_2
			}
		}))

		return
	end)
	self:bind(Dorm3dPhotoARMediator.PLAY_SINGLE_ACTION, function(arg_3_0, arg_3_1)
		self:sendNotification(Dorm3dPhotoARMediator.PLAY_SINGLE_ACTION, {
			name = arg_3_1
		})

		return
	end)
	self:bind(Dorm3dPhotoARMediator.SCENE_CALL, function(arg_4_0, arg_4_1, ...)
		self:sendNotification(Dorm3dPhotoARMediator.SCENE_CALL, {
			name = arg_4_1,
			args = packEx(...)
		})

		return
	end)
	self:bind(Dorm3dPhotoARMediator.AR_PHOTO_INITED, function()
		self:sendNotification(Dorm3dPhotoARMediator.AR_PHOTO_INITED)

		return
	end)
	self:bind(Dorm3dPhotoARMediator.ACTIVE_AR_UI, function(arg_6_0, arg_6_1)
		self:sendNotification(Dorm3dPhotoARMediator.ACTIVE_AR_UI, {
			flag = arg_6_1
		})

		return
	end)
	self.viewComponent:SetRoom(self.contextData.roomId)
	self.viewComponent:SetGroupId(self.contextData.groupId)
	self.viewComponent:SetARLite(self.contextData.arCheckState)

	return
end

function Dorm3dPhotoARMediator:listNotificationInterests()
	return {
		ApartmentProxy.UPDATE_APARTMENT,
		Dorm3dPhotoARMediator.Camera_Pinch_Value_Change,
		Dorm3dARMediator.INIT_AR_PLANE,
		Dorm3dARMediator.AR_INIT_FINISH
	}
end

function Dorm3dPhotoARMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == ApartmentProxy.UPDATE_APARTMENT then
		-- block empty
	elseif var_8_0 == Dorm3dPhotoARMediator.Camera_Pinch_Value_Change then
		self.viewComponent:SetCamaraPinchSliderValue(arg_8_1.body.value)
	elseif var_8_0 == Dorm3dARMediator.INIT_AR_PLANE then
		self.viewComponent:SetPhotoUIActive(false)
	elseif var_8_0 == Dorm3dARMediator.AR_INIT_FINISH then
		self.viewComponent:SetPhotoUIActive(true)
	end

	return
end

function Dorm3dPhotoARMediator:remove()
	return
end

return Dorm3dPhotoARMediator
