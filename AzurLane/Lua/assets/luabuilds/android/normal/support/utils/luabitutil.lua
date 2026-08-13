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
	pairs = var_1_10001

	for iter_1_0, iter_1_1 in var_1_10001(var_0_0) do
		if iter_1_1 == arg_1_0 then
			return iter_1_0
		end
	end

	return 0
end

local function var_0_2(arg_2_0, arg_2_1)
	local function var_2_0(arg_3_0, arg_3_1)
		if arg_3_0 < arg_2_1 then
			table = var_2

			var_2.insert(arg_3_1, arg_3_0)
		else
			local var_3_0 = var_2_0

			math = var_2_10003

			var_3_0(var_2_10003.floor(arg_3_0 / arg_2_1), arg_3_1)

			table = var_3_0

			var_3_0.insert(arg_3_1, arg_3_0 % arg_2_1)
		end

		return
	end

	local var_2_1 = {}

	var_2_0(arg_2_0, var_2_1)

	return var_2_1
end

local function var_0_3(arg_4_0, arg_4_1)
	local var_4_0 = var_0_2(arg_4_0, arg_4_1)
	local var_4_1 = ""

	ipairs = var_4

	for iter_4_0, iter_4_1 in var_4(var_4_0) do
		var_4_1 = var_4_1 .. var_0_0[iter_4_1]
	end

	return var_4_1
end

local var_0_4 = ConvertDec2X

local function var_0_5(arg_5_0, arg_5_1)
	local var_5_0 = {}

	string = var_1_10003

	local var_5_1 = var_1_10003.len(arg_5_0)

	while 0 < var_5_1 do
		string = var_5_2

		local var_5_2 = var_5_2.sub(arg_5_0, var_5_1, var_5_1)

		var_5_0[#var_5_0 + 1] = var_0_1(var_5_2)
		var_5_1 = var_5_1 - 1
	end

	local var_5_3 = 0

	ipairs = var_1_10006

	for iter_5_0, iter_5_1 in var_1_10006(var_5_0) do
		math = var_1_10011
		var_5_3 = var_5_3 + iter_5_1 * var_1_10011.pow(arg_5_1, iter_5_0 - 1)
	end

	return var_5_3
end

local var_0_6 = ConvertStr2Dec

return
