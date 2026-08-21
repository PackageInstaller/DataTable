local var_0_0 = class("LocalSystemTimeUtil", import(".SystemTimeUtil"))

function var_0_0.Flush(arg_1_0)
	local var_1_0 = string.split(os.date("%H:%M:%S"), ":")
	local var_1_1 = var_1_0[2]
	local var_1_2 = tonumber(var_1_0[1])
	local var_1_3 = var_1_2 < 12 and "AM" or "PM"

	if arg_1_0.callback then
		arg_1_0.callback(var_1_2, var_1_1, var_1_3)
	end

	arg_1_0:AddTimer((arg_1_0:GetSecondsToNextMinute((os.time()))))

	return
end

return var_0_0
