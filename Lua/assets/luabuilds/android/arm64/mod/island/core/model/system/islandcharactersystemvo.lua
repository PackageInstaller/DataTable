local var_0_0 = class("IslandCharacterSystemVO", import(".IslandSystemVO"))
local var_0_1 = 0

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.isSelf = arg_1_0:IsSelf(arg_1_3)
	arg_1_0.id = arg_1_1
	arg_1_0.name = "_system_" .. arg_1_0.id
	arg_1_0.slotDic = {}

	arg_1_0:InitCfgData(arg_1_0.id)

	arg_1_0.config = pg.island_production_place[arg_1_0.id]
	arg_1_0.behaviourTree = arg_1_0.config.behaviourTree
	arg_1_0.worker = 0
	arg_1_0.productSystem = arg_1_2
	arg_1_0.chickenId = arg_1_2.id % 10 * 100 + 1
	arg_1_0.slotShipUnitDic = {}

	return
end

function var_0_0.IsSelf(arg_2_0, arg_2_1)
	local var_2_0 = getProxy(PlayerProxy)

	return var_2_0:getRawData().id == arg_2_1
end

function var_0_0.GetType(arg_3_0)
	return IslandConst.SYSTEM_TYPE_CHARACTER
end

function var_0_0.InitCfgData(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(pg.island_production_place[arg_4_1].commission_slot) do
		arg_4_0.slotDic[pg.island_production_commission[iter_4_1].slot] = iter_4_1
	end

	return
end

function var_0_0.GetUnit(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_9000

	if not pg.island_world_objects[pg.island_production_commission[arg_5_0.slotDic[arg_5_2]].birthplace] then
		return nil
	end

	local var_5_0
	local var_5_1

	if arg_5_0.config.interactionType == var_0_1 and not arg_5_3 then
		local var_5_2 = IslandCalcUtil.GetRandomPointOnCircle(BuildVector3(pg.island_world_objects[arg_5_0:GetObjId(arg_5_2)].param.position), 2)

		var_5_0 = {
			var_5_2.x,
			var_5_2.y,
			var_5_2.z
		}
	else
		var_5_0 = pg.island_world_objects[pg.island_production_commission[arg_5_0.slotDic[arg_5_2]].birthplace].param.position
		var_5_1 = pg.island_world_objects[pg.island_production_commission[arg_5_0.slotDic[arg_5_2]].birthplace].param.rotation
	end

	local var_5_3

	if arg_5_0.isSelf then
		local var_5_4 = getProxy(IslandProxy)

		var_5_3 = var_5_4.GetIsland(var_5_9000):GetCharacterAgency():GetShipById(arg_5_1).GetModelUnit(var_5_4)
	else
		var_5_3 = pg.island_chara_template[arg_5_1].unit_id
	end

	if arg_5_1 == 1 then
		local var_5_5 = arg_5_0.config.chickenbehaviourTree or arg_5_0.config.npcbehaviourTree
		local var_5_6 = false

		if arg_5_1 == 1 then
			arg_5_0.chickenId = arg_5_0.chickenId + 1
			arg_5_1 = arg_5_0.chickenId
			arg_5_0.slotShipUnitDic[arg_5_2] = arg_5_0.chickenId
			var_5_6 = true
		end

		return IslandDelegateUnitVO.New({
			id = arg_5_1,
			isChicken = var_5_6,
			modelId = var_5_3,
			type = IslandConst.UNIT_TYPE_SYSTEM_DELEAGTION,
			name = "system_unit" .. arg_5_1,
			position = var_5_0,
			rotation = var_5_1 or Vector3.zero,
			scale = Vector3.one,
			behaviourTree = var_5_5
		})
	end
end

function var_0_0.GetUnitShipIdBySlotId(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 1 then
		return arg_6_0.slotShipUnitDic[arg_6_2]
	end

	return arg_6_1
end

function var_0_0.GetObjId(arg_7_0, arg_7_1)
	return pg.island_production_commission[arg_7_0.slotDic[arg_7_1]].performanceObjid
end

function var_0_0.GetperformanceObjidList(arg_8_0, arg_8_1)
	if table.contains({
		IslandProductConst.FarmlandPlaceId,
		IslandProductConst.OrchardPlaceId,
		IslandProductConst.GardenPlaceId
	}, arg_8_0.id) then
		for iter_8_0, iter_8_1 in ipairs(pg.island_production_slot[arg_8_1].exclusion_slot) do
			table.insert({}, {
				unitId = arg_8_0.productSystem:GetUnitIdBySlotId(iter_8_1),
				unitType = IslandConst.UNIT_LIST_OBJ
			})
		end
	elseif table.contains({
		IslandProductConst.MinePlaceId,
		IslandProductConst.FellingPlaceId,
		IslandProductConst.TechnologyPlaceId,
		IslandProductConst.FisheryPlaceId
	}, arg_8_0.id) then
		table.insert({}, {
			unitId = pg.island_production_commission[arg_8_0.slotDic[arg_8_1]].performanceObjid,
			unitType = IslandConst.UNIT_LIST_OBJ
		})
	elseif arg_8_0.id == IslandProductConst.PasturePlaceId then
		for iter_8_2, iter_8_3 in ipairs(pg.island_production_slot[arg_8_1].animal) do
			table.insert({}, {
				unitId = iter_8_3,
				unitType = IslandConst.UNIT_LIST_DELEGATION_ANIMATION
			})
		end
	end

	return {}
end

function var_0_0.SetWorkerCnt(arg_9_0, arg_9_1)
	arg_9_0.worker = arg_9_1

	return
end

function var_0_0.GetWorkerCnt(arg_10_0)
	return arg_10_0.worker
end

function var_0_0.SetkCurrentWorkerList(arg_11_0, arg_11_1)
	arg_11_0.workerList = arg_11_1

	return
end

function var_0_0.GetWorkerList(arg_12_0)
	return arg_12_0.workerList
end

function var_0_0.GetBehaviourTree(arg_13_0)
	if arg_13_0.behaviourTree == "" then
		return nil
	end

	return arg_13_0.behaviourTree
end

return var_0_0
