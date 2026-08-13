class = var_0_10000

local var_0_0 = "Dorm3dARMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.IN_ITAR_PHOTO = "Dorm3dARMediator:IN_ITAR_PHOTO"
var_0_1.INIT_AR_PLANE = "Dorm3dARMediator:INIT_AR_PLANE"
var_0_1.AR_INIT_FINISH = "Dorm3dARMediator:AR_INIT_FINISH"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.IN_ITAR_PHOTO, function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.addSubLayers

		Context = var_2_10003

		local var_2_2 = var_2_10003.New
		local var_2_3 = {}

		Dorm3dPhotoARMediator = var_2_10006
		var_2_3.mediator = var_2_10006
		Dorm3dPhotoARLayer = var_2_10006
		var_2_3.viewComponent = var_2_10006
		var_2_3.data = {
			roomId = arg_1_0.contextData.roomId,
			groupId = arg_1_0.contextData.groupId,
			arCheckState = arg_1_0.contextData.ARCheckState,
			holyLightRoot = arg_1_0.viewComponent.holyLightRoot
		}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.INIT_AR_PLANE, function()
		local var_3_0 = arg_1_0

		var_0.sendNotification(var_3_0, var_0_1.INIT_AR_PLANE)

		return
	end)
	arg_1_0:bind(var_0_1.AR_INIT_FINISH, function()
		local var_4_0 = arg_1_0

		var_0.sendNotification(var_4_0, var_0_1.AR_INIT_FINISH)

		return
	end)

	local var_1_0 = arg_1_0.viewComponent

	var_1.SetARLite(var_1_0, arg_1_0.contextData.ARCheckState)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	Dorm3dPhotoShareLayerMediator = var_1_10002
	var_5_0[1] = var_1_10002.EXIT_SHARE
	Dorm3dPhotoARMediator = var_2
	var_5_0[2] = var_2.AR_PHOTO_INITED
	Dorm3dPhotoARMediator = var_2
	var_5_0[3] = var_2.ACTIVE_AR_UI
	Dorm3dPhotoARMediator = var_2
	var_5_0[4] = var_2.SCENE_CALL

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1:getBody()

	Dorm3dPhotoShareLayerMediator = var_6_0

	if var_6_1 == var_6_0.EXIT_SHARE then
		local var_6_3 = arg_6_0.viewComponent

		var_4.SetARUIActive(var_6_3, true)
	else
		Dorm3dPhotoARMediator = var_4

		if var_6_1 == var_4.AR_PHOTO_INITED then
			local var_6_4 = arg_6_0.viewComponent

			var_4.InitARPlane(var_6_4)
		else
			Dorm3dPhotoARMediator = var_4

			if var_6_1 == var_4.ACTIVE_AR_UI then
				local var_6_5 = arg_6_0.viewComponent

				var_4.SetARUIActive(var_6_5, var_6_2.flag)
			else
				Dorm3dPhotoARMediator = var_4

				if var_6_1 == var_4.SCENE_CALL then
					local var_6_6 = arg_6_0.viewComponent[var_6_2.name]
					local var_6_7 = arg_6_0.viewComponent

					unpackEx = var_1_10007

					var_6_6(var_6_7, var_1_10007(var_6_2.args))
				end
			end
		end
	end

	return
end

return var_0_1
