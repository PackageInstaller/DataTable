local var_0_0 = {}

;({}).ForamtNumberK = function(arg_1_0)
	arg_1_0 = tonumber(arg_1_0) or 0

	local var_1_0 = arg_1_0 < 0 and "-" or ""
	local var_1_1 = math.abs(arg_1_0)

	if var_1_1 < 10000 then
		return var_0_0.ForamtNumber(arg_1_0)
	end

	local var_1_2 = tostring((math.floor(var_1_1 / 1000))):reverse():gsub("(%d%d%d)", "%1,"):reverse()

	return var_1_0 .. var_1_2:gsub("^,", "") .. "K"
end
;({}).ForamtNumber = function(arg_2_0)
	arg_2_0 = tonumber(arg_2_0) or 0

	local var_2_0 = arg_2_0 < 0 and "-" or ""
	local var_2_1 = math.abs(arg_2_0)

	if var_2_1 < 1000 then
		return arg_2_0
	end

	local var_2_2 = tostring(var_2_1):reverse():gsub("(%d%d%d)", "%1,"):reverse()

	return var_2_0 .. var_2_2:gsub("^,", "")
end

return {}
