local var_0_0 = {}

manager.net:Bind(85105, function(arg_1_0)
	ActivityUnlockStateData:InitData(arg_1_0)
end)

function var_0_0.UpdateState(arg_2_0, arg_2_1, arg_2_2)
	manager.net:Push(85106, {
		id = arg_2_0,
		opt = {
			key = arg_2_1,
			value = arg_2_2
		}
	})
	ActivityUnlockStateData:UpdateState(arg_2_0, arg_2_1, arg_2_2)
end

return var_0_0
