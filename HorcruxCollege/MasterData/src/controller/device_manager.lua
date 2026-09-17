local var_0_0 = {}

var_0_0.platform = "unknown"
var_0_0.model = "unknown"

local var_0_1 = cc.Application:getInstance()
local var_0_2 = var_0_1:getTargetPlatform()

if var_0_2 == cc.PLATFORM_OS_WINDOWS then
	var_0_0.platform = "windows"
elseif var_0_2 == cc.PLATFORM_OS_MAC then
	var_0_0.platform = "mac"
elseif var_0_2 == cc.PLATFORM_OS_ANDROID then
	var_0_0.platform = "android"
elseif var_0_2 == cc.PLATFORM_OS_IPHONE or var_0_2 == cc.PLATFORM_OS_IPAD then
	var_0_0.platform = "ios"
	var_0_0.model = var_0_2 == cc.PLATFORM_OS_IPHONE and "iphone" or "ipad"
end

local var_0_3 = var_0_1:getCurrentLanguage()

var_0_3 = var_0_3 == cc.LANGUAGE_CHINESE and "cn" or var_0_3 == cc.LANGUAGE_FRENCH and "fr" or var_0_3 == cc.LANGUAGE_ITALIAN and "it" or var_0_3 == cc.LANGUAGE_GERMAN and "gr" or var_0_3 == cc.LANGUAGE_SPANISH and "sp" or var_0_3 == cc.LANGUAGE_RUSSIAN and "ru" or var_0_3 == cc.LANGUAGE_KOREAN and "kr" or var_0_3 == cc.LANGUAGE_JAPANESE and "jp" or var_0_3 == cc.LANGUAGE_HUNGARIAN and "hu" or var_0_3 == cc.LANGUAGE_PORTUGUESE and "pt" or var_0_3 == cc.LANGUAGE_ARABIC and "ar" or "en"
var_0_0.language = var_0_3
var_0_0.writablePath = cc.FileUtils:getInstance():getWritablePath()
var_0_0.directorySeparator = "/"
var_0_0.pathSeparator = ":"

if var_0_0.platform == "windows" then
	var_0_0.directorySeparator = "\\"
	var_0_0.pathSeparator = ";"
end

function var_0_0.showActivityIndicator()
	cc.Native:showActivityIndicator()
end

function var_0_0.hideActivityIndicator()
	cc.Native:hideActivityIndicator()
end

function var_0_0.showAlert(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if type(arg_3_2) ~= "table" then
		arg_3_2 = {
			tostring(arg_3_2)
		}
	else
		table.map(arg_3_2, function(arg_4_0)
			return tostring(arg_4_0)
		end)
	end

	if var_0_0.platform == "android" then
		luaj.callStaticMethod("org/cocos2dx/utils/PSNative", "createAlert", {
			arg_3_0,
			arg_3_1,
			arg_3_2,
			function(arg_5_0)
				if type(arg_5_0) == "string" then
					arg_5_0 = require("json").decode(arg_5_0)
					arg_5_0.buttonIndex = tonumber(arg_5_0.buttonIndex)
				end

				if arg_3_3 then
					arg_3_3(arg_5_0)
				end
			end
		}, "(Ljava/lang/String;Ljava/lang/String;Ljava/util/Vector;I)V")
	else
		local var_3_0 = ""

		if #arg_3_2 > 0 then
			var_3_0 = arg_3_2[1]

			table.remove(arg_3_2, 1)
		end

		cc.Native:createAlert(arg_3_0, arg_3_1, var_3_0)

		for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
			cc.Native:addAlertButton(iter_3_1)
		end

		if type(arg_3_3) ~= "function" then
			function arg_3_3()
				return
			end
		end

		cc.Native:showAlert(arg_3_3)
	end
end

function var_0_0.cancelAlert()
	cc.Native:cancelAlert()
end

function var_0_0.openURL(arg_8_0)
	cc.Native:openURL(arg_8_0)
end

function var_0_0.imageWriteToPhotosAlbum(arg_9_0)
	cc.Native.imageWriteToPhotosAlbum(arg_9_0)
end

function var_0_0.showInputBox(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0 = tostring(arg_10_0 or "INPUT TEXT")
	arg_10_1 = tostring(arg_10_1 or "INPUT TEXT, CLICK OK BUTTON")
	arg_10_2 = tostring(arg_10_2 or "")

	return cc.Native:getInputText(arg_10_0, arg_10_1, arg_10_2)
end

function var_0_0.getInternetConnectionStatus()
	if var_0_0.platform == "windows" then
		return 0
	end

	return cc.Network:getInternetConnectionStatus()
end

function var_0_0.isLocalWiFiAvailable()
	if var_0_0.platform == "windows" then
		return false
	end

	return cc.Network:isLocalWiFiAvailable()
end

function var_0_0.isInternetConnectAvailable()
	if var_0_0.platform == "windows" then
		return false
	end

	return cc.Network:isInternetConnectAvailable()
end

function var_0_0.createHTTPRequest(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2 = arg_14_2 or "GET"
	arg_14_2 = string.upper(tostring(arg_14_2)) == "GET" and cc.kCCHTTPRequestMethodGET or string.upper(tostring(arg_14_2)) == "PUT" and cc.kCCHTTPRequestMethodPUT or string.upper(tostring(arg_14_2)) == "DELETE" and cc.kCCHTTPRequestMethodDELETE or cc.kCCHTTPRequestMethodPOST

	return cc.HTTPRequest:createWithUrl(arg_14_0, arg_14_1, arg_14_2)
end

function var_0_0.getOpenUDID()
	return cc.Native:getOpenUDID()
end

function var_0_0.getPackageChannel()
	if cc.Native.getPackageChannel then
		return cc.Native:getPackageChannel()
	end

	return "FY"
end

if var_0_0.platform == "android" then
	function var_0_0.getDeviceManufacturer()
		return cc.Native:getDeviceManufacturer()
	end

	function var_0_0.getDeviceProduct()
		return cc.Native:getDeviceProduct()
	end

	function var_0_0.getDeviceBrand()
		return cc.Native:getDeviceBrand()
	end

	function var_0_0.getDeviceModel()
		return cc.Native:getDeviceModel()
	end

	function var_0_0.getDeviceDevice()
		return cc.Native:getDeviceDevice()
	end

	function var_0_0.getDeviceSerial()
		return cc.Native:getDeviceSerial()
	end

	function var_0_0.getDeviceAndroidVersion()
		return cc.Native:getDeviceAndroidVersion()
	end

	function var_0_0.getIMEI()
		return cc.Native:getIMEI()
	end

	function var_0_0.getPackageName()
		return cc.Native:getPackageName()
	end
end

if var_0_0.platform == "ios" then
	function var_0_0.copyStringToClipboard(arg_26_0)
		cc.Native.copyStringToClipboard(arg_26_0)
	end

	function var_0_0.NTESCSGuardianGetToken()
		cc.Native.NTESCSGuardianGetToken()
	end

	function var_0_0.NTESCSGuardianSetExtraData(arg_28_0, arg_28_1)
		cc.Native.NTESCSGuardianSetExtraData(arg_28_0, arg_28_1)
	end

	function var_0_0.openAppleStorePraisePage()
		cc.Native.openAppleStorePraisePage()
	end
end

local var_0_4

local function var_0_5()
	if config.packagechannel == "palmpi" then
		return config.packagechannel
	elseif var_0_0.getPackageChannel() == "FY" then
		if not var_0_4 then
			var_0_4 = FeiyuManager.getchannelid()

			local channel_reflect_data = require("data.channel_reflect_data")

			if channel_reflect_data[var_0_4] then
				var_0_4 = channel_reflect_data[var_0_4].reflect
			end
		end

		return var_0_4
	else
		return SDKManager:getchannelid()
	end
end

function var_0_0.getChannelID()
	if var_0_0.platform == "windows" then
		return var_0_5()
	end

	if config.clientmode == 0 then
		return var_0_0.getPackageChannel() .. var_0_5()
	else
		return var_0_5()
	end
end

function var_0_0.getDeviceID()
	if var_0_0.platform == "windows" then
		return var_0_0.getOpenUDID()
	elseif var_0_0.platform == "android" then
		if var_0_0.getPackageChannel() == "FY" then
			return FeiyuManager.getDeviceID()
		else
			return var_0_0.getOpenUDID()
		end
	elseif var_0_0.platform == "ios" then
		if var_0_0.getPackageChannel() == "FY" then
			return FeiyuManager.getIDFA()
		else
			return var_0_0.getOpenUDID()
		end
	end

	return ""
end

function var_0_0.getPackageAssetsVersion()
	return cc.Native:getPackageAssetsVersion()
end

function var_0_0.getCurCity()
	return "CN"
end

return var_0_0
