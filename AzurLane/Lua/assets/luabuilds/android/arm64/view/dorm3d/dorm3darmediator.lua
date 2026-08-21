local var_0_0 = class("Dorm3dARMediator", import("view.base.ContextMediator"))

var_0_0.IN_ITAR_PHOTO = "Dorm3dARMediator:IN_ITAR_PHOTO"
var_0_0.INIT_AR_PLANE = "Dorm3dARMediator:INIT_AR_PLANE"
var_0_0.AR_INIT_FINISH = "Dorm3dARMediator:AR_INIT_FINISH"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.IN_ITAR_PHOTO, function()
		arg_1_0:addSubLayers(Context.New({
			mediator = Dorm3dPhotoARMediator,
			viewComponent = Dorm3dPhotoARLayer,
			data = {
				roomId = arg_1_0.contextData.roomId,
				groupId = arg_1_0.contextData.groupId,
				arCheckState = arg_1_0.contextData.ARCheckState,
				holyLightRoot = arg_1_0.viewComponent.holyLightRoot
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.INIT_AR_PLANE, function()
		arg_1_0:sendNotification(var_0_0.INIT_AR_PLANE)

		return
	end)
	arg_1_0:bind(var_0_0.AR_INIT_FINISH, function()
		arg_1_0:sendNotification(var_0_0.AR_INIT_FINISH)

		return
	end)
	arg_1_0.viewComponent:SetARLite(arg_1_0.contextData.ARCheckState)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		Dorm3dPhotoShareLayerMediator.EXIT_SHARE,
		Dorm3dPhotoARMediator.AR_PHOTO_INITED,
		Dorm3dPhotoARMediator.ACTIVE_AR_UI,
		Dorm3dPhotoARMediator.SCENE_CALL
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == Dorm3dPhotoShareLayerMediator.EXIT_SHARE then
		arg_6_0.viewComponent:SetARUIActive(true)
	elseif var_6_0 == Dorm3dPhotoARMediator.AR_PHOTO_INITED then
		arg_6_0.viewComponent:InitARPlane()
	elseif var_6_0 == Dorm3dPhotoARMediator.ACTIVE_AR_UI then
		arg_6_0.viewComponent:SetARUIActive(var_6_1.flag)
	elseif var_6_0 == Dorm3dPhotoARMediator.SCENE_CALL then
		arg_6_0.viewComponent[var_6_1.name](arg_6_0.viewComponent, unpackEx(var_6_1.args))
	end

	return
end

return var_0_0
