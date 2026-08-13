local var_0_0 = {}

PermissionHelper = PermissionHelper

function var_0.IsAndroid()
	PLATFORM = var_1_10000
	PLATFORM_ANDROID = var_1_10001

	local var_1_0

	if var_1_10000 == var_1_10001 then
		IsUnityEditor = var_1_10000
		var_1_0 = not var_1_10000
	else
		var_1_0 = false
	end

	if false then
		var_1_0 = true
	end

	return var_1_0
end

function var_0.IsIOS()
	PLATFORM = var_1_10000
	PLATFORM_IPHONEPLAYER = var_1_10001

	local var_2_0

	if var_1_10000 == var_1_10001 then
		IsUnityEditor = var_1_10000
		var_2_0 = not var_1_10000
	else
		var_2_0 = false
	end

	if false then
		var_2_0 = true
	end

	return var_2_0
end

var_0.Android10SDKLevel = 29
var_0.StateGranted = 0

function var_0.RequestCamera(arg_3_0, arg_3_1)
	if var_0.IsAndroid() or var_0.IsIOS() then
		local var_3_0 = {}

		YSNormalTool = var_1_10003
		var_3_0[1] = var_1_10003.PermissionTool.Camera
		YSNormalTool = var_3
		var_3_0[2] = var_3.PermissionTool.MIC

		if var_0.IsAndroid() then
			YSNormalTool = var_3

			if var_3.OtherTool.GetAndroidBuildVersion() < var_0.Android10SDKLevel then
				table = var_3

				local var_3_1 = var_3.insert

				var_1_10004 = var_3_0
				YSNormalTool = var_1_10005

				var_3_1(var_1_10004, var_1_10005.PermissionTool.Photo)
			end
		end

		local function var_3_2(arg_4_0, arg_4_1)
			underscore = var_2_10002

			if var_2_10002.all(arg_4_1:ToTable(), function(arg_5_0)
				return arg_5_0 == var_0.StateGranted
			end) then
				if arg_3_0 then
					arg_3_0()
				end
			elseif arg_3_1 then
				arg_3_1()
			end

			return
		end

		YSNormalTool = var_1_10004

		var_1_10004.PermissionTool.RequestMultiPermission(var_3_0, var_3_2)
	elseif arg_3_0 then
		arg_3_0()
	end

	return
end

function var_0.Request3DDorm(arg_6_0, arg_6_1)
	if var_0.IsAndroid() or var_0.IsIOS() then
		local var_6_0 = {}

		YSNormalTool = var_1_10003
		var_6_0[1] = var_1_10003.PermissionTool.MIC

		if var_0.IsAndroid() then
			YSNormalTool = var_3

			if var_3.OtherTool.GetAndroidBuildVersion() < var_0.Android10SDKLevel then
				table = var_3

				local var_6_1 = var_3.insert

				var_1_10004 = var_6_0
				YSNormalTool = var_1_10005

				var_6_1(var_1_10004, var_1_10005.PermissionTool.Photo)
			end
		end

		local function var_6_2(arg_7_0, arg_7_1)
			underscore = var_2_10002

			if var_2_10002.all(arg_7_1:ToTable(), function(arg_8_0)
				return arg_8_0 == var_0.StateGranted
			end) then
				if arg_6_0 then
					arg_6_0()
				end
			elseif arg_6_1 then
				arg_6_1()
			end

			return
		end

		YSNormalTool = var_1_10004

		var_1_10004.PermissionTool.RequestMultiPermission(var_6_0, var_6_2)
	elseif arg_6_0 then
		arg_6_0()
	end

	return
end

return
