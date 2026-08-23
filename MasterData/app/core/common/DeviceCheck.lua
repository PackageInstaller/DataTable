local NativeCallUtils = require("app.core.platform.NativeCallUtils")
local var_0_1 = {}

var_0_1.CUR_LEVEL = 2
var_0_1.DEVICE_LV = {
	HIGH = 2,
	MID = 1,
	LOW = 0,
	UNKOWN = -1
}

local DeviceCheckConst = require("app.core.common.DeviceCheckConst")

function var_0_1.toInt(arg_1_0)
	return math.floor(arg_1_0 + 0.5)
end

function var_0_1.getDeviceTotalMemoryMB()
	if device.isAndroid() then
		local var_2_0 = var_0_1.toInt(NativeCallUtils.call("getDeviceTotalMemory", nil, "int"))

		if var_2_0 == -3 then
			return -1
		else
			return var_2_0
		end
	else
		return -1
	end
end

function var_0_1.getDeviceCPUMaxFreqMHz()
	if device.isAndroid() then
		local var_3_0 = var_0_1.toInt(NativeCallUtils.call("getDeviceCPUMaxFreqKHz", nil, "int"))

		if var_3_0 == -1 or var_3_0 == -3 then
			return -1
		else
			return var_3_0 / 1000
		end
	else
		return -1
	end
end

function var_0_1.judgeAndroidDeviceMemoryLv()
	local var_4_0 = var_0_1.getDeviceTotalMemoryMB()

	if var_4_0 == -1 then
		return -1
	end

	local var_4_1 = 0

	for iter_4_0, iter_4_1 in pairs(DeviceCheckConst.MEMORY_LEVELS) do
		if iter_4_1 <= var_4_0 then
			var_4_1 = var_4_1 + 1
		else
			break
		end
	end

	return var_4_1
end

function var_0_1.judgeAndroidDeviceCPULv()
	local var_5_0 = var_0_1.getDeviceCPUMaxFreqMHz()

	if var_5_0 == -1 then
		return -1
	end

	local var_5_1 = 0

	for iter_5_0, iter_5_1 in pairs(DeviceCheckConst.CPU_LEVELS) do
		if iter_5_1 <= var_5_0 then
			var_5_1 = var_5_1 + 1
		else
			break
		end
	end

	return var_5_1
end

function var_0_1.getDevicePerformanceLv()
	if device.isAndroid() then
		if require("app.core.platform.NativeCallUtils").call("isSimulator", {
			{
				path = g.core.model.User.ShareData:getSavaPath()
			}
		}, "boolean") then
			return DeviceCheckConst.DEVICE_LEVEL_SIGN.HIGH
		end

		local var_6_0 = var_0_1.judgeAndroidDeviceMemoryLv()
		local var_6_1 = var_0_1.judgeAndroidDeviceCPULv()
		local var_6_3 = math.max(0, var_6_0) + math.max(0, var_6_1)
		local var_6_5 = math.floor(((var_6_1 == var_0_1.DEVICE_LV.UNKOWN and var_6_0 == var_0_1.DEVICE_LV.UNKOWN or nil) and 1) / ((var_6_1 == var_0_1.DEVICE_LV.UNKOWN or var_6_0 == var_0_1.DEVICE_LV.UNKOWN or nil) and 1))

		if var_6_5 == DeviceCheckConst.LEVEL_SIGN.MID_LOW or var_6_5 == DeviceCheckConst.LEVEL_SIGN.MID_HIGH then
			var_6_5 = DeviceCheckConst.DEVICE_LEVEL_SIGN.MID
		elseif var_6_5 == DeviceCheckConst.LEVEL_SIGN.HIGH then
			var_6_5 = DeviceCheckConst.DEVICE_LEVEL_SIGN.HIGH
		end

		return var_6_5
	elseif device.isIOS() then
		return var_0_1.judgeIOSDeviceModelLv()
	elseif device.isWindows() then
		return var_0_1.DEVICE_LV.HIGH
	else
		return var_0_1.DEVICE_LV.UNKOWN
	end
end

function var_0_1.getIosDeviceModel()
	if device.isIOS() then
		local var_7_0, var_7_1 = NativeCallUtils.call("getDeviceString", nil, "string")

		if var_7_1 and var_7_0 then
			local var_7_2 = tostring(var_7_0)
			local var_7_3 = "unknown"
			local var_7_4 = ""

			if string.find(var_7_2, "iPhone") then
				var_7_3 = "iphone"
				var_7_4 = string.gsub(var_7_2, "iPhone", "")
			elseif string.find(var_7_2, "iPad") then
				var_7_3 = "ipad"
				var_7_4 = string.gsub(var_7_2, "iPad", "")
			elseif string.find(var_7_2, "iPod") then
				var_7_3 = "ipod"
				var_7_4 = string.gsub(var_7_2, "iPod", "")
			end

			local var_7_5 = -1

			if var_7_4 ~= "" then
				local var_7_6 = string.find(var_7_4, ",")

				if var_7_6 and var_7_6 > 0 then
					var_7_5 = var_0_1.toInt(string.sub(var_7_4, 1, var_7_6 - 1)) * 100 + var_0_1.toInt(string.sub(var_7_4, var_7_6 + 1))
				end
			end

			return var_7_3, var_7_5
		end
	end

	return "unknown", -1
end

function var_0_1.judgeIOSDeviceModelLv()
	local var_8_0, var_8_1 = var_0_1.getIosDeviceModel()

	if var_8_0 == "unknown" or var_8_1 == -1 then
		return DeviceCheckConst.DEVICE_LEVEL_SIGN.UNKNOWN
	end

	local var_8_2 = DeviceCheckConst.DEVICE_LEVEL_SIGN.LOW

	if DeviceCheckConst.IOS_DEVICE_LEVELS[var_8_0] then
		for iter_8_0, iter_8_1 in ipairs(DeviceCheckConst.IOS_DEVICE_LEVELS[var_8_0]) do
			if iter_8_1 <= var_8_1 then
				var_8_2 = iter_8_0
			else
				break
			end
		end
	end

	return var_8_2
end

return var_0_1
