local var_0_0 = class("MainActivityBtnMellowAdapt")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.activityBtn = arg_1_1

	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.__cname = arg_1_1.__cname

	setmetatable(arg_1_0, {
		__index = function(arg_2_0, arg_2_1)
			local var_2_0 = rawget(arg_2_0, "class")

			if var_2_0[arg_2_1] then
				return var_2_0[arg_2_1] or arg_1_0.activityBtn[arg_2_1]
			end
		end
	})

	return
end

function var_0_0.UpdatePosition(arg_3_0, arg_3_1)
	return
end

function var_0_0.ResPath(arg_4_0)
	return "LinkButton_mellow"
end

function var_0_0.Dispose(arg_5_0)
	pg.DelegateInfo.Dispose(arg_5_0)
	arg_5_0.activityBtn:Dispose()

	arg_5_0.activityBtn = nil

	return
end

return var_0_0
