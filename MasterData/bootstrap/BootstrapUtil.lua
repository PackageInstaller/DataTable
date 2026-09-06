-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/bootstrap/BootstrapUtil.lua

module("bootstrap.BootstrapUtil", package.seeall)

local BootstrapUtil = {}
local json = require("cjson")

BootstrapUtil.sdkClazz = "com.baitian.wrap.OneSDKWrap"
BootstrapUtil.KEY_INIT = "key_sdk_init"
BootstrapUtil.KEY_KEY_SDK_SCREEN_CHANGED = "key_sdk_screen_changed"
BootstrapUtil.STATUS_OK = 0
BootstrapUtil.INIT_SUCCESS = 1
BootstrapUtil.INIT_PROGRESS = 0
BootstrapUtil.INIT_FAIL = -1
BootstrapUtil._listeners = {}

function BootstrapUtil.setSdkClazz(clazz)
	BootstrapUtil.sdkClazz = clazz
end

function BootstrapUtil.getNetworkInfo()
	local nativeMgr = Framework.NativeMgr.Instance
	local sdkClazz = BootstrapUtil.sdkClazz
	local method = "getNetworkInfo"

	return (Framework.OSDef.RunOS == Framework.OSDef.Android or Framework.OSDef.RunOS == Framework.OSDef.IOS or nil) and nativeMgr:CallStaticString(sdkClazz, method, "{}")
end

function BootstrapUtil.sdkDestroy()
	local nativeMgr = Framework.NativeMgr.Instance
	local sdkClazz = BootstrapUtil.sdkClazz
	local method = "destroy"

	nativeMgr:CallStatic(sdkClazz, method, "{}")
end

function BootstrapUtil.getDevJson()
	local nativeMgr = Framework.NativeMgr.Instance
	local sdkClazz = BootstrapUtil.sdkClazz
	local method = "getDevJson"
	local devJson = nativeMgr:CallStaticString(sdkClazz, method, "{}")

	return (not string.nilorempty(devJson) or nil) and json.decode(devJson)
end

function BootstrapUtil.getGameVersionCode()
	local versionCode = "0"
	local nativeMgr = Framework.NativeMgr.Instance
	local sdkClazz = BootstrapUtil.sdkClazz
	local method = "getDevJson"
	local devJson = nativeMgr:CallStaticString(sdkClazz, method, "{}")

	if not string.nilorempty(devJson) then
		local devInfo = json.decode(devJson)

		versionCode = devInfo.gameVersionCode
	end

	return checknumber(versionCode)
end

function BootstrapUtil.getGameVersionName()
	local versionName = "0.0.0"
	local nativeMgr = Framework.NativeMgr.Instance
	local sdkClazz = BootstrapUtil.sdkClazz
	local method = "getDevJson"
	local devJson = nativeMgr:CallStaticString(sdkClazz, method, "{}")

	if not string.nilorempty(devJson) then
		local devInfo = json.decode(devJson)

		versionName = devInfo.gameVersionName
	end

	return versionName
end

function BootstrapUtil.getGamePackageName()
	if not BootstrapUtil._gamepackageName then
		local devInfo = BootstrapUtil.getDevJson()

		BootstrapUtil._gamepackageName = devInfo.gamepackageName or "com.baitian.unity.editor"
	end

	return BootstrapUtil._gamepackageName
end

function BootstrapUtil.getChannelId()
	if not BootstrapUtil._channelId then
		local devInfo = BootstrapUtil.getDevJson()

		BootstrapUtil._channelId = devInfo.channelId or "0000"
	end

	return BootstrapUtil._channelId
end

function BootstrapUtil.getCoChannelId()
	if BootstrapUtil._cochannelId == nil then
		local res = BootstrapUtil.getDevJson()

		BootstrapUtil._cochannelId = checknumber(res.cochannelId)
	end

	return BootstrapUtil._cochannelId
end

function BootstrapUtil.getImei()
	if BootstrapUtil._imei == nil then
		local res = BootstrapUtil.getDevJson()

		BootstrapUtil._imei = res.imei
	end

	return BootstrapUtil._imei
end

function BootstrapUtil.getGameHotUpdateVersionCode()
	if rescache.resLoadMode == Framework.ResourceLoadMode.Direct then
		return "0.0.0"
	else
		return Framework.HotUpdate.VersionMgr.Instance.localVersion
	end
end

function BootstrapUtil.getPlatformId()
	if not BootstrapUtil._platformId then
		local nativeMgr = Framework.NativeMgr.Instance
		local sdkClazz = BootstrapUtil.sdkClazz
		local method = "getPlatformId"
		local platformId = nativeMgr:CallStaticIntDefault(sdkClazz, method, "{}", 0)

		if platformId < 0 then
			platformId = 0
		end

		BootstrapUtil._platformId = platformId
	end

	return BootstrapUtil._platformId
end

function BootstrapUtil.getGameId()
	if not BootstrapUtil._gameId then
		local nativeMgr = Framework.NativeMgr.Instance
		local sdkClazz = BootstrapUtil.sdkClazz
		local method = "getGameId"

		BootstrapUtil._gameId = nativeMgr:CallStaticStringDefault(sdkClazz, method, "{}", 0)
	end

	return BootstrapUtil._gameId
end

function BootstrapUtil.sensorsTrack(eventId, properties, isFlush)
	local nativeMgr = Framework.NativeMgr.Instance
	local sdkClazz = BootstrapUtil.sdkClazz
	local method = "sensorsTrack"

	properties = properties or {}

	if isFlush == nil then
		isFlush = true
	end

	local param = {}

	param.eventId = eventId
	param.properties = json.encode(properties)
	param.isFlush = isFlush

	local paramString = json.encode(param)

	nativeMgr:CallStatic(sdkClazz, method, paramString)
end

function BootstrapUtil.sensorsTrackOnce(eventId, properties, key, isFlush)
	local isTracked = UnityEngine.PlayerPrefs.GetInt(key) == 1

	if isTracked then
		return
	end

	UnityEngine.PlayerPrefs.SetInt(key, 1)
	BootstrapUtil.sensorsTrack(eventId, properties, isFlush)
end

function BootstrapUtil.sensorsTrackLoadingOnce(name, key)
	local isTracked = UnityEngine.PlayerPrefs.GetInt(key) == 1

	if isTracked then
		return
	end

	UnityEngine.PlayerPrefs.SetInt(key, 1)

	local properties = {}

	properties[BootstrapConstdef.ELoginCommonIdName] = name

	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.ELoginCommonId, properties, true)
end

function BootstrapUtil.hideTransition()
	local nativeMgr = Framework.NativeMgr.Instance
	local sdkClazz = BootstrapUtil.sdkClazz
	local method = "hideTransition"

	nativeMgr:CallStatic(sdkClazz, method, "{}")
end

function BootstrapUtil.checkSdkInit()
	local nativeMgr = Framework.NativeMgr.Instance
	local sdkClazz = BootstrapUtil.sdkClazz
	local method = "checkSdkInit"

	return nativeMgr:CallStaticIntDefault(sdkClazz, method, "{}", BootstrapUtil.INIT_SUCCESS)
end

function BootstrapUtil.sdkInit(isHideSplash)
	local nativeMgr = Framework.NativeMgr.Instance
	local sdkClazz = BootstrapUtil.sdkClazz
	local method = "init"
	local param = {
		isHideSplash = isHideSplash
	}
	local paramString = json.encode(param)

	nativeMgr:CallStatic(sdkClazz, method, paramString)
end

function BootstrapUtil.invoke(clazz, method, param)
	local nativeMgr = Framework.NativeMgr.Instance

	param = param or {}

	local paramString = json.encode(param)

	nativeMgr:CallStatic(clazz, method, paramString)
end

function BootstrapUtil.registerInitListener(callFunc, callObj)
	BootstrapUtil.registerListener(BootstrapUtil.KEY_INIT, callFunc, callObj)
end

function BootstrapUtil.clearNativeCallback()
	local nativeMgr = Framework.NativeMgr.Instance

	nativeMgr:SetCallback(nil, nil)
end

function BootstrapUtil.showWebBrowser(url, isUserBrowser)
	local nativeMgr = Framework.NativeMgr.Instance
	local sdkClazz = BootstrapUtil.sdkClazz
	local method = "showWebBrowser"
	local param = {
		url = url,
		isUserBrowser = isUserBrowser
	}
	local paramString = json.encode(param)

	nativeMgr:CallStatic(sdkClazz, method, paramString)
end

function BootstrapUtil.getHotUpdateDeviceType()
	if Framework.OSDef.isEditor then
		return 0
	elseif Framework.OSDef.RunOS == Framework.OSDef.Android then
		return 0
	elseif Framework.OSDef.RunOS == Framework.OSDef.IOS then
		return 1
	elseif Framework.OSDef.RunOS == Framework.OSDef.Win32 or Framework.OSDef.RunOS == Framework.OSDef.Mac then
		return 4
	else
		return 0
	end
end

function BootstrapUtil.registerScreenChangedListener()
	BootstrapUtil.registerListener(BootstrapUtil.KEY_KEY_SDK_SCREEN_CHANGED, function(result)
		if BootstrapUtil._isCanUseAdapter() then
			SceneAdapterUtil.Adapter(result.screenWidth, result.screenHeight)
		end

		BootstrapAdaptationoverlayview.updatePos()
	end)
end

function BootstrapUtil.registerNativeCallBack()
	local nativeMgr = Framework.NativeMgr.Instance

	nativeMgr:SetCallback(function(message)
		local result = json.decode(message)
		local key = result.msgkey
		local listener = BootstrapUtil._listeners[key]

		if listener ~= nil then
			-- block empty
		end

		::label_28_3::
	end, nil)
end

function BootstrapUtil.registerListener(key, callFunc, callObj)
	if key == nil or callFunc == nil then
		return
	end

	BootstrapUtil._listeners[key] = {
		func = callFunc,
		obj = callObj
	}
end

function BootstrapUtil.clearInitCallback()
	BootstrapUtil.unregisterListener(BootstrapUtil.KEY_INIT)
end

function BootstrapUtil.unregisterListener(key)
	BootstrapUtil._listeners[key] = nil
end

function BootstrapUtil._isCanUseAdapter()
	local vc = checknumber(BootstrapUtil.getGameVersionCode())

	if Framework.OSDef.RunOS == Framework.OSDef.Android and vc < 970 then
		return false
	elseif Framework.OSDef.RunOS == Framework.OSDef.IOS and vc < 970 then
		return false
	else
		return true
	end
end

return BootstrapUtil
