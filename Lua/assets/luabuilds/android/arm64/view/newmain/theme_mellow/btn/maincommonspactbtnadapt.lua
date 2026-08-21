local var_0_0 = class("MainCommonSpActBtnAdapt")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.spActBtn = arg_1_1

	pg.DelegateInfo.New(arg_1_0)
	setmetatable(arg_1_0, {
		__index = function(arg_2_0, arg_2_1)
			local var_2_0 = rawget(arg_2_0, "class")

			if var_2_0[arg_2_1] then
				return var_2_0[arg_2_1] or arg_1_0.spActBtn[arg_2_1]
			end
		end
	})

	return
end

function var_0_0.GetUIName(arg_3_0)
	return arg_3_0.spActBtn:GetUIName()
end

function var_0_0.Dispose(arg_4_0)
	pg.DelegateInfo.Dispose(arg_4_0)
	arg_4_0.spActBtn:Dispose()

	arg_4_0.spActBtn = nil

	return
end

return var_0_0
