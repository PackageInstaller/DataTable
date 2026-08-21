PERMISSION_GRANTED = "permission_granted"
PERMISSION_NEVER_REMIND = "permission_never_remind"
PERMISSION_REJECT = "permission_reject"
ANDROID_CAMERA_PERMISSION = "android.permission.CAMERA"
ANDROID_RECORD_AUDIO_PERMISSION = "android.permission.RECORD_AUDIO"
ANDROID_WRITE_EXTERNAL_PERMISSION = "android.permission.WRITE_EXTERNAL_STORAGE"

function CheckPermissionGranted(arg_1_0)
	return PermissionMgr.Inst:CheckPermissionGranted(arg_1_0)
end

function ApplyPermission(arg_2_0)
	PermissionMgr.Inst:ApplyPermission(arg_2_0)

	return
end

function OpenDetailSetting()
	PermissionMgr.Inst:OpenDetailSetting()

	return
end

function OnPermissionRequestResult(arg_4_0)
	pg.m02:sendNotification(PERMISSION_GRANTED, arg_4_0)

	return
end

function OnPermissionNeverRemind(arg_5_0)
	pg.m02:sendNotification(PERMISSION_NEVER_REMIND, arg_5_0)

	return
end

function OnPermissionReject(arg_6_0)
	pg.m02:sendNotification(PERMISSION_REJECT, arg_6_0)

	return
end

IOS_AV_AUTH_GRANTED = "IOS_AV_AUTH_GRANTED"
IOS_AV_AUTH_REJECTED = "IOS_AV_AUTH_REJECTED"

function OnReceiveIOSAVAuth(arg_7_0)
	if arg_7_0 == "true" then
		pg.m02:sendNotification(IOS_AV_AUTH_GRANTED)
	elseif arg_7_0 == "false" then
		pg.m02:sendNotification(IOS_AV_AUTH_REJECTED)
	end

	return
end

function CheckCameraPermissionGranted()
	local var_8_0 = getProxy(UserProxy):GetCacheGatewayInServerLogined()

	if var_8_0 == PLATFORM_ANDROID then
		return CheckPermissionGranted(ANDROID_CAMERA_PERMISSION)
	elseif var_8_0 == PLATFORM_IPHONEPLAYER then
		return PermissionMgr.Inst:GetIOSAVAuthStatus() == 3
	end

	return
end

function ApplyCameraPermission()
	local var_9_0 = getProxy(UserProxy):GetCacheGatewayInServerLogined()

	if var_9_0 == PLATFORM_ANDROID then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("apply_permission_camera_tip1"),
			onYes = function()
				ApplyPermission({
					ANDROID_CAMERA_PERMISSION
				})

				return
			end
		})
	elseif var_9_0 == PLATFORM_IPHONEPLAYER then
		PermissionMgr.Inst:ApplyIOSAVAuth()
	end

	return
end

return
