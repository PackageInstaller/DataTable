tonumber = var_0_10000
type = var_0_10001
print = var_0_10002
error = var_0_10003
setmetatable = var_0_10004
require = var_0_10005

local var_0_0 = var_0_10005("lpeg")

getmetatable = var_7

local var_0_1 = var_7(var_0_0.P(0))

_VERSION = var_0_10008

if var_0_10008 == "Lua 5.2" then
	local var_0_2
	local var_0_3 = _ENV
end

local var_0_4 = var_5.P(1)
local var_0_5 = {
	nl = var_5.P("\n")
}
local var_0_6
local var_0_7
local var_0_8

;(function()
	var_0_0.locale(var_0_5)

	var_0_5.a = var_0_5.alpha
	var_0_5.c = var_0_5.cntrl
	var_0_5.d = var_0_5.digit
	var_0_5.g = var_0_5.graph
	var_0_5.l = var_0_5.lower
	var_0_5.p = var_0_5.punct
	var_0_5.s = var_0_5.space
	var_0_5.u = var_0_5.upper
	var_0_5.w = var_0_5.alnum
	var_0_5.x = var_0_5.xdigit
	var_0_5.A = var_0_4 - var_0_5.a
	var_0_5.C = var_0_4 - var_0_5.c
	var_0_5.D = var_0_4 - var_0_5.d
	var_0_5.G = var_0_4 - var_0_5.g
	var_0_5.L = var_0_4 - var_0_5.l
	var_0_5.P = var_0_4 - var_0_5.p
	var_0_5.S = var_0_4 - var_0_5.s
	var_0_5.U = var_0_4 - var_0_5.u
	var_0_5.W = var_0_4 - var_0_5.w
	var_0_5.X = var_0_4 - var_0_5.x
	var_0_6 = {}
	var_0_7 = {}
	var_0_8 = {}

	local var_1_0 = {
		__mode = "v"
	}

	var_0_10004(var_0_6, var_1_0)
	var_0_10004(var_0_7, var_1_0)
	var_0_10004(var_0_8, var_1_0)

	return
end)()

local var_0_9 = var_5.P(function(arg_2_0, arg_2_1)
	var_0_10002(arg_2_1, arg_2_0:sub(1, arg_2_1 - 1))

	return arg_2_1
end)

local function var_0_10(arg_3_0, arg_3_1)
	if not (arg_3_1 and arg_3_1[arg_3_0]) then
		var_0_10003("undefined name: " .. arg_3_0)
	end

	return var_2
end

local function var_0_11(arg_4_0, arg_4_1)
	local var_4_0

	if not (#arg_4_0 < arg_4_1 + 20) or not arg_4_0:sub(arg_4_1) then
		var_4_0 = arg_4_0:sub(arg_4_1, arg_4_1 + 20) .. "..."
	end

	local var_4_1 = "pattern error near '%s'"
	local var_4_2 = var_3.format(var_4_1, var_4_0)

	var_0_10003(var_4_2, 2)

	return
end

local function var_0_12(arg_5_0, arg_5_1)
	local var_5_0 = var_0_0.P(true)

	while arg_5_1 >= 1 do
		if arg_5_1 % 2 >= 1 then
			var_5_0 = var_5_0 * arg_5_0
		end

		arg_5_0 = arg_5_0 * arg_5_0
		arg_5_1 = arg_5_1 / 2
	end

	return var_5_0
end

local function var_0_13(arg_6_0, arg_6_1, arg_6_2)
	if var_0_10001(arg_6_2) ~= "string" then
		return nil
	end

	local var_6_0 = #arg_6_2 + arg_6_1

	if arg_6_0:sub(arg_6_1, var_6_0 - 1) == arg_6_2 then
		return var_6_0
	else
		return nil
	end

	return
end

local var_0_14 = (var_0_5.space + "--" * (var_0_4 - var_0_5.nl)^0)^0
local var_0_15 = var_5.R("AZ", "az", "__") * var_5.R("AZ", "az", "__", "09")^0
local var_0_16 = var_0_14 * "<-"
local var_0_17 = var_5.P("/") + ")" + "}" + ":}" + "~}" + "|}" + var_0_15 * var_0_16 + -1
local var_0_18 = var_5.C(var_0_15) * var_5.Carg(1)
local var_0_19 = var_5.C(var_5.R("09")^1) * var_0_14 / var_0_10000
local var_0_20 = "'" * var_5.C((var_0_4 - "'")^0) * "'" + "\"" * var_5.C((var_0_4 - "\"")^0) * "\""
local var_0_21 = "%" * var_0_18 / function(arg_7_0, arg_7_1)
	local var_7_0

	if not arg_7_1 or not arg_7_1[arg_7_0] then
		var_7_0 = var_0_5[arg_7_0]
	end

	if not var_7_0 then
		var_0_10003("name '" .. arg_7_0 .. "' undefined")
	end

	return var_7_0
end + var_5.Cs(var_0_4 * (var_5.P("-") / "") * (var_0_4 - "]")) / var_0_0.R + var_5.C(var_0_4)
local var_0_22 = "[" * var_5.C(var_5.P("^")^-1) * var_5.Cf(var_0_21 * (var_0_21 - "]")^0, var_0_1.__add) / function(arg_8_0, arg_8_1)
	local var_8_0

	if arg_8_0 ~= "^" or not (var_0_4 - arg_8_1) then
		var_8_0 = arg_8_1
	end

	return var_8_0
end * "]"

local function var_0_23(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0[arg_9_1] then
		var_0_10003("'" .. arg_9_1 .. "' already defined as a rule")
	else
		arg_9_0[arg_9_1] = arg_9_2
	end

	return arg_9_0
end

local function var_0_24(arg_10_0, arg_10_1)
	return var_0_23({
		arg_10_0
	}, arg_10_0, arg_10_1)
end

local function var_0_25(arg_11_0, arg_11_1)
	if not arg_11_1 then
		var_0_10003("rule '" .. arg_11_0 .. "' used outside a grammar")
	else
		return var_0_0.V(arg_11_0)
	end

	return
end

local var_0_26 = var_5.P({
	"Exp",
	Exp = var_0_14 * (var_5.V("Grammar") + var_5.Cf(var_5.V("Seq") * ("/" * var_0_14 * var_5.V("Seq"))^0, var_0_1.__add)),
	Seq = var_5.Cf(var_5.Cc(var_5.P("")) * var_5.V("Prefix")^0, var_0_1.__mul) * (#var_0_17 + var_0_11),
	Prefix = "&" * var_0_14 * var_5.V("Prefix") / var_0_1.__len + "!" * var_0_14 * var_5.V("Prefix") / var_0_1.__unm + var_5.V("Suffix"),
	Suffix = var_5.Cf(var_5.V("Primary") * var_0_14 * ((var_5.P("+") * var_5.Cc(1, var_0_1.__pow) + var_5.P("*") * var_5.Cc(0, var_0_1.__pow) + var_5.P("?") * var_5.Cc(-1, var_0_1.__pow) + "^" * (var_5.Cg(var_0_19 * var_5.Cc(var_0_12)) + var_5.Cg(var_5.C(var_5.S("+-") * var_5.R("09")^1) * var_5.Cc(var_0_1.__pow))) + "->" * var_0_14 * (var_5.Cg((var_0_20 + var_0_19) * var_5.Cc(var_0_1.__div)) + var_5.P("{}") * var_5.Cc(nil, var_5.Ct) + var_5.Cg(var_0_18 / var_0_10 * var_5.Cc(var_0_1.__div))) + "=>" * var_0_14 * var_5.Cg(var_0_18 / var_0_10 * var_5.Cc(var_5.Cmt))) * var_0_14)^0, function(arg_12_0, arg_12_1, arg_12_2)
		return arg_12_2(arg_12_0, arg_12_1)
	end),
	Primary = "(" * var_5.V("Exp") * ")" + var_0_20 / var_0_0.P + var_0_22 + var_27 + "{:" * (var_21 * ":" + var_5.Cc(nil)) * var_5.V("Exp") * ":}" / function(arg_13_0, arg_13_1)
		return var_0_0.Cg(arg_13_1, arg_13_0)
	end + "=" * var_21 / function(arg_14_0)
		return var_0_0.Cmt(var_0_0.Cb(arg_14_0), var_0_13)
	end + var_5.P("{}") / var_0_0.Cp + "{~" * var_5.V("Exp") * "~}" / var_0_0.Cs + "{|" * var_5.V("Exp") * "|}" / var_0_0.Ct + "{" * var_5.V("Exp") * "}" / var_0_0.C + var_5.P(".") * var_5.Cc(var_0_4) + (var_21 * -var_0_16 + "<" * var_21 * ">") * var_5.Cb("G") / var_0_25,
	Definition = var_21 * var_0_16 * var_5.V("Exp"),
	Grammar = var_5.Cg(var_5.Cc(true), "G") * var_5.Cf(var_5.V("Definition") / var_0_24 * var_5.Cg(var_5.V("Definition"))^0, var_0_23) / var_0_0.P
})
local var_0_27 = var_0_14 * var_5.Cg(var_5.Cc(false), "G") * var_0_26 / var_0_0.P * (-var_0_4 + var_0_11)

local function var_0_28(arg_15_0, arg_15_1)
	if var_0_0.type(arg_15_0) == "pattern" then
		return arg_15_0
	end

	local var_15_0 = var_0_27

	if not var_2.match(var_15_0, arg_15_0, 1, arg_15_1) then
		var_0_10003("incorrect pattern", 3)
	end

	return var_2
end

local function var_0_29(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0

	if not var_0_6[arg_16_1] then
		var_16_0 = var_0_28(arg_16_1)
		var_0_6[arg_16_1] = var_16_0
	end

	return var_16_0:match(arg_16_0, arg_16_2 or 1)
end

local function var_0_30(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0

	if not var_0_7[arg_17_1] then
		var_17_0 = var_0_28(arg_17_1) / 0
		var_17_0 = var_0_0.P({
			var_0_0.Cp() * var_17_0 * var_0_0.Cp() + 1 * var_0_0.V(1)
		})
		var_0_7[arg_17_1] = var_17_0
	end

	local var_17_1, var_17_2 = var_17_0:match(arg_17_0, arg_17_2 or 1)

	if var_17_1 then
		return var_17_1, var_17_2 - 1
	else
		return var_17_1
	end

	return
end

local function var_0_31(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0

	if not var_0_8[arg_18_1] then
		var_18_0 = {}
	end

	var_0_8[arg_18_1] = var_18_0

	local var_18_1

	if not var_18_0[arg_18_2] then
		var_18_1 = var_0_28(arg_18_1)
		var_18_0[arg_18_2] = var_0_0.Cs((var_18_1 / arg_18_2 + 1)^0)
	end

	return var_18_1:match(arg_18_0)
end

local var_0_32 = {
	compile = var_0_28,
	match = var_0_29,
	find = var_0_30,
	gsub = var_0_31,
	updatelocale = var_14
}

if var_0_10008 == "Lua 5.1" then
	-- block empty
end

return var_0_32
