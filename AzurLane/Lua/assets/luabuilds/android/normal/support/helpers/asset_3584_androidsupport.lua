local var_0_0 = "permission_granted"
local var_0_1 = PERMISSION_GRANTED
local var_0_2 = "permission_never_remind"
local var_0_3 = PERMISSION_NEVER_REMIND
local var_0_4 = "permission_reject"
local var_0_5 = PERMISSION_REJECT
local var_0_6 = "android.permission.CAMERA"
local var_0_7 = ANDROID_CAMERA_PERMISSION
local var_0_8 = "android.permission.RECORD_AUDIO"
local var_0_9 = ANDROID_RECORD_AUDIO_PERMISSION
local var_0_10 = "android.permission.WRITE_EXTERNAL_STORAGE"
local var_0_11 = ANDROID_WRITE_EXTERNAL_PERMISSION

local function var_0_12(arg_1_0)
	PermissionMgr = var_1_10001

	local var_1_0 = var_1_10001.Inst

	return var_1.CheckPermissionGranted(var_1_0, arg_1_0)
end

local var_0_13 = CheckPermissionGranted

local function var_0_14(arg_2_0)
	PermissionMgr = var_1_10001

	local var_2_0 = var_1_10001.Inst

	var_1.ApplyPermission(var_2_0, arg_2_0)

	return
end

local var_0_15 = ApplyPermission

local function var_0_16()
	PermissionMgr = var_1_10000

	local var_3_0 = var_1_10000.Inst

	var_0.OpenDetailSetting(var_3_0)

	return
end

local var_0_17 = OpenDetailSetting

local function var_0_18(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.m02
	local var_4_1 = var_1.sendNotification

	PERMISSION_GRANTED = var_1_10003

	var_4_1(var_4_0, var_1_10003, arg_4_0)

	return
end

local var_0_19 = OnPermissionRequestResult

local function var_0_20(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.m02
	local var_5_1 = var_1.sendNotification

	PERMISSION_NEVER_REMIND = var_1_10003

	var_5_1(var_5_0, var_1_10003, arg_5_0)

	return
end

local var_0_21 = OnPermissionNeverRemind

local function var_0_22(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.m02
	local var_6_1 = var_1.sendNotification

	PERMISSION_REJECT = var_1_10003

	var_6_1(var_6_0, var_1_10003, arg_6_0)

	return
end

local var_0_23 = OnPermissionReject
local var_0_24 = "IOS_AV_AUTH_GRANTED"
local var_0_25 = IOS_AV_AUTH_GRANTED
local var_0_26 = "IOS_AV_AUTH_REJECTED"
local var_0_27 = IOS_AV_AUTH_REJECTED

local function var_0_28(arg_7_0)
	if arg_7_0 == "true" then
		pg = var_1_10001

		local var_7_0 = var_1_10001.m02

		var_1_10001 = var_1_10001.sendNotification
		IOS_AV_AUTH_GRANTED = var_1_10003

		var_1_10001(var_7_0, var_1_10003)
	elseif arg_7_0 == "false" then
		pg = var_1_10001

		local var_7_1 = var_1_10001.m02
		local var_7_2 = var_1.sendNotification

		IOS_AV_AUTH_REJECTED = var_1_10003

		var_7_2(var_7_1, var_1_10003)
	end

	return
end

local var_0_29 = OnReceiveIOSAVAuth

local function var_0_30()
	getProxy = var_1_10000
	UserProxy = var_1_10001

	local var_8_0 = var_1_10000(var_1_10001)
	local var_8_1 = var_0.GetCacheGatewayInServerLogined(var_8_0)

	PLATFORM_ANDROID = var_8_0

	if var_8_1 == var_8_0 then
		CheckPermissionGranted = var_8_0
		ANDROID_CAMERA_PERMISSION = var_1_10002

		return var_8_0(var_1_10002)
	else
		PLATFORM_IPHONEPLAYER = var_8_0

		if var_8_1 == var_8_0 then
			PermissionMgr = var_8_0

			local var_8_2 = var_8_0.Inst

			return var_1.GetIOSAVAuthStatus(var_8_2) == 3
		end
	end

	return
end

local var_0_31 = CheckCameraPermissionGranted

local function var_0_32()
	getProxy = var_1_10000
	UserProxy = var_1_10001

	local var_9_0 = var_1_10000(var_1_10001)
	local var_9_1 = var_0.GetCacheGatewayInServerLogined(var_9_0)

	PLATFORM_ANDROID = var_9_0

	if var_9_1 == var_9_0 then
		pg = var_9_0

		local var_9_2 = var_9_0.MsgboxMgr.GetInstance()

		var_9_0 = var_9_0.ShowMsgBox

		local var_9_3 = {}

		i18n = var_1_10004
		var_9_3.content = var_1_10004("apply_permission_camera_tip1")

		function var_9_3.onYes()
			ApplyPermission = var_2_10000

			local var_10_0 = {}

			ANDROID_CAMERA_PERMISSION = var_2_10002
			var_10_0[1] = var_2_10002

			var_2_10000(var_10_0)

			return
		end

		var_9_0(var_9_2, var_9_3)
	else
		PLATFORM_IPHONEPLAYER = var_9_0

		if var_9_1 == var_9_0 then
			PermissionMgr = var_9_0

			local var_9_4 = var_9_0.Inst

			var_1.ApplyIOSAVAuth(var_9_4)
		end
	end

	return
end

local var_0_33 = ApplyCameraPermission

return
