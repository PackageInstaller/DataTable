local var_0_0 = class("NodeCanvasBaseObject")

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
		arg_3_0.args[var_3_0.Current.Key] = var_3_0.Current.Value
	end

	return
end

function var_0_0.GetNodeInstance(arg_4_0)
	return arg_4_0.instance
end

function var_0_0.GetRouter(arg_5_0)
	local var_5_0 = arg_5_0:GetNodeInstance()

	if var_5_0 then
		return var_5_0.router
	end

	return
end

function var_0_0.GetElapsedTime(arg_6_0)
	local var_6_0 = arg_6_0:GetNodeInstance()

	if var_6_0 then
		return var_6_0.elapsedTime
	end

	return 0
end

function var_0_0.GetBlackboard(arg_7_0)
	local var_7_0 = arg_7_0:GetNodeInstance()

	if not var_7_0 then
		return nil
	end

	return var_7_0.blackboard
end

function var_0_0.GetBlackboardVariable(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:GetBlackboard()

	if not var_8_0 then
		return nil
	end

	local var_8_1 = arg_8_0:GetNodeInstance()
	local var_8_2 = var_8_0:GetVariable(arg_8_1)

	return var_8_2 and var_8_2.value
end

function var_0_0.SetBlackboardVariable(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:GetBlackboard()

	if not var_9_0 then
		return
	end

	var_9_0:SetVariableValue(arg_9_1, arg_9_2)

	return
end

function var_0_0.AddBlackboardVariable(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:GetBlackboard()

	if not var_10_0 then
		return
	end

	var_10_0:AddVariable(arg_10_1, arg_10_2)

	return
end

function var_0_0.GetAgent(arg_11_0)
	local var_11_0 = arg_11_0:GetNodeInstance()

	if not var_11_0 then
		return nil
	end

	return var_11_0.agent
end

function var_0_0.GetComponent(arg_12_0, arg_12_1)
	return arg_12_0:GetAgent():GetComponent(arg_12_1)
end

function var_0_0.ExistArg(arg_13_0, arg_13_1)
	assert(arg_13_0.args[arg_13_1] ~= nil, "arg is null >>>>" .. arg_13_1)

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

	return tonumber((arg_16_0:GetArgByName(arg_16_1)))
end

function var_0_0.GetBoolArg(arg_17_0, arg_17_1)
	if not arg_17_0:ExistArg(arg_17_1) then
		return false
	end

	local var_17_0 = arg_17_0:GetArgByName(arg_17_1)

	if type(var_17_0) == "string" then
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
