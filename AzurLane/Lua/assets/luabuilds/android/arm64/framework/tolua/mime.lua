local var_0_0 = _G
local var_0_1 = require("ltn12")
local var_0_2 = require("io")
local var_0_3 = require("string")
local var_0_4 = require("mime.core")

var_0_4.encodet = {}
var_0_4.decodet = {}
var_0_4.wrapt = {}
;({}).base64 = function()
	return var_0_1.filter.cycle(var_0_4.b64, "")
end
;({})["quoted-printable"] = function(arg_4_0)
	return var_0_1.filter.cycle(var_0_4.qp, "", arg_4_0 == "binary" and "=0D=0A" or "\r\n")
end
;({}).base64 = function()
	return var_0_1.filter.cycle(var_0_4.unb64, "")
end
;({})["quoted-printable"] = function()
	return var_0_1.filter.cycle(var_0_4.unqp, "")
end
;({}).text = function(arg_8_0)
	arg_8_0 = arg_8_0 or 76

	return var_0_1.filter.cycle(var_0_4.wrp, arg_8_0, arg_8_0)
end
;({}).base64 = ({}).text
;({}).default = ({}).text
;({})["quoted-printable"] = function()
	return var_0_1.filter.cycle(var_0_4.qpwrp, 76, 76)
end
var_0_4.encode = (function(arg_1_0)
	return function(arg_2_0, arg_2_1, arg_2_2)
		if var_0_0.type(arg_2_0) ~= "string" then
			arg_2_2 = arg_2_1
			arg_2_1 = arg_2_0
			arg_2_0 = "default"
		end

		if not arg_1_0[arg_2_0 or "nil"] then
			var_0_0.error("unknown key (" .. var_0_0.tostring(arg_2_0) .. ")", 3)
		else
			return var_2_0(arg_2_1, arg_2_2)
		end

		return
	end
end)({})
var_0_4.decode = (function(arg_1_0)
	return function(arg_2_0, arg_2_1, arg_2_2)
		if var_0_0.type(arg_2_0) ~= "string" then
			arg_2_2 = arg_2_1
			arg_2_1 = arg_2_0
			arg_2_0 = "default"
		end

		if not arg_1_0[arg_2_0 or "nil"] then
			var_0_0.error("unknown key (" .. var_0_0.tostring(arg_2_0) .. ")", 3)
		else
			return var_2_0(arg_2_1, arg_2_2)
		end

		return
	end
end)({})
var_0_4.wrap = (function(arg_1_0)
	return function(arg_2_0, arg_2_1, arg_2_2)
		if var_0_0.type(arg_2_0) ~= "string" then
			arg_2_2 = arg_2_1
			arg_2_1 = arg_2_0
			arg_2_0 = "default"
		end

		if not arg_1_0[arg_2_0 or "nil"] then
			var_0_0.error("unknown key (" .. var_0_0.tostring(arg_2_0) .. ")", 3)
		else
			return var_2_0(arg_2_1, arg_2_2)
		end

		return
	end
end)({})

function var_0_4.normalize(arg_10_0)
	return var_0_1.filter.cycle(var_0_4.eol, 0, arg_10_0)
end

function var_0_4.stuff()
	return var_0_1.filter.cycle(var_0_4.dot, 2)
end

return var_0_4
