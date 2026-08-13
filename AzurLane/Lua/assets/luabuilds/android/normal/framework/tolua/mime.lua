_G = var_0_10000
require = var_0_10001

local var_0_0 = var_0_10001("ltn12")

require = var_2

local var_0_1 = var_2("mime.core")

require = var_3

local var_0_2 = var_3("io")

require = var_4

local var_0_3 = var_4("string")
local var_0_4 = var_0_1
local var_0_5 = {}
local var_0_6 = {}
local var_0_7 = {}

var_0_4.encodet = var_0_5
var_0_4.decodet = var_0_6
var_0_4.wrapt = var_0_7

local function var_0_8(arg_1_0)
	return function(arg_2_0, arg_2_1, arg_2_2)
		if var_0_10000.type(arg_2_0) ~= "string" then
			arg_2_0, arg_2_1, arg_2_2 = "default", arg_2_0, arg_2_1
		end

		if not arg_1_0[arg_2_0 or "nil"] then
			var_0_10000.error("unknown key (" .. var_0_10000.tostring(arg_2_0) .. ")", 3)
		else
			return var_3(arg_2_1, arg_2_2)
		end

		return
	end
end

function var_0_5.base64()
	return var_0_0.filter.cycle(var_0_4.b64, "")
end

var_0_5["quoted-printable"] = function(arg_4_0)
	return var_0_0.filter.cycle(var_0_4.qp, "", arg_4_0 == "binary" and "=0D=0A" or "\r\n")
end

function var_0_6.base64()
	return var_0_0.filter.cycle(var_0_4.unb64, "")
end

var_0_6["quoted-printable"] = function()
	return var_0_0.filter.cycle(var_0_4.unqp, "")
end

local function var_0_9(arg_7_0)
	if arg_7_0 then
		if arg_7_0 == "" then
			return "''"
		else
			return var_0_3.len(arg_7_0)
		end
	else
		return "nil"
	end

	return
end

function var_0_7.text(arg_8_0)
	arg_8_0 = arg_8_0 or 76

	return var_0_0.filter.cycle(var_0_4.wrp, arg_8_0, arg_8_0)
end

var_0_7.base64 = var_0_7.text
var_0_7.default = var_0_7.text
var_0_7["quoted-printable"] = function()
	return var_0_0.filter.cycle(var_0_4.qpwrp, 76, 76)
end
var_0_4.encode = var_0_8(var_0_5)
var_0_4.decode = var_0_8(var_0_6)
var_0_4.wrap = var_0_8(var_0_7)

function var_0_4.normalize(arg_10_0)
	return var_0_0.filter.cycle(var_0_4.eol, 0, arg_10_0)
end

function var_0_4.stuff()
	return var_0_0.filter.cycle(var_0_4.dot, 2)
end

return var_0_4
