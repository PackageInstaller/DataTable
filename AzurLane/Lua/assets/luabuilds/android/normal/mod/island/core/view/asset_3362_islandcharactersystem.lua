class = var_0_10000

local var_0_0 = "IslandCharacterSystem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.Core.View.SceneObject.IslandSceneUnit"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.scheduleList = {}

	local var_1_0 = arg_1_0.data

	arg_1_0.workerCnt = var_3.GetWorkerCnt(var_1_0)

	return
end

function var_0_1.OnStart(arg_2_0)
	if arg_2_0.behaviourTreeOwner then
		LuaHelper = var_1

		var_1.NodeCanvasSetIntVariableValue(arg_2_0.behaviourTreeOwner, "worker", arg_2_0.workerCnt)

		local var_2_0 = {}

		IslandProductConst = var_2
		var_2_0[1] = var_2.FarmlandPlaceId
		IslandProductConst = var_2
		var_2_0[2] = var_2.OrchardPlaceId
		IslandProductConst = var_2
		var_2_0[3] = var_2.GardenPlaceId

		local var_2_1 = arg_2_0.data
		local var_2_2

		if not var_2.GetWorkerList(var_2_1) then
			var_2_2 = {}
		end

		local var_2_3 = arg_2_0.data.id

		IslandProductConst = var_4

		if var_2_3 == var_4.MinePlaceId then
			return
		end

		ipairs = var_2_3

		for iter_2_0, iter_2_1 in var_2_3(var_2_2) do
			table = var_1_10008
			iter_2_1.nextIn = var_1_10008.contains(var_2_0, arg_2_0.data.id)

			arg_2_0:StartDelegation(iter_2_1)
		end
	end

	return
end

function var_0_1.StartDelegation(arg_3_0, arg_3_1)
	if not arg_3_0.behaviourTreeOwner then
		return
	end

	table = var_2

	var_2.insert(arg_3_0.scheduleList, arg_3_1)

	return
end

function var_0_1.ExecuteDelegation(arg_4_0, arg_4_1)
	arg_4_0.workerCnt = arg_4_0.workerCnt + 1

	local var_4_0 = arg_4_0.data
	local var_4_1 = var_2.GetUnitShipIdBySlotId(var_4_0, arg_4_1.ship_id, arg_4_1.area_id)
	local var_4_2 = arg_4_0:GetView()
	local var_4_3 = var_3.GetSystemUnitModule(var_4_2, var_4_1)
	local var_4_4 = arg_4_0.data
	local var_4_5 = var_4.GetperformanceObjidList(var_4_4, arg_4_1.area_id)

	System = var_4_4

	local var_4_6 = var_4_4.Collections.Generic.List_IslandUnitNode()
	local var_4_7

	if var_4_3 then
		IslandUnitNode = var_4_7
		var_4_7 = var_4_7.New()
		var_4_7.unitId = var_4_1
		IslandConst = var_1_10007
		var_4_7.unitType = var_1_10007.UNIT_LIST_DELEGATION

		var_4_6:Add(var_4_7)
	end

	ipairs = var_4_7

	for iter_4_0, iter_4_1 in var_4_7(var_4_5) do
		IslandUnitNode = var_1_10011
		var_1_10011 = var_1_10011.New()
		var_1_10011.unitId = iter_4_1.unitId
		var_1_10011.unitType = iter_4_1.unitType

		var_4_6:Add(var_1_10011)
	end

	if arg_4_1.nextIn then
		local var_4_8 = arg_4_0.behaviourTreeOwner

		var_6.SendEvent(var_4_8, "system_unit_add_nextIn", var_4_6, nil)
	else
		local var_4_9 = arg_4_0.behaviourTreeOwner

		var_6.SendEvent(var_4_9, "system_unit_add", var_4_6, nil)
	end

	return
end

function var_0_1.EndDelegation(arg_5_0, arg_5_1)
	if not arg_5_0.behaviourTreeOwner then
		return
	end

	arg_5_0.workerCnt = arg_5_0.workerCnt - 1
	LuaHelper = var_2

	var_2.NodeCanvasSetIntVariableValue(arg_5_0.behaviourTreeOwner, "worker", arg_5_0.workerCnt)

	IslandUnitNode = var_2

	local var_5_0 = var_2.New()

	var_5_0.unitId = arg_5_1.ship_id
	IslandConst = var_3
	var_5_0.unitType = var_3.UNIT_LIST_DELEGATION

	local var_5_1 = arg_5_0.behaviourTreeOwner

	var_3.SendEvent(var_5_1, "system_unit_remove", var_5_0, nil)

	return
end

function var_0_1.OnUpdate(arg_6_0)
	if #arg_6_0.scheduleList <= 0 then
		return
	end

	local var_6_0 = arg_6_0:GetView()

	if not var_1.IsLoaded(var_6_0) then
		return
	end

	local var_6_1 = arg_6_0._go
	local var_6_2 = var_1.GetComponent

	typeof = var_1_10003
	ParadoxNotion = var_1_10004

	if not var_6_2(var_6_1, var_1_10003(var_1_10004.Services.EventRouter)) then
		return
	end

	table = var_6_1

	local var_6_3 = var_6_1.remove(arg_6_0.scheduleList, 1)

	arg_6_0:ExecuteDelegation(var_6_3)

	return
end

function var_0_1.OnDestroy(arg_7_0)
	table = var_1_10001

	var_1_10001.clear(arg_7_0.scheduleList)

	return
end

return var_0_1
