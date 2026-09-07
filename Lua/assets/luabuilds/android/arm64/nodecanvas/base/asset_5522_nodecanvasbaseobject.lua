local NodeCanvasBaseObject = class("NodeCanvasBaseObject")

function NodeCanvasBaseObject:Ctor()
	self.args = {}
	self.instance = nil

	return
end

function NodeCanvasBaseObject:Init(arg_2_1, arg_2_2)
	self:SetArgs(arg_2_2)

	self.instance = arg_2_1

	return
end

function NodeCanvasBaseObject:SetArgs(arg_3_1)
	self.args = {}

	local var_3_0 = arg_3_1:GetEnumerator()

	while var_3_0:MoveNext() do
		self.args[var_3_0.Current.Key] = var_3_0.Current.Value
	end

	return
end

function NodeCanvasBaseObject:GetNodeInstance()
	return self.instance
end

function NodeCanvasBaseObject:GetRouter()
	local var_5_0 = self:GetNodeInstance()

	if var_5_0 then
		return var_5_0.router
	end

	return
end

function NodeCanvasBaseObject:GetElapsedTime()
	local var_6_0 = self:GetNodeInstance()

	if var_6_0 then
		return var_6_0.elapsedTime
	end

	return 0
end

function NodeCanvasBaseObject:GetBlackboard()
	local var_7_0 = self:GetNodeInstance()

	if not var_7_0 then
		return nil
	end

	return var_7_0.blackboard
end

function NodeCanvasBaseObject:GetBlackboardVariable(arg_8_1)
	local var_8_0 = self:GetBlackboard()

	if not var_8_0 then
		return nil
	end

	local var_8_1 = self:GetNodeInstance()
	local var_8_2 = var_8_0:GetVariable(arg_8_1)

	return var_8_2 and var_8_2.value
end

function NodeCanvasBaseObject:SetBlackboardVariable(arg_9_1, arg_9_2)
	local var_9_0 = self:GetBlackboard()

	if not var_9_0 then
		return
	end

	var_9_0:SetVariableValue(arg_9_1, arg_9_2)

	return
end

function NodeCanvasBaseObject:AddBlackboardVariable(arg_10_1, arg_10_2)
	local var_10_0 = self:GetBlackboard()

	if not var_10_0 then
		return
	end

	var_10_0:AddVariable(arg_10_1, arg_10_2)

	return
end

function NodeCanvasBaseObject:GetAgent()
	local var_11_0 = self:GetNodeInstance()

	if not var_11_0 then
		return nil
	end

	return var_11_0.agent
end

function NodeCanvasBaseObject:GetComponent(arg_12_1)
	return self:GetAgent():GetComponent(arg_12_1)
end

function NodeCanvasBaseObject:ExistArg(arg_13_1)
	assert(self.args[arg_13_1] ~= nil, "arg is null >>>>" .. arg_13_1)

	return self.args[arg_13_1] ~= nil
end

function NodeCanvasBaseObject:GetArgByName(arg_14_1)
	return self.args[arg_14_1]
end

function NodeCanvasBaseObject:GetStringArg(arg_15_1)
	if not self:ExistArg(arg_15_1) then
		return ""
	end

	return self:GetArgByName(arg_15_1)
end

function NodeCanvasBaseObject:GetFloatArg(arg_16_1)
	if not self:ExistArg(arg_16_1) then
		return 0
	end

	return tonumber((self:GetArgByName(arg_16_1)))
end

function NodeCanvasBaseObject:GetBoolArg(arg_17_1)
	if not self:ExistArg(arg_17_1) then
		return false
	end

	local var_17_0 = self:GetArgByName(arg_17_1)

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

return NodeCanvasBaseObject
