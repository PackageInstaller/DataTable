local var_0_0 = {}

function var_0_0.ForamtNumberK(arg_1_0)
	arg_1_0 = tonumber(arg_1_0) or 0

	local var_1_0 = arg_1_0 < 0 and "-" or ""
	local var_1_1 = math.abs(arg_1_0)

	if var_1_1 < 10000 then
		return var_0_0.ForamtNumber(arg_1_0)
	end

	return var_1_0 .. tostring((math.floor(var_1_1 / 1000))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. "K"
end

function var_0_0.ForamtNumber(arg_2_0)
	arg_2_0 = tonumber(arg_2_0) or 0

	local var_2_0 = arg_2_0 < 0 and "-" or ""
	local var_2_1 = math.abs(arg_2_0)

	if var_2_1 < 1000 then
		return arg_2_0
	end

	return var_2_0 .. tostring(var_2_1):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end

return var_0_0
