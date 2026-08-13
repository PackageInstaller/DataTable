print = var_0_10000

local function var_0_0(...)
	IsUnityEditor = var_1_10000

	if var_1_10000 then
		local var_1_0 = var_0_10000

		debug = var_1_10001
		var_1_10001 = var_1_10001.traceback
		printEx = var_1_10002

		var_1_0(var_1_10001(var_1_10002(...), 2))
	else
		local var_1_1 = var_0_10000

		printEx = var_1_10001

		var_1_1(var_1_10001(...))
	end

	return
end

IsUnityEditor = originalPrint

local var_0_1

if var_0_1 then
	function var_0_1(...)
		local var_2_0 = var_0_10000

		debug = var_1_10001

		local var_2_1 = var_1_10001.traceback

		printEx = var_1_10002

		var_2_0(var_2_1(var_1_10002(...), 2))

		return
	end

	var_0_1 = print
else
	function var_0_1()
		return
	end

	var_0_1 = print
end

setmetatable = var_0_1

local var_0_2 = var_0_1({}, {
	__mode = "kv"
})

getmetatable = var_2
GameObject = var_3

local var_0_3 = var_2(var_3).__index

function var_2.__index(arg_4_0, arg_4_1)
	if arg_4_1 == "transform" then
		if var_0_2[arg_4_0] then
			return var_2
		end

		local var_4_0 = var_0_3(arg_4_0, arg_4_1)

		var_0_2[arg_4_0] = var_4_0

		return var_4_0
	elseif arg_4_1 == "gameObject" then
		return arg_4_0
	else
		return var_0_3(arg_4_0, arg_4_1)
	end

	return
end

setmetatable = var_4

local var_0_4 = var_4({}, {
	__mode = "kv"
})

getmetatable = var_5
Transform = var_6

local var_0_5 = var_5(var_6).__index

function var_5.__index(arg_5_0, arg_5_1)
	if arg_5_1 == "gameObject" then
		if var_0_4[arg_5_0] then
			return var_2
		end

		local var_5_0 = var_0_5(arg_5_0, arg_5_1)

		var_0_4[arg_5_0] = var_5_0

		return var_5_0
	elseif arg_5_1 == "transform" then
		return arg_5_0
	else
		return var_0_5(arg_5_0, arg_5_1)
	end

	return
end

local function var_0_6(arg_6_0)
	PoolMgr = var_1_10001

	local var_6_0 = var_1_10001.GetInstance()

	var_1.ExcessPainting(var_6_0, true)

	PoolMgr = var_1

	local var_6_1 = var_1.GetInstance()

	var_1.ExcessDymPainting(var_6_1, true)

	PoolMgr = var_1

	local var_6_2 = var_1.GetInstance()

	var_1.ExcessSpineChar(var_6_2, true)

	GCThread = var_1

	local var_6_3 = var_1.GetInstance()

	var_1.GC(var_6_3, arg_6_0)

	return
end

local var_0_7 = gcAll

local function var_0_8(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = 0

	for iter_7_0 = 1, #arg_7_0 do
		if arg_7_0[iter_7_0 - var_7_0] == arg_7_1 then
			table = var_8

			var_8.remove(arg_7_0, iter_7_0 - var_7_0)

			if arg_7_2 then
				var_7_0 = var_7_0 + 1
			else
				break
			end
		end
	end

	return
end

local var_0_9 = RemoveTableItem

local function var_0_10(arg_8_0)
	return arg_8_0 == nil or arg_8_0:Equals(nil)
end

local var_0_11 = IsNil

local function var_0_12(arg_9_0)
	return arg_9_0 ~= arg_9_0
end

local var_0_13 = isnan

local function var_0_14(arg_10_0)
	string = var_1_10001

	return var_1_10001.match(arg_10_0, ".*/")
end

local var_0_15 = GetDir

local function var_0_16(arg_11_0)
	string = var_1_10001

	return var_1_10001.match(arg_11_0, ".*/(.*)")
end

local var_0_17 = GetFileName

local function var_0_18(arg_12_0)
	pairs = var_1_10001

	for iter_12_0, iter_12_1 in var_1_10001(arg_12_0) do
		if iter_12_1 ~= nil then
			Debugger = var_1_10006
			var_1_10006 = var_1_10006.Log

			local var_12_0 = "Key: {0}, Value: {1}"

			tostring = var_1_10008
			var_1_10008 = var_1_10008(iter_12_0)
			tostring = var_9

			var_1_10006(var_12_0, var_1_10008, var_9(iter_12_1))
		else
			Debugger = var_1_10006
			var_1_10006 = var_1_10006.Log

			local var_12_1 = "Key: {0}, Value nil"

			tostring = var_1_10008

			var_1_10006(var_12_1, var_1_10008(iter_12_0))
		end
	end

	return
end

local var_0_19 = DumpTable

local function var_0_20(arg_13_0)
	if arg_13_0 == nil then
		return "nil"
	end

	local var_13_0 = {}

	return (function(arg_14_0, arg_14_1)
		type = var_2_10002

		if var_2_10002(arg_14_0) ~= "table" then
			return arg_14_0
		end

		if var_13_0[arg_14_0] then
			tostring = var_2

			return var_2(arg_14_0)
		end

		var_13_0[arg_14_0] = true

		local var_14_0 = {}

		pairs = var_3

		for iter_14_0, iter_14_1 in var_3(arg_14_0) do
			type = var_2_10008

			if var_2_10008(iter_14_1) == "table" then
				table = var_2_10008
				var_2_10008 = var_2_10008.insert

				local var_14_1 = var_14_0

				string = var_2_10010

				var_2_10008(var_14_1, var_2_10010.format("%s[%s] = %s", arg_14_1 .. "  ", iter_14_0, var_0(iter_14_1, arg_14_1 .. "  ")))
			else
				table = var_2_10008
				var_2_10008 = var_2_10008.insert

				local var_14_2 = var_14_0

				string = var_2_10010
				var_2_10010 = var_2_10010.format

				local var_14_3 = "%s[%s] = %s"
				local var_14_4 = arg_14_1 .. "  "
				local var_14_5 = iter_14_0

				tostring = var_2_10014

				var_2_10008(var_14_2, var_2_10010(var_14_3, var_14_4, var_14_5, var_2_10014(iter_14_1)))
			end
		end

		if #var_14_0 == 0 then
			return "{}"
		else
			string = var_3

			local var_14_6 = var_3.format
			local var_14_7 = "{\n%s\n%s}"

			table = var_5

			return var_14_6(var_14_7, var_5.concat(var_14_0, "\n"), arg_14_1)
		end

		return
	end)(arg_13_0, "")
end

local var_0_21 = PrintTable

local function var_0_22(arg_15_0, arg_15_1)
	local var_15_0

	if not arg_15_1 then
		_G = arg_15_1
	end

	string = var_1_10003

	for iter_15_0 in var_1_10003.gmatch(arg_15_0, "%w+") do
		arg_15_1 = arg_15_1[iter_15_0]
	end

	if arg_15_1 == nil then
		Debugger = var_3

		var_3.Log("Lua Module {0} not exists", arg_15_0)

		return
	end

	Debugger = var_3

	var_3.Log("-----------------Dump Table {0}-----------------", arg_15_0)

	type = var_3

	if var_3(var_2) == "table" then
		pairs = var_3

		for iter_15_1, iter_15_2 in var_3(var_2) do
			Debugger = var_1_10008
			var_1_10008 = var_1_10008.Log
			var_1_10009 = "Key: {0}, Value: {1}"

			local var_15_1 = iter_15_1

			tostring = var_1_10011

			var_1_10008(var_1_10009, var_15_1, var_1_10011(iter_15_2))
		end
	end

	getmetatable = var_3

	local var_15_2 = var_3(var_2)

	Debugger = var_4

	var_4.Log("-----------------Dump meta {0}-----------------", arg_15_0)

	while var_15_2 ~= nil and var_15_2 ~= var_2 do
		pairs = var_4

		for iter_15_3, iter_15_4 in var_4(var_15_2) do
			if iter_15_3 ~= nil then
				Debugger = var_1_10009
				var_1_10009 = var_1_10009.Log

				local var_15_3 = "Key: {0}, Value: {1}"

				tostring = var_1_10011
				var_1_10011 = var_1_10011(iter_15_3)
				tostring = var_12

				var_1_10009(var_15_3, var_1_10011, var_12(iter_15_4))
			end
		end

		getmetatable = var_4
		var_15_2 = var_4(var_15_2)
	end

	Debugger = var_4

	var_4.Log("-----------------Dump meta Over-----------------")

	Debugger = var_4

	var_4.Log("-----------------Dump Table Over-----------------")

	return
end

local var_0_23 = PrintLua

local function var_0_24(arg_16_0)
	type = var_1_10001

	return var_1_10001(arg_16_0) == "string"
end

local var_0_25 = IsString

local function var_0_26(arg_17_0)
	type = var_1_10001

	return var_1_10001(arg_17_0) == "number"
end

local var_0_27 = IsNumber

local function var_0_28(arg_18_0)
	return arg_18_0 and true or false
end

local var_0_29 = tobool

local function var_0_30(...)
	IsUnityEditor = var_1_10000

	if var_1_10000 then
		Debugger = var_1_10000
		var_1_10000 = var_1_10000.LogWarning
		debug = var_1_10001
		var_1_10001 = var_1_10001.traceback
		printEx = var_1_10002

		var_1_10000(var_1_10001(var_1_10002(...), 2))
	else
		Debugger = var_1_10000

		local var_19_0 = var_1_10000.LogWarning

		printEx = var_1_10001

		var_19_0(var_1_10001(...))
	end

	return
end

local var_0_31 = warning

local function var_0_32(...)
	IsUnityEditor = var_1_10000

	if var_1_10000 then
		Debugger = var_1_10000
		var_1_10000 = var_1_10000.LogError
		debug = var_1_10001
		var_1_10001 = var_1_10001.traceback
		printEx = var_1_10002

		var_1_10000(var_1_10001(var_1_10002(...)))
	else
		Debugger = var_1_10000

		local var_20_0 = var_1_10000.LogError

		printEx = var_1_10001

		var_20_0(var_1_10001(...))
	end

	return
end

local var_0_33 = errorMsg

local function var_0_34(arg_21_0)
	Vector3 = var_1_10001

	local var_21_0

	if not arg_21_0[1] then
		var_21_0 = 0
	end

	local var_21_1

	if not arg_21_0[2] then
		var_21_1 = 0
	end

	local var_21_2

	if not arg_21_0[3] then
		var_21_2 = 0
	end

	return var_1_10001(var_21_0, var_21_1, var_21_2)
end

local var_0_35 = BuildVector3

local function var_0_36(arg_22_0)
	debug = var_1_10001

	local var_22_0 = var_1_10001.getinfo(arg_22_0)

	string = var_2

	return var_2.format("file:%s#%d", var_22_0.source, var_22_0.linedefined)
end

local var_0_37 = ShowFuncInfo

local function var_0_38(arg_23_0)
	local var_23_0 = {}

	for iter_23_0 in arg_23_0:gmatch(".") do
		table = var_1_10006

		var_1_10006.insert(var_23_0, iter_23_0)
	end

	return var_23_0
end

require = String2Table

local var_0_39 = var_7("bit")

local function var_0_40(arg_24_0)
	type = var_1_10001

	if var_1_10001(arg_24_0) ~= "string" then
		return arg_24_0
	end

	local var_24_0 = ""
	local var_24_1 = 1

	while true do
		string = var_1_10003
		var_1_10003 = var_1_10003.byte(arg_24_0, var_24_1)

		local var_24_2

		if var_1_10003 ~= nil then
			string = var_5

			if var_5.sub(arg_24_0, var_24_1, var_24_1 + 1) == "\\u" then
				tonumber = var_5
				var_1_10006 = "0x"
				string = var_7
				var_24_2 = var_5(var_1_10006 .. var_7.sub(arg_24_0, var_24_1 + 2, var_24_1 + 5))
				var_24_1 = var_24_1 + 6

				goto label_24_0
			end
		end

		if var_1_10003 ~= nil then
			var_24_2 = var_1_10003
			var_24_1 = var_24_1 + 1
		else
			break
		end

		::label_24_0::

		if var_24_2 <= 127 then
			local var_24_3 = var_24_0

			string = var_1_10006
			var_24_0 = var_24_3 .. var_1_10006.char(var_0_39.band(var_24_2, 127))
		elseif var_24_2 >= 128 and var_24_2 <= 2047 then
			local var_24_4 = var_24_0

			string = var_1_10006

			local var_24_5 = var_24_4 .. var_1_10006.char(var_0_39.bor(192, var_0_39.band(var_0_39.rshift(var_24_2, 6), 31)))

			string = var_1_10006
			var_24_0 = var_24_5 .. var_1_10006.char(var_0_39.bor(128, var_0_39.band(var_24_2, 63)))
		elseif var_24_2 >= 2048 and var_24_2 <= 65535 then
			local var_24_6 = var_24_0

			string = var_1_10006

			local var_24_7 = var_24_6 .. var_1_10006.char(var_0_39.bor(224, var_0_39.band(var_0_39.rshift(var_24_2, 12), 15)))

			string = var_1_10006

			local var_24_8 = var_24_7 .. var_1_10006.char(var_0_39.bor(128, var_0_39.band(var_0_39.rshift(var_24_2, 6), 63)))

			string = var_1_10006
			var_24_0 = var_24_8 .. var_1_10006.char(var_0_39.bor(128, var_0_39.band(var_24_2, 63)))
		end
	end

	return var_24_0 .. "\x00"
end

local var_0_41 = unicode_to_utf8

local function var_0_42(arg_25_0)
	type = var_1_10001

	if var_1_10001(arg_25_0) ~= "string" then
		return arg_25_0
	end

	local var_25_0 = ""
	local var_25_1 = 1

	string = var_1_10003

	local var_25_2 = var_1_10003.byte(arg_25_0, var_25_1)
	local var_25_3 = 0

	while var_25_2 ~= nil do
		local var_25_4
		local var_25_5

		if var_25_2 >= 0 and var_25_2 <= 127 then
			var_25_4 = var_25_2
			var_25_5 = 0
		elseif var_0_39.band(var_25_2, 224) == 192 then
			local var_25_6 = 0

			var_1_10008 = 0

			local var_25_7 = var_0_39.band(var_25_2, var_0_39.rshift(255, 3))

			var_25_1 = var_25_1 + 1
			string = var_9
			var_25_2 = var_9.byte(arg_25_0, var_25_1)
			var_1_10008 = var_0_39.band(var_25_2, var_0_39.rshift(255, 2))
			var_25_4 = var_0_39.bor(var_1_10008, var_0_39.lshift(var_0_39.band(var_25_7, var_0_39.rshift(255, 6)), 6))
			var_25_5 = var_0_39.rshift(var_25_7, 2)
		elseif var_0_39.band(var_25_2, 240) == 224 then
			local var_25_8 = 0

			var_1_10008 = 0

			local var_25_9 = 0
			local var_25_10 = var_0_39.band(var_25_2, var_0_39.rshift(255, 3))

			var_25_1 = var_25_1 + 1
			string = var_10
			var_25_2 = var_10.byte(arg_25_0, var_25_1)
			var_1_10008 = var_0_39.band(var_25_2, var_0_39.rshift(255, 2))
			var_25_1 = var_25_1 + 1
			string = var_10
			var_25_2 = var_10.byte(arg_25_0, var_25_1)

			local var_25_11 = var_0_39.band(var_25_2, var_0_39.rshift(255, 2))

			var_25_4 = var_0_39.bor(var_0_39.lshift(var_0_39.band(var_1_10008, var_0_39.rshift(255, 6)), 6), var_25_11)
			var_25_5 = var_0_39.bor(var_0_39.lshift(var_25_10, 4), var_0_39.rshift(var_1_10008, 2))
		end

		local var_25_12 = var_25_0

		string = var_1_10008
		var_25_0 = var_25_12 .. var_1_10008.format("\\u%02x%02x", var_25_5, var_25_4)

		if var_25_5 == 0 then
			var_25_3 = var_25_3 + 1
		else
			var_25_3 = var_25_3 + 2
		end

		var_25_1 = var_25_1 + 1
		string = var_25_12
		var_25_2 = var_25_12.byte(arg_25_0, var_25_1)
	end

	return var_25_0, var_25_3
end

local var_0_43 = utf8_to_unicode

local function var_0_44(arg_26_0)
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

local var_0_45 = utf8_size

local function var_0_46(arg_27_0)
	local var_27_0 = 1
	local var_27_1 = 0
	local var_27_2 = #arg_27_0

	while var_27_0 <= var_27_2 do
		string = var_1_10004
		var_1_10004 = var_1_10004.byte(arg_27_0, var_27_0)
		utf8_size = var_5
		var_27_0 = var_27_0 + var_5(var_1_10004)
		var_27_1 = var_27_1 + 1
	end

	return var_27_1
end

local var_0_47 = utf8_len

local function var_0_48(arg_28_0, ...)
	if arg_28_0 then
		type = var_1_10001

		if var_1_10001(arg_28_0) == "function" then
			return arg_28_0(...)
		end
	end

	return
end

local var_0_49 = existCall

local function var_0_50(...)
	local var_29_0 = {}

	select = var_1_10001
	var_29_0.len = var_1_10001("#", ...)
	var_29_0[1] = ...

	return var_29_0
end

local var_0_51 = packEx

local function var_0_52(arg_30_0)
	unpack = var_1_10001

	return var_1_10001(arg_30_0, 1, arg_30_0.len)
end

local var_0_53 = unpackEx

local function var_0_54(...)
	packEx = var_1_10000

	local var_31_0 = var_1_10000(...)

	for iter_31_0 = 1, var_31_0.len do
		tostring = var_1_10005
		var_31_0[iter_31_0] = var_1_10005(var_31_0[iter_31_0])
	end

	table = var_1

	return var_1.concat(var_31_0, " ")
end

local var_0_55 = printEx

local function var_0_56(arg_32_0, arg_32_1, ...)
	assert = var_1_10002
	type = var_1_10003

	var_1_10002(var_1_10003(arg_32_0) == "table")

	getfenv = var_1_10002

	local var_32_0 = var_1_10002(arg_32_1)

	setfenv = var_3

	local var_32_1 = arg_32_1

	setmetatable = var_1_10005

	var_3(var_32_1, var_1_10005({}, {
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

	packEx = var_3

	local var_32_2 = var_3(arg_32_1(...))

	setfenv = var_4

	var_4(arg_32_1, var_32_0)

	unpackEx = var_4

	return var_4(var_32_2)
end

local var_0_57 = envFunc

local function var_0_58(arg_35_0, arg_35_1)
	if arg_35_0 ~= nil then
		type = var_1_10002

		local var_35_0

		if var_1_10002(arg_35_0) ~= arg_35_1 then
			var_35_0 = false
		else
			var_35_0 = true
		end

		return var_35_0
	end
end

local function var_0_59(arg_36_0, arg_36_1, arg_36_2)
	setmetatable = var_1_10003

	local var_36_0 = var_1_10003({
		__index = function(arg_37_0, arg_37_1)
			rawget = var_2_10002

			local var_37_0 = var_2_10002(arg_37_0, "class")

			if var_0_58(arg_36_1[arg_37_1], "function") then
				return var_37_0[arg_37_1]
			elseif var_0_58(var_37_0[arg_37_1], "function") then
				return function(...)
					return arg_36_2(var_37_0[arg_37_1], ...)
				end
			else
				rawget = var_3

				if var_3(arg_37_0, arg_37_1) == nil then
					return var_37_0[arg_37_1]
				else
					return var_3
				end
			end

			return
		end
	}, arg_36_0.class)

	setmetatable = var_4

	var_4(arg_36_0, var_36_0)

	return
end

local var_0_60 = injectClassProcess

local function var_0_61(arg_39_0)
	local var_39_0 = {}

	getmetatable = var_1_10002

	local var_39_1 = var_1_10002(arg_39_0)

	setmetatable = var_3

	var_3(arg_39_0, nil)

	pairs = var_3

	for iter_39_0, iter_39_1 in var_3(arg_39_0) do
		var_39_0[iter_39_0] = iter_39_1
	end

	setmetatable = var_3

	var_3(arg_39_0, var_39_1)

	return var_39_0
end

local var_0_62 = cloneRawTableFormClass

local function var_0_63(arg_40_0)
	if arg_40_0 and arg_40_0 == "" then
		return nil
	else
		return arg_40_0
	end

	return
end

local var_0_64 = noEmptyStr

return
