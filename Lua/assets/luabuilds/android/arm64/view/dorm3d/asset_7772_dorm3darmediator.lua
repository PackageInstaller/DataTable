local Dorm3dARMediator = class("Dorm3dARMediator", import("view.base.ContextMediator"))

Dorm3dARMediator.IN_ITAR_PHOTO = "Dorm3dARMediator:IN_ITAR_PHOTO"
Dorm3dARMediator.INIT_AR_PLANE = "Dorm3dARMediator:INIT_AR_PLANE"
Dorm3dARMediator.AR_INIT_FINISH = "Dorm3dARMediator:AR_INIT_FINISH"

function Dorm3dARMediator:register()
	self:bind(Dorm3dARMediator.IN_ITAR_PHOTO, function()
		self:addSubLayers(Context.New({
			mediator = Dorm3dPhotoARMediator,
			viewComponent = Dorm3dPhotoARLayer,
			data = {
				roomId = self.contextData.roomId,
				groupId = self.contextData.groupId,
				arCheckState = self.contextData.ARCheckState,
				holyLightRoot = self.viewComponent.holyLightRoot
			}
		}))

		return
	end)
	self:bind(Dorm3dARMediator.INIT_AR_PLANE, function()
		self:sendNotification(Dorm3dARMediator.INIT_AR_PLANE)

		return
	end)
	self:bind(Dorm3dARMediator.AR_INIT_FINISH, function()
		self:sendNotification(Dorm3dARMediator.AR_INIT_FINISH)

		return
	end)
	self.viewComponent:SetARLite(self.contextData.ARCheckState)

	return
end

function Dorm3dARMediator:listNotificationInterests()
	return {
		Dorm3dPhotoShareLayerMediator.EXIT_SHARE,
		Dorm3dPhotoARMediator.AR_PHOTO_INITED,
		Dorm3dPhotoARMediator.ACTIVE_AR_UI,
		Dorm3dPhotoARMediator.SCENE_CALL
	}
end

function Dorm3dARMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == Dorm3dPhotoShareLayerMediator.EXIT_SHARE then
		self.viewComponent:SetARUIActive(true)
	elseif var_6_0 == Dorm3dPhotoARMediator.AR_PHOTO_INITED then
		self.viewComponent:InitARPlane()
	elseif var_6_0 == Dorm3dPhotoARMediator.ACTIVE_AR_UI then
		self.viewComponent:SetARUIActive(var_6_1.flag)
	elseif var_6_0 == Dorm3dPhotoARMediator.SCENE_CALL then
		self.viewComponent[var_6_1.name](self.viewComponent, unpackEx(var_6_1.args))
	end

	return
end

return Dorm3dARMediator
