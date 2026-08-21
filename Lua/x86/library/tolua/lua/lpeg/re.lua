local var_0_0 = tonumber
local var_0_1 = type
local var_0_2 = print
local var_0_3 = error
local var_0_4 = setmetatable
local var_0_5 = require("lpeg")
local var_0_6 = var_0_5
local var_0_7 = getmetatable(var_0_6.P(0))
local var_0_8 = _VERSION

if var_0_8 == "Lua 5.2" then
	_ENV = nil
end

local var_0_9 = var_0_5.P(1)
local var_0_10 = {
	nl = var_0_5.P("\n")
}
local var_0_11
local var_0_12
local var_0_13

local function var_0_14()
	var_0_6.locale(var_0_10)

	var_0_10.a = var_0_10.alpha
	var_0_10.c = var_0_10.cntrl
	var_0_10.d = var_0_10.digit
	var_0_10.g = var_0_10.graph
	var_0_10.l = var_0_10.lower
	var_0_10.p = var_0_10.punct
	var_0_10.s = var_0_10.space
	var_0_10.u = var_0_10.upper
	var_0_10.w = var_0_10.alnum
	var_0_10.x = var_0_10.xdigit
	var_0_10.A = var_0_9 - var_0_10.a
	var_0_10.C = var_0_9 - var_0_10.c
	var_0_10.D = var_0_9 - var_0_10.d
	var_0_10.G = var_0_9 - var_0_10.g
	var_0_10.L = var_0_9 - var_0_10.l
	var_0_10.P = var_0_9 - var_0_10.p
	var_0_10.S = var_0_9 - var_0_10.s
	var_0_10.U = var_0_9 - var_0_10.u
	var_0_10.W = var_0_9 - var_0_10.w
	var_0_10.X = var_0_9 - var_0_10.x
	var_0_11 = {}
	var_0_12 = {}
	var_0_13 = {}

	local var_1_0 = {
		__mode = "v"
	}

	var_0_4(var_0_11, var_1_0)
	var_0_4(var_0_12, var_1_0)
	var_0_4(var_0_13, var_1_0)
end

var_0_14()

local var_0_15 = var_0_5.P(function(arg_2_0, arg_2_1)
	var_0_2(arg_2_1, arg_2_0:sub(1, arg_2_1 - 1))

	return arg_2_1
end)

local function var_0_16(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1 and arg_3_1[arg_3_0]

	if not var_3_0 then
		var_0_3("undefined name: " .. arg_3_0)
	end

	return var_3_0
end

local function var_0_17(arg_4_0, arg_4_1)
	local var_4_0 = #arg_4_0 < arg_4_1 + 20 and arg_4_0:sub(arg_4_1) or arg_4_0:sub(arg_4_1, arg_4_1 + 20) .. "..."
	local var_4_1 = ("pattern error near '%s'"):format(var_4_0)

	var_0_3(var_4_1, 2)
end

local function var_0_18(arg_5_0, arg_5_1)
	local var_5_0 = var_0_6.P(true)

	while arg_5_1 >= 1 do
		if arg_5_1 % 2 >= 1 then
			var_5_0 = var_5_0 * arg_5_0
		end

		arg_5_0 = arg_5_0 * arg_5_0
		arg_5_1 = arg_5_1 / 2
	end

	return var_5_0
end

local function var_0_19(arg_6_0, arg_6_1, arg_6_2)
	if var_0_1(arg_6_2) ~= "string" then
		return nil
	end

	local var_6_0 = #arg_6_2 + arg_6_1

	if arg_6_0:sub(arg_6_1, var_6_0 - 1) == arg_6_2 then
		return var_6_0
	else
		return nil
	end
end

local var_0_20 = (var_0_10.space + "--" * (var_0_9 - var_0_10.nl)^0)^0
local var_0_21 = var_0_5.R("AZ", "az", "__") * var_0_5.R("AZ", "az", "__", "09")^0
local var_0_22 = var_0_20 * "<-"
local var_0_23 = var_0_5.P("/") + ")" + "}" + ":}" + "~}" + "|}" + var_0_21 * var_0_22 + -1
local var_0_24 = var_0_5.C(var_0_21)
local var_0_25 = var_0_24 * var_0_5.Carg(1)
local var_0_26 = var_0_5.C(var_0_5.R("09")^1) * var_0_20 / var_0_0
local var_0_27 = "'" * var_0_5.C((var_0_9 - "'")^0) * "'" + "\"" * var_0_5.C((var_0_9 - "\"")^0) * "\""
local var_0_28 = "%" * var_0_25 / function(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1 and arg_7_1[arg_7_0] or var_0_10[arg_7_0]

	if not var_7_0 then
		var_0_3("name '" .. arg_7_0 .. "' undefined")
	end

	return var_7_0
end
local var_0_29 = var_0_28 + var_0_5.Cs(var_0_9 * (var_0_5.P("-") / "") * (var_0_9 - "]")) / var_0_6.R + var_0_5.C(var_0_9)
local var_0_30 = "[" * var_0_5.C(var_0_5.P("^")^-1) * var_0_5.Cf(var_0_29 * (var_0_29 - "]")^0, var_0_7.__add) / function(arg_8_0, arg_8_1)
	return arg_8_0 == "^" and var_0_9 - arg_8_1 or arg_8_1
end * "]"

local function var_0_31(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0[arg_9_1] then
		var_0_3("'" .. arg_9_1 .. "' already defined as a rule")
	else
		arg_9_0[arg_9_1] = arg_9_2
	end

	return arg_9_0
end

local function var_0_32(arg_10_0, arg_10_1)
	return var_0_31({
		arg_10_0
	}, arg_10_0, arg_10_1)
end

local function var_0_33(arg_11_0, arg_11_1)
	if not arg_11_1 then
		var_0_3("rule '" .. arg_11_0 .. "' used outside a grammar")
	else
		return var_0_6.V(arg_11_0)
	end
end

local var_0_34 = var_0_5.P({
	"Exp",
	Exp = var_0_20 * (var_0_5.V("Grammar") + var_0_5.Cf(var_0_5.V("Seq") * ("/" * var_0_20 * var_0_5.V("Seq"))^0, var_0_7.__add)),
	Seq = var_0_5.Cf(var_0_5.Cc(var_0_5.P("")) * var_0_5.V("Prefix")^0, var_0_7.__mul) * (#var_0_23 + var_0_17),
	Prefix = "&" * var_0_20 * var_0_5.V("Prefix") / var_0_7.__len + "!" * var_0_20 * var_0_5.V("Prefix") / var_0_7.__unm + var_0_5.V("Suffix"),
	Suffix = var_0_5.Cf(var_0_5.V("Primary") * var_0_20 * ((var_0_5.P("+") * var_0_5.Cc(1, var_0_7.__pow) + var_0_5.P("*") * var_0_5.Cc(0, var_0_7.__pow) + var_0_5.P("?") * var_0_5.Cc(-1, var_0_7.__pow) + "^" * (var_0_5.Cg(var_0_26 * var_0_5.Cc(var_0_18)) + var_0_5.Cg(var_0_5.C(var_0_5.S("+-") * var_0_5.R("09")^1) * var_0_5.Cc(var_0_7.__pow))) + "->" * var_0_20 * (var_0_5.Cg((var_0_27 + var_0_26) * var_0_5.Cc(var_0_7.__div)) + var_0_5.P("{}") * var_0_5.Cc(nil, var_0_5.Ct) + var_0_5.Cg(var_0_25 / var_0_16 * var_0_5.Cc(var_0_7.__div))) + "=>" * var_0_20 * var_0_5.Cg(var_0_25 / var_0_16 * var_0_5.Cc(var_0_5.Cmt))) * var_0_20)^0, function(arg_12_0, arg_12_1, arg_12_2)
		return arg_12_2(arg_12_0, arg_12_1)
	end),
	Primary = "(" * var_0_5.V("Exp") * ")" + var_0_27 / var_0_6.P + var_0_30 + var_0_28 + "{:" * (var_0_24 * ":" + var_0_5.Cc(nil)) * var_0_5.V("Exp") * ":}" / function(arg_13_0, arg_13_1)
		return var_0_6.Cg(arg_13_1, arg_13_0)
	end + "=" * var_0_24 / function(arg_14_0)
		return var_0_6.Cmt(var_0_6.Cb(arg_14_0), var_0_19)
	end + var_0_5.P("{}") / var_0_6.Cp + "{~" * var_0_5.V("Exp") * "~}" / var_0_6.Cs + "{|" * var_0_5.V("Exp") * "|}" / var_0_6.Ct + "{" * var_0_5.V("Exp") * "}" / var_0_6.C + var_0_5.P(".") * var_0_5.Cc(var_0_9) + (var_0_24 * -var_0_22 + "<" * var_0_24 * ">") * var_0_5.Cb("G") / var_0_33,
	Definition = var_0_24 * var_0_22 * var_0_5.V("Exp"),
	Grammar = var_0_5.Cg(var_0_5.Cc(true), "G") * var_0_5.Cf(var_0_5.V("Definition") / var_0_32 * var_0_5.Cg(var_0_5.V("Definition"))^0, var_0_31) / var_0_6.P
})
local var_0_35 = var_0_20 * var_0_5.Cg(var_0_5.Cc(false), "G") * var_0_34 / var_0_6.P * (-var_0_9 + var_0_17)

local function var_0_36(arg_15_0, arg_15_1)
	if var_0_6.type(arg_15_0) == "pattern" then
		return arg_15_0
	end

	local var_15_0 = var_0_35:match(arg_15_0, 1, arg_15_1)

	if not var_15_0 then
		var_0_3("incorrect pattern", 3)
	end

	return var_15_0
end

local function var_0_37(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = var_0_11[arg_16_1]

	if not var_16_0 then
		var_16_0 = var_0_36(arg_16_1)
		var_0_11[arg_16_1] = var_16_0
	end

	return var_16_0:match(arg_16_0, arg_16_2 or 1)
end

local function var_0_38(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = var_0_12[arg_17_1]

	if not var_17_0 then
		var_17_0 = var_0_36(arg_17_1) / 0
		var_17_0 = var_0_6.P({
			var_0_6.Cp() * var_17_0 * var_0_6.Cp() + 1 * var_0_6.V(1)
		})
		var_0_12[arg_17_1] = var_17_0
	end

	local var_17_1, var_17_2 = var_17_0:match(arg_17_0, arg_17_2 or 1)

	if var_17_1 then
		return var_17_1, var_17_2 - 1
	else
		return var_17_1
	end
end

local function var_0_39(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = var_0_13[arg_18_1] or {}

	var_0_13[arg_18_1] = var_18_0

	local var_18_1 = var_18_0[arg_18_2]

	if not var_18_1 then
		var_18_1 = var_0_36(arg_18_1)
		var_18_1 = var_0_6.Cs((var_18_1 / arg_18_2 + 1)^0)
		var_18_0[arg_18_2] = var_18_1
	end

	return var_18_1:match(arg_18_0)
end

local var_0_40 = {
	compile = var_0_36,
	match = var_0_37,
	find = var_0_38,
	gsub = var_0_39,
	updatelocale = var_0_14
}

if var_0_8 == "Lua 5.1" then
	-- block empty
end

return var_0_40
