local var_0_0 = {}
local var_0_1 = {}
local var_0_2 = false

function var_0_0.Inject(arg_1_0, arg_1_1)
	var_0_1 = {}
	var_0_2 = false

	function arg_1_1.RegisterEvent(arg_2_0, arg_2_1, arg_2_2)
		var_0_1[arg_2_1] = arg_2_2
	end

	function arg_1_1.UnRegisterEvent(arg_3_0, arg_3_1)
		var_0_1[arg_3_1] = nil
	end

	function arg_1_1.DispatchEvent(arg_4_0, arg_4_1)
		local var_4_0 = var_0_1[arg_4_1]

		if var_4_0 then
			var_4_0()
		end
	end

	function arg_1_1.DisposeEvent(arg_5_0)
		var_0_1 = {}
	end

	function arg_1_1.OpenShop(arg_6_0)
		return
	end

	function arg_1_1.ImmediateNextFlag(arg_7_0, arg_7_1)
		arg_7_0:SetImmediateNextFlag(arg_7_1)
	end
end

return var_0_0
