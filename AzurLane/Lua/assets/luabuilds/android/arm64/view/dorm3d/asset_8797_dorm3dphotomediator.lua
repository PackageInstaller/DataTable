class = var_0_10000

local var_0_0 = "Dorm3dPhotoMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.SHARE_PANEL = "Dorm3dPhotoMediator:SHARE_PANEL"
var_0_1.CAMERA_LIFT_CHANGED = "CAMERA_LIFT_CHANGED"
var_0_1.CAMERA_STICK_MOVE = "CAMERA_STICK_MOVE"
var_0_1.GO_AR = "Dorm3dPhotoMediator:GO_AR"
var_0_1.OPEN_SKIN_SELECT_LAYER = "Dorm3dPhotoMediator:OPEN_SKIN_SELECT_LAYER"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0.contextData.view
	local var_1_1 = arg_1_0.viewComponent

	var_2.SetSceneRoot(var_1_1, var_1_0)

	local var_1_2 = arg_1_0.viewComponent

	var_2.SetRoom(var_1_2, var_1_0.room)

	local var_1_3 = arg_1_0.viewComponent

	var_2.SetGroupId(var_1_3, arg_1_0.contextData.groupId)
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
	arg_1_0:bind(var_0_1.GO_AR, function(arg_3_0, arg_3_1)
		LOCK_DORM3D_AR = var_2_10002

		if var_2_10002 then
			pg = var_2_10002

			local var_3_0 = var_2_10002.TipsMgr.GetInstance()

			var_2_10002 = var_2_10002.ShowTips
			i18n = var_2_10005

			var_2_10002(var_3_0, var_2_10005("dorm3d_AR_switch"))

			return
		end

		pg = var_2_10002

		local var_3_1 = var_2_10002.SdkMgr.GetInstance()

		if var_2.IsYunPackage(var_3_1) then
			pg = var_2
			var_3_1 = var_2.TipsMgr.GetInstance()

			var_2.ShowTips(var_3_1, "指挥官，当前平台不支持该功能哦")

			return
		end

		local var_3_2
		local var_3_3

		local function var_3_4()
			local var_4_0 = arg_1_0
			local var_4_1 = var_0.sendNotification

			GAME = var_3_10003

			local var_4_2 = var_3_10003.GO_SCENE

			SCENE = var_3_10004

			local var_4_3 = var_3_10004.DORM3D_AR
			local var_4_4 = {
				ARCheckState = arg_3_1
			}
			local var_4_5 = var_1_0.room

			var_4_4.roomId = var_6.GetConfigID(var_4_5)

			local var_4_6 = var_1_0.apartment

			var_4_4.groupId = var_6.GetConfigID(var_4_6)

			var_4_1(var_4_0, var_4_2, var_4_3, var_4_4)

			return
		end

		local function var_3_5()
			PermissionHelper = var_3_10000

			local var_5_1

			if var_3_10000.IsAndroid() then
				pg = var_5_1

				local var_5_0 = var_5_1.MsgboxMgr.GetInstance()

				var_5_1 = var_5_1.ShowMsgBox

				local var_5_2 = {}

				i18n = var_3_10004
				var_5_2.content = var_3_10004("apply_permission_camera_tip3")

				function var_5_2.onYes()
					PermissionHelper = var_4_10000

					var_4_10000.RequestCamera(var_3_4, var_3_5)

					return
				end

				var_5_1(var_5_0, var_5_2)
			else
				PermissionHelper = var_5_1

				if var_5_1.IsIOS() then
					pg = var_0

					local var_5_3 = var_0.MsgboxMgr.GetInstance()
					local var_5_4 = var_0.ShowMsgBox
					local var_5_5 = {}

					i18n = var_3_10004
					var_5_5.content = var_3_10004("apply_permission_camera_tip2")

					var_5_4(var_5_3, var_5_5)
				end
			end

			return
		end

		pg = var_3_1

		local var_3_6 = var_3_1.MsgboxMgr.GetInstance()
		local var_3_7 = var_4.ShowMsgBox
		local var_3_8 = {}

		i18n = var_2_10008
		var_3_8.content = var_2_10008("apply_permission_camera_tip1")

		function var_3_8.onYes()
			PermissionHelper = var_3_10000

			var_3_10000.RequestCamera(var_3_4, var_3_5)

			return
		end

		var_3_7(var_3_6, var_3_8)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_SKIN_SELECT_LAYER, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		local var_8_0 = arg_1_0
		local var_8_1 = var_5.addSubLayers

		Context = var_2_10008

		local var_8_2 = var_2_10008.New
		local var_8_3 = {}

		Dorm3dSkinSelectLayer = var_2_10011
		var_8_3.viewComponent = var_2_10011
		Dorm3dSkinSelectMediator = var_2_10011
		var_8_3.mediator = var_2_10011
		var_8_3.data = {
			groupId = arg_8_1,
			ladyEnv = arg_8_2,
			onSwitchSkin = arg_8_3,
			isPublicRoom = arg_8_4
		}

		var_8_1(var_8_0, var_8_2(var_8_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_9_0)
	local var_9_0 = {}

	ApartmentProxy = var_1_10002
	var_9_0[1] = var_1_10002.UPDATE_APARTMENT
	var_9_0[2] = var_0_1.CAMERA_LIFT_CHANGED
	var_9_0[3] = var_0_1.CAMERA_STICK_MOVE

	return var_9_0
end

function var_0_1.handleNotification(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1
	local var_10_1 = arg_10_1.getName(var_10_0)
	local var_10_2 = arg_10_1:getBody()

	ApartmentProxy = var_10_0

	if var_10_1 == var_10_0.UPDATE_APARTMENT then
		-- block empty
	elseif var_10_1 == var_0_1.CAMERA_LIFT_CHANGED then
		local var_10_3 = arg_10_0.viewComponent

		var_4.SetPhotoCameraSliderValue(var_10_3, var_10_2.value)
	elseif var_10_1 == var_0_1.CAMERA_STICK_MOVE then
		local var_10_4 = arg_10_0.viewComponent

		var_4.SetPhotoStickDelta(var_10_4, var_10_2)
	end

	return
end

function var_0_1.remove(arg_11_0)
	return
end

return var_0_1
