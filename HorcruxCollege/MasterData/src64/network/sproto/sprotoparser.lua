local var_0_9000
local lpeg = require("lpeg")
local table = require("table")
local var_0_2
local var_0_3

if _VERSION == "Lua 5.3" then
	function var_0_2(arg_1_0)
		return string.pack("<s4", arg_1_0)
	end

	function var_0_3(arg_2_0)
		arg_2_0 = (arg_2_0 + 1) * 2

		return string.pack("<I2", arg_2_0)
	end
end

local var_0_18
local var_0_17
local var_0_15
local var_0_16
local var_0_9
local var_0_13

do
	function var_0_2(arg_3_0)
		local var_3_0 = math.floor(#arg_3_0 / 256)
		local var_3_1 = math.floor(var_3_0 / 256)

		return string.char(#arg_3_0 % 256) .. string.char(var_3_0 % 256) .. string.char(var_3_1 % 256) .. string.char((math.floor(var_3_1 / 256))) .. arg_3_0
	end

	function var_0_3(arg_4_0)
		arg_4_0 = (arg_4_0 + 1) * 2

		assert(arg_4_0 >= 0 and arg_4_0 < 65536)

		return string.char(arg_4_0 % 256) .. string.char((math.floor(arg_4_0 / 256)))
	end

	local var_0_4 = lpeg.Ct
	local var_0_5 = lpeg.Cg
	local var_0_6 = lpeg.Cc
	local var_0_7 = lpeg.Cmt(lpeg.Carg(1), function(arg_6_0, arg_6_1, arg_6_2)
		error(string.format("syntax error at [%s] line (%d)", arg_6_2.file or "", arg_6_2.line))

		return arg_6_1
	end)
	local var_0_8 = lpeg.Cmt((lpeg.P("\n") + "\r\n") * lpeg.Carg(1), function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_1 > arg_5_2.pos then
			arg_5_2.line = arg_5_2.line + 1
			arg_5_2.pos = arg_5_1
		end

		return arg_5_1
	end)

	var_0_9 = lpeg.S(" \t") + var_0_8 + "#" * (1 - var_0_8)^0 * (var_0_8 + lpeg.P(-1))

	local var_0_10 = var_0_9^0
	local var_0_11 = var_0_9^1
	local var_0_12 = lpeg.R("az") + lpeg.R("AZ") + "_"

	var_0_13 = lpeg.C(var_0_12 * (var_0_12 + lpeg.R("09"))^0)

	local var_0_14 = lpeg.C(var_0_12 * (var_0_12 + lpeg.R("09"))^0 * var_0_9000)

	var_0_15 = lpeg.R("09")^1 / tonumber

	function var_0_16(arg_7_0)
		return var_0_4(var_0_10 * (arg_7_0 * var_0_11)^0 * arg_7_0^0 * var_0_10)
	end

	function var_0_17(arg_8_0, arg_8_1)
		return var_0_4(var_0_5(var_0_6(arg_8_0), "type") * var_0_5(arg_8_1))
	end

	var_0_18 = {
		"ALL",
		FIELD = var_0_17("field", var_0_13 * var_0_9^1 * var_0_15 * var_0_9^0 * ":" * var_0_9^0 * lpeg.C("*")^-1 * var_0_14 * ("(" * var_0_9^0 * var_0_13 * var_0_9^0 * ")" + "(" * var_0_9^0 * lpeg.C(("." * (var_0_12 * (var_0_12 + lpeg.R("09"))^0))^0) * var_0_9^0 * ")")^0),
		STRUCT = lpeg.P("{") * var_0_16(lpeg.V("FIELD") + lpeg.V("TYPE")) * lpeg.P("}"),
		TYPE = var_0_17("type", lpeg.P(".") * var_0_13 * var_0_9^0 * lpeg.V("STRUCT")),
		SUBPROTO = lpeg.Ct((lpeg.C("request") + lpeg.C("response")) * var_0_9^1 * (var_0_14 + lpeg.V("STRUCT")))
	}
end

var_0_18.PROTOCOL = var_0_17("protocol", var_0_13 * var_0_9^1 * var_0_15 * var_0_9^0 * lpeg.P("{") * var_0_16(lpeg.V("SUBPROTO")) * lpeg.P("}"))
var_0_18.ALL = var_0_16(lpeg.V("TYPE") + lpeg.V("PROTOCOL"))

local var_0_19 = var_0_9^0 * lpeg.P(var_0_18) * var_0_9^0
local var_0_20 = {}

function var_0_20:protocol(arg_9_1)
	local var_9_0 = {
		tag = arg_9_1[2]
	}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1[3]) do
		assert(var_9_0[iter_9_1[1]] == nil)

		local var_9_1 = iter_9_1[2]

		if type(iter_9_1[2]) == "table" then
			var_9_1 = arg_9_1[1] .. "." .. iter_9_1[1]
			self.type[arg_9_1[1] .. "." .. iter_9_1[1]] = var_0_20.type(self, {
				arg_9_1[1] .. "." .. iter_9_1[1],
				var_9_1
			})
		end

		if var_9_1 == "nil" then
			if iter_9_1[1] == "response" then
				var_9_0.confirm = true
			end
		else
			var_9_0[iter_9_1[1]] = var_9_1
		end
	end

	return var_9_0
end

function var_0_20:type(arg_10_1)
	local var_10_0 = {}
	local var_10_1 = arg_10_1[1]
	local var_10_2 = {}
	local var_10_3 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1[2]) do
		if iter_10_1.type == "field" then
			if var_10_3[iter_10_1[1]] then
				error(string.format("redefine %s in type %s", iter_10_1[1], var_10_1))
			end

			var_10_3[iter_10_1[1]] = true

			if var_10_2[iter_10_1[2]] then
				error(string.format("redefine tag %d in type %s", iter_10_1[2], var_10_1))
			end

			var_10_2[iter_10_1[2]] = true

			local var_10_4 = {
				name = iter_10_1[1],
				tag = iter_10_1[2]
			}

			table.insert(var_10_0, var_10_4)

			local var_10_5 = iter_10_1[3]

			if iter_10_1[3] == "*" then
				var_10_4.array = true
				var_10_5 = iter_10_1[4]
			end

			local var_10_6 = iter_10_1[5]

			if iter_10_1[5] then
				if var_10_5 == "integer" then
					var_10_4.decimal = var_10_6
				else
					assert(var_10_4.array)

					var_10_4.key = var_10_6
				end
			end

			var_10_4.typename = var_10_5
		else
			assert(iter_10_1.type == "type")

			local var_10_7 = var_10_1 .. "." .. iter_10_1[1]

			iter_10_1[1] = var_10_1 .. "." .. iter_10_1[1]

			assert(self.type[var_10_7] == nil, "redefined " .. var_10_7)

			self.type[var_10_7] = var_0_20.type(self, iter_10_1)
		end
	end

	table.sort(var_10_0, function(arg_11_0, arg_11_1)
		return arg_11_0.tag < arg_11_1.tag
	end)

	return var_10_0
end

local function var_0_21(arg_12_0)
	local var_12_0 = {
		type = {},
		protocol = {}
	}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0) do
		local var_12_1 = var_12_0[iter_12_1.type]
		local var_12_2 = iter_12_1[1]

		assert(var_12_0[iter_12_1.type][iter_12_1[1]] == nil, "redefined " .. iter_12_1[1])

		var_12_1[var_12_2] = var_0_20[iter_12_1.type](var_12_0, iter_12_1)
	end

	return var_12_0
end

local var_0_22 = {
	boolean = 1,
	binary = 2,
	string = 2,
	integer = 0
}

local function var_0_23(arg_13_0, arg_13_1, arg_13_2)
	if var_0_22[arg_13_2] then
		return arg_13_2
	end

	if arg_13_0[arg_13_1 .. "." .. arg_13_2] then
		return arg_13_1 .. "." .. arg_13_2
	else
		arg_13_1 = arg_13_1:match("(.+)%..+$")

		if arg_13_1 then
			return var_0_23(arg_13_0, arg_13_1, arg_13_2)
		elseif arg_13_0[arg_13_2] then
			return arg_13_2
		end
	end
end

local function var_0_24(arg_14_0)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(arg_14_0.protocol) do
		if var_14_0[iter_14_1.tag] then
			error(string.format("redefined protocol tag %d at %s", iter_14_1.tag, iter_14_0))
		end

		if iter_14_1.request and not arg_14_0.type[iter_14_1.request] then
			error(string.format("Undefined request type %s in protocol %s", iter_14_1.request, iter_14_0))
		end

		if iter_14_1.response and not arg_14_0.type[iter_14_1.response] then
			error(string.format("Undefined response type %s in protocol %s", iter_14_1.response, iter_14_0))
		end

		var_14_0[iter_14_1.tag] = iter_14_1
	end

	return arg_14_0
end

local function var_0_25(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.type) do
		for iter_15_2, iter_15_3 in pairs(iter_15_1) do
			local var_15_0 = var_0_23(arg_15_0.type, iter_15_0, iter_15_3.typename)

			if var_15_0 == nil then
				error(string.format("Undefined type %s in type %s", iter_15_3.typename, iter_15_0))
			end

			iter_15_3.typename = var_15_0
		end
	end

	return arg_15_0
end

local function var_0_26(arg_16_0, arg_16_1)
	return var_0_25(var_0_24(var_0_21((lpeg.match(var_0_19 * -1 + var_0_7, arg_16_0, 1, {
		line = 1,
		pos = 0,
		file = arg_16_1
	})))))
end

local function var_0_27(arg_17_0)
	local var_17_0 = {}

	if arg_17_0.array then
		if arg_17_0.key then
			table.insert(var_17_0, "\x06\x00")
		else
			table.insert(var_17_0, "\x05\x00")
		end
	else
		table.insert(var_17_0, "\x04\x00")
	end

	table.insert(var_17_0, "\x00\x00")

	if arg_17_0.buildin then
		table.insert(var_17_0, var_0_3(arg_17_0.buildin))

		if arg_17_0.extra then
			table.insert(var_17_0, var_0_3(arg_17_0.extra))
		else
			table.insert(var_17_0, "\x01\x00")
		end

		table.insert(var_17_0, var_0_3(arg_17_0.tag))
	else
		table.insert(var_17_0, "\x01\x00")
		table.insert(var_17_0, var_0_3(arg_17_0.type))
		table.insert(var_17_0, var_0_3(arg_17_0.tag))
	end

	if arg_17_0.array then
		table.insert(var_17_0, var_0_3(1))
	end

	if arg_17_0.key then
		table.insert(var_17_0, var_0_3(arg_17_0.key))
	end

	table.insert(var_17_0, var_0_2(arg_17_0.name))

	return var_0_2(table.concat(var_17_0))
end

local function var_0_28(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = {}
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		var_18_1.array = iter_18_1.array
		var_18_1.name = iter_18_1.name
		var_18_1.tag = iter_18_1.tag
		var_18_1.extra = iter_18_1.decimal
		var_18_1.buildin = var_0_22[iter_18_1.typename]

		if iter_18_1.typename == "binary" then
			var_18_1.extra = 1
		end

		local var_18_2

		if not var_18_1.buildin then
			var_18_2 = assert(arg_18_2[iter_18_1.typename])
			var_18_1.type = var_18_2.id
		else
			var_18_1.type = nil
		end

		if iter_18_1.key then
			var_18_1.key = var_18_2.fields[iter_18_1.key]

			if not var_18_1.key then
				error("Invalid map index :" .. iter_18_1.key)
			end
		else
			var_18_1.key = nil
		end

		table.insert(var_18_0, var_0_27(var_18_1))
	end

	return var_0_2(table.concat(#var_18_0 == 0 and {
		"\x01\x00",
		"\x00\x00",
		var_0_2(arg_18_0)
	} or {
		"\x02\x00",
		"\x00\x00",
		"\x00\x00",
		var_0_2(arg_18_0),
		var_0_2(table.concat(var_18_0))
	}))
end

local function var_0_29(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1.request then
		if arg_19_2[arg_19_1.request] == nil then
			error(string.format("Protocol %s request type %s not found", arg_19_0, arg_19_1.request))
		end
	end

	local var_19_1 = {
		"\x04\x00",
		"\x00\x00",
		var_0_3(arg_19_1.tag)
	}

	if arg_19_1.request == nil and arg_19_1.response == nil and arg_19_1.confirm == nil then
		var_19_1[1] = "\x02\x00"
	else
		if arg_19_1.request then
			table.insert(var_19_1, var_0_3(arg_19_2[arg_19_1.request].id))
		else
			table.insert(var_19_1, "\x01\x00")
		end

		if arg_19_1.response then
			table.insert(var_19_1, var_0_3(arg_19_2[arg_19_1.response].id))
		elseif arg_19_1.confirm then
			var_19_1[1] = "\x05\x00"

			table.insert(var_19_1, "\x01\x00")
			table.insert(var_19_1, var_0_3(1))
		else
			var_19_1[1] = "\x03\x00"
		end
	end

	table.insert(var_19_1, var_0_2(arg_19_0))

	return var_0_2(table.concat(var_19_1))
end

local function var_0_30(arg_20_0, arg_20_1)
	if next(arg_20_0) == nil then
		assert(next(arg_20_1) == nil)

		return "\x00\x00"
	end

	local var_20_1
	local var_20_2 = {}

	for iter_20_0 in pairs(arg_20_0) do
		table.insert(var_20_2, iter_20_0)
	end

	table.sort(var_20_2)

	for iter_20_1, iter_20_2 in ipairs(var_20_2) do
		local var_20_3 = {}

		for iter_20_3, iter_20_4 in ipairs(arg_20_0[iter_20_2]) do
			if var_0_22[iter_20_4.typename] then
				var_20_3[iter_20_4.name] = iter_20_4.tag
			end
		end

		var_20_2[iter_20_2] = {
			id = iter_20_1 - 1,
			fields = var_20_3
		}
	end

	local var_20_4 = {}

	for iter_20_5, iter_20_6 in ipairs(var_20_2) do
		table.insert(var_20_4, var_0_28(iter_20_6, arg_20_0[iter_20_6], var_20_2))
	end

	local var_20_5 = var_0_2(table.concat(var_20_4))

	if next(arg_20_1) then
		local var_20_6 = {}

		for iter_20_7, iter_20_8 in pairs(arg_20_1) do
			table.insert(var_20_6, iter_20_8)

			iter_20_8.name = iter_20_7
		end

		table.sort(var_20_6, function(arg_21_0, arg_21_1)
			return arg_21_0.tag < arg_21_1.tag
		end)

		var_20_1 = {}

		for iter_20_9, iter_20_10 in ipairs(var_20_6) do
			table.insert(var_20_1, var_0_29(iter_20_10.name, iter_20_10, var_20_2))
		end

		var_20_1 = var_0_2(table.concat(var_20_1))
	end

	return table.concat(var_20_1 == nil and {
		"\x01\x00",
		"\x00\x00",
		var_20_5
	} or {
		"\x02\x00",
		"\x00\x00",
		"\x00\x00",
		var_20_5,
		var_20_1
	})
end

local function var_0_31(arg_22_0)
	return var_0_30(arg_22_0.type, arg_22_0.protocol)
end

return {
	dump = function(arg_23_0)
		local var_23_0 = ""

		for iter_23_0 = 1, #arg_23_0 do
			var_23_0 = var_23_0 .. string.format("%02X ", string.byte(arg_23_0, iter_23_0))

			if iter_23_0 % 8 == 0 then
				if iter_23_0 % 16 == 0 then
					print(var_23_0)

					var_23_0 = ""
				else
					var_23_0 = var_23_0 .. "- "
				end
			end
		end

		print(var_23_0)
	end,
	parse = function(arg_24_0, arg_24_1)
		return (var_0_31((var_0_26(arg_24_0, arg_24_1 or "=text"))))
	end
}
