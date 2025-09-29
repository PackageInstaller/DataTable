local var_0_0 = _G
local var_0_1 = require("ltn12")
local var_0_2 = require("mime.core")
local var_0_3 = require("io")
local var_0_4 = require("string")
local var_0_5 = var_0_2
local var_0_6 = {}
local var_0_7 = {}
local var_0_8 = {}

var_0_5.encodet = var_0_6
var_0_5.decodet = var_0_7
var_0_5.wrapt = var_0_8

local function var_0_9(arg_1_0)
	return function(arg_2_0, arg_2_1, arg_2_2)
		if var_0_0.type(arg_2_0) ~= "string" then
			arg_2_0, arg_2_1, arg_2_2 = "default", arg_2_0, arg_2_1
		end

		local var_2_0 = arg_1_0[arg_2_0 or "nil"]

		if not var_2_0 then
			var_0_0.error("unknown key (" .. var_0_0.tostring(arg_2_0) .. ")", 3)
		else
			return var_2_0(arg_2_1, arg_2_2)
		end
	end
end

function var_0_6.base64()
	return var_0_1.filter.cycle(var_0_5.b64, "")
end

var_0_6["quoted-printable"] = function(arg_4_0)
	return var_0_1.filter.cycle(var_0_5.qp, "", arg_4_0 == "binary" and "=0D=0A" or "\r\n")
end

function var_0_7.base64()
	return var_0_1.filter.cycle(var_0_5.unb64, "")
end

var_0_7["quoted-printable"] = function()
	return var_0_1.filter.cycle(var_0_5.unqp, "")
end

local function var_0_10(arg_7_0)
	if arg_7_0 then
		if arg_7_0 == "" then
			return "''"
		else
			return var_0_4.len(arg_7_0)
		end
	else
		return "nil"
	end
end

function var_0_8.text(arg_8_0)
	arg_8_0 = arg_8_0 or 76

	return var_0_1.filter.cycle(var_0_5.wrp, arg_8_0, arg_8_0)
end

var_0_8.base64 = var_0_8.text
var_0_8.default = var_0_8.text
var_0_8["quoted-printable"] = function()
	return var_0_1.filter.cycle(var_0_5.qpwrp, 76, 76)
end
var_0_5.encode = var_0_9(var_0_6)
var_0_5.decode = var_0_9(var_0_7)
var_0_5.wrap = var_0_9(var_0_8)

function var_0_5.normalize(arg_10_0)
	return var_0_1.filter.cycle(var_0_5.eol, 0, arg_10_0)
end

function var_0_5.stuff()
	return var_0_1.filter.cycle(var_0_5.dot, 2)
end

return var_0_5
