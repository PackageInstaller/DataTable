class = var_0_10000

local var_0_0 = var_0_10000("MainCommonSpActBtnAdapt")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.spActBtn = arg_1_1
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	setmetatable = var_2

	var_2(arg_1_0, {
		__index = function(arg_2_0, arg_2_1)
			rawget = var_2_10002

			local var_2_0

			if not var_2_10002(arg_2_0, "class")[arg_2_1] or not var_2[arg_2_1] then
				var_2_0 = arg_1_0.spActBtn[arg_2_1]
			end

			return var_2_0
		end
	})

	return
end

function var_0_0.GetUIName(arg_3_0)
	local var_3_0 = arg_3_0.spActBtn

	return var_1.GetUIName(var_3_0)
end

function var_0_0.Dispose(arg_4_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_4_0)

	local var_4_0 = arg_4_0.spActBtn

	var_1.Dispose(var_4_0)

	arg_4_0.spActBtn = nil

	return
end

return var_0_0
