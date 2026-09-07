local MainCameraBtn = class("MainCameraBtn", import(".MainBaseBtn"))

function MainCameraBtn:OnClick()
	self:OpenCamera()

	return
end

function MainCameraBtn:Flush(arg_2_1)
	setActive(self._tf, true)

	return
end

function MainCameraBtn:OpenCamera()
	if pg.SdkMgr.GetInstance():IsYunPackage() then
		pg.TipsMgr.GetInstance():ShowTips("指挥官，当前平台不支持该功能哦")

		return
	end

	local function var_3_2()
		self:emit(NewMainMediator.GO_SNAPSHOT)

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
end

return MainCameraBtn
