class = var_0_10000

local var_0_0 = "LocalSystemTimeUtil"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SystemTimeUtil"))

function var_0_1.Flush(arg_1_0)
	os = var_1_10001

	local var_1_0 = var_1_10001.date("%H:%M:%S")

	string = var_1_10002

	local var_1_1 = var_1_10002.split(var_1_0, ":")[2]

	tonumber = var_4

	local var_1_2 = var_4(var_2[1]) < 12 and "AM" or "PM"

	if arg_1_0.callback then
		arg_1_0.callback(var_4, var_1_1, var_1_2)
	end

	os = var_7

	local var_1_3 = var_7.time()
	local var_1_4 = arg_1_0:GetSecondsToNextMinute(var_1_3)

	arg_1_0:AddTimer(var_1_4)

	return
end

return var_0_1
