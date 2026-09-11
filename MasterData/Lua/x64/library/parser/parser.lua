local lpeg = require("lpeg")
local var_0_1 = lpeg.S(" \t\n")^0
local var_0_2 = lpeg.R("09")
local var_0_3 = lpeg.R("AZ", "az")
local var_0_4 = lpeg.C(lpeg.P("true")) * var_0_1
local var_0_5 = lpeg.C(lpeg.P("false")) * var_0_1
local var_0_6 = lpeg.V("AddSub")
local var_0_7 = lpeg.V("MulDiv")
local var_0_8 = lpeg.V("Exponent")
local var_0_9 = lpeg.V("Operand")
local var_0_10 = lpeg.V("Ref")
local var_0_11 = lpeg.V("VarList")
local var_0_12 = lpeg.V("Val")
local var_0_13 = "bool"
local var_0_14 = "addsub"
local var_0_15 = "muldiv"
local var_0_16 = "expo"
local var_0_17 = "ref"
local var_0_18 = "call"
local var_0_19 = "array"
local var_0_20 = {
	var_0_12,
	Val = lpeg.V("Array") + lpeg.V("Bool") + var_0_6
}

var_0_20.Bool = lpeg.Ct(lpeg.Cc("bool") * (var_0_4 + var_0_5 + var_0_6 * (lpeg.C(lpeg.P("<=") + lpeg.P(">=") + lpeg.P("!=") + lpeg.P("==") + lpeg.S("<>")) * var_0_1) * var_0_6))
var_0_20.AddSub = lpeg.Ct(lpeg.Cc("addsub") * var_0_7 * (lpeg.C(lpeg.S("+-")) * var_0_1 * var_0_7)^0)
var_0_20.MulDiv = lpeg.Ct(lpeg.Cc("muldiv") * var_0_8 * (lpeg.C(lpeg.S("*/")) * var_0_1 * var_0_8)^0)
var_0_20.Exponent = lpeg.Ct(lpeg.Cc("expo") * var_0_9 * (lpeg.C(lpeg.S("^")) * var_0_1 * var_0_9)^0)
var_0_20.Operand = lpeg.C(("-" + var_0_2) * var_0_2^0 * ("." * var_0_2^0)^-1) / tonumber * var_0_1 + "(" * var_0_1 * var_0_6 * (")" * var_0_1) + lpeg.V("Call") + var_0_10
var_0_20.Ref = lpeg.Ct(lpeg.Cc("ref") * (lpeg.C("#" * var_0_2 * var_0_2^0) * var_0_1 + (lpeg.C(var_0_3 * (var_0_2 + var_0_3 + "_")^0) * var_0_1 - (var_0_4 + var_0_5) * var_0_1)) * ("[" * var_0_1 * var_0_6 * ("]" * var_0_1))^0)
var_0_20.Call = lpeg.Ct(lpeg.Cc("call") * var_0_10 * var_0_1 * ("(" * var_0_1) * var_0_11 * (")" * var_0_1))
var_0_20.VarList = lpeg.Ct((var_0_12 * ("," * var_0_1)^-1)^0)
var_0_20.Array = lpeg.Ct(lpeg.Cc("array") * ("[" * var_0_1) * var_0_11 * ("]" * var_0_1))

local var_0_21 = var_0_1 * lpeg.P(var_0_20) * -1

function simplify(arg_1_0)
	if type(arg_1_0) ~= "table" then
		return arg_1_0
	elseif arg_1_0[1] == var_0_14 or arg_1_0[1] == var_0_15 or arg_1_0[1] == var_0_16 then
		local var_1_0 = #arg_1_0

		if #arg_1_0 == 2 then
			arg_1_0 = simplify(arg_1_0[2])
		else
			for iter_1_0 = 2, var_1_0 do
				arg_1_0[iter_1_0] = simplify(arg_1_0[iter_1_0])
			end
		end
	elseif arg_1_0[1] == var_0_13 then
		for iter_1_1 = 2, #arg_1_0 do
			arg_1_0[iter_1_1] = simplify(arg_1_0[iter_1_1])
		end
	elseif arg_1_0[1] == var_0_17 then
		for iter_1_2 = 3, #arg_1_0 do
			arg_1_0[iter_1_2] = simplify(arg_1_0[iter_1_2])
		end
	elseif arg_1_0[1] == var_0_19 then
		for iter_1_3 = 1, #arg_1_0[2] do
			arg_1_0[2][iter_1_3] = simplify(arg_1_0[2][iter_1_3])
		end
	elseif arg_1_0[1] == var_0_18 then
		for iter_1_4, iter_1_5 in ipairs(arg_1_0[3]) do
			arg_1_0[3][iter_1_4] = simplify(arg_1_0[3][iter_1_4])
		end
	end

	return arg_1_0
end

function eval_expr_lr(arg_2_0, arg_2_1, arg_2_2)
	if type(arg_2_0) ~= "table" or arg_2_0[1] ~= var_0_14 and arg_2_0[1] ~= var_0_15 then
		return nil, "invalid expr(left to right)"
	end

	local var_2_3, var_2_4 = eval(arg_2_0[2], arg_2_1, arg_2_2)

	if var_2_3 == nil then
		return nil, var_2_4
	end

	for iter_2_0 = 3, #arg_2_0, 2 do
		local var_2_5, var_2_6 = eval(arg_2_0[iter_2_0 + 1], arg_2_1, arg_2_2)

		if var_2_6 ~= nil then
			return nil, var_2_6
		end

		if arg_2_0[iter_2_0] == "+" then
			var_2_3 = var_2_3 + var_2_5
		elseif arg_2_0[iter_2_0] == "-" then
			var_2_3 = var_2_3 - var_2_5
		elseif arg_2_0[iter_2_0] == "*" then
			var_2_3 = var_2_3 * var_2_5
		elseif arg_2_0[iter_2_0] == "/" then
			var_2_3 = var_2_3 / var_2_5
		else
			return nil, arg_2_0[iter_2_0] .. " operator is not supported"
		end
	end

	return var_2_3
end

function eval_expr_rl(arg_3_0, arg_3_1, arg_3_2)
	if type(arg_3_0) ~= "table" or arg_3_0[1] ~= var_0_16 then
		return nil, "invalid expr(right to left)"
	end

	local var_3_3, var_3_4 = eval(arg_3_0[#arg_3_0], arg_3_1, arg_3_2)

	if var_3_3 == nil then
		return nil, var_3_4
	end

	for iter_3_0 = #arg_3_0 - 1, 3, -2 do
		local var_3_5, var_3_6 = eval(arg_3_0[iter_3_0 - 1], arg_3_1, arg_3_2)

		if var_3_6 ~= nil then
			return nil, var_3_6
		end

		if arg_3_0[iter_3_0] == "^" then
			var_3_3 = var_3_5^var_3_3
		else
			return nil, arg_3_0[iter_3_0] .. " operator is not supported"
		end
	end

	return var_3_3
end

function eval_bool(arg_4_0, arg_4_1, arg_4_2)
	if type(arg_4_0) ~= "table" or arg_4_0[1] ~= var_0_13 then
		return nil, "invalid bool"
	end

	if arg_4_0[2] == "true" then
		return true
	elseif arg_4_0[2] == "false" then
		return false
	end

	local var_4_3, var_4_4 = eval(arg_4_0[2], arg_4_1, arg_4_2)
	local var_4_5, var_4_6 = eval(arg_4_0[4], arg_4_1, arg_4_2)

	if arg_4_0[3] == "<" then
		return var_4_3 < var_4_5
	elseif arg_4_0[3] == "==" then
		return var_4_3 == var_4_5
	elseif arg_4_0[3] == ">" then
		return var_4_5 < var_4_3
	elseif arg_4_0[3] == "<=" then
		return var_4_3 <= var_4_5
	elseif arg_4_0[3] == ">=" then
		return var_4_5 <= var_4_3
	elseif arg_4_0[3] == "!=" then
		return var_4_3 ~= var_4_5
	end

	return nil, "invalid bool operator"
end

function eval_array(arg_5_0, arg_5_1, arg_5_2)
	if type(arg_5_0) ~= "table" or arg_5_0[1] ~= var_0_19 or type(arg_5_0[2]) ~= "table" then
		return nil, "invalid array"
	end

	local var_5_0 = {}

	for iter_5_0 = 1, #arg_5_0[2] do
		local var_5_1, var_5_2 = eval(arg_5_0[2][iter_5_0], arg_5_1, arg_5_2)

		if var_5_2 ~= nil then
			return nil, var_5_2
		end

		table.insert(var_5_0, var_5_1)
	end

	log(var_0_19, var_5_0)

	return var_5_0
end

function eval_call(arg_6_0, arg_6_1, arg_6_2)
	if type(arg_6_0) ~= "table" or arg_6_0[1] ~= var_0_18 then
		return nil, "invalid call"
	end

	local var_6_0 = eval(arg_6_0[2], arg_6_1, arg_6_2)

	if type(var_6_0) ~= "function" then
		return nil, arg_6_0[2][2] .. " is not a function"
	end

	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0[3]) do
		local var_6_3

		var_6_1[iter_6_0], var_6_3 = eval(iter_6_1, arg_6_1, arg_6_2)

		if var_6_3 ~= nil then
			return nil, var_6_3
		end
	end

	return var_6_0(unpack(var_6_1))
end

function lookup(arg_7_0, arg_7_1, arg_7_2)
	if type(arg_7_0) ~= "table" or arg_7_0[1] ~= var_0_17 then
		return nil, "invalid ref"
	end

	local var_7_0 = arg_7_2[arg_7_0[2]]

	if arg_7_2[arg_7_0[2]] ~= nil then
		for iter_7_0 = 3, #arg_7_0 do
			local var_7_1, var_7_2 = eval(arg_7_0[iter_7_0], arg_7_1, arg_7_2)

			if var_7_2 ~= nil then
				return nil, var_7_2
			end

			log("array", var_7_0)

			if type(var_7_0) ~= "table" then
				return nil, "index of non-table"
			end

			var_7_0 = var_7_0[var_7_1]
		end

		return var_7_0
	end

	return arg_7_1[arg_7_0[2]]
end

function eval(arg_8_0, arg_8_1, arg_8_2)
	if type(arg_8_0) == "number" then
		return arg_8_0
	elseif type(arg_8_0) ~= "table" then
		return nil, "invalid ast"
	elseif arg_8_0[1] == var_0_14 or arg_8_0[1] == var_0_15 then
		return eval_expr_lr(arg_8_0, arg_8_1, arg_8_2)
	elseif arg_8_0[1] == var_0_16 then
		return eval_expr_rl(arg_8_0, arg_8_1, arg_8_2)
	elseif arg_8_0[1] == var_0_17 then
		return lookup(arg_8_0, arg_8_1, arg_8_2)
	elseif arg_8_0[1] == var_0_13 then
		return eval_bool(arg_8_0, arg_8_1, arg_8_2)
	elseif arg_8_0[1] == var_0_19 then
		return eval_array(arg_8_0, arg_8_1, arg_8_2)
	elseif arg_8_0[1] == var_0_18 then
		return eval_call(arg_8_0, arg_8_1, arg_8_2)
	end
end

return {
	parse = function(arg_9_0)
		return simplify((var_0_21:match(arg_9_0)))
	end,
	eval = eval
}
