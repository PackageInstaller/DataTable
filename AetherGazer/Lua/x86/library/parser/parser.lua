local var_0_0 = require("lpeg")
local var_0_1 = var_0_0.S
local var_0_2 = var_0_0.R
local var_0_3 = var_0_0.P
local var_0_4 = var_0_0.Ct
local var_0_5 = var_0_0.C
local var_0_6 = var_0_0.Cc
local var_0_7 = var_0_0.V
local var_0_8 = var_0_1(" \t\n")^0
local var_0_9 = var_0_2("09")
local var_0_10 = var_0_5(("-" + var_0_9) * var_0_9^0 * ("." * var_0_9^0)^-1) / tonumber * var_0_8
local var_0_11 = var_0_2("AZ", "az")
local var_0_12 = "(" * var_0_8
local var_0_13 = ")" * var_0_8
local var_0_14 = "[" * var_0_8
local var_0_15 = "]" * var_0_8
local var_0_16 = "," * var_0_8
local var_0_17 = var_0_5(var_0_3("true")) * var_0_8
local var_0_18 = var_0_5(var_0_3("false")) * var_0_8
local var_0_19 = var_0_5(var_0_3("<=") + var_0_3(">=") + var_0_3("!=") + var_0_3("==") + var_0_1("<>")) * var_0_8
local var_0_20 = var_0_5(var_0_1("+-")) * var_0_8
local var_0_21 = var_0_5(var_0_1("*/")) * var_0_8
local var_0_22 = var_0_5(var_0_1("^")) * var_0_8
local var_0_23 = var_0_5(var_0_11 * (var_0_9 + var_0_11 + "_")^0) * var_0_8 - (var_0_17 + var_0_18) * var_0_8
local var_0_24 = var_0_5("#" * var_0_9 * var_0_9^0) * var_0_8
local var_0_25 = var_0_7("AddSub")
local var_0_26 = var_0_7("MulDiv")
local var_0_27 = var_0_7("Exponent")
local var_0_28 = var_0_7("Operand")
local var_0_29 = var_0_7("Ref")
local var_0_30 = var_0_7("Call")
local var_0_31 = var_0_7("VarList")
local var_0_32 = var_0_7("Val")
local var_0_33 = var_0_7("Bool")
local var_0_34 = var_0_7("Array")
local var_0_35 = "bool"
local var_0_36 = "addsub"
local var_0_37 = "muldiv"
local var_0_38 = "expo"
local var_0_39 = "ref"
local var_0_40 = "call"
local var_0_41 = "array"
local var_0_42 = var_0_8 * var_0_3({
	var_0_32,
	Val = var_0_34 + var_0_33 + var_0_25,
	Bool = var_0_4(var_0_6(var_0_35) * (var_0_17 + var_0_18 + var_0_25 * var_0_19 * var_0_25)),
	AddSub = var_0_4(var_0_6(var_0_36) * var_0_26 * (var_0_20 * var_0_26)^0),
	MulDiv = var_0_4(var_0_6(var_0_37) * var_0_27 * (var_0_21 * var_0_27)^0),
	Exponent = var_0_4(var_0_6(var_0_38) * var_0_28 * (var_0_22 * var_0_28)^0),
	Operand = var_0_10 + var_0_12 * var_0_25 * var_0_13 + var_0_30 + var_0_29,
	Ref = var_0_4(var_0_6(var_0_39) * (var_0_24 + var_0_23) * (var_0_14 * var_0_25 * var_0_15)^0),
	Call = var_0_4(var_0_6(var_0_40) * var_0_29 * var_0_8 * var_0_12 * var_0_31 * var_0_13),
	VarList = var_0_4((var_0_32 * var_0_16^-1)^0),
	Array = var_0_4(var_0_6(var_0_41) * var_0_14 * var_0_31 * var_0_15)
}) * -1

function simplify(arg_1_0)
	if type(arg_1_0) ~= "table" then
		return arg_1_0
	elseif arg_1_0[1] == var_0_36 or arg_1_0[1] == var_0_37 or arg_1_0[1] == var_0_38 then
		local var_1_0 = #arg_1_0

		if var_1_0 == 2 then
			arg_1_0 = simplify(arg_1_0[2])
		else
			for iter_1_0 = 2, var_1_0 do
				arg_1_0[iter_1_0] = simplify(arg_1_0[iter_1_0])
			end
		end
	elseif arg_1_0[1] == var_0_35 then
		for iter_1_1 = 2, #arg_1_0 do
			arg_1_0[iter_1_1] = simplify(arg_1_0[iter_1_1])
		end
	elseif arg_1_0[1] == var_0_39 then
		for iter_1_2 = 3, #arg_1_0 do
			arg_1_0[iter_1_2] = simplify(arg_1_0[iter_1_2])
		end
	elseif arg_1_0[1] == var_0_41 then
		local var_1_1 = arg_1_0[2]

		for iter_1_3 = 1, #var_1_1 do
			var_1_1[iter_1_3] = simplify(var_1_1[iter_1_3])
		end
	elseif arg_1_0[1] == var_0_40 then
		local var_1_2 = arg_1_0[3]

		for iter_1_4, iter_1_5 in ipairs(var_1_2) do
			var_1_2[iter_1_4] = simplify(var_1_2[iter_1_4])
		end
	end

	return arg_1_0
end

function eval_expr_lr(arg_2_0, arg_2_1, arg_2_2)
	if type(arg_2_0) ~= "table" or arg_2_0[1] ~= var_0_36 and arg_2_0[1] ~= var_0_37 then
		return nil, "invalid expr(left to right)"
	end

	local var_2_0
	local var_2_1
	local var_2_2
	local var_2_3, var_2_4 = eval(arg_2_0[2], arg_2_1, arg_2_2)

	if var_2_3 == nil then
		return nil, var_2_4
	end

	for iter_2_0 = 3, #arg_2_0, 2 do
		local var_2_5 = arg_2_0[iter_2_0]
		local var_2_6, var_2_7 = eval(arg_2_0[iter_2_0 + 1], arg_2_1, arg_2_2)

		if var_2_7 ~= nil then
			return nil, var_2_7
		end

		if var_2_5 == "+" then
			var_2_3 = var_2_3 + var_2_6
		elseif var_2_5 == "-" then
			var_2_3 = var_2_3 - var_2_6
		elseif var_2_5 == "*" then
			var_2_3 = var_2_3 * var_2_6
		elseif var_2_5 == "/" then
			var_2_3 = var_2_3 / var_2_6
		else
			return nil, var_2_5 .. " operator is not supported"
		end
	end

	return var_2_3
end

function eval_expr_rl(arg_3_0, arg_3_1, arg_3_2)
	if type(arg_3_0) ~= "table" or arg_3_0[1] ~= var_0_38 then
		return nil, "invalid expr(right to left)"
	end

	local var_3_0
	local var_3_1
	local var_3_2
	local var_3_3 = #arg_3_0
	local var_3_4, var_3_5 = eval(arg_3_0[var_3_3], arg_3_1, arg_3_2)

	if var_3_4 == nil then
		return nil, var_3_5
	end

	for iter_3_0 = var_3_3 - 1, 3, -2 do
		local var_3_6 = arg_3_0[iter_3_0]
		local var_3_7, var_3_8 = eval(arg_3_0[iter_3_0 - 1], arg_3_1, arg_3_2)

		if var_3_8 ~= nil then
			return nil, var_3_8
		end

		if var_3_6 == "^" then
			var_3_4 = var_3_7^var_3_4
		else
			return nil, var_3_6 .. " operator is not supported"
		end
	end

	return var_3_4
end

function eval_bool(arg_4_0, arg_4_1, arg_4_2)
	if type(arg_4_0) ~= "table" or arg_4_0[1] ~= var_0_35 then
		return nil, "invalid bool"
	end

	if arg_4_0[2] == "true" then
		return true
	elseif arg_4_0[2] == "false" then
		return false
	end

	local var_4_0
	local var_4_1
	local var_4_2
	local var_4_3, var_4_4 = eval(arg_4_0[2], arg_4_1, arg_4_2)
	local var_4_5, var_4_6 = eval(arg_4_0[4], arg_4_1, arg_4_2)
	local var_4_7 = arg_4_0[3]

	if var_4_7 == "<" then
		return var_4_3 < var_4_5
	elseif var_4_7 == "==" then
		return var_4_3 == var_4_5
	elseif var_4_7 == ">" then
		return var_4_5 < var_4_3
	elseif var_4_7 == "<=" then
		return var_4_3 <= var_4_5
	elseif var_4_7 == ">=" then
		return var_4_5 <= var_4_3
	elseif var_4_7 == "!=" then
		return var_4_3 ~= var_4_5
	end

	return nil, "invalid bool operator"
end

function eval_array(arg_5_0, arg_5_1, arg_5_2)
	if type(arg_5_0) ~= "table" or arg_5_0[1] ~= var_0_41 or type(arg_5_0[2]) ~= "table" then
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

	log(var_0_41, var_5_0)

	return var_5_0
end

function eval_call(arg_6_0, arg_6_1, arg_6_2)
	if type(arg_6_0) ~= "table" or arg_6_0[1] ~= var_0_40 then
		return nil, "invalid call"
	end

	local var_6_0 = eval(arg_6_0[2], arg_6_1, arg_6_2)

	if type(var_6_0) ~= "function" then
		return nil, arg_6_0[2][2] .. " is not a function"
	end

	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0[3]) do
		local var_6_2
		local var_6_3

		var_6_1[iter_6_0], var_6_3 = eval(iter_6_1, arg_6_1, arg_6_2)

		if var_6_3 ~= nil then
			return nil, var_6_3
		end
	end

	return var_6_0(unpack(var_6_1))
end

function lookup(arg_7_0, arg_7_1, arg_7_2)
	if type(arg_7_0) ~= "table" or arg_7_0[1] ~= var_0_39 then
		return nil, "invalid ref"
	end

	local var_7_0 = arg_7_2[arg_7_0[2]]

	if var_7_0 ~= nil then
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
	elseif arg_8_0[1] == var_0_36 or arg_8_0[1] == var_0_37 then
		return eval_expr_lr(arg_8_0, arg_8_1, arg_8_2)
	elseif arg_8_0[1] == var_0_38 then
		return eval_expr_rl(arg_8_0, arg_8_1, arg_8_2)
	elseif arg_8_0[1] == var_0_39 then
		return lookup(arg_8_0, arg_8_1, arg_8_2)
	elseif arg_8_0[1] == var_0_35 then
		return eval_bool(arg_8_0, arg_8_1, arg_8_2)
	elseif arg_8_0[1] == var_0_41 then
		return eval_array(arg_8_0, arg_8_1, arg_8_2)
	elseif arg_8_0[1] == var_0_40 then
		return eval_call(arg_8_0, arg_8_1, arg_8_2)
	end
end

return {
	parse = function(arg_9_0)
		local var_9_0 = var_0_42:match(arg_9_0)

		return simplify(var_9_0)
	end,
	eval = eval
}
