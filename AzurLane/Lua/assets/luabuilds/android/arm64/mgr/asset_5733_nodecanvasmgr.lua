pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.NodeCanvasMgr = var_0_10001("NodeCanvasMgr")

local var_0_1 = var_0.NodeCanvasMgr

function var_0_1.Ctor(arg_1_0)
	arg_1_0:Clear()

	return
end

function var_0_1.Init(arg_2_0, arg_2_1)
	print = var_1_10002

	var_1_10002("initializing NodeCanvas manager...")

	existCall = var_1_10002

	var_1_10002(arg_2_1)

	return
end

function var_0_1.Active(arg_3_0, arg_3_1)
	assert = var_1_10002

	var_1_10002(not arg_3_0.functionDic)

	arg_3_0.functionDic = {}

	if arg_3_1 then
		arg_3_0:SetOwner(arg_3_1)
	end

	return
end

function var_0_1.SetOwner(arg_4_0, arg_4_1)
	GetComponent = var_1_10002
	arg_4_0.mainOwner = var_1_10002(arg_4_1, "GraphOwner")
	GetComponent = var_2
	arg_4_0.mainBlackboard = var_2(arg_4_1, "Blackboard")

	return
end

function var_0_1.SetBlackboradValue(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_3 = arg_5_3 or arg_5_0.mainBlackboard

	if arg_5_2 == nil then
		arg_5_3:RemoveVariable(arg_5_1)
	elseif arg_5_3:GetVariable(arg_5_1) == nil then
		arg_5_3:AddVariable(arg_5_1, arg_5_2)
	else
		arg_5_3:SetVariableValue(arg_5_1, arg_5_2)
	end

	return
end

function var_0_1.GetBlackboradValue(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2 = arg_6_2 or arg_6_0.mainBlackboard

	return arg_6_2:GetVariable(arg_6_1).value
end

function var_0_1.CopyAllBlackBoardValue(arg_7_0, arg_7_1, arg_7_2)
	ReflectionHelp = var_1_10003

	local var_7_0 = var_1_10003.RefGetProperty

	typeof = var_1_10005

	local var_7_1 = var_7_0(var_1_10005("NodeCanvas.Framework.IBlackboard"), "variables", arg_7_1)
	local var_7_2 = var_3.GetEnumerator(var_7_1)

	while var_7_2:MoveNext() do
		local var_7_3 = var_7_2.Current.Key
		local var_7_4 = var_5.Value.value

		type = var_1_10008

		if var_1_10008(var_7_4) == "number" then
			-- block empty
		else
			arg_7_0:SetBlackboradValue(var_7_3, var_7_4, arg_7_2)
		end
	end

	return
end

function var_0_1.SendEvent(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_3 = arg_8_3 or arg_8_0.mainOwner

	if arg_8_2 == nil then
		arg_8_3:SendEvent(arg_8_1)
	else
		arg_8_3:SendEvent(arg_8_1, arg_8_2, nil)
	end

	return
end

function var_0_1.SendGlobalEvent(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.mainOwner.graph

	var_3.SendGlobalEvent(var_9_0, arg_9_1, arg_9_2, nil)

	return
end

function var_0_1.RegisterFunc(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.functionDic[arg_10_1] = arg_10_2

	return
end

function var_0_1.UnregisterFunc(arg_11_0, arg_11_1)
	local var_11_0

	if arg_11_0.functionDic[arg_11_1] then
		var_11_0 = arg_11_0.functionDic
		var_11_0[arg_11_1] = nil
	else
		warning = var_11_0

		var_11_0("NodeCanvasMgr UnregisterFunc not found:" .. arg_11_1)
	end

	return
end

function var_0_1.CallFunc(arg_12_0, arg_12_1, ...)
	assert = var_1_10002

	var_1_10002(arg_12_0.functionDic[arg_12_1], "with out register call:" .. arg_12_1)
	arg_12_0.functionDic[arg_12_1](...)

	return
end

function var_0_1.Clear(arg_13_0)
	arg_13_0.functionDic = nil
	arg_13_0.mainOwner = nil
	arg_13_0.mainBlackboard = nil

	return
end

local function var_0_2(arg_14_0, ...)
	local var_14_0 = var_0.NodeCanvasMgr.GetInstance()

	assert = var_1_10002

	var_1_10002(var_14_0 and var_14_0.functionDic)
	var_14_0:CallFunc(arg_14_0, ...)

	return
end

local var_0_3 = LuaActionTaskCall

return
