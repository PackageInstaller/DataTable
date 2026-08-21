local var_0_0 = print

function originalPrint(...)
	if IsUnityEditor then
		var_0_0(debug.traceback(printEx(...), 2))
	else
		var_0_0(printEx(...))
	end

	return
end

print = IsUnityEditor and function(...)
	var_0_0(debug.traceback(printEx(...), 2))

	return
end or function()
	return
end

local var_0_1 = setmetatable({}, {
	__mode = "kv"
})
local var_0_2 = getmetatable(GameObject)
local var_0_3 = var_0_2.__index

function var_0_2.__index(arg_4_0, arg_4_1)
	if arg_4_1 == "transform" then
		if var_0_1[arg_4_0] then
			return var_0_1[arg_4_0]
		end

		local var_4_0 = var_0_3(arg_4_0, arg_4_1)

		var_0_1[arg_4_0] = var_4_0

		return var_4_0
	elseif arg_4_1 == "gameObject" then
		return arg_4_0
	else
		return var_0_3(arg_4_0, arg_4_1)
	end

	return
end

local var_0_4 = setmetatable({}, {
	__mode = "kv"
})
local var_0_5 = getmetatable(Transform)
local var_0_6 = var_0_5.__index

function var_0_5.__index(arg_5_0, arg_5_1)
	if arg_5_1 == "gameObject" then
		if var_0_4[arg_5_0] then
			return var_0_4[arg_5_0]
		end

		local var_5_0 = var_0_6(arg_5_0, arg_5_1)

		var_0_4[arg_5_0] = var_5_0

		return var_5_0
	elseif arg_5_1 == "transform" then
		return arg_5_0
	else
		return var_0_6(arg_5_0, arg_5_1)
	end

	return
end

function gcAll(arg_6_0)
	PoolMgr.GetInstance():ExcessPainting(true)
	PoolMgr.GetInstance():ExcessDymPainting(true)
	PoolMgr.GetInstance():ExcessSpineChar(true)
	GCThread.GetInstance():GC(arg_6_0)

	return
end

function RemoveTableItem(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0 = 1, #arg_7_0 do
		local var_7_0

		if arg_7_0[iter_7_0 - 0] == arg_7_1 then
			table.remove(arg_7_0, iter_7_0 - 0)

			if arg_7_2 then
				var_7_0 = 0 + 1
			else
				break
			end
		end
	end

	return
end

function IsNil(arg_8_0)
	return arg_8_0 == nil or arg_8_0:Equals(nil)
end

function isnan(arg_9_0)
	return arg_9_0 ~= arg_9_0
end

function GetDir(arg_10_0)
	return string.match(arg_10_0, ".*/")
end

function GetFileName(arg_11_0)
	return string.match(arg_11_0, ".*/(.*)")
end

function DumpTable(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0) do
		if iter_12_1 ~= nil then
			Debugger.Log("Key: {0}, Value: {1}", tostring(iter_12_0), tostring(iter_12_1))
		else
			Debugger.Log("Key: {0}, Value nil", tostring(iter_12_0))
		end
	end

	return
end

function PrintTable(arg_13_0)
	if arg_13_0 == nil then
		return "nil"
	end

	local var_13_0 = {}

	return (function(arg_14_0, arg_14_1)
		if type(arg_14_0) ~= "table" then
			return arg_14_0
		end

		if var_13_0[arg_14_0] then
			return tostring(arg_14_0)
		end

		var_13_0[arg_14_0] = true

		for iter_14_0, iter_14_1 in pairs(arg_14_0) do
			if type(iter_14_1) == "table" then
				table.insert({}, string.format("%s[%s] = %s", arg_14_1 .. "  ", iter_14_0, var_0(iter_14_1, arg_14_1 .. "  ")))
			else
				table.insert({}, string.format("%s[%s] = %s", arg_14_1 .. "  ", iter_14_0, tostring(iter_14_1)))
			end
		end

		if #{} == 0 then
			return "{}"
		else
			return string.format("{\n%s\n%s}", table.concat({}, "\n"), arg_14_1)
		end

		return
	end)(arg_13_0, "")
end

function PrintLua(arg_15_0, arg_15_1)
	arg_15_1 = arg_15_1 or _G

	for iter_15_0 in string.gmatch(arg_15_0, "%w+") do
		arg_15_1 = arg_15_1[iter_15_0]
	end

	if arg_15_1 == nil then
		Debugger.Log("Lua Module {0} not exists", arg_15_0)

		return
	end

	Debugger.Log("-----------------Dump Table {0}-----------------", arg_15_0)

	if type(arg_15_1) == "table" then
		for iter_15_1, iter_15_2 in pairs(arg_15_1) do
			Debugger.Log("Key: {0}, Value: {1}", iter_15_1, tostring(iter_15_2))
		end
	end

	local var_15_1 = getmetatable(arg_15_1)

	Debugger.Log("-----------------Dump meta {0}-----------------", arg_15_0)

	while var_15_1 ~= nil and var_15_1 ~= arg_15_1 do
		for iter_15_3, iter_15_4 in pairs(var_15_1) do
			if iter_15_3 ~= nil then
				Debugger.Log("Key: {0}, Value: {1}", tostring(iter_15_3), tostring(iter_15_4))
			end
		end

		var_15_1 = getmetatable(var_15_1)
	end

	Debugger.Log("-----------------Dump meta Over-----------------")
	Debugger.Log("-----------------Dump Table Over-----------------")

	return
end

function IsString(arg_16_0)
	return type(arg_16_0) == "string"
end

function IsNumber(arg_17_0)
	return type(arg_17_0) == "number"
end

function tobool(arg_18_0)
	return not not arg_18_0
end

function warning(...)
	if IsUnityEditor then
		Debugger.LogWarning(debug.traceback(printEx(...), 2))
	else
		Debugger.LogWarning(printEx(...))
	end

	return
end

function errorMsg(...)
	if IsUnityEditor then
		Debugger.LogError(debug.traceback(printEx(...)))
	else
		Debugger.LogError(printEx(...))
	end

	return
end

function BuildVector3(arg_21_0)
	local var_21_0 = arg_21_0[1] or 0
	local var_21_1 = arg_21_0[2] or 0
	local var_21_2 = arg_21_0[3] or 0

	return Vector3(var_21_0, var_21_1, var_21_2)
end

function ShowFuncInfo(arg_22_0)
	local var_22_0 = debug.getinfo(arg_22_0)

	return string.format("file:%s#%d", var_22_0.source, var_22_0.linedefined)
end

function String2Table(arg_23_0)
	for iter_23_0 in arg_23_0:gmatch(".") do
		table.insert({}, iter_23_0)
	end

	return {}
end

local var_0_7 = require("bit")

function unicode_to_utf8(arg_24_0)
	if type(arg_24_0) ~= "string" then
		return arg_24_0
	end

	local var_24_0 = ""
	local var_24_1 = 1

	while true do
		local var_24_2 = string.byte(arg_24_0, var_24_1)
		local var_24_3

		if var_24_2 ~= nil and string.sub(arg_24_0, var_24_1, var_24_1 + 1) == "\\u" then
			var_24_3 = tonumber("0x" .. string.sub(arg_24_0, var_24_1 + 2, var_24_1 + 5))
			var_24_1 = var_24_1 + 6
		elseif var_24_2 ~= nil then
			var_24_3 = var_24_2
			var_24_1 = var_24_1 + 1
		else
			break
		end

		if var_24_3 <= 127 then
			var_24_0 = var_24_0 .. string.char(var_0_7.band(var_24_3, 127))
		elseif var_24_3 >= 128 and var_24_3 <= 2047 then
			var_24_0 = var_24_0 .. string.char(var_0_7.bor(192, var_0_7.band(var_0_7.rshift(var_24_3, 6), 31)))
			var_24_0 = var_24_0 .. string.char(var_0_7.bor(128, var_0_7.band(var_24_3, 63)))
		elseif var_24_3 >= 2048 and var_24_3 <= 65535 then
			var_24_0 = var_24_0 .. string.char(var_0_7.bor(224, var_0_7.band(var_0_7.rshift(var_24_3, 12), 15)))
			var_24_0 = var_24_0 .. string.char(var_0_7.bor(128, var_0_7.band(var_0_7.rshift(var_24_3, 6), 63)))
			var_24_0 = var_24_0 .. string.char(var_0_7.bor(128, var_0_7.band(var_24_3, 63)))
		end
	end

	return var_24_0 .. "\x00"
end

function utf8_to_unicode(arg_25_0)
	if type(arg_25_0) ~= "string" then
		return arg_25_0
	end

	local var_25_0 = ""
	local var_25_1 = 1
	local var_25_2 = string.byte(arg_25_0, 1)
	local var_25_3 = 0

	while var_25_2 ~= nil do
		local var_25_4
		local var_25_5

		if var_25_2 >= 0 and var_25_2 <= 127 then
			var_25_4 = var_25_2
			var_25_5 = 0
		elseif var_0_7.band(var_25_2, 224) == 192 then
			var_25_1 = var_25_1 + 1
			var_25_2 = string.byte(arg_25_0, var_25_1)
			var_25_4 = var_0_7.bor(var_0_7.band(var_25_2, var_0_7.rshift(255, 2)), var_0_7.lshift(var_0_7.band(0, var_0_7.rshift(255, 6)), 6))
			var_25_5 = var_0_7.rshift(var_0_7.band(var_25_2, var_0_7.rshift(255, 3)), 2)
		elseif var_0_7.band(var_25_2, 240) == 224 then
			var_25_1 = var_25_1 + 1
			var_25_2 = string.byte(arg_25_0, var_25_1)
			var_25_1 = var_25_1 + 1
			var_25_2 = string.byte(arg_25_0, var_25_1)
			var_25_4 = var_0_7.bor(var_0_7.lshift(var_0_7.band(0, var_0_7.rshift(255, 6)), 6), (var_0_7.band(var_25_2, var_0_7.rshift(255, 2))))
			var_25_5 = var_0_7.bor(var_0_7.lshift(var_0_7.band(var_25_2, var_0_7.rshift(255, 3)), 4), var_0_7.rshift(var_0_7.band(var_25_2, var_0_7.rshift(255, 2)), 2))
		end

		var_25_0 = var_25_0 .. string.format("\\u%02x%02x", var_25_5, var_25_4)
		var_25_3 = var_25_5 == 0 and var_25_3 + 1 or var_25_3 + 2
		var_25_1 = var_25_1 + 1
		var_25_2 = string.byte(arg_25_0, var_25_1)
	end

	return var_25_0, var_25_3
end

function utf8_size(arg_26_0)
	if not arg_26_0 then
		return 0
	elseif arg_26_0 > 240 then
		return 4
	elseif arg_26_0 > 225 then
		return 3
	elseif arg_26_0 > 192 then
		return 2
	else
		return 1
	end

	return
end

function utf8_len(arg_27_0)
	local var_27_0 = 0

	while 1 <= #arg_27_0 do
		local var_27_1 = 1 + utf8_size((string.byte(arg_27_0, 1)))

		var_27_0 = var_27_0 + 1
	end

	return var_27_0
end

function existCall(arg_28_0, ...)
	if arg_28_0 and type(arg_28_0) == "function" then
		return arg_28_0(...)
	end

	return
end

function packEx(...)
	return {
		len = select("#", ...),
		...
	}
end

function unpackEx(arg_30_0)
	return unpack(arg_30_0, 1, arg_30_0.len)
end

function printEx(...)
	local var_31_0 = packEx(...)

	for iter_31_0 = 1, var_31_0.len do
		var_31_0[iter_31_0] = tostring(var_31_0[iter_31_0])
	end

	return table.concat(var_31_0, " ")
end

function envFunc(arg_32_0, arg_32_1, ...)
	assert(type(arg_32_0) == "table")

	local var_32_0 = getfenv(arg_32_1)

	setfenv(arg_32_1, setmetatable({}, {
		__index = function(arg_33_0, arg_33_1)
			if arg_32_0[arg_33_1] ~= nil then
				return arg_32_0[arg_33_1]
			else
				return var_32_0[arg_33_1]
			end

			return
		end,
		__newindex = function(arg_34_0, arg_34_1, arg_34_2)
			arg_32_0[arg_34_1] = arg_34_2

			return
		end
	}))
	setfenv(arg_32_1, (getfenv(arg_32_1)))

	return unpackEx((packEx(arg_32_1(...))))
end

local function var_0_8(arg_35_0, arg_35_1)
	return arg_35_0 ~= nil and type(arg_35_0) == arg_35_1
end

function injectClassProcess(arg_36_0, arg_36_1, arg_36_2)
	setmetatable(arg_36_0, (setmetatable({
		__index = function(arg_37_0, arg_37_1)
			local var_37_0 = rawget(arg_37_0, "class")

			if var_0_8(arg_36_1[arg_37_1], "function") then
				return var_37_0[arg_37_1]
			elseif var_0_8(var_37_0[arg_37_1], "function") then
				return function(...)
					return arg_36_2(var_37_0[arg_37_1], ...)
				end
			else
				local var_37_1 = rawget(arg_37_0, arg_37_1)

				if var_37_1 == nil then
					return var_37_0[arg_37_1]
				else
					return var_37_1
				end
			end

			return
		end
	}, arg_36_0.class)))

	return
end

function cloneRawTableFormClass(arg_39_0)
	setmetatable(arg_39_0, nil)

	for iter_39_0, iter_39_1 in pairs(arg_39_0) do
		({})[iter_39_0] = iter_39_1
	end

	setmetatable(arg_39_0, (getmetatable(arg_39_0)))

	return {}
end

function noEmptyStr(arg_40_0)
	if arg_40_0 and arg_40_0 == "" then
		return nil
	else
		return arg_40_0
	end

	return
end

return
