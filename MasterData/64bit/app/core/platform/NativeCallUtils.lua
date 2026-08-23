local var_0_0 = device
local var_0_1 = LuaObjcBridge
local var_0_2 = LuaJavaBridge
local var_0_3 = LuaJsBridge

local function var_0_4(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0, var_1_1 = var_0_1.callStaticMethod(arg_1_0, arg_1_1, arg_1_2)

	if var_1_0 then
		return var_1_0, var_1_1
	else
		print("call native failed..." .. tostring(var_1_1))

		local var_1_2 = string.format("luaoc.callStaticMethod(\"%s\", \"%s\", \"%s\") - error: [%s] ", arg_1_0, arg_1_1, tostring(arg_1_2), tostring(var_1_1))

		if var_1_1 == -1 then
			print(var_1_2 .. "INVALID PARAMETERS")
		elseif var_1_1 == -2 then
			print(var_1_2 .. "CLASS NOT FOUND")
		elseif var_1_1 == -3 then
			print(var_1_2 .. "METHOD NOT FOUND")
		elseif var_1_1 == -4 then
			print(var_1_2 .. "EXCEPTION OCCURRED")
		elseif var_1_1 == -5 then
			print(var_1_2 .. "INVALID METHOD SIGNATURE")
		else
			print(var_1_2 .. "UNKNOWN")
		end

		return var_1_0, var_1_1
	end
end

local function var_0_5(arg_2_0, arg_2_1, arg_2_2)
	if type(arg_2_0) ~= "table" then
		arg_2_0 = {}
	end

	if arg_2_1 then
		return arg_2_0, arg_2_1
	end

	arg_2_1 = {
		"("
	}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		local var_2_0 = type(iter_2_1)

		arg_2_1[#arg_2_1 + 1] = var_2_0 == "number" and "I" or var_2_0 == "boolean" and "Z" or var_2_0 == "function" and "I" or "Ljava/lang/String;"
	end

	local var_2_1 = "V"

	if arg_2_2 ~= nil then
		if arg_2_2 == "boolean" then
			var_2_1 = "Z"
		elseif arg_2_2 == "int" then
			var_2_1 = "I"
		elseif arg_2_2 == "string" then
			var_2_1 = "Ljava/lang/String;"
		end
	end

	arg_2_1[#arg_2_1 + 1] = ")" .. var_2_1

	return arg_2_0, table.concat(arg_2_1)
end

local function var_0_6(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0

	arg_3_2, var_3_0 = var_0_5(arg_3_2, nil, arg_3_3)

	print("call_luaj:" .. arg_3_0 .. "," .. arg_3_1 .. tostring(var_3_0))

	local var_3_1, var_3_2 = var_0_2.callStaticMethod(arg_3_0, arg_3_1, arg_3_2, var_3_0)

	if var_3_1 then
		return var_3_1, var_3_2
	else
		print("call java native failed..." .. tostring(var_3_2))

		return var_3_1, var_3_2
	end
end

local function var_0_7(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_3 = arg_4_3 or "void"

	local var_4_0, var_4_1 = var_0_3.callStaticMethod(arg_4_0, arg_4_1, arg_4_2, arg_4_3)

	if var_4_0 then
		return var_4_0, var_4_1
	else
		print("LuaJsBridge-lua::call js native failed..." .. tostring(var_4_1))

		return var_4_0, var_4_1
	end
end

local function var_0_8(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
		for iter_5_2, iter_5_3 in pairs(iter_5_1) do
			var_5_0[iter_5_2] = iter_5_3

			break
		end
	end

	return var_5_0
end

local function var_0_9(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			table.insert(var_6_0, iter_6_3)

			break
		end
	end

	return var_6_0
end

local var_0_10 = {}

function var_0_10.call(arg_7_0, arg_7_1, arg_7_2)
	if var_0_10.isTestProj() then
		return
	end

	if var_0_0.isIOS() then
		if arg_7_1 ~= nil then
			arg_7_1 = var_0_8(arg_7_1)

			local var_7_0, var_7_1 = var_0_4("Platform", arg_7_0, arg_7_1)

			return var_7_1, var_7_0
		else
			local var_7_2, var_7_3 = var_0_4("Platform", arg_7_0)

			return var_7_3, var_7_2
		end
	elseif var_0_0.isAndroid() then
		if arg_7_1 ~= nil then
			arg_7_1 = var_0_9(arg_7_1)

			local var_7_4, var_7_5 = var_0_6("com.youzu.platform.Platform", arg_7_0, arg_7_1, arg_7_2)

			return var_7_5, var_7_4
		else
			local var_7_6, var_7_7 = var_0_6("com.youzu.platform.Platform", arg_7_0, arg_7_1, arg_7_2)

			return var_7_7, var_7_6
		end
	elseif var_0_0.isOHOS() then
		arg_7_1 = arg_7_1 or {}
		arg_7_1 = var_0_9(arg_7_1)

		local var_7_8, var_7_9 = var_0_7("Platform", arg_7_0, arg_7_1, arg_7_2)

		return var_7_9, var_7_8
	end
end

function var_0_10.isTestProj()
	if var_0_0.isIOS() then
		local var_8_0, var_8_1 = var_0_4("Platform", "isTestProj")

		return var_8_1, var_8_0
	elseif var_0_0.isAndroid() then
		local var_8_2, var_8_3 = var_0_6("org.cocos2dx.lua.AppActivity", "isTestProj", nil, "boolean")

		return var_8_3, var_8_2
	elseif var_0_0.isOHOS() then
		return false
	end

	return true
end

return var_0_10
