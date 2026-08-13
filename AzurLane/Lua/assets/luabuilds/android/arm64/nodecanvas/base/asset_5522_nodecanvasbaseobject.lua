class = var_0_10000

local var_0_0 = var_0_10000("NodeCanvasBaseObject")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.args = {}
	arg_1_0.instance = nil

	return
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:SetArgs(arg_2_2)

	arg_2_0.instance = arg_2_1

	return
end

function var_0_0.SetArgs(arg_3_0, arg_3_1)
	arg_3_0.args = {}

	local var_3_0 = arg_3_1:GetEnumerator()

	while var_3_0:MoveNext() do
		local var_3_1 = var_3_0.Current

		arg_3_0.args[var_3_1.Key] = var_3_1.Value
	end

	return
end

function var_0_0.GetNodeInstance(arg_4_0)
	return arg_4_0.instance
end

function var_0_0.GetRouter(arg_5_0)
	if arg_5_0:GetNodeInstance() then
		return var_1.router
	end

	return
end

function var_0_0.GetElapsedTime(arg_6_0)
	if arg_6_0:GetNodeInstance() then
		return var_1.elapsedTime
	end

	return 0
end

function var_0_0.GetBlackboard(arg_7_0)
	if not arg_7_0:GetNodeInstance() then
		return nil
	end

	return var_1.blackboard
end

function var_0_0.GetBlackboardVariable(arg_8_0, arg_8_1)
	if not arg_8_0:GetBlackboard() then
		return nil
	end

	local var_8_0 = arg_8_0:GetNodeInstance()

	return var_2:GetVariable(arg_8_1) and var_4.value
end

function var_0_0.SetBlackboardVariable(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0:GetBlackboard() then
		return
	end

	var_3:SetVariableValue(arg_9_1, arg_9_2)

	return
end

function var_0_0.AddBlackboardVariable(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0:GetBlackboard() then
		return
	end

	var_3:AddVariable(arg_10_1, arg_10_2)

	return
end

function var_0_0.GetAgent(arg_11_0)
	if not arg_11_0:GetNodeInstance() then
		return nil
	end

	return var_1.agent
end

function var_0_0.GetComponent(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:GetAgent()

	return var_2.GetComponent(var_12_0, arg_12_1)
end

function var_0_0.ExistArg(arg_13_0, arg_13_1)
	assert = var_1_10002

	var_1_10002(arg_13_0.args[arg_13_1] ~= nil, "arg is null >>>>" .. arg_13_1)

	return arg_13_0.args[arg_13_1] ~= nil
end

function var_0_0.GetArgByName(arg_14_0, arg_14_1)
	return arg_14_0.args[arg_14_1]
end

function var_0_0.GetStringArg(arg_15_0, arg_15_1)
	if not arg_15_0:ExistArg(arg_15_1) then
		return ""
	end

	return arg_15_0:GetArgByName(arg_15_1)
end

function var_0_0.GetFloatArg(arg_16_0, arg_16_1)
	if not arg_16_0:ExistArg(arg_16_1) then
		return 0
	end

	local var_16_0 = arg_16_0:GetArgByName(arg_16_1)

	tonumber = var_1_10003

	return var_1_10003(var_16_0)
end

function var_0_0.GetBoolArg(arg_17_0, arg_17_1)
	if not arg_17_0:ExistArg(arg_17_1) then
		return false
	end

	local var_17_0 = arg_17_0:GetArgByName(arg_17_1)

	type = var_1_10003

	if var_1_10003(var_17_0) == "string" then
		if var_17_0 == "true" then
			return true
		end

		return false
	else
		return var_17_0
	end

	return
end

return var_0_0
