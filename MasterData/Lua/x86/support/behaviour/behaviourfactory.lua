local var_0_0 = {
	Chain = import(".basic.Chain"),
	DoubleBuffer = import(".basic.DoubleBuffer"),
	EventProtocol = import(".basic.EventProtocol"),
	StateMachine = import(".basic.StateMachine")
}
local var_0_1 = {
	CreateBehaviour = function(arg_1_0)
		return var_0_0[arg_1_0].New()
	end,
	ExtendNewBehaviour = function(arg_2_0, arg_2_1)
		if var_0_0[arg_2_0] then
			printInfo("exist behaviour %s has been overwritten!", arg_2_0)
		end

		var_0_0[arg_2_0] = arg_2_1
	end,
	IsBehaviourAvailable = function(arg_3_0)
		return var_0_0[arg_3_0] ~= nil
	end
}
local var_0_2 = {
	Chain = true,
	StateMachine = true,
	EventProtocol = true,
	DoubleBuffer = true
}

function var_0_1.GetAllBasicBehavioursName()
	return table.keys(var_0_2)
end

return var_0_1
