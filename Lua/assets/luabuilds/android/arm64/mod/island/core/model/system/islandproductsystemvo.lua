local var_0_0 = class("IslandProductSystemVO", import(".IslandSystemVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

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

function var_0_0.GetType(arg_2_0)
	return IslandConst.SYSTEM_TYPE_PRODUCT
end

function var_0_0.GetBehaviourTree(arg_3_0)
	return nil
end

function var_0_0.IsSelf(arg_4_0, arg_4_1)
	local var_4_0 = getProxy(PlayerProxy)

	return var_4_0:getRawData().id == arg_4_1
end

function var_0_0.InitCfgData(arg_5_0)
	arg_5_0.slotToUnitDic = {}

	arg_5_0:InitCommissionCfgData()
	arg_5_0:InitHandPlantCfg()
	arg_5_0:InitHandCollectCfg()
	arg_5_0:InitCommissionEffectCfg()

	return
end

function var_0_0.InitCommissionEffectCfg(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(pg.island_set.island_fishery_bubble_vfx.key_value_varchar) do
		arg_6_0.commissionEffectDic[iter_6_1[1]] = iter_6_1[2]
	end

	return
end

function var_0_0.InitHandPlantCfg(arg_7_0)
	if not table.contains({
		IslandProductConst.FarmlandPlaceId,
		IslandProductConst.OrchardPlaceId,
		IslandProductConst.GardenPlaceId
	}, arg_7_0.productPlaceId) then
		return
	end

	arg_7_0.workUnitDic = {}

	local var_7_0 = pg.island_production_farm.get_id_list_by_place_id[arg_7_0.productPlaceId] or {}

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		arg_7_0.slotToUnitDic[pg.island_production_farm[iter_7_1].slotId] = pg.island_production_farm[iter_7_1].objId

		if not arg_7_0.workUnitDic[pg.island_production_farm[iter_7_1].objId] then
			arg_7_0.workUnitDic[pg.island_production_farm[iter_7_1].objId] = {}
			arg_7_0.workUnitDic[pg.island_production_farm[iter_7_1].objId].idle_unit = pg.island_production_farm[iter_7_1].idle_unit
			arg_7_0.workUnitDic[pg.island_production_farm[iter_7_1].objId].work_unit = pg.island_production_farm[iter_7_1].work_unit
		end
	end

	return
end

function var_0_0.InitHandCollectCfg(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(pg.island_production_mining.all) do
		arg_8_0.slotToUnitDic[pg.island_production_mining[iter_8_1].slotId] = arg_8_0.slotToUnitDic[pg.island_production_mining[iter_8_1].slotId] or pg.island_production_mining[iter_8_1].objId
	end

	return
end

function var_0_0.GetUnitDatas(arg_9_0)
	arg_9_0:GenHandCollectSlot({})
	arg_9_0:GenHandPlantSlot({})
	arg_9_0:GenAnimalBySlot({})
	arg_9_0:GenPlaceModelUnit({})
	arg_9_0:GenPlaceSlotModelUnit({})

	return {}
end

function var_0_0.GenPlaceSlotModelUnit(arg_10_0, arg_10_1)
	if not table.contains({
		IslandProductConst.FisheryPlaceId
	}, arg_10_0.productPlaceId) then
		return
	end

	local var_10_0 = pg.island_production_slot.get_id_list_by_place[arg_10_0.productPlaceId] or {}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if pg.island_production_slot[iter_10_1].type == 9 then
			local var_10_1 = pg.island_production_commission[arg_10_0:GetCommissionSlotId(iter_10_1)].unlockObjid

			if var_10_1 ~= 0 then
				if arg_10_0.building ~= nil then
					if arg_10_0.building:GetDelegationSlotData(iter_10_1) == nil then
						table.insert(arg_10_1, (IslandDataConvertor.WorldObj2IslandUnit(pg.island_world_objects[var_10_1])))
					end
				end
			end
		end
	end

	return
end

function var_0_0.GenPlaceModelUnit(arg_11_0, arg_11_1)
	if not table.contains(IslandProductConst.haveModelPlaces, arg_11_0.productPlaceId) then
		return
	end

	table.insert(arg_11_1, (arg_11_0:GetPlaceModelUnit(arg_11_0.building ~= nil)))

	return
end

function var_0_0.GetPlaceModelId(arg_12_0, arg_12_1)
	if arg_12_1 then
		return pg.island_production_place[arg_12_0.productPlaceId].unlocked_obj
	else
		return pg.island_production_place[arg_12_0.productPlaceId].locked_obj
	end

	return
end

function var_0_0.GetPlaceModelUnit(arg_13_0, arg_13_1)
	return IslandDataConvertor.WorldObj2IslandUnit(pg.island_world_objects[arg_13_0:GetPlaceModelId(arg_13_1)])
end

function var_0_0.InitCommissionCfgData(arg_14_0)
	arg_14_0.slotCommissionDic = {}

	for iter_14_0, iter_14_1 in ipairs(pg.island_production_place[arg_14_0.productPlaceId].commission_slot) do
		arg_14_0.slotCommissionDic[pg.island_production_commission[iter_14_1].slot] = iter_14_1
	end

	return
end

function var_0_0.GetCommissionSlotId(arg_15_0, arg_15_1)
	return arg_15_0.slotCommissionDic[arg_15_1]
end

function var_0_0.GenHandCollectSlot(arg_16_0, arg_16_1)
	if not arg_16_0.building or not arg_16_0.isSelf then
		return
	end

	arg_16_0:GenHandCollectSlotInSlotPlace(arg_16_1)

	return
end

function var_0_0.GenHandCollectSlotInSlotPlace(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.building:GetBuildingCollectData()

	if not var_17_0 then
		return
	end

	for iter_17_0, iter_17_1 in pairs((var_17_0:GetCollectSlotDatasDic())) do
		local var_17_1 = arg_17_0:GenHandCollectSlotByDataNew(iter_17_1)

		if var_17_1 then
			table.insert(arg_17_1, var_17_1)
		end
	end

	return
end

function var_0_0.GetHandCollectSlotBySlotId(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.building

	if not arg_18_0.building then
		if arg_18_0.isSelf then
			local var_18_1 = getProxy(IslandProxy):GetIsland() or getProxy(IslandProxy):GetSharedIsland()

			var_18_0 = var_18_1:GetBuildingAgency():GetBuilding(arg_18_0.productPlaceId)

			local var_18_2 = var_18_0:GetBuildingCollectData()

			return arg_18_0.slotToUnitDic[var_18_2:GetCollectSlotData(arg_18_1).configId]
		end
	end
end

function var_0_0.GenHandCollectSlotByDataNew(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.productPlaceId == IslandProductConst.FellingPlaceId
	local var_19_1 = arg_19_0.slotToUnitDic[arg_19_1.configId]

	if arg_19_1:GetCanCollectTimeStamps() == 0 or var_19_0 then
		local var_19_2 = {
			unitId = pg.island_formula[pg.island_production_slot[arg_19_1.configId].formula[1]].unitid[1][2],
			typ = IslandConst.UNIT_TYPE_ITEM_HANDLE_COLLECT,
			slotId = arg_19_1.configId
		}
		local var_19_3 = pg.island_world_objects[var_19_1] or {}

		return (arg_19_0:CollectSlotObj2IslandUnit(var_19_3, var_19_2))
	end

	return
end

function var_0_0.InitHandCollectSlotBySlotId(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.building

	if not arg_20_0.building then
		if arg_20_0.isSelf then
			local var_20_1 = getProxy(IslandProxy):GetIsland() or getProxy(IslandProxy):GetSharedIsland()

			var_20_0 = var_20_1:GetBuildingAgency():GetBuilding(arg_20_0.productPlaceId)

			return arg_20_0:GenHandCollectSlotByDataNew((var_20_0:GetCollectSlotData(arg_20_1)))
		end
	end
end

function var_0_0.GenHandPlantSlot(arg_21_0, arg_21_1)
	local var_21_0 = pg.island_production_farm.get_id_list_by_place_id[arg_21_0.productPlaceId] or {}

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		local var_21_1 = pg.island_production_farm[iter_21_1].unlock_unit
		local var_21_2 = IslandProductConst.ProductSlotType.HandPlant
		local var_21_3

		if arg_21_0.building then
			if arg_21_0.building.handSlotData[pg.island_production_farm[iter_21_1].slotId] then
				var_21_1 = pg.island_production_farm[iter_21_1].idle_unit
				var_21_3 = arg_21_0.building.handSlotData[pg.island_production_farm[iter_21_1].slotId]:GetPlantFormulaId() or nil

				if var_21_3 then
					var_21_1 = pg.island_production_farm[iter_21_1].work_unit
				else
					local var_21_4 = arg_21_0.building:GetDelegationSlotData(pg.island_production_slot[pg.island_production_farm[iter_21_1].slotId].exclusion_slot[1])

					if var_21_4 and not var_21_4:CanStartDelegation() then
						var_21_1 = pg.island_production_farm[iter_21_1].work_unit
						var_21_2 = IslandProductConst.ProductSlotType.RoleDelegation
						var_21_3 = var_21_4:GetFormulaId()
					end
				end
			end
		end

		local var_21_5 = {
			unitId = var_21_1,
			typ = IslandConst.UNIT_TYPE_ITEM_HANDLE_PLANTING,
			formula_id = var_21_3,
			slotId = pg.island_production_farm[iter_21_1].slotId,
			slotType = var_21_2
		}
		local var_21_6 = pg.island_world_objects[pg.island_production_farm[iter_21_1].objId]
		local var_21_7

		if not pg.island_world_objects[pg.island_production_farm[iter_21_1].objId] then
			var_21_6 = {}
			var_21_7 = arg_21_1
		end

		table.insert(arg_21_1, (arg_21_0:ProductSlotObj2IslandUnit(var_21_6, var_21_5)))
	end

	return
end

function var_0_0.GenAnimalBySlot(arg_22_0, arg_22_1)
	if not arg_22_0.building then
		return
	end

	if arg_22_0.productPlaceId ~= IslandProductConst.PasturePlaceId then
		return
	end

	for iter_22_0, iter_22_1 in pairs(arg_22_0.building:GetDelegationSlotDatas()) do
		local var_22_1 = pg.island_production_commission[arg_22_0:GetCommissionSlotId(iter_22_0)]

		for iter_22_2, iter_22_3 in ipairs(iter_22_1:GetPartList()) do
			local var_22_2 = pg.island_world_objects[var_22_1.birthplace] or {}
			local var_22_3 = IslandCalcUtil.GetRandomPointOnCircle(BuildVector3(var_22_2.param.position), 5)

			table.insert(arg_22_1, (arg_22_0:ProductAniObj2IslandUnit(pg.island_ranch_animal[iter_22_3], {
				var_22_3.x,
				var_22_3.y,
				var_22_3.z
			})))
		end
	end

	return
end

function var_0_0.GenAnimalByAnialConfig(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = pg.island_world_objects[pg.island_production_commission[arg_23_0:GetCommissionSlotId(arg_23_2)].birthplace] or {}
	local var_23_1 = IslandCalcUtil.GetRandomPointOnCircle(BuildVector3(var_23_0.param.position), 5)

	return (arg_23_0:ProductAniObj2IslandUnit(pg.island_ranch_animal[arg_23_1], {
		var_23_1.x,
		var_23_1.y,
		var_23_1.z
	}))
end

function var_0_0.GenHandPlantUnitBySlotData(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0:GetUnitIdBySlotId(arg_24_1)

	if arg_24_2 then
		local var_24_1 = arg_24_0.workUnitDic[var_24_0].work_unit or arg_24_0.workUnitDic[var_24_0].idle_unit
		local var_24_2 = arg_24_0.unitDic[var_24_0]

		if arg_24_0.unitDic[var_24_0] then
			var_24_2.modelId = var_24_1

			var_24_2:ChangeSlotType(IslandProductConst.ProductSlotType.HandPlant)
			var_24_2:StartPlantGrowthTime(arg_24_2)
		else
			local var_24_3 = {
				unitId = var_24_1,
				typ = IslandConst.UNIT_TYPE_ITEM_HANDLE_PLANTING,
				formula_id = arg_24_2,
				slotId = arg_24_1,
				slotType = IslandProductConst.ProductSlotType.HandPlant
			}
			local var_24_4 = pg.island_world_objects[var_24_0] or {}

			var_24_2 = arg_24_0:ProductSlotObj2IslandUnit(var_24_4, var_24_3)
		end

		return var_24_2
	end
end

function var_0_0.GetUnitIdBySlotId(arg_25_0, arg_25_1)
	return arg_25_0.slotToUnitDic[arg_25_1]
end

function var_0_0.GetUnitVOByUnitId(arg_26_0, arg_26_1)
	return arg_26_0.unitDic[arg_26_1]
end

function var_0_0.ProductSlotObj2IslandUnit(arg_27_0, arg_27_1, arg_27_2)
	arg_27_2 = arg_27_2 or {}

	local var_27_1 = {
		id = arg_27_1.id
	}

	var_27_1.modelId = arg_27_2.unitId or arg_27_1.unitId
	var_27_1.type = arg_27_2.typ or arg_27_1.type
	var_27_1.name = arg_27_1.name
	var_27_1.position = arg_27_1.param.position
	var_27_1.rotation = arg_27_1.param.rotation
	var_27_1.scale = arg_27_1.param.scale or {
		1,
		1,
		1
	}
	var_27_1.behaviourTree = arg_27_1.behaviourTree
	var_27_1.isDynamic = arg_27_1.gen_type == IslandConst.UNIT_GEN_TYPE_DYNAMIC
	var_27_1.showCondition = arg_27_1.show_param or {}
	var_27_1.hideCondition = arg_27_1.hide_param or {}
	var_27_1.formula_id = arg_27_2.formula_id
	var_27_1.slotId = arg_27_2.slotId
	var_27_1.slotType = arg_27_2.slotType
	var_27_1.isSelfIsland = arg_27_0.isSelf

	local var_27_2 = var_27_0(var_27_1)

	arg_27_0.unitDic[var_27_2.id] = var_27_2

	return var_27_2
end

function var_0_0.CollectSlotObj2IslandUnit(arg_28_0, arg_28_1, arg_28_2)
	arg_28_2 = arg_28_2 or {}

	local var_28_1 = {
		id = arg_28_1.id
	}

	var_28_1.modelId = arg_28_2.unitId or arg_28_1.unitId
	var_28_1.type = arg_28_2.typ or arg_28_1.type
	var_28_1.name = arg_28_1.name
	var_28_1.position = arg_28_1.param.position
	var_28_1.rotation = arg_28_1.param.rotation
	var_28_1.scale = arg_28_1.param.scale or {
		1,
		1,
		1
	}
	var_28_1.behaviourTree = arg_28_1.behaviourTree
	var_28_1.isDynamic = arg_28_1.gen_type == IslandConst.UNIT_GEN_TYPE_DYNAMIC
	var_28_1.showCondition = arg_28_1.show_param or {}
	var_28_1.hideCondition = arg_28_1.hide_param or {}
	var_28_1.formula_id = arg_28_2.formula_id
	var_28_1.slotId = arg_28_2.slotId
	var_28_1.slotType = arg_28_2.slotType
	var_28_1.isSelfIsland = arg_28_0.isSelf

	return (var_28_0(var_28_1))
end

function var_0_0.ProductAniObj2IslandUnit(arg_29_0, arg_29_1, arg_29_2)
	return IslandUnitVO.New({
		behaviourTree = "island/nodecanvas/system/system_npc_animal",
		id = arg_29_1.id,
		modelId = arg_29_1.unit_id,
		type = IslandConst.UNIT_TYPE_SYSTEM_DELEAGTION_ANIMATION,
		name = "system_unit" .. arg_29_1.id,
		position = arg_29_2,
		rotation = Vector3.zero,
		scale = Vector3.one
	})
end

function var_0_0.GetDelegateUnitsByBuildIdAndSlotId(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = {}

	switch(arg_30_1, {
		[IslandProductConst.FisheryPlaceId] = function()
			var_30_0 = arg_30_0:GetDelegateFishUnits(arg_30_2, arg_30_3)

			return
		end
	})

	return {}
end

function var_0_0.GetDelegateEffectsByCommissonId(arg_32_0, arg_32_1)
	return arg_32_0.commissionEffectDic[arg_32_0:GetCommissionSlotId(arg_32_1)]
end

function var_0_0.GenUnitByDelegateEffectId(arg_33_0, arg_33_1)
	if pg.island_world_objects[arg_33_1] then
		return (IslandDataConvertor.WorldObj2IslandUnit(pg.island_world_objects[arg_33_1], {
			typ = IslandConst.UNIT_TYPE_ITEM
		}))
	end

	return
end

function var_0_0.GetDelegateFishUnits(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0:GetCommissionSlotId(arg_34_1)

	for iter_34_0 = 1, math.random(pg.island_formula[arg_34_2].unitid[2][1], pg.island_formula[arg_34_2].unitid[2][2]) do
		arg_34_0.delegateSlotUnits[var_34_0] = arg_34_0.delegateSlotUnits[var_34_0] or {}

		table.insert(arg_34_0.delegateSlotUnits[var_34_0], arg_34_0.delegateUnitsId)

		arg_34_0.delegateUnitsId = arg_34_0.delegateUnitsId + 1

		table.insert({}, (arg_34_0:GenDelegateFishUnit(arg_34_0.delegateUnitsId, pg.island_formula[arg_34_2].unitid[1][1], pg.island_world_objects[pg.island_production_commission[var_34_0].performanceObjid], pg.island_formula[arg_34_2].unitid[2][3])))
	end

	return {}
end

function var_0_0.GetDelegatUnitsBySlotId(arg_35_0, arg_35_1)
	return arg_35_0.delegateSlotUnits[arg_35_0:GetCommissionSlotId(arg_35_1)] or {}
end

function var_0_0.GetDelegateSlotUnits(arg_36_0)
	return arg_36_0.delegateSlotUnits
end

function var_0_0.GenDelegateFishUnit(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	return IslandDelegateFishVO.New({
		behaviourTree = "",
		id = arg_37_1,
		modelId = arg_37_2,
		type = IslandConst.UNIT_TYPE_DELEGATE_FISH,
		name = pg.island_unit_character[arg_37_2].id,
		position = arg_37_3.param.position,
		rotation = Vector3.zero,
		scale = Vector3.one,
		speed = arg_37_4
	})
end

return var_0_0
