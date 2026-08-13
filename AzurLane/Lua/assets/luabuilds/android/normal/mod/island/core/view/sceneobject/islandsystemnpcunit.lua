class = var_0_10000

local var_0_0 = "IslandSystemNpcUnit"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandNpcUnit"))

function var_0_1.SetupBt(arg_1_0)
	if not arg_1_0.behaviourTreeOwner then
		return
	end

	local var_1_0 = arg_1_0:GetView()

	if not var_1.IsInit(var_1_0) then
		local var_1_1 = arg_1_0.behaviourTreeOwner.graph.blackboard

		var_1.SetVariableValue(var_1_1, "working", true)
	end

	var_0_1.super.SetupBt(arg_1_0)

	return
end

return var_0_1
