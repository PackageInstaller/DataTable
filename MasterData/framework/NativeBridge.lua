-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/native/NativeBridge.lua

module("framework.native.NativeBridge", package.seeall)

local NativeBridge = class("NativeBridge")
local json = require("cjson")

NativeBridge.MESSAGE_KEY = "msgkey"

function NativeBridge:ctor()
	self._nativeMgr = Framework.NativeMgr.Instance

	self._nativeMgr:SetCallback(NativeBridge._handleMsg, self)

	self._listeners = {}
end

function NativeBridge:registerListener(key, callFunc, callObj)
	if key == nil or callFunc == nil then
		return
	end

	self._listeners[key] = {
		func = callFunc,
		obj = callObj
	}
end

function NativeBridge:unregisterListener(key)
	self._listeners[key] = nil
end

function NativeBridge:invoke(clazz, method, param)
	param = param or {}

	local paramString = json.encode(param)

	self._nativeMgr:CallStatic(clazz, method, paramString)
end

function NativeBridge:invokeString(clazz, method, param, defaultValue)
	param = param or {}

	local paramString = json.encode(param)

	if defaultValue == nil then
		return self._nativeMgr:CallStaticString(clazz, method, paramString)
	else
		return self._nativeMgr:CallStaticStringDefault(clazz, method, paramString, defaultValue)
	end
end

function NativeBridge:invokeInt(clazz, method, param, defaultValue)
	param = param or {}

	local paramString = json.encode(param)

	if defaultValue == nil then
		return self._nativeMgr:CallStaticInt(clazz, method, paramString)
	else
		return self._nativeMgr:CallStaticIntDefault(clazz, method, paramString, defaultValue)
	end
end

function NativeBridge:invokeBool(clazz, method, param, defaultValue)
	param = param or {}

	local paramString = json.encode(param)

	if defaultValue == nil then
		return self._nativeMgr:CallStaticBool(clazz, method, paramString)
	else
		return self._nativeMgr:CallStaticBoolDefault(clazz, method, paramString, defaultValue)
	end
end

function NativeBridge:invokeLong(clazz, method, param, defaultValue)
	param = param or {}

	local paramString = json.encode(param)

	if defaultValue == nil then
		return self._nativeMgr:CallStaticLong(clazz, method, paramString)
	else
		return self._nativeMgr:CallStaticLongDefault(clazz, method, paramString, defaultValue)
	end
end

function NativeBridge:invokeFloat(clazz, method, param, defaultValue)
	param = param or {}

	local paramString = json.encode(param)

	if defaultValue == nil then
		return self._nativeMgr:CallStaticFloat(clazz, method, paramString)
	else
		return self._nativeMgr:CallStaticFloatDefault(clazz, method, paramString, defaultValue)
	end
end

function NativeBridge:setGameObject(objectName)
	local clazz = "com.baitian.bridge.NativeManager"
	local method = "setGameObject"
	local param = {
		gameObject = objectName
	}

	self:invoke(clazz, method, param)
end

function NativeBridge:isMethodExist(clazzName, methodName)
	local clazz = "com.baitian.bridge.NativeManager"
	local method = "isMethodExist"
	local param = {
		targetClazz = clazzName,
		targetMethod = methodName
	}

	return (self:invokeBool(clazz, method, param, false))
end

function NativeBridge:log(nativeContent)
	local clazz = "com.baitian.bridge.NativeManager"
	local method = "log"
	local param = {
		content = nativeContent
	}

	self:invoke(clazz, method, param)
end

function NativeBridge:_handleMsg(message)
	local result = json.decode(message)
	local key = result[NativeBridge.MESSAGE_KEY]
	local listener = self._listeners[key]

	if listener ~= nil then
		-- block empty
	end

	::label_13_1::
end

NativeBridge.instance = NativeBridge.New()

return NativeBridge
