class = var_0_10000

local var_0_0 = "IslandProductSystemVO"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandSystemVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.isSelf = arg_1_0:IsSelf(arg_1_3)
	arg_1_0.productPlaceId = arg_1_1
	arg_1_0.building = arg_1_2
	arg_1_0.unitDic = {}
	arg_1_0.delegateSlotUnits = {}
	arg_1_0.delegateUnitsId = 1
	arg_1_0.commissionEffectDic = {}

	arg_1_0:InitCfgData()

	return
end

function var_0_1.GetType(arg_2_0)
	IslandConst = var_1_10001

	return var_1_10001.SYSTEM_TYPE_PRODUCT
end

function var_0_1.GetBehaviourTree(arg_3_0)
	return nil
end

function var_0_1.IsSelf(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_4_0 = var_1_10002(var_1_10003)

	return var_2.getRawData(var_4_0).id == arg_4_1
end

function var_0_1.InitCfgData(arg_5_0)
	arg_5_0.slotToUnitDic = {}

	arg_5_0:InitCommissionCfgData()
	arg_5_0:InitHandPlantCfg()
	arg_5_0:InitHandCollectCfg()
	arg_5_0:InitCommissionEffectCfg()

	return
end

function var_0_1.InitCommissionEffectCfg(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.island_set.island_fishery_bubble_vfx

	ipairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(var_6_0.key_value_varchar) do
		arg_6_0.commissionEffectDic[iter_6_1[1]] = iter_6_1[2]
	end

	return
end

function var_0_1.InitHandPlantCfg(arg_7_0)
	local var_7_0 = {}

	IslandProductConst = var_1_10002
	var_7_0[1] = var_1_10002.FarmlandPlaceId
	IslandProductConst = var_2
	var_7_0[2] = var_2.OrchardPlaceId
	IslandProductConst = var_2
	var_7_0[3] = var_2.GardenPlaceId
	table = var_2

	if not var_2.contains(var_7_0, arg_7_0.productPlaceId) then
		return
	end

	arg_7_0.workUnitDic = {}
	ipairs = var_2
	pg = var_3

	local var_7_1

	if not var_3.island_production_farm.get_id_list_by_place_id[arg_7_0.productPlaceId] then
		var_7_1 = {}
	end

	for iter_7_0, iter_7_1 in var_2(var_7_1) do
		pg = var_1_10007

		local var_7_2 = var_1_10007.island_production_farm[iter_7_1].objId
		local var_7_3 = var_1_10007.slotId

		arg_7_0.slotToUnitDic[var_7_3] = var_7_2

		if not arg_7_0.workUnitDic[var_7_2] then
			arg_7_0.workUnitDic[var_7_2] = {}
			arg_7_0.workUnitDic[var_7_2].idle_unit = var_1_10007.idle_unit
			arg_7_0.workUnitDic[var_7_2].work_unit = var_1_10007.work_unit
		end
	end

	return
end

function var_0_1.InitHandCollectCfg(arg_8_0)
	ipairs = var_1_10001
	pg = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10001(var_1_10002.island_production_mining.all) do
		pg = var_1_10006
		var_1_10006 = var_1_10006.island_production_mining[iter_8_1]

		if not arg_8_0.slotToUnitDic[var_1_10006.slotId] then
			arg_8_0.slotToUnitDic[var_1_10006.slotId] = var_1_10006.objId
		end
	end

	return
end

function var_0_1.GetUnitDatas(arg_9_0)
	local var_9_0 = {}

	arg_9_0:GenHandCollectSlot(var_9_0)
	arg_9_0:GenHandPlantSlot(var_9_0)
	arg_9_0:GenAnimalBySlot(var_9_0)
	arg_9_0:GenPlaceModelUnit(var_9_0)
	arg_9_0:GenPlaceSlotModelUnit(var_9_0)

	return var_9_0
end

function var_0_1.GenPlaceSlotModelUnit(arg_10_0, arg_10_1)
	local var_10_0 = {}

	IslandProductConst = var_1_10003
	var_10_0[1] = var_1_10003.FisheryPlaceId
	table = var_3

	if not var_3.contains(var_10_0, arg_10_0.productPlaceId) then
		return
	end

	pg = var_3

	local var_10_1

	if not var_3.island_production_slot.get_id_list_by_place[arg_10_0.productPlaceId] then
		var_10_1 = {}
	end

	ipairs = var_4

	for iter_10_0, iter_10_1 in var_4(var_10_1) do
		pg = var_1_10009

		if var_1_10009.island_production_slot[iter_10_1].type == 9 then
			local var_10_2 = arg_10_0
			local var_10_3 = arg_10_0.GetCommissionSlotId(var_10_2, iter_10_1)

			pg = var_10_2

			if var_10_2.island_production_commission[var_10_3].unlockObjid ~= 0 then
				if arg_10_0.building ~= nil then
					var_1_10014 = arg_10_0.building

					if var_13.GetDelegationSlotData(var_1_10014, iter_10_1) == nil then
						pg = var_13

						local var_10_4 = var_13.island_world_objects[var_12]

						IslandDataConvertor = var_1_10014
						var_1_10014 = var_1_10014.WorldObj2IslandUnit(var_10_4)
						table = var_15

						var_15.insert(arg_10_1, var_1_10014)
					end
				end
			end
		end
	end

	return
end

function var_0_1.GenPlaceModelUnit(arg_11_0, arg_11_1)
	table = var_1_10002

	local var_11_0 = var_1_10002.contains

	IslandProductConst = var_1_10003

	if not var_11_0(var_1_10003.haveModelPlaces, arg_11_0.productPlaceId) then
		return
	end

	local var_11_1 = arg_11_0.building ~= nil
	local var_11_2 = arg_11_0
	local var_11_3 = arg_11_0.GetPlaceModelUnit(var_11_2, var_11_1)

	table = var_11_2

	var_11_2.insert(arg_11_1, var_11_3)

	return
end

function var_0_1.GetPlaceModelId(arg_12_0, arg_12_1)
	if arg_12_1 then
		pg = var_1_10002

		return var_1_10002.island_production_place[arg_12_0.productPlaceId].unlocked_obj
	else
		pg = var_1_10002

		return var_1_10002.island_production_place[arg_12_0.productPlaceId].locked_obj
	end

	return
end

function var_0_1.GetPlaceModelUnit(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.GetPlaceModelId(var_13_0, arg_13_1)

	pg = var_13_0

	local var_13_2 = var_13_0.island_world_objects[var_13_1]

	IslandDataConvertor = var_4

	return var_4.WorldObj2IslandUnit(var_13_2)
end

function var_0_1.InitCommissionCfgData(arg_14_0)
	arg_14_0.slotCommissionDic = {}
	pg = var_1

	local var_14_0 = var_1.island_production_place[arg_14_0.productPlaceId].commission_slot

	ipairs = var_1_10003

	for iter_14_0, iter_14_1 in var_1_10003(var_14_0) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.island_production_commission[iter_14_1]
		arg_14_0.slotCommissionDic[var_1_10008.slot] = iter_14_1
	end

	return
end

function var_0_1.GetCommissionSlotId(arg_15_0, arg_15_1)
	return arg_15_0.slotCommissionDic[arg_15_1]
end

function var_0_1.GenHandCollectSlot(arg_16_0, arg_16_1)
	if not arg_16_0.building or not arg_16_0.isSelf then
		return
	end

	arg_16_0:GenHandCollectSlotInSlotPlace(arg_16_1)

	return
end

function var_0_1.GenHandCollectSlotInSlotPlace(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.building

	if not var_2.GetBuildingCollectData(var_17_0) then
		return
	end

	local var_17_1 = var_2
	local var_17_2 = var_2.GetCollectSlotDatasDic(var_17_1)

	pairs = var_17_1

	for iter_17_0, iter_17_1 in var_17_1(var_17_2) do
		local var_17_3 = arg_17_0

		if arg_17_0.GenHandCollectSlotByDataNew(var_17_3, iter_17_1) then
			table = var_17_3

			var_17_3.insert(arg_17_1, var_9)
		end
	end

	return
end

function var_0_1.GetHandCollectSlotBySlotId(arg_18_0, arg_18_1)
	if not arg_18_0.building then
		if arg_18_0.isSelf then
			getProxy = var_18_1
			IslandProxy = var_1_10004
			var_1_10004 = var_18_1(var_1_10004)

			local var_18_1

			if not var_18_1.GetIsland(var_1_10004) then
				getProxy = var_18_1
				IslandProxy = var_1_10004

				local var_18_0 = var_18_1(var_1_10004)

				var_18_1 = var_18_1.GetSharedIsland(var_18_0)
			end

			local var_18_2 = var_18_1:GetBuildingAgency()
			local var_18_3 = var_4.GetBuilding(var_18_2, arg_18_0.productPlaceId)
			local var_18_4 = var_18_3:GetBuildingCollectData()
			local var_18_5 = var_3.GetCollectSlotData(var_18_4, arg_18_1)

			return arg_18_0.slotToUnitDic[var_18_5.configId]
		end
	end
end

function var_0_1.GenHandCollectSlotByDataNew(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.productPlaceId

	IslandProductConst = var_1_10003

	local var_19_1 = var_19_0 == var_1_10003.FellingPlaceId
	local var_19_2 = arg_19_0.slotToUnitDic[arg_19_1.configId]

	pg = var_4

	local var_19_3 = var_4.island_production_slot[arg_19_1.configId].formula[1]

	pg = var_5

	local var_19_4 = var_5.island_formula[var_19_3].unitid[1][2]

	if arg_19_1:GetCanCollectTimeStamps() == 0 or var_19_1 then
		local var_19_5 = {
			unitId = var_19_4
		}

		IslandConst = var_1_10009
		var_19_5.typ = var_1_10009.UNIT_TYPE_ITEM_HANDLE_COLLECT
		var_19_5.slotId = arg_19_1.configId
		pg = var_9

		local var_19_6

		if not var_9.island_world_objects[var_19_2] then
			var_19_6 = {}
		end

		return (arg_19_0:CollectSlotObj2IslandUnit(var_19_6, var_19_5))
	end

	return
end

function var_0_1.InitHandCollectSlotBySlotId(arg_20_0, arg_20_1)
	if not arg_20_0.building then
		if arg_20_0.isSelf then
			getProxy = var_20_1
			IslandProxy = var_1_10004
			var_1_10004 = var_20_1(var_1_10004)

			local var_20_1

			if not var_20_1.GetIsland(var_1_10004) then
				getProxy = var_20_1
				IslandProxy = var_1_10004

				local var_20_0 = var_20_1(var_1_10004)

				var_20_1 = var_20_1.GetSharedIsland(var_20_0)
			end

			local var_20_2 = var_20_1:GetBuildingAgency()
			local var_20_3 = var_4.GetBuilding(var_20_2, arg_20_0.productPlaceId)
			local var_20_4 = var_20_3:GetCollectSlotData(arg_20_1)

			return arg_20_0:GenHandCollectSlotByDataNew(var_20_4)
		end
	end
end

function var_0_1.GenHandPlantSlot(arg_21_0, arg_21_1)
	ipairs = var_1_10002
	pg = var_1_10003

	local var_21_0

	if not var_1_10003.island_production_farm.get_id_list_by_place_id[arg_21_0.productPlaceId] then
		var_21_0 = {}
	end

	for iter_21_0, iter_21_1 in var_1_10002(var_21_0) do
		pg = var_1_10007

		local var_21_1 = var_1_10007.island_production_farm[iter_21_1].objId
		local var_21_2 = var_1_10007.slotId
		local var_21_3 = var_1_10007.unlock_unit

		IslandProductConst = var_1_10011
		var_1_10011 = var_1_10011.ProductSlotType.HandPlant

		local var_21_4

		if arg_21_0.building and arg_21_0.building.handSlotData[var_21_2] then
			var_21_3 = var_1_10007.idle_unit
			var_21_4 = var_13:GetPlantFormulaId() or nil

			if var_21_4 then
				var_21_3 = var_1_10007.work_unit
			else
				pg = var_1_10014
				var_1_10014 = var_1_10014.island_production_slot[var_21_2].exclusion_slot[1]

				local var_21_5 = arg_21_0.building

				if var_15.GetDelegationSlotData(var_21_5, var_1_10014) then
					local var_21_6 = var_15

					if not var_15.CanStartDelegation(var_21_6) then
						var_21_3 = var_1_10007.work_unit
						IslandProductConst = var_21_6
						var_1_10011 = var_21_6.ProductSlotType.RoleDelegation
						var_21_4 = var_15:GetFormulaId()
					end
				end
			end
		end

		local var_21_7 = {
			unitId = var_21_3
		}

		IslandConst = var_1_10014
		var_21_7.typ = var_1_10014.UNIT_TYPE_ITEM_HANDLE_PLANTING
		var_21_7.formula_id = var_21_4
		var_21_7.slotId = var_21_2
		var_21_7.slotType = var_1_10011
		pg = var_1_10014

		if not var_1_10014.island_world_objects[var_21_1] then
			var_1_10014 = {}
		end

		local var_21_8 = arg_21_0
		local var_21_9 = arg_21_0.ProductSlotObj2IslandUnit(var_21_8, var_1_10014, var_21_7)

		table = var_21_8

		var_21_8.insert(arg_21_1, var_21_9)
	end

	return
end

function var_0_1.GenAnimalBySlot(arg_22_0, arg_22_1)
	if not arg_22_0.building then
		return
	end

	local var_22_0 = arg_22_0.productPlaceId

	IslandProductConst = var_1_10003

	if var_22_0 ~= var_1_10003.PasturePlaceId then
		return
	end

	pairs = var_22_0

	local var_22_1 = arg_22_0.building

	for iter_22_0, iter_22_1 in var_22_0(var_3.GetDelegationSlotDatas(var_22_1)) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.island_production_slot[iter_22_0]

		local var_22_2 = arg_22_0
		local var_22_3 = arg_22_0.GetCommissionSlotId(var_22_2, iter_22_0)

		pg = var_22_2

		local var_22_4 = var_22_2.island_production_commission[var_22_3]

		ipairs = var_10

		for iter_22_2, iter_22_3 in var_10(iter_22_1:GetPartList()) do
			pg = var_1_10015
			var_1_10015 = var_1_10015.island_ranch_animal[iter_22_3]
			pg = var_1_10016

			if not var_1_10016.island_world_objects[var_22_4.birthplace] then
				var_1_10016 = {}
			end

			IslandCalcUtil = var_17

			local var_22_5 = var_17.GetRandomPointOnCircle

			BuildVector3 = var_1_10018

			local var_22_6 = var_22_5(var_1_10018(var_1_10016.param.position), 5)
			local var_22_7 = {
				var_22_6.x,
				var_22_6.y,
				var_22_6.z
			}
			local var_22_8 = arg_22_0

			var_1_10018 = arg_22_0.ProductAniObj2IslandUnit(var_22_8, var_1_10015, var_22_7)
			table = var_22_8

			var_22_8.insert(arg_22_1, var_1_10018)
		end
	end

	return
end

function var_0_1.GenAnimalByAnialConfig(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0
	local var_23_1 = arg_23_0.GetCommissionSlotId(var_23_0, arg_23_2)

	pg = var_23_0

	local var_23_2 = var_23_0.island_production_commission[var_23_1]

	pg = var_5

	local var_23_3 = var_5.island_ranch_animal[arg_23_1]

	pg = var_1_10006

	local var_23_4

	if not var_1_10006.island_world_objects[var_23_2.birthplace] then
		var_23_4 = {}
	end

	IslandCalcUtil = var_7

	local var_23_5 = var_7.GetRandomPointOnCircle

	BuildVector3 = var_1_10008

	local var_23_6 = var_23_5(var_1_10008(var_23_4.param.position), 5)
	local var_23_7 = {
		var_23_6.x,
		var_23_6.y,
		var_23_6.z
	}

	return (arg_23_0:ProductAniObj2IslandUnit(var_23_3, var_23_7))
end

function var_0_1.GenHandPlantUnitBySlotData(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0:GetUnitIdBySlotId(arg_24_1)
	local var_24_1 = arg_24_0.workUnitDic[var_24_0]
	local var_24_2

	if not arg_24_2 or not var_24_1.work_unit then
		var_24_2 = var_24_1.idle_unit
	end

	local var_24_6

	if arg_24_0.unitDic[var_24_0] then
		var_24_6.modelId = var_24_2
		var_1_10008 = var_24_6

		local var_24_3 = var_24_6.ChangeSlotType

		IslandProductConst = var_1_10009

		var_24_3(var_1_10008, var_1_10009.ProductSlotType.HandPlant)

		var_1_10008 = var_24_6

		var_24_6.StartPlantGrowthTime(var_1_10008, arg_24_2)
	else
		local var_24_4 = {
			unitId = var_24_2
		}

		IslandConst = var_1_10008
		var_24_4.typ = var_1_10008.UNIT_TYPE_ITEM_HANDLE_PLANTING
		var_24_4.formula_id = arg_24_2
		var_24_4.slotId = arg_24_1
		IslandProductConst = var_8
		var_24_4.slotType = var_8.ProductSlotType.HandPlant
		pg = var_8

		local var_24_5

		if not var_8.island_world_objects[var_24_0] then
			var_24_5 = {}
		end

		var_24_6 = arg_24_0:ProductSlotObj2IslandUnit(var_24_5, var_24_4)
	end

	return var_24_6
end

function var_0_1.GetUnitIdBySlotId(arg_25_0, arg_25_1)
	return arg_25_0.slotToUnitDic[arg_25_1]
end

function var_0_1.GetUnitVOByUnitId(arg_26_0, arg_26_1)
	return arg_26_0.unitDic[arg_26_1]
end

function var_0_1.ProductSlotObj2IslandUnit(arg_27_0, arg_27_1, arg_27_2)
	arg_27_2 = arg_27_2 or {}
	IslandProductSlotUnitVO = var_1_10003

	local var_27_0 = var_1_10003.New
	local var_27_1 = {
		id = arg_27_1.id
	}
	local var_27_2

	if not arg_27_2.unitId then
		var_27_2 = arg_27_1.unitId
	end

	var_27_1.modelId = var_27_2

	local var_27_3

	if not arg_27_2.typ then
		var_27_3 = arg_27_1.type
	end

	var_27_1.type = var_27_3
	var_27_1.name = arg_27_1.name
	var_27_1.position = arg_27_1.param.position
	var_27_1.rotation = arg_27_1.param.rotation

	local var_27_4

	if not arg_27_1.param.scale then
		var_27_4 = {
			1,
			1,
			1
		}
	end

	var_27_1.scale = var_27_4
	var_27_1.behaviourTree = arg_27_1.behaviourTree

	local var_27_5 = arg_27_1.gen_type

	IslandConst = var_1_10006
	var_27_1.isDynamic = var_27_5 == var_1_10006.UNIT_GEN_TYPE_DYNAMIC

	local var_27_6

	if not arg_27_1.show_param then
		var_27_6 = {}
	end

	var_27_1.showCondition = var_27_6

	local var_27_7

	if not arg_27_1.hide_param then
		var_27_7 = {}
	end

	var_27_1.hideCondition = var_27_7
	var_27_1.formula_id = arg_27_2.formula_id
	var_27_1.slotId = arg_27_2.slotId
	var_27_1.slotType = arg_27_2.slotType
	var_27_1.isSelfIsland = arg_27_0.isSelf

	local var_27_8 = var_27_0(var_27_1)

	arg_27_0.unitDic[var_27_8.id] = var_27_8

	return var_27_8
end

function var_0_1.CollectSlotObj2IslandUnit(arg_28_0, arg_28_1, arg_28_2)
	arg_28_2 = arg_28_2 or {}
	IslandCollectSlotUnitVO = var_1_10003

	local var_28_0 = var_1_10003.New
	local var_28_1 = {
		id = arg_28_1.id
	}
	local var_28_2

	if not arg_28_2.unitId then
		var_28_2 = arg_28_1.unitId
	end

	var_28_1.modelId = var_28_2

	local var_28_3

	if not arg_28_2.typ then
		var_28_3 = arg_28_1.type
	end

	var_28_1.type = var_28_3
	var_28_1.name = arg_28_1.name
	var_28_1.position = arg_28_1.param.position
	var_28_1.rotation = arg_28_1.param.rotation

	local var_28_4

	if not arg_28_1.param.scale then
		var_28_4 = {
			1,
			1,
			1
		}
	end

	var_28_1.scale = var_28_4
	var_28_1.behaviourTree = arg_28_1.behaviourTree

	local var_28_5 = arg_28_1.gen_type

	IslandConst = var_1_10006
	var_28_1.isDynamic = var_28_5 == var_1_10006.UNIT_GEN_TYPE_DYNAMIC

	local var_28_6

	if not arg_28_1.show_param then
		var_28_6 = {}
	end

	var_28_1.showCondition = var_28_6

	local var_28_7

	if not arg_28_1.hide_param then
		var_28_7 = {}
	end

	var_28_1.hideCondition = var_28_7
	var_28_1.formula_id = arg_28_2.formula_id
	var_28_1.slotId = arg_28_2.slotId
	var_28_1.slotType = arg_28_2.slotType
	var_28_1.isSelfIsland = arg_28_0.isSelf

	return (var_28_0(var_28_1))
end

function var_0_1.ProductAniObj2IslandUnit(arg_29_0, arg_29_1, arg_29_2)
	IslandUnitVO = var_1_10003

	local var_29_0 = var_1_10003.New
	local var_29_1 = {
		behaviourTree = "island/nodecanvas/system/system_npc_animal",
		id = arg_29_1.id,
		modelId = arg_29_1.unit_id
	}

	IslandConst = var_5
	var_29_1.type = var_5.UNIT_TYPE_SYSTEM_DELEAGTION_ANIMATION
	var_29_1.name = "system_unit" .. arg_29_1.id
	var_29_1.position = arg_29_2
	Vector3 = var_5
	var_29_1.rotation = var_5.zero
	Vector3 = var_5
	var_29_1.scale = var_5.one

	return var_29_0(var_29_1)
end

function var_0_1.GetDelegateUnitsByBuildIdAndSlotId(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = {}

	switch = var_1_10005

	local var_30_1 = arg_30_1
	local var_30_2 = {}

	IslandProductConst = var_1_10008
	var_30_2[var_1_10008.FisheryPlaceId] = function()
		local var_31_0 = arg_30_0

		var_30_0 = var_0.GetDelegateFishUnits(var_31_0, arg_30_2, arg_30_3)

		return
	end

	var_1_10005(var_30_1, var_30_2)

	return var_30_0
end

function var_0_1.GetDelegateEffectsByCommissonId(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0:GetCommissionSlotId(arg_32_1)

	return arg_32_0.commissionEffectDic[var_32_0]
end

function var_0_1.GenUnitByDelegateEffectId(arg_33_0, arg_33_1)
	pg = var_1_10002

	if var_1_10002.island_world_objects[arg_33_1] then
		local var_33_0 = {}

		IslandConst = var_1_10004
		var_33_0.typ = var_1_10004.UNIT_TYPE_ITEM
		IslandDataConvertor = var_4

		return (var_4.WorldObj2IslandUnit(var_2, var_33_0))
	end

	return
end

function var_0_1.GetDelegateFishUnits(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = {}
	local var_34_1 = arg_34_0
	local var_34_2 = arg_34_0.GetCommissionSlotId(var_34_1, arg_34_1)

	pg = var_34_1

	local var_34_3 = var_34_1.island_production_commission[var_34_2]

	pg = var_6

	local var_34_4 = var_6.island_formula[arg_34_2].unitid[1][1]

	pg = var_1_10008

	local var_34_5 = var_1_10008.island_world_objects[var_34_3.performanceObjid]

	math = var_9

	local var_34_6 = var_9.random(var_6.unitid[2][1], var_6.unitid[2][2])
	local var_34_7 = var_6.unitid[2][3]

	for iter_34_0 = 1, var_34_6 do
		local var_34_8 = arg_34_0.delegateUnitsId
		local var_34_9 = arg_34_0.delegateSlotUnits
		local var_34_10

		if not arg_34_0.delegateSlotUnits[var_34_2] then
			var_34_10 = {}
		end

		var_34_9[var_34_2] = var_34_10
		table = var_34_9

		var_34_9.insert(arg_34_0.delegateSlotUnits[var_34_2], var_34_8)

		arg_34_0.delegateUnitsId = arg_34_0.delegateUnitsId + 1

		local var_34_11 = arg_34_0
		local var_34_12 = arg_34_0.GenDelegateFishUnit(var_34_11, var_34_8, var_34_4, var_34_5, var_34_7)

		table = var_34_11

		var_34_11.insert(var_34_0, var_34_12)
	end

	return var_34_0
end

function var_0_1.GetDelegatUnitsBySlotId(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:GetCommissionSlotId(arg_35_1)
	local var_35_1

	if not arg_35_0.delegateSlotUnits[var_35_0] then
		var_35_1 = {}
	end

	return var_35_1
end

function var_0_1.GetDelegateSlotUnits(arg_36_0)
	return arg_36_0.delegateSlotUnits
end

function var_0_1.GenDelegateFishUnit(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	IslandDelegateFishVO = var_1_10005

	local var_37_0 = var_1_10005.New
	local var_37_1 = {
		behaviourTree = "",
		id = arg_37_1,
		modelId = arg_37_2
	}

	IslandConst = var_1_10007
	var_37_1.type = var_1_10007.UNIT_TYPE_DELEGATE_FISH
	pg = var_7
	var_37_1.name = var_7.island_unit_character[arg_37_2].id
	var_37_1.position = arg_37_3.param.position
	Vector3 = var_7
	var_37_1.rotation = var_7.zero
	Vector3 = var_7
	var_37_1.scale = var_7.one
	var_37_1.speed = arg_37_4

	return var_37_0(var_37_1)
end

return var_0_1
