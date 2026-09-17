local core = require("sproto.core")
local var_0_1 = assert
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {
	__mode = "kv"
}
local var_0_5 = {
	__index = var_0_2
}
local var_0_6 = {
	__index = var_0_2
}
local var_0_7 = {
	__index = var_0_3
}

function var_0_5:__gc()
	core.deleteproto(self.__cobj)
end

function var_0_2.new(arg_2_0)
	return setmetatable({
		__cobj = var_0_1(core.newproto(arg_2_0)),
		__tcache = setmetatable({}, var_0_4),
		__pcache = setmetatable({}, var_0_4)
	}, var_0_5)
end

function var_0_2.sharenew(arg_3_0)
	return setmetatable({
		__cobj = arg_3_0,
		__tcache = setmetatable({}, var_0_4),
		__pcache = setmetatable({}, var_0_4)
	}, var_0_6)
end

function var_0_2.parse(arg_4_0)
	return var_0_2.new((require("network.sproto.sprotoparser").parse(arg_4_0)))
end

function var_0_2:host(arg_5_1)
	arg_5_1 = arg_5_1 or "package"

	return setmetatable({
		__proto = self,
		__package = var_0_1(core.querytype(self.__cobj, arg_5_1), "type package not found"),
		__session = {}
	}, var_0_7)
end

local function var_0_8(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.__tcache[arg_6_1]

	if not arg_6_0.__tcache[arg_6_1] then
		var_6_0 = var_0_1(core.querytype(arg_6_0.__cobj, arg_6_1), "type not found")
		arg_6_0.__tcache[arg_6_1] = var_6_0
	end

	return var_6_0
end

function var_0_2:exist_type(arg_7_1)
	if not self.__tcache[arg_7_1] then
		return core.querytype(self.__cobj, arg_7_1) ~= nil
	else
		return true
	end
end

function var_0_2.encode(arg_8_0, arg_8_1, arg_8_2)
	return core.encode(var_0_8(arg_8_0, arg_8_1), arg_8_2)
end

function var_0_2.decode(arg_9_0, arg_9_1, ...)
	return core.decode(var_0_8(arg_9_0, arg_9_1), ...)
end

function var_0_2.pencode(arg_10_0, arg_10_1, arg_10_2)
	return core.pack(core.encode(var_0_8(arg_10_0, arg_10_1), arg_10_2))
end

function var_0_2.pdecode(arg_11_0, arg_11_1, ...)
	return core.decode(var_0_8(arg_11_0, arg_11_1), core.unpack(...))
end

local function var_0_9(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.__pcache[arg_12_1]

	if not arg_12_0.__pcache[arg_12_1] then
		local var_12_1, var_12_2, var_12_3 = core.protocol(arg_12_0.__cobj, arg_12_1)

		var_0_1(var_12_1, arg_12_1 .. " not found")

		if tonumber(arg_12_1) then
			var_12_1 = arg_12_1
			arg_12_1 = var_12_1
		end

		var_12_0 = {
			request = var_12_2,
			response = var_12_3,
			name = arg_12_1,
			tag = var_12_1
		}
		arg_12_0.__pcache[arg_12_1] = var_12_0
		arg_12_0.__pcache[var_12_1] = var_12_0
	end

	return var_12_0
end

function var_0_2:exist_proto(arg_13_1)
	if not self.__pcache[arg_13_1] then
		return core.protocol(self.__cobj, arg_13_1) ~= nil
	else
		return true
	end
end

function var_0_2.request_encode(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = var_0_9(arg_14_0, arg_14_1)

	if var_14_0.request then
		return core.encode(var_14_0.request, arg_14_2), var_14_0.tag
	else
		return "", var_14_0.tag
	end
end

function var_0_2.response_encode(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = var_0_9(arg_15_0, arg_15_1).response

	if var_15_0 then
		return core.encode(var_15_0, arg_15_2)
	else
		return ""
	end
end

function var_0_2.request_decode(arg_16_0, arg_16_1, ...)
	local var_16_0 = var_0_9(arg_16_0, arg_16_1)

	if var_16_0.request then
		return core.decode(var_16_0.request, ...), var_16_0.name
	else
		return nil, var_16_0.name
	end
end

function var_0_2.response_decode(arg_17_0, arg_17_1, ...)
	local var_17_0 = var_0_9(arg_17_0, arg_17_1).response

	if var_17_0 then
		return core.decode(var_17_0, ...)
	end
end

var_0_2.pack = core.pack
var_0_2.unpack = core.unpack

function var_0_2.default(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_2 == nil then
		return core.default(var_0_8(arg_18_0, arg_18_1))
	else
		local var_18_0 = var_0_9(arg_18_0, arg_18_1)

		if arg_18_2 == "REQUEST" then
			if var_18_0.request then
				return core.default(var_18_0.request)
			end
		elseif arg_18_2 == "RESPONSE" then
			if var_18_0.response then
				return core.default(var_18_0.response)
			end
		else
			error("Invalid type")
		end
	end
end

local var_0_10 = {}

local function var_0_11(arg_19_0, arg_19_1, arg_19_2)
	return function(arg_20_0, arg_20_1)
		var_0_10.type = nil
		var_0_10.session = arg_19_2
		var_0_10.ud = arg_20_1

		local var_20_0 = core.encode(arg_19_0.__package, var_0_10)

		if arg_19_1 then
			return core.pack(var_20_0 .. core.encode(arg_19_1, arg_20_0))
		else
			return core.pack(var_20_0)
		end
	end
end

function var_0_3:dispatch(...)
	local var_21_0 = core.unpack(...)

	var_0_10.type = nil
	var_0_10.session = nil
	var_0_10.ud = nil

	local var_21_1, var_21_2 = core.decode(self.__package, var_21_0, var_0_10)
	local var_21_3 = var_21_0:sub(var_21_2 + 1)

	if var_21_1.type then
		local var_21_4 = var_0_9(self.__proto, var_21_1.type)
		local var_21_5

		if var_21_4.request then
			var_21_5 = core.decode(var_21_4.request, var_21_3)
		end

		if var_0_10.session then
			return "REQUEST", var_21_4.name, var_21_5, var_0_11(self, var_21_4.response, var_0_10.session), var_21_1.session, var_21_1.ud
		else
			return "REQUEST", var_21_4.name, var_21_5, nil, nil, var_21_1.ud
		end
	else
		local var_21_6 = var_0_1(var_0_10.session, "session not found")
		local var_21_7 = var_0_1(self.__session[var_21_6], "Unknown session")

		self.__session[var_21_6] = nil

		if var_21_7 == true then
			return "RESPONSE", var_21_6, nil, var_21_1.ud
		else
			return "RESPONSE", var_21_6, core.decode(var_21_7, var_21_3), var_21_1.ud
		end
	end
end

function var_0_3.attach(arg_22_0, arg_22_1)
	return function(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
		local var_23_0 = var_0_9(arg_22_1, arg_23_0)

		var_0_10.type = var_23_0.tag
		var_0_10.session = arg_23_2
		var_0_10.ud = arg_23_3

		local var_23_1 = core.encode(arg_22_0.__package, var_0_10)

		if arg_23_2 then
			arg_22_0.__session[arg_23_2] = var_23_0.response or true
		end

		if var_23_0.request then
			return core.pack(var_23_1 .. core.encode(var_23_0.request, arg_23_1))
		else
			return core.pack(var_23_1)
		end
	end
end

return var_0_2
