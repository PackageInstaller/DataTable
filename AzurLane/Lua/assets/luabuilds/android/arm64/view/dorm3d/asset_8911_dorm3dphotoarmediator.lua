class = var_0_10000

local var_0_0 = "Dorm3dPhotoARMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.SHARE_PANEL = "Dorm3dPhotoARMediator:SHARE_PANEL"
var_0_1.Camera_Pinch_Value_Change = "Camera_Pinch_Value_Change"
var_0_1.PLAY_SINGLE_ACTION = "Dorm3dPhotoARMediator.PLAY_SINGLE_ACTION"
var_0_1.SCENE_CALL = "Dorm3dPhotoARMediator.SCENE_CALL"
var_0_1.EXIT_SHARE = "Dorm3dPhotoARMediator:EXIT_SHARE"
var_0_1.AR_PHOTO_INITED = "Dorm3dPhotoARMediator:AR_PHOTO_INITED"
var_0_1.ACTIVE_AR_UI = "Dorm3dPhotoARMediator:ACTIVE_AR_UI"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.SHARE_PANEL, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_2_2 = var_2_10006.New
		local var_2_3 = {}

		Dorm3dPhotoShareLayerMediator = var_2_10009
		var_2_3.mediator = var_2_10009
		Dorm3dPhotoShareLayer = var_2_10009
		var_2_3.viewComponent = var_2_10009
		var_2_3.data = {
			photoTex = arg_2_1,
			photoData = arg_2_2
		}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.PLAY_SINGLE_ACTION, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		Dorm3dPhotoARMediator = var_2_10005

		var_3_1(var_3_0, var_2_10005.PLAY_SINGLE_ACTION, {
			name = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.SCENE_CALL, function(arg_4_0, arg_4_1, ...)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		Dorm3dPhotoARMediator = var_2_10005

		local var_4_2 = var_2_10005.SCENE_CALL
		local var_4_3 = {
			name = arg_4_1
		}

		packEx = var_2_10007
		var_4_3.args = var_2_10007(...)

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)
	arg_1_0:bind(var_0_1.AR_PHOTO_INITED, function()
		local var_5_0 = arg_1_0

		var_0.sendNotification(var_5_0, var_0_1.AR_PHOTO_INITED)

		return
	end)
	arg_1_0:bind(var_0_1.ACTIVE_AR_UI, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0

		var_2.sendNotification(var_6_0, var_0_1.ACTIVE_AR_UI, {
			flag = arg_6_1
		})

		return
	end)

	local var_1_0 = arg_1_0.viewComponent

	var_1.SetRoom(var_1_0, arg_1_0.contextData.roomId)

	local var_1_1 = arg_1_0.viewComponent

	var_1.SetGroupId(var_1_1, arg_1_0.contextData.groupId)

	local var_1_2 = arg_1_0.viewComponent

	var_1.SetARLite(var_1_2, arg_1_0.contextData.arCheckState)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	ApartmentProxy = var_1_10002
	var_7_0[1] = var_1_10002.UPDATE_APARTMENT
	var_7_0[2] = var_0_1.Camera_Pinch_Value_Change
	Dorm3dARMediator = var_2
	var_7_0[3] = var_2.INIT_AR_PLANE
	Dorm3dARMediator = var_2
	var_7_0[4] = var_2.AR_INIT_FINISH

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.getName(var_8_0)
	local var_8_2 = arg_8_1:getBody()

	ApartmentProxy = var_8_0

	if var_8_1 == var_8_0.UPDATE_APARTMENT then
		-- block empty
	elseif var_8_1 == var_0_1.Camera_Pinch_Value_Change then
		local var_8_3 = arg_8_0.viewComponent

		var_4.SetCamaraPinchSliderValue(var_8_3, arg_8_1.body.value)
	else
		Dorm3dARMediator = var_4

		if var_8_1 == var_4.INIT_AR_PLANE then
			local var_8_4 = arg_8_0.viewComponent

			var_4.SetPhotoUIActive(var_8_4, false)
		else
			Dorm3dARMediator = var_4

			if var_8_1 == var_4.AR_INIT_FINISH then
				local var_8_5 = arg_8_0.viewComponent

				var_4.SetPhotoUIActive(var_8_5, true)
			end
		end
	end

	return
end

function var_0_1.remove(arg_9_0)
	return
end

return var_0_1
