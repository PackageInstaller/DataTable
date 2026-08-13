class = var_0_10000

local var_0_0 = "IslandCharacterSystemVO"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandSystemVO"))
local var_0_2 = 0
local var_0_3 = 1

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.isSelf = arg_1_0:IsSelf(arg_1_3)
	arg_1_0.id = arg_1_1
	arg_1_0.name = "_system_" .. arg_1_0.id
	arg_1_0.slotDic = {}

	arg_1_0:InitCfgData(arg_1_0.id)

	pg = var_4
	arg_1_0.config = var_4.island_production_place[arg_1_0.id]
	arg_1_0.behaviourTree = arg_1_0.config.behaviourTree
	arg_1_0.worker = 0
	arg_1_0.productSystem = arg_1_2
	arg_1_0.chickenId = arg_1_2.id % 10 * 100 + 1
	arg_1_0.slotShipUnitDic = {}

	return
end

function var_0_1.IsSelf(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_2_0 = var_1_10002(var_1_10004)

	return var_2.getRawData(var_2_0).id == arg_2_1
end

function var_0_1.GetType(arg_3_0)
	IslandConst = var_1_10001

	return var_1_10001.SYSTEM_TYPE_CHARACTER
end

function var_0_1.InitCfgData(arg_4_0, arg_4_1)
	pg = var_1_10002

	local var_4_0 = var_1_10002.island_production_place[arg_4_1].commission_slot

	ipairs = var_1_10004

	for iter_4_0, iter_4_1 in var_1_10004(var_4_0) do
		pg = var_1_10009
		var_1_10009 = var_1_10009.island_production_commission[iter_4_1]
		arg_4_0.slotDic[var_1_10009.slot] = iter_4_1
	end

	return
end

function var_0_1.GetUnit(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0.slotDic[arg_5_2]

	pg = var_1_10005

	local var_5_1 = var_1_10005.island_production_commission[var_5_0]

	pg = var_1_10006

	if not var_1_10006.island_world_objects[var_5_1.birthplace] then
		return nil
	end

	local var_5_2
	local var_5_3

	if arg_5_0.config.interactionType == var_0_2 and not arg_5_3 then
		local var_5_4 = arg_5_0
		local var_5_5 = arg_5_0.GetObjId(var_5_4, arg_5_2)

		pg = var_10

		local var_5_6 = var_10.island_world_objects[var_5_5]

		IslandCalcUtil = var_5_4

		local var_5_7 = var_5_4.GetRandomPointOnCircle

		BuildVector3 = var_1_10013

		local var_5_8 = var_5_7(var_1_10013(var_5_6.param.position), 2)

		var_5_2 = {
			var_5_8.x,
			var_5_8.y,
			var_5_8.z
		}
	else
		var_5_2 = var_6.param.position
		var_5_3 = var_6.param.rotation
	end

	local var_5_9

	if arg_5_0.isSelf then
		getProxy = var_10
		IslandProxy = var_1_10012
		var_1_10012 = var_10(var_1_10012)

		local var_5_10 = var_10.GetIsland(var_1_10012)
		local var_5_11 = var_10.GetCharacterAgency(var_5_10)

		var_1_10015 = var_11.GetShipById(var_5_11, arg_5_1)
		var_5_9 = var_1_10012.GetModelUnit(var_1_10015)
	else
		pg = var_10
		var_5_9 = var_10.island_chara_template[arg_5_1].unit_id
	end

	local var_5_12

	if arg_5_1 ~= 1 or not arg_5_0.config.chickenbehaviourTree then
		var_5_12 = arg_5_0.config.npcbehaviourTree
	end

	local var_5_13 = false

	if arg_5_1 == 1 then
		arg_5_0.chickenId = arg_5_0.chickenId + 1
		arg_5_1 = arg_5_0.chickenId
		var_1_10012 = arg_5_0.slotShipUnitDic
		var_1_10012[arg_5_2] = arg_5_1
		var_5_13 = true
	end

	IslandDelegateUnitVO = var_1_10012

	local var_5_14 = var_1_10012.New
	local var_5_15 = {
		id = arg_5_1,
		isChicken = var_5_13,
		modelId = var_5_9
	}

	IslandConst = var_1_10015
	var_5_15.type = var_1_10015.UNIT_TYPE_SYSTEM_DELEAGTION
	var_5_15.name = "system_unit" .. arg_5_1
	var_5_15.position = var_5_2

	local var_5_16

	if not var_5_3 then
		::label_5_0::

		Vector3 = var_5_16
		var_5_16 = var_5_16.zero
	end

	var_5_15.rotation = var_5_16
	Vector3 = var_5_16
	var_5_15.scale = var_5_16.one
	var_5_15.behaviourTree = var_5_12

	return var_5_14(var_5_15)
end

function var_0_1.GetUnitShipIdBySlotId(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 1 then
		return arg_6_0.slotShipUnitDic[arg_6_2]
	end

	return arg_6_1
end

function var_0_1.GetObjId(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.slotDic[arg_7_1]

	pg = var_1_10003

	return var_1_10003.island_production_commission[var_7_0].performanceObjid
end

function var_0_1.GetperformanceObjidList(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = {}

	IslandProductConst = var_1_10004
	var_8_1[1] = var_1_10004.FarmlandPlaceId
	IslandProductConst = var_4
	var_8_1[2] = var_4.OrchardPlaceId
	IslandProductConst = var_4
	var_8_1[3] = var_4.GardenPlaceId

	local var_8_2 = {}

	IslandProductConst = var_1_10005
	var_8_2[1] = var_1_10005.MinePlaceId
	IslandProductConst = var_5
	var_8_2[2] = var_5.FellingPlaceId
	IslandProductConst = var_5
	var_8_2[3] = var_5.TechnologyPlaceId
	IslandProductConst = var_5
	var_8_2[4] = var_5.FisheryPlaceId
	table = var_5

	local var_8_3

	if var_5.contains(var_8_1, arg_8_0.id) then
		pg = var_8_3
		var_8_3 = var_8_3.island_production_slot[arg_8_1]
		ipairs = var_1_10006

		for iter_8_0, iter_8_1 in var_1_10006(var_8_3.exclusion_slot) do
			var_1_10013 = arg_8_0.productSystem
			var_1_10011 = var_1_10011.GetUnitIdBySlotId(var_1_10013, iter_8_1)

			local var_8_4 = {
				unitId = var_1_10011
			}

			IslandConst = var_1_10013
			var_8_4.unitType = var_1_10013.UNIT_LIST_OBJ
			table = var_1_10013

			var_1_10013.insert(var_8_0, var_8_4)
		end
	else
		table = var_8_3

		if var_8_3.contains(var_8_2, arg_8_0.id) then
			local var_8_5 = arg_8_0.slotDic[arg_8_1]

			pg = var_1_10006
			var_1_10006 = var_1_10006.island_production_commission[var_8_5]

			local var_8_6 = {
				unitId = var_1_10006.performanceObjid
			}

			IslandConst = var_8
			var_8_6.unitType = var_8.UNIT_LIST_OBJ
			table = var_8

			var_8.insert(var_8_0, var_8_6)
		else
			local var_8_7 = arg_8_0.id

			IslandProductConst = var_1_10006

			if var_8_7 == var_1_10006.PasturePlaceId then
				pg = var_8_7

				local var_8_8 = var_8_7.island_production_slot[arg_8_1]

				ipairs = var_6

				for iter_8_2, iter_8_3 in var_6(var_8_8.animal) do
					pg = var_1_10011
					var_1_10011 = var_1_10011.island_ranch_animal[iter_8_3]

					local var_8_9 = {
						unitId = iter_8_3
					}

					IslandConst = var_1_10013
					var_8_9.unitType = var_1_10013.UNIT_LIST_DELEGATION_ANIMATION
					table = var_1_10013

					var_1_10013.insert(var_8_0, var_8_9)
				end
			end
		end
	end

	return var_8_0
end

function var_0_1.SetWorkerCnt(arg_9_0, arg_9_1)
	arg_9_0.worker = arg_9_1

	return
end

function var_0_1.GetWorkerCnt(arg_10_0)
	return arg_10_0.worker
end

function var_0_1.SetkCurrentWorkerList(arg_11_0, arg_11_1)
	arg_11_0.workerList = arg_11_1

	return
end

function var_0_1.GetWorkerList(arg_12_0)
	return arg_12_0.workerList
end

function var_0_1.GetBehaviourTree(arg_13_0)
	if arg_13_0.behaviourTree == "" then
		return nil
	end

	return arg_13_0.behaviourTree
end

return var_0_1
