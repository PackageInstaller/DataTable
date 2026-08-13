local var_0_0 = {}

function var_0_0.ForamtNumberK(arg_1_0)
	tonumber = var_1_10001
	arg_1_0 = var_1_10001(arg_1_0) or 0

	local var_1_0 = arg_1_0 < 0 and "-" or ""

	math = var_2

	if var_2.abs(arg_1_0) < 10000 then
		return var_0_0.ForamtNumber(arg_1_0)
	end

	math = var_3

	local var_1_1 = var_3.floor(var_2 / 1000)

	tostring = var_4

	local var_1_2 = var_4(var_1_1)
	local var_1_3 = var_4.reverse(var_1_2)
	local var_1_4 = var_4.gsub(var_1_3, "(%d%d%d)", "%1,")
	local var_1_5 = var_4.reverse(var_1_4)
	local var_1_6 = var_4.gsub(var_1_5, "^,", "")

	return var_1_0 .. var_1_6 .. "K"
end

function var_0_0.ForamtNumber(arg_2_0)
	tonumber = var_1_10001
	arg_2_0 = var_1_10001(arg_2_0) or 0

	local var_2_0 = arg_2_0 < 0 and "-" or ""

	math = var_2

	if var_2.abs(arg_2_0) < 1000 then
		return arg_2_0
	end

	tostring = var_3

	local var_2_1 = var_3(var_2)
	local var_2_2 = var_3.reverse(var_2_1)
	local var_2_3 = var_3.gsub(var_2_2, "(%d%d%d)", "%1,")
	local var_2_4 = var_3.reverse(var_2_3)
	local var_2_5 = var_3.gsub(var_2_4, "^,", "")

	return var_2_0 .. var_2_5
end

return var_0_0
