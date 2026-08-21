module("framework.native.NativeBridge", package.seeall)

local var_0_0 = class("NativeBridge")
local var_0_1 = require("cjson")

var_0_0.MESSAGE_KEY = "msgkey"

function var_0_0.ctor(arg_1_0)
	arg_1_0._nativeMgr = Astral.NativeMgr.Instance

	arg_1_0._nativeMgr:SetCallback(var_0_0._handleMsg, arg_1_0)

	arg_1_0._listeners = {}
end

function var_0_0.registerListener(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_1 == nil or arg_2_2 == nil then
		return
	end

	local var_2_0 = {
		func = arg_2_2,
		obj = arg_2_3
	}

	arg_2_0._listeners[arg_2_1] = var_2_0
end

function var_0_0.unregisterListener(arg_3_0, arg_3_1)
	arg_3_0._listeners[arg_3_1] = nil
end

function var_0_0.invoke(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_3 = arg_4_3 or {}

	local var_4_0 = var_0_1.encode(arg_4_3)

	arg_4_0._nativeMgr:CallStatic(arg_4_1, arg_4_2, var_4_0)
end

function var_0_0.invokeString(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_3 = arg_5_3 or {}

	local var_5_0 = var_0_1.encode(arg_5_3)

	if arg_5_4 == nil then
		return arg_5_0._nativeMgr:CallStaticString(arg_5_1, arg_5_2, var_5_0)
	else
		return arg_5_0._nativeMgr:CallStaticStringDefault(arg_5_1, arg_5_2, var_5_0, arg_5_4)
	end
end

function var_0_0.invokeInt(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_3 = arg_6_3 or {}

	local var_6_0 = var_0_1.encode(arg_6_3)

	if arg_6_4 == nil then
		return arg_6_0._nativeMgr:CallStaticInt(arg_6_1, arg_6_2, var_6_0)
	else
		return arg_6_0._nativeMgr:CallStaticIntDefault(arg_6_1, arg_6_2, var_6_0, arg_6_4)
	end
end

function var_0_0.invokeBool(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_3 = arg_7_3 or {}

	local var_7_0 = var_0_1.encode(arg_7_3)

	if arg_7_4 == nil then
		return arg_7_0._nativeMgr:CallStaticBool(arg_7_1, arg_7_2, var_7_0)
	else
		return arg_7_0._nativeMgr:CallStaticBoolDefault(arg_7_1, arg_7_2, var_7_0, arg_7_4)
	end
end

function var_0_0.invokeLong(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	arg_8_3 = arg_8_3 or {}

	local var_8_0 = var_0_1.encode(arg_8_3)

	if arg_8_4 == nil then
		return arg_8_0._nativeMgr:CallStaticLong(arg_8_1, arg_8_2, var_8_0)
	else
		return arg_8_0._nativeMgr:CallStaticLongDefault(arg_8_1, arg_8_2, var_8_0, arg_8_4)
	end
end

function var_0_0.invokeFloat(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_3 = arg_9_3 or {}

	local var_9_0 = var_0_1.encode(arg_9_3)

	if arg_9_4 == nil then
		return arg_9_0._nativeMgr:CallStaticFloat(arg_9_1, arg_9_2, var_9_0)
	else
		return arg_9_0._nativeMgr:CallStaticFloatDefault(arg_9_1, arg_9_2, var_9_0, arg_9_4)
	end
end

function var_0_0.setGameObject(arg_10_0, arg_10_1)
	local var_10_0 = "com.baitian.bridge.NativeManager"
	local var_10_1 = "setGameObject"
	local var_10_2 = {
		gameObject = arg_10_1
	}

	arg_10_0:invoke(var_10_0, var_10_1, var_10_2)
end

function var_0_0.isMethodExist(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = "com.baitian.bridge.NativeManager"
	local var_11_1 = "isMethodExist"
	local var_11_2 = {
		targetClazz = arg_11_1,
		targetMethod = arg_11_2
	}

	return (arg_11_0:invokeBool(var_11_0, var_11_1, var_11_2, false))
end

function var_0_0.log(arg_12_0, arg_12_1)
	local var_12_0 = "com.baitian.bridge.NativeManager"
	local var_12_1 = "log"
	local var_12_2 = {
		content = arg_12_1
	}

	arg_12_0:invoke(var_12_0, var_12_1, var_12_2)
end

function var_0_0._handleMsg(arg_13_0, arg_13_1)
	local var_13_0 = var_0_1.decode(arg_13_1)
	local var_13_1 = var_13_0[var_0_0.MESSAGE_KEY]
	local var_13_2 = arg_13_0._listeners[var_13_1]

	if var_13_2 ~= nil then
		local var_13_3 = var_13_2.func
		local var_13_4 = var_13_2.obj

		if var_13_4 ~= nil then
			var_13_3(var_13_4, var_13_0)
		else
			var_13_3(var_13_0)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
