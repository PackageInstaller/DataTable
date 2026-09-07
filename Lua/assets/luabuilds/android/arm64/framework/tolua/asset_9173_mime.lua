local var_0_0 = _G
local ltn12 = require("ltn12")
local io = require("io")
local string = require("string")
local core = require("mime.core")
local var_0_5 = {}
local var_0_6 = {}
local var_0_7 = {}

core.encodet = var_0_5
core.decodet = var_0_6
core.wrapt = var_0_7

local function var_0_8(arg_1_0)
	return function(arg_2_0, arg_2_1, arg_2_2)
		if var_0_0.type(arg_2_0) ~= "string" then
			arg_2_2 = arg_2_1
			arg_2_1 = arg_2_0
			arg_2_0 = "default"
		end

		local var_2_0 = arg_1_0[arg_2_0 or "nil"]

		if not arg_1_0[arg_2_0 or "nil"] then
			var_0_0.error("unknown key (" .. var_0_0.tostring(arg_2_0) .. ")", 3)
		else
			return var_2_0(arg_2_1, arg_2_2)
		end

		return
	end
end

function var_0_5.base64()
	return ltn12.filter.cycle(core.b64, "")
end

var_0_5["quoted-printable"] = function(arg_4_0)
	return ltn12.filter.cycle(core.qp, "", arg_4_0 == "binary" and "=0D=0A" or "\r\n")
end

function var_0_6.base64()
	return ltn12.filter.cycle(core.unb64, "")
end

var_0_6["quoted-printable"] = function()
	return ltn12.filter.cycle(core.unqp, "")
end

function var_0_7.text(arg_8_0)
	arg_8_0 = arg_8_0 or 76

	return ltn12.filter.cycle(core.wrp, arg_8_0, arg_8_0)
end

var_0_7.base64 = var_0_7.text
var_0_7.default = var_0_7.text
var_0_7["quoted-printable"] = function()
	return ltn12.filter.cycle(core.qpwrp, 76, 76)
end
core.encode = var_0_8(var_0_5)
core.decode = var_0_8(var_0_6)
core.wrap = var_0_8(var_0_7)

function core.normalize(arg_10_0)
	return ltn12.filter.cycle(core.eol, 0, arg_10_0)
end

function core.stuff()
	return ltn12.filter.cycle(core.dot, 2)
end

return core
