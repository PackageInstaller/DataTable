local var_0_0 = class("IslandSystemNpcUnit", import(".IslandNpcUnit"))

function var_0_0.SetupBt(arg_1_0)
	if not arg_1_0.behaviourTreeOwner then
		return
	end

	local var_1_0 = arg_1_0:GetView()

	if not var_1_0:IsInit() then
		arg_1_0.behaviourTreeOwner.graph.blackboard:SetVariableValue("working", true)
	end

	var_0_0.super.SetupBt(arg_1_0)

	return
end

return var_0_0
