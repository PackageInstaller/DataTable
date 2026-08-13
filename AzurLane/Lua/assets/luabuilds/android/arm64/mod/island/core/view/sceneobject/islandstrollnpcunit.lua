class = var_0_10000

local var_0_0 = "IslandStrollNpcUnit"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandDressupNpcUnit"))

function var_0_1.SetupBt(arg_1_0)
	if not arg_1_0.behaviourTreeOwner then
		return
	end

	local var_1_0 = arg_1_0.data
	local var_1_1 = var_1.GetPath(var_1_0)

	LuaHelper = var_1_10002

	var_1_10002.NodeCanvasSetIntVariableValue(arg_1_0.behaviourTreeOwner, "pathId", var_1_1)
	var_0_1.super.SetupBt(arg_1_0)

	return
end

return var_0_1
