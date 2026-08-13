class = var_0_10000

local var_0_0 = "IslandSeekGameSystem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.Core.View.SceneObject.IslandSceneUnit"))

function var_0_1.OnSceneInitEnd(arg_1_0)
	local var_1_0 = arg_1_0.data

	arg_1_0.MONITOR_LIST = var_1.GetInteractiveObjects(var_1_0)
	ipairs = var_1

	for iter_1_0, iter_1_1 in var_1(arg_1_0:GetObjUnitList()) do
		if iter_1_1.behaviourTreeOwner then
			LuaHelper = var_6

			var_6.NodeCanvasSetIntVariableValue(iter_1_1.behaviourTreeOwner, "systemId", arg_1_0.id)
		end
	end

	if arg_1_0.behaviourTreeOwner then
		LuaHelper = var_1

		var_1.NodeCanvasSetIntVariableValue(arg_1_0.behaviourTreeOwner, "step", 0)
	end

	arg_1_0:Start()

	return
end

function var_0_1.StartGame(arg_2_0)
	ipairs = var_1_10001

	for iter_2_0, iter_2_1 in var_1_10001(arg_2_0:GetObjUnitList()) do
		iter_2_1:Start()
	end

	return
end

function var_0_1.OnLateUpdate(arg_3_0)
	return
end

function var_0_1.StopGame(arg_4_0)
	if arg_4_0.behaviourTreeOwner then
		arg_4_0:StopBt()
	end

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.GetObjUnitList(var_4_0)

	ipairs = var_4_0

	for iter_4_0, iter_4_1 in var_4_0(var_4_1) do
		table = var_1_10007

		if var_1_10007.contains(arg_4_0.MONITOR_LIST, iter_4_1.id) then
			iter_4_1:StopBt()
		end
	end

	return
end

function var_0_1.RestartGame(arg_5_0)
	ipairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0:GetObjUnitList()) do
		if iter_5_1.behaviourTreeOwner then
			LuaHelper = var_6

			var_6.NodeCanvasSetIntVariableValue(iter_5_1.behaviourTreeOwner, "step", 0)
		end

		iter_5_1:RestartBt()
	end

	if arg_5_0.behaviourTreeOwner then
		LuaHelper = var_1

		var_1.NodeCanvasSetIntVariableValue(arg_5_0.behaviourTreeOwner, "step", 0)
		arg_5_0:RestartBt()
	end

	return
end

function var_0_1.GetObjUnitList(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = arg_6_0:GetView()
	local var_6_2 = var_2.GetUnitListByKey

	IslandConst = var_1_10004

	local var_6_3 = var_6_2(var_6_1, var_1_10004.UNIT_LIST_OBJ)

	ipairs = var_6_1

	for iter_6_0, iter_6_1 in var_6_1(var_6_3) do
		table = var_1_10008

		var_1_10008.insert(var_6_0, iter_6_1)
	end

	table = var_3

	var_3.insert(var_6_0, arg_6_0:GetView().player)

	return var_6_0
end

function var_0_1.GetUnitById(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:GetView()

	return var_2.GetUnitModule(var_7_0, arg_7_1)
end

return var_0_1
