local var_0_0 = class("IslandStrollNpcUnit", import(".IslandDressupNpcUnit"))

function var_0_0.SetupBt(arg_1_0)
	if not arg_1_0.behaviourTreeOwner then
		return
	end

	LuaHelper.NodeCanvasSetIntVariableValue(arg_1_0.behaviourTreeOwner, "pathId", (arg_1_0.data:GetPath()))
	var_0_0.super.SetupBt(arg_1_0)

	return
end

return var_0_0
