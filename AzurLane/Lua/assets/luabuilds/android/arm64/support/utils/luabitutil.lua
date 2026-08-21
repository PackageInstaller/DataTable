local var_0_0 = {
	[0] = "0",
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G"
}

local function var_0_1(arg_1_0)
	for iter_1_0, iter_1_1 in pairs(var_0_0) do
		if iter_1_1 == arg_1_0 then
			return iter_1_0
		end
	end

	return 0
end

local function var_0_2(arg_2_0, arg_2_1)
	(function(arg_3_0, arg_3_1)
		if arg_3_0 < arg_2_1 then
			table.insert(arg_3_1, arg_3_0)
		else
			var_0(math.floor(arg_3_0 / arg_2_1), arg_3_1)
			table.insert(arg_3_1, arg_3_0 % arg_2_1)
		end

		return
	end)(arg_2_0, {})

	return {}
end

function ConvertDec2X(arg_4_0, arg_4_1)
	local var_4_0 = ""

	for iter_4_0, iter_4_1 in ipairs((var_0_2(arg_4_0, arg_4_1))) do
		var_4_0 = var_4_0 .. var_0_0[iter_4_1]
	end

	return var_4_0
end

function ConvertStr2Dec(arg_5_0, arg_5_1)
	local var_5_0 = string.len(arg_5_0)

	while var_5_0 > 0 do
		({})[#{} + 1] = var_0_1((string.sub(arg_5_0, var_5_0, var_5_0)))
		var_5_0 = var_5_0 - 1
	end

	local var_5_1 = 0

	for iter_5_0, iter_5_1 in ipairs({}) do
		var_5_1 = var_5_1 + iter_5_1 * math.pow(arg_5_1, iter_5_0 - 1)
	end

	return var_5_1
end

return
