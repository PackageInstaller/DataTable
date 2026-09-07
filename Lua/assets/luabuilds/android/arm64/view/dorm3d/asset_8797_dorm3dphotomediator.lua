local Dorm3dPhotoMediator = class("Dorm3dPhotoMediator", import("view.base.ContextMediator"))

Dorm3dPhotoMediator.SHARE_PANEL = "Dorm3dPhotoMediator:SHARE_PANEL"
Dorm3dPhotoMediator.CAMERA_LIFT_CHANGED = "CAMERA_LIFT_CHANGED"
Dorm3dPhotoMediator.CAMERA_STICK_MOVE = "CAMERA_STICK_MOVE"
Dorm3dPhotoMediator.GO_AR = "Dorm3dPhotoMediator:GO_AR"
Dorm3dPhotoMediator.OPEN_SKIN_SELECT_LAYER = "Dorm3dPhotoMediator:OPEN_SKIN_SELECT_LAYER"

function Dorm3dPhotoMediator:register()
	local var_1_0 = self.contextData.view

	self.viewComponent:SetSceneRoot(self.contextData.view)
	self.viewComponent:SetRoom(self.contextData.view.room)
	self.viewComponent:SetGroupId(self.contextData.groupId)
	self:bind(Dorm3dPhotoMediator.SHARE_PANEL, function(arg_2_0, arg_2_1, arg_2_2)
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
	self:bind(Dorm3dPhotoMediator.GO_AR, function(arg_3_0, arg_3_1)
		if LOCK_DORM3D_AR then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_AR_switch"))

			return
		end

		if pg.SdkMgr.GetInstance():IsYunPackage() then
			pg.TipsMgr.GetInstance():ShowTips("指挥官，当前平台不支持该功能哦")

			return
		end

		local function var_3_2()
			self:sendNotification(GAME.GO_SCENE, SCENE.DORM3D_AR, {
				ARCheckState = arg_3_1,
				roomId = var_1_0.room:GetConfigID(),
				groupId = var_1_0.apartment:GetConfigID()
			})

			return
		end

		local function var_3_3()
			if PermissionHelper.IsAndroid() then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("apply_permission_camera_tip3"),
					onYes = function()
						PermissionHelper.RequestCamera(var_3_2, var_3_3)

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
				PermissionHelper.RequestCamera(var_3_2, var_3_3)

				return
			end
		})

		return
	end)
	self:bind(Dorm3dPhotoMediator.OPEN_SKIN_SELECT_LAYER, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		self:addSubLayers(Context.New({
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

function Dorm3dPhotoMediator:listNotificationInterests()
	return {
		ApartmentProxy.UPDATE_APARTMENT,
		Dorm3dPhotoMediator.CAMERA_LIFT_CHANGED,
		Dorm3dPhotoMediator.CAMERA_STICK_MOVE
	}
end

function Dorm3dPhotoMediator:handleNotification(arg_10_1)
	local var_10_0 = arg_10_1:getName()
	local var_10_1 = arg_10_1:getBody()

	if var_10_0 == ApartmentProxy.UPDATE_APARTMENT then
		-- block empty
	elseif var_10_0 == Dorm3dPhotoMediator.CAMERA_LIFT_CHANGED then
		self.viewComponent:SetPhotoCameraSliderValue(var_10_1.value)
	elseif var_10_0 == Dorm3dPhotoMediator.CAMERA_STICK_MOVE then
		self.viewComponent:SetPhotoStickDelta(var_10_1)
	end

	return
end

function Dorm3dPhotoMediator:remove()
	return
end

return Dorm3dPhotoMediator
