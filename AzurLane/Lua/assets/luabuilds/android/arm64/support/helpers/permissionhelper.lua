PermissionHelper = {}

local var_0_0 = PermissionHelper

function PermissionHelper.IsAndroid()
	return PLATFORM == PLATFORM_ANDROID and not IsUnityEditor
end

function PermissionHelper.IsIOS()
	return PLATFORM == PLATFORM_IPHONEPLAYER and not IsUnityEditor
end

PermissionHelper.Android10SDKLevel = 29
PermissionHelper.StateGranted = 0

function PermissionHelper.RequestCamera(arg_3_0, arg_3_1)
	if var_0_0.IsAndroid() or var_0_0.IsIOS() then
		local var_3_0 = {
			YSNormalTool.PermissionTool.Camera,
			YSNormalTool.PermissionTool.MIC
		}

		if var_0_0.IsAndroid() and YSNormalTool.OtherTool.GetAndroidBuildVersion() < var_0_0.Android10SDKLevel then
			table.insert(var_3_0, YSNormalTool.PermissionTool.Photo)
		end

		YSNormalTool.PermissionTool.RequestMultiPermission(var_3_0, function(arg_4_0, arg_4_1)
			if underscore.all(arg_4_1:ToTable(), function(arg_5_0)
				return arg_5_0 == var_0_0.StateGranted
			end) then
				if arg_3_0 then
					arg_3_0()
				end
			elseif arg_3_1 then
				arg_3_1()
			end

			return
		end)
	elseif arg_3_0 then
		arg_3_0()
	end

	return
end

function PermissionHelper.Request3DDorm(arg_6_0, arg_6_1)
	if var_0_0.IsAndroid() or var_0_0.IsIOS() then
		local var_6_0 = {
			YSNormalTool.PermissionTool.MIC
		}

		if var_0_0.IsAndroid() and YSNormalTool.OtherTool.GetAndroidBuildVersion() < var_0_0.Android10SDKLevel then
			table.insert(var_6_0, YSNormalTool.PermissionTool.Photo)
		end

		YSNormalTool.PermissionTool.RequestMultiPermission(var_6_0, function(arg_7_0, arg_7_1)
			if underscore.all(arg_7_1:ToTable(), function(arg_8_0)
				return arg_8_0 == var_0_0.StateGranted
			end) then
				if arg_6_0 then
					arg_6_0()
				end
			elseif arg_6_1 then
				arg_6_1()
			end

			return
		end)
	elseif arg_6_0 then
		arg_6_0()
	end

	return
end

return
