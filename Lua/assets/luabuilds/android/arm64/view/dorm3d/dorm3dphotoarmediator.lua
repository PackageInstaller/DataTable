local var_0_0 = class("Dorm3dPhotoARMediator", import("view.base.ContextMediator"))

var_0_0.SHARE_PANEL = "Dorm3dPhotoARMediator:SHARE_PANEL"
var_0_0.Camera_Pinch_Value_Change = "Camera_Pinch_Value_Change"
var_0_0.PLAY_SINGLE_ACTION = "Dorm3dPhotoARMediator.PLAY_SINGLE_ACTION"
var_0_0.SCENE_CALL = "Dorm3dPhotoARMediator.SCENE_CALL"
var_0_0.EXIT_SHARE = "Dorm3dPhotoARMediator:EXIT_SHARE"
var_0_0.AR_PHOTO_INITED = "Dorm3dPhotoARMediator:AR_PHOTO_INITED"
var_0_0.ACTIVE_AR_UI = "Dorm3dPhotoARMediator:ACTIVE_AR_UI"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.SHARE_PANEL, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:addSubLayers(Context.New({
			mediator = Dorm3dPhotoShareLayerMediator,
			viewComponent = Dorm3dPhotoShareLayer,
			data = {
				photoTex = arg_2_1,
				photoData = arg_2_2
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.PLAY_SINGLE_ACTION, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(Dorm3dPhotoARMediator.PLAY_SINGLE_ACTION, {
			name = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.SCENE_CALL, function(arg_4_0, arg_4_1, ...)
		arg_1_0:sendNotification(Dorm3dPhotoARMediator.SCENE_CALL, {
			name = arg_4_1,
			args = packEx(...)
		})

		return
	end)
	arg_1_0:bind(var_0_0.AR_PHOTO_INITED, function()
		arg_1_0:sendNotification(var_0_0.AR_PHOTO_INITED)

		return
	end)
	arg_1_0:bind(var_0_0.ACTIVE_AR_UI, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(var_0_0.ACTIVE_AR_UI, {
			flag = arg_6_1
		})

		return
	end)
	arg_1_0.viewComponent:SetRoom(arg_1_0.contextData.roomId)
	arg_1_0.viewComponent:SetGroupId(arg_1_0.contextData.groupId)
	arg_1_0.viewComponent:SetARLite(arg_1_0.contextData.arCheckState)

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		ApartmentProxy.UPDATE_APARTMENT,
		var_0_0.Camera_Pinch_Value_Change,
		Dorm3dARMediator.INIT_AR_PLANE,
		Dorm3dARMediator.AR_INIT_FINISH
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == ApartmentProxy.UPDATE_APARTMENT then
		-- block empty
	elseif var_8_0 == var_0_0.Camera_Pinch_Value_Change then
		arg_8_0.viewComponent:SetCamaraPinchSliderValue(arg_8_1.body.value)
	elseif var_8_0 == Dorm3dARMediator.INIT_AR_PLANE then
		arg_8_0.viewComponent:SetPhotoUIActive(false)
	elseif var_8_0 == Dorm3dARMediator.AR_INIT_FINISH then
		arg_8_0.viewComponent:SetPhotoUIActive(true)
	end

	return
end

function var_0_0.remove(arg_9_0)
	return
end

return var_0_0
