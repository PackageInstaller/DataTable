local var_0_0 = class("Dorm3dPhotoMediator", import("view.base.ContextMediator"))

var_0_0.SHARE_PANEL = "Dorm3dPhotoMediator:SHARE_PANEL"
var_0_0.CAMERA_LIFT_CHANGED = "CAMERA_LIFT_CHANGED"
var_0_0.CAMERA_STICK_MOVE = "CAMERA_STICK_MOVE"
var_0_0.GO_AR = "Dorm3dPhotoMediator:GO_AR"
var_0_0.OPEN_SKIN_SELECT_LAYER = "Dorm3dPhotoMediator:OPEN_SKIN_SELECT_LAYER"

function var_0_0.register(arg_1_0)
	local var_1_0 = arg_1_0.contextData.view

	arg_1_0.viewComponent:SetSceneRoot(arg_1_0.contextData.view)
	arg_1_0.viewComponent:SetRoom(arg_1_0.contextData.view.room)
	arg_1_0.viewComponent:SetGroupId(arg_1_0.contextData.groupId)
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
	arg_1_0:bind(var_0_0.GO_AR, function(arg_3_0, arg_3_1)
		if LOCK_DORM3D_AR then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_AR_switch"))

			return
		end

		local var_3_0 = pg.SdkMgr.GetInstance()

		if var_3_0:IsYunPackage() then
			pg.TipsMgr.GetInstance():ShowTips("指挥官，当前平台不支持该功能哦")

			return
		end

		local function var_3_3()
			arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.DORM3D_AR, {
				ARCheckState = arg_3_1,
				roomId = var_1_0.room:GetConfigID(),
				groupId = var_1_0.apartment:GetConfigID()
			})

			return
		end

		local function var_3_4()
			if PermissionHelper.IsAndroid() then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("apply_permission_camera_tip3"),
					onYes = function()
						PermissionHelper.RequestCamera(var_3_3, var_3_4)

						return
					end
				})
			elseif PermissionHelper.IsIOS() then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("apply_permission_camera_tip2")
				})
			end

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("apply_permission_camera_tip1"),
			onYes = function()
				PermissionHelper.RequestCamera(var_3_3, var_3_4)

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_SKIN_SELECT_LAYER, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dSkinSelectLayer,
			mediator = Dorm3dSkinSelectMediator,
			data = {
				groupId = arg_8_1,
				ladyEnv = arg_8_2,
				onSwitchSkin = arg_8_3,
				isPublicRoom = arg_8_4
			}
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_9_0)
	return {
		ApartmentProxy.UPDATE_APARTMENT,
		var_0_0.CAMERA_LIFT_CHANGED,
		var_0_0.CAMERA_STICK_MOVE
	}
end

function var_0_0.handleNotification(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:getName()
	local var_10_1 = arg_10_1:getBody()

	if var_10_0 == ApartmentProxy.UPDATE_APARTMENT then
		-- block empty
	elseif var_10_0 == var_0_0.CAMERA_LIFT_CHANGED then
		arg_10_0.viewComponent:SetPhotoCameraSliderValue(var_10_1.value)
	elseif var_10_0 == var_0_0.CAMERA_STICK_MOVE then
		arg_10_0.viewComponent:SetPhotoStickDelta(var_10_1)
	end

	return
end

function var_0_0.remove(arg_11_0)
	return
end

return var_0_0
