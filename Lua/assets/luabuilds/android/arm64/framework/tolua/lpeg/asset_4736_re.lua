local var_0_0 = type
local var_0_1 = print
local var_0_2 = error
local var_0_3 = setmetatable
local lpeg = require("lpeg")
local var_0_5 = lpeg
local var_0_6 = getmetatable(lpeg.P(0))

if _VERSION == "Lua 5.2" then
	_ENV = nil
end

local var_0_7 = lpeg.P(1)
local var_0_8 = {
	nl = lpeg.P("\n")
}
local var_0_9
local var_0_10
local var_0_11

local function var_0_12()
	var_0_5.locale(var_0_8)

	var_0_8.a = var_0_8.alpha
	var_0_8.c = var_0_8.cntrl
	var_0_8.d = var_0_8.digit
	var_0_8.g = var_0_8.graph
	var_0_8.l = var_0_8.lower
	var_0_8.p = var_0_8.punct
	var_0_8.s = var_0_8.space
	var_0_8.u = var_0_8.upper
	var_0_8.w = var_0_8.alnum
	var_0_8.x = var_0_8.xdigit
	var_0_8.A = var_0_7 - var_0_8.a
	var_0_8.C = var_0_7 - var_0_8.c
	var_0_8.D = var_0_7 - var_0_8.d
	var_0_8.G = var_0_7 - var_0_8.g
	var_0_8.L = var_0_7 - var_0_8.l
	var_0_8.P = var_0_7 - var_0_8.p
	var_0_8.S = var_0_7 - var_0_8.s
	var_0_8.U = var_0_7 - var_0_8.u
	var_0_8.W = var_0_7 - var_0_8.w
	var_0_8.X = var_0_7 - var_0_8.x
	var_0_9 = {}
	var_0_10 = {}
	var_0_11 = {}

	local var_1_0 = {
		__mode = "v"
	}

	var_0_3(var_0_9, var_1_0)
	var_0_3(var_0_10, var_1_0)
	var_0_3(var_0_11, var_1_0)

	return
end

var_0_12()

local var_0_13 = lpeg.P(function(arg_2_0, arg_2_1)
	var_0_1(arg_2_1, arg_2_0:sub(1, arg_2_1 - 1))

	return arg_2_1
end)

local function var_0_14(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1 and arg_3_1[arg_3_0]

	if not (arg_3_1 and arg_3_1[arg_3_0]) then
		var_0_2("undefined name: " .. arg_3_0)
	end

	return var_3_0
end

local function var_0_15(arg_4_0, arg_4_1)
	var_0_2(("pattern error near '%s'"):format(#arg_4_0 < arg_4_1 + 20 and arg_4_0:sub(arg_4_1) or arg_4_0:sub(arg_4_1, arg_4_1 + 20) .. "..."), 2)

	return
end

local function var_0_16(arg_6_0, arg_6_1, arg_6_2)
	if var_0_0(arg_6_2) ~= "string" then
		return nil
	end

	if arg_6_0:sub(arg_6_1, #arg_6_2 + arg_6_1 - 1) == arg_6_2 then
		return #arg_6_2 + arg_6_1
	else
		return nil
	end

	return
end

local var_0_17 = lpeg.R("AZ", "az", "__") * lpeg.R("AZ", "az", "__", "09")^0
local var_0_18 = lpeg.C(var_0_17)
local var_0_19 = var_0_18 * lpeg.Carg(1)
local var_0_20 = lpeg.C(lpeg.R("09")^1) * (var_0_8.space + "--" * (var_0_7 - var_0_8.nl)^0)^0 / tonumber
local var_0_21 = "'" * lpeg.C((var_0_7 - "'")^0) * "'" + "\"" * lpeg.C((var_0_7 - "\"")^0) * "\""
local var_0_22 = "%" * var_0_19 / function(arg_7_0, arg_7_1)
	local var_7_0

	if arg_7_1 then
		var_7_0 = arg_7_1[arg_7_0] or var_0_8[arg_7_0]

		if not var_7_0 then
			var_0_2("name '" .. arg_7_0 .. "' undefined")
		end
	end

	return var_7_0
end
local var_0_23 = var_0_22 + lpeg.Cs(var_0_7 * (lpeg.P("-") / "") * (var_0_7 - "]")) / lpeg.R + lpeg.C(var_0_7)

local function var_0_24(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0[arg_9_1] then
		var_0_2("'" .. arg_9_1 .. "' already defined as a rule")
	else
		arg_9_0[arg_9_1] = arg_9_2
	end

	return arg_9_0
end

local var_0_25 = (var_0_8.space + "--" * (var_0_7 - var_0_8.nl)^0)^0 * lpeg.Cg(lpeg.Cc(false), "G") * lpeg.P({
	"Exp",
	Exp = (var_0_8.space + "--" * (var_0_7 - var_0_8.nl)^0)^0 * (lpeg.V("Grammar") + lpeg.Cf(lpeg.V("Seq") * ("/" * (var_0_8.space + "--" * (var_0_7 - var_0_8.nl)^0)^0 * lpeg.V("Seq"))^0, var_0_6.__add)),
	Seq = lpeg.Cf(lpeg.Cc(lpeg.P("")) * lpeg.V("Prefix")^0, var_0_6.__mul) * (#(lpeg.P("/") + ")" + "}" + ":}" + "~}" + "|}" + var_0_17 * ((var_0_8.space + "--" * (var_0_7 - var_0_8.nl)^0)^0 * "<-") + -1) + var_0_15),
	Prefix = "&" * (var_0_8.space + "--" * (var_0_7 - var_0_8.nl)^0)^0 * lpeg.V("Prefix") / var_0_6.__len + "!" * (var_0_8.space + "--" * (var_0_7 - var_0_8.nl)^0)^0 * lpeg.V("Prefix") / var_0_6.__unm + lpeg.V("Suffix"),
	Suffix = lpeg.Cf(lpeg.V("Primary") * (var_0_8.space + "--" * (var_0_7 - var_0_8.nl)^0)^0 * ((lpeg.P("+") * lpeg.Cc(1, var_0_6.__pow) + lpeg.P("*") * lpeg.Cc(0, var_0_6.__pow) + lpeg.P("?") * lpeg.Cc(-1, var_0_6.__pow) + "^" * (lpeg.Cg(var_0_20 * lpeg.Cc(function(arg_5_0, arg_5_1)
		local var_5_0 = var_0_5.P(true)

		while arg_5_1 >= 1 do
			if arg_5_1 % 2 >= 1 then
				var_5_0 = var_5_0 * arg_5_0
			end

			arg_5_0 = arg_5_0 * arg_5_0
			arg_5_1 = arg_5_1 / 2
		end

		return var_5_0
	end)) + lpeg.Cg(lpeg.C(lpeg.S("+-") * lpeg.R("09")^1) * lpeg.Cc(var_0_6.__pow))) + "->" * (var_0_8.space + "--" * (var_0_7 - var_0_8.nl)^0)^0 * (lpeg.Cg((var_0_21 + var_0_20) * lpeg.Cc(var_0_6.__div)) + lpeg.P("{}") * lpeg.Cc(nil, lpeg.Ct) + lpeg.Cg(var_0_19 / var_0_14 * lpeg.Cc(var_0_6.__div))) + "=>" * (var_0_8.space + "--" * (var_0_7 - var_0_8.nl)^0)^0 * lpeg.Cg(var_0_19 / var_0_14 * lpeg.Cc(lpeg.Cmt))) * (var_0_8.space + "--" * (var_0_7 - var_0_8.nl)^0)^0)^0, function(arg_12_0, arg_12_1, arg_12_2)
		return arg_12_2(arg_12_0, arg_12_1)
	end),
	Primary = "(" * lpeg.V("Exp") * ")" + var_0_21 / lpeg.P + "[" * lpeg.C(lpeg.P("^")^-1) * lpeg.Cf(var_0_23 * (var_0_23 - "]")^0, var_0_6.__add) / function(arg_8_0, arg_8_1)
		return (arg_8_0 == "^" or nil) and (var_0_7 - arg_8_1 or arg_8_1)
	end * "]" + var_0_22 + "{:" * (var_0_18 * ":" + lpeg.Cc(nil)) * lpeg.V("Exp") * ":}" / function(arg_13_0, arg_13_1)
		return var_0_5.Cg(arg_13_1, arg_13_0)
	end + "=" * var_0_18 / function(arg_14_0)
		return var_0_5.Cmt(var_0_5.Cb(arg_14_0), var_0_16)
	end + lpeg.P("{}") / lpeg.Cp + "{~" * lpeg.V("Exp") * "~}" / lpeg.Cs + "{|" * lpeg.V("Exp") * "|}" / lpeg.Ct + "{" * lpeg.V("Exp") * "}" / lpeg.C + lpeg.P(".") * lpeg.Cc(var_0_7) + (var_0_18 * -((var_0_8.space + "--" * (var_0_7 - var_0_8.nl)^0)^0 * "<-") + "<" * var_0_18 * ">") * lpeg.Cb("G") / function(arg_11_0, arg_11_1)
		if not arg_11_1 then
			var_0_2("rule '" .. arg_11_0 .. "' used outside a grammar")
		else
			return var_0_5.V(arg_11_0)
		end

		return
	end,
	Definition = var_0_18 * ((var_0_8.space + "--" * (var_0_7 - var_0_8.nl)^0)^0 * "<-") * lpeg.V("Exp"),
	Grammar = lpeg.Cg(lpeg.Cc(true), "G") * lpeg.Cf(lpeg.V("Definition") / function(arg_10_0, arg_10_1)
		return var_0_24({
			arg_10_0
		}, arg_10_0, arg_10_1)
	end * lpeg.Cg(lpeg.V("Definition"))^0, var_0_24) / lpeg.P
}) / lpeg.P * (-var_0_7 + var_0_15)

local function var_0_26(arg_15_0, arg_15_1)
	if var_0_5.type(arg_15_0) == "pattern" then
		return arg_15_0
	end

	local var_15_0 = var_0_25:match(arg_15_0, 1, arg_15_1)

	if not var_15_0 then
		var_0_2("incorrect pattern", 3)
	end

	return var_15_0
end

if _VERSION == "Lua 5.1" then
	-- block empty
end

return {
	compile = var_0_26,
	match = function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = var_0_9[arg_16_1]

		if not var_0_9[arg_16_1] then
			var_16_0 = var_0_26(arg_16_1)
			var_0_9[arg_16_1] = var_16_0
		end

		return var_16_0:match(arg_16_0, arg_16_2 or 1)
	end,
	find = function(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = var_0_10[arg_17_1]

		if not var_0_10[arg_17_1] then
			var_17_0 = var_0_26(arg_17_1) / 0
			var_17_0 = var_0_5.P({
				var_0_5.Cp() * var_17_0 * var_0_5.Cp() + 1 * var_0_5.V(1)
			})
			var_0_10[arg_17_1] = var_17_0
		end

		local var_17_1, var_17_2 = var_17_0:match(arg_17_0, arg_17_2 or 1)

		if var_17_1 then
			return var_17_1, var_17_2 - 1
		else
			return var_17_1
		end

		return
	end,
	gsub = function(arg_18_0, arg_18_1, arg_18_2)
		local var_18_0 = var_0_11[arg_18_1] or {}

		var_0_11[arg_18_1] = var_18_0

		local var_18_1 = var_18_0[arg_18_2]

		if not var_18_0[arg_18_2] then
			var_18_1 = var_0_26(arg_18_1)
			var_18_1 = var_0_5.Cs((var_18_1 / arg_18_2 + 1)^0)
			var_18_0[arg_18_2] = var_18_1
		end

		return var_18_1:match(arg_18_0)
	end,
	updatelocale = var_0_12
}
