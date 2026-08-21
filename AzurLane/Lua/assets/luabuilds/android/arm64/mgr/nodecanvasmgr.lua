pg = pg or {}

local var_0_0 = pg

pg.NodeCanvasMgr = singletonClass("NodeCanvasMgr")

function pg.NodeCanvasMgr.Ctor(arg_1_0)
	arg_1_0:Clear()

	return
end

function pg.NodeCanvasMgr.Init(arg_2_0, arg_2_1)
	print("initializing NodeCanvas manager...")
	existCall(arg_2_1)

	return
end

function pg.NodeCanvasMgr.Active(arg_3_0, arg_3_1)
	assert(not arg_3_0.functionDic)

	arg_3_0.functionDic = {}

	if arg_3_1 then
		arg_3_0:SetOwner(arg_3_1)
	end

	return
end

function pg.NodeCanvasMgr.SetOwner(arg_4_0, arg_4_1)
	arg_4_0.mainOwner = GetComponent(arg_4_1, "GraphOwner")
	arg_4_0.mainBlackboard = GetComponent(arg_4_1, "Blackboard")

	return
end

function pg.NodeCanvasMgr.SetBlackboradValue(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
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

function pg.NodeCanvasMgr.GetBlackboradValue(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2 = arg_6_2 or arg_6_0.mainBlackboard

	return arg_6_2:GetVariable(arg_6_1).value
end

function pg.NodeCanvasMgr.CopyAllBlackBoardValue(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = ReflectionHelp.RefGetProperty(typeof("NodeCanvas.Framework.IBlackboard"), "variables", arg_7_1):GetEnumerator()

	while var_7_0:MoveNext() do
		if type(var_7_0.Current.Value.value) == "number" then
			-- block empty
		else
			arg_7_0:SetBlackboradValue(var_7_0.Current.Key, var_7_0.Current.Value.value, arg_7_2)
		end
	end

	return
end

function pg.NodeCanvasMgr.SendEvent(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_3 = arg_8_3 or arg_8_0.mainOwner

	if arg_8_2 == nil then
		arg_8_3:SendEvent(arg_8_1)
	else
		arg_8_3:SendEvent(arg_8_1, arg_8_2, nil)
	end

	return
end

function pg.NodeCanvasMgr.SendGlobalEvent(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.mainOwner.graph:SendGlobalEvent(arg_9_1, arg_9_2, nil)

	return
end

function pg.NodeCanvasMgr.RegisterFunc(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.functionDic[arg_10_1] = arg_10_2

	return
end

function pg.NodeCanvasMgr.UnregisterFunc(arg_11_0, arg_11_1)
	if arg_11_0.functionDic[arg_11_1] then
		arg_11_0.functionDic[arg_11_1] = nil
	else
		warning("NodeCanvasMgr UnregisterFunc not found:" .. arg_11_1)
	end

	return
end

function pg.NodeCanvasMgr.CallFunc(arg_12_0, arg_12_1, ...)
	assert(arg_12_0.functionDic[arg_12_1], "with out register call:" .. arg_12_1)
	arg_12_0.functionDic[arg_12_1](...)

	return
end

function pg.NodeCanvasMgr.Clear(arg_13_0)
	arg_13_0.functionDic = nil
	arg_13_0.mainOwner = nil
	arg_13_0.mainBlackboard = nil

	return
end

function LuaActionTaskCall(arg_14_0, ...)
	local var_14_0 = var_0_0.NodeCanvasMgr.GetInstance()

	assert(var_14_0 and var_14_0.functionDic)
	var_14_0:CallFunc(arg_14_0, ...)

	return
end

return
