local IslandProductSystemVO = class("IslandProductSystemVO", import(".IslandSystemVO"))

function IslandProductSystemVO:Ctor(arg_1_1, arg_1_2, arg_1_3)
	IslandProductSystemVO.super.Ctor(self, arg_1_1)

	self.isSelf = self:IsSelf(arg_1_3)
	self.productPlaceId = arg_1_1
	self.building = arg_1_2
	self.unitDic = {}
	self.delegateSlotUnits = {}
	self.delegateUnitsId = 1
	self.commissionEffectDic = {}

	self:InitCfgData()

	return
end

function IslandProductSystemVO:GetType()
	return IslandConst.SYSTEM_TYPE_PRODUCT
end

function IslandProductSystemVO:GetBehaviourTree()
	return nil
end

function IslandProductSystemVO:IsSelf(arg_4_1)
	return getProxy(PlayerProxy):getRawData().id == arg_4_1
end

function IslandProductSystemVO:InitCfgData()
	self.slotToUnitDic = {}

	self:InitCommissionCfgData()
	self:InitHandPlantCfg()
	self:InitHandCollectCfg()
	self:InitCommissionEffectCfg()

	return
end

function IslandProductSystemVO:InitCommissionEffectCfg()
	for iter_6_0, iter_6_1 in ipairs(pg.island_set.island_fishery_bubble_vfx.key_value_varchar) do
		self.commissionEffectDic[iter_6_1[1]] = iter_6_1[2]
	end

	return
end

function IslandProductSystemVO:InitHandPlantCfg()
	if not table.contains({
		IslandProductConst.FarmlandPlaceId,
		IslandProductConst.OrchardPlaceId,
		IslandProductConst.GardenPlaceId
	}, self.productPlaceId) then
		return
	end

	self.workUnitDic = {}

	for iter_7_0, iter_7_1 in ipairs(pg.island_production_farm.get_id_list_by_place_id[self.productPlaceId] or {}) do
		self.slotToUnitDic[pg.island_production_farm[iter_7_1].slotId] = pg.island_production_farm[iter_7_1].objId

		if not self.workUnitDic[pg.island_production_farm[iter_7_1].objId] then
			self.workUnitDic[pg.island_production_farm[iter_7_1].objId] = {}
			self.workUnitDic[pg.island_production_farm[iter_7_1].objId].idle_unit = pg.island_production_farm[iter_7_1].idle_unit
			self.workUnitDic[pg.island_production_farm[iter_7_1].objId].work_unit = pg.island_production_farm[iter_7_1].work_unit
		end
	end

	return
end

function IslandProductSystemVO:InitHandCollectCfg()
	for iter_8_0, iter_8_1 in ipairs(pg.island_production_mining.all) do
		self.slotToUnitDic[pg.island_production_mining[iter_8_1].slotId] = self.slotToUnitDic[pg.island_production_mining[iter_8_1].slotId] or pg.island_production_mining[iter_8_1].objId
	end

	return
end

function IslandProductSystemVO:GetUnitDatas()
	local var_9_0 = {}

	self:GenHandCollectSlot(var_9_0)
	self:GenHandPlantSlot(var_9_0)
	self:GenAnimalBySlot(var_9_0)
	self:GenPlaceModelUnit(var_9_0)
	self:GenPlaceSlotModelUnit(var_9_0)

	return var_9_0
end

function IslandProductSystemVO:GenPlaceSlotModelUnit(arg_10_1)
	if not table.contains({
		IslandProductConst.FisheryPlaceId
	}, self.productPlaceId) then
		return
	end

	for iter_10_0, iter_10_1 in ipairs(pg.island_production_slot.get_id_list_by_place[self.productPlaceId] or {}) do
		if pg.island_production_slot[iter_10_1].type == 9 then
			local var_10_0 = pg.island_production_commission[self:GetCommissionSlotId(iter_10_1)].unlockObjid

			if var_10_0 ~= 0 then
				if self.building ~= nil then
					if self.building:GetDelegationSlotData(iter_10_1) == nil then
						table.insert(arg_10_1, (IslandDataConvertor.WorldObj2IslandUnit(pg.island_world_objects[var_10_0])))
					end
				end
			end
		end
	end

	return
end

function IslandProductSystemVO:GenPlaceModelUnit(arg_11_1)
	if not table.contains(IslandProductConst.haveModelPlaces, self.productPlaceId) then
		return
	end

	table.insert(arg_11_1, (self:GetPlaceModelUnit(self.building ~= nil)))

	return
end

function IslandProductSystemVO:GetPlaceModelId(arg_12_1)
	if arg_12_1 then
		return pg.island_production_place[self.productPlaceId].unlocked_obj
	else
		return pg.island_production_place[self.productPlaceId].locked_obj
	end

	return
end

function IslandProductSystemVO:GetPlaceModelUnit(arg_13_1)
	return IslandDataConvertor.WorldObj2IslandUnit(pg.island_world_objects[self:GetPlaceModelId(arg_13_1)])
end

function IslandProductSystemVO:InitCommissionCfgData()
	self.slotCommissionDic = {}

	for iter_14_0, iter_14_1 in ipairs(pg.island_production_place[self.productPlaceId].commission_slot) do
		self.slotCommissionDic[pg.island_production_commission[iter_14_1].slot] = iter_14_1
	end

	return
end

function IslandProductSystemVO:GetCommissionSlotId(arg_15_1)
	return self.slotCommissionDic[arg_15_1]
end

function IslandProductSystemVO:GenHandCollectSlot(arg_16_1)
	if not self.building or not self.isSelf then
		return
	end

	self:GenHandCollectSlotInSlotPlace(arg_16_1)

	return
end

function IslandProductSystemVO:GenHandCollectSlotInSlotPlace(arg_17_1)
	local var_17_0 = self.building:GetBuildingCollectData()

	if not var_17_0 then
		return
	end

	for iter_17_0, iter_17_1 in pairs((var_17_0:GetCollectSlotDatasDic())) do
		local var_17_1 = self:GenHandCollectSlotByDataNew(iter_17_1)

		if var_17_1 then
			table.insert(arg_17_1, var_17_1)
		end
	end

	return
end

function IslandProductSystemVO:GetHandCollectSlotBySlotId(arg_18_1)
	return self.slotToUnitDic[(self.building or ((self.isSelf or nil) and (getProxy(IslandProxy):GetIsland() or getProxy(IslandProxy):GetSharedIsland())):GetBuildingAgency():GetBuilding(self.productPlaceId)):GetBuildingCollectData():GetCollectSlotData(arg_18_1).configId]
end

function IslandProductSystemVO:GenHandCollectSlotByDataNew(arg_19_1)
	if arg_19_1:GetCanCollectTimeStamps() == 0 or self.productPlaceId == IslandProductConst.FellingPlaceId then
		return (self:CollectSlotObj2IslandUnit((not pg.island_world_objects[self.slotToUnitDic[arg_19_1.configId]] or nil) and {}, {
			unitId = pg.island_formula[pg.island_production_slot[arg_19_1.configId].formula[1]].unitid[1][2],
			typ = IslandConst.UNIT_TYPE_ITEM_HANDLE_COLLECT,
			slotId = arg_19_1.configId
		}))
	end

	return
end

function IslandProductSystemVO:InitHandCollectSlotBySlotId(arg_20_1)
	return self:GenHandCollectSlotByDataNew(((self.building or ((self.isSelf or nil) and (getProxy(IslandProxy):GetIsland() or getProxy(IslandProxy):GetSharedIsland())):GetBuildingAgency():GetBuilding(self.productPlaceId)):GetCollectSlotData(arg_20_1)))
end

function IslandProductSystemVO:GenHandPlantSlot(arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(pg.island_production_farm.get_id_list_by_place_id[self.productPlaceId] or {}) do
		local var_21_1 = pg.island_production_farm[iter_21_1].unlock_unit
		local var_21_2 = IslandProductConst.ProductSlotType.HandPlant
		local var_21_3

		if self.building then
			if self.building.handSlotData[pg.island_production_farm[iter_21_1].slotId] then
				var_21_1 = pg.island_production_farm[iter_21_1].idle_unit
				var_21_3 = self.building.handSlotData[pg.island_production_farm[iter_21_1].slotId]:GetPlantFormulaId() or nil

				if var_21_3 then
					var_21_1 = pg.island_production_farm[iter_21_1].work_unit
				else
					local var_21_4 = self.building:GetDelegationSlotData(pg.island_production_slot[pg.island_production_farm[iter_21_1].slotId].exclusion_slot[1])

					if var_21_4 and not var_21_4:CanStartDelegation() then
						var_21_1 = pg.island_production_farm[iter_21_1].work_unit
						var_21_2 = IslandProductConst.ProductSlotType.RoleDelegation
						var_21_3 = var_21_4:GetFormulaId()
					end
				end
			end
		end

		table.insert(arg_21_1, (self:ProductSlotObj2IslandUnit(pg.island_world_objects[pg.island_production_farm[iter_21_1].objId] or {}, {
			unitId = var_21_1,
			typ = IslandConst.UNIT_TYPE_ITEM_HANDLE_PLANTING,
			formula_id = var_21_3,
			slotId = pg.island_production_farm[iter_21_1].slotId,
			slotType = var_21_2
		})))
	end

	return
end

function IslandProductSystemVO:GenAnimalBySlot(arg_22_1)
	if not self.building then
		return
	end

	if self.productPlaceId ~= IslandProductConst.PasturePlaceId then
		return
	end

	for iter_22_0, iter_22_1 in pairs(self.building:GetDelegationSlotDatas()) do
		local var_22_1 = pg.island_production_commission[self:GetCommissionSlotId(iter_22_0)]

		for iter_22_2, iter_22_3 in ipairs(iter_22_1:GetPartList()) do
			local var_22_3 = IslandCalcUtil.GetRandomPointOnCircle(BuildVector3((pg.island_world_objects[var_22_1.birthplace] or {}).param.position), 5)

			table.insert(arg_22_1, (self:ProductAniObj2IslandUnit(pg.island_ranch_animal[iter_22_3], {
				var_22_3.x,
				var_22_3.y,
				var_22_3.z
			})))
		end
	end

	return
end

function IslandProductSystemVO:GenAnimalByAnialConfig(arg_23_1, arg_23_2)
	local var_23_0 = IslandCalcUtil.GetRandomPointOnCircle(BuildVector3((pg.island_world_objects[pg.island_production_commission[self:GetCommissionSlotId(arg_23_2)].birthplace] or {}).param.position), 5)

	return (self:ProductAniObj2IslandUnit(pg.island_ranch_animal[arg_23_1], {
		var_23_0.x,
		var_23_0.y,
		var_23_0.z
	}))
end

function IslandProductSystemVO:GenHandPlantUnitBySlotData(arg_24_1, arg_24_2)
	local var_24_0 = self:GetUnitIdBySlotId(arg_24_1)
	local var_24_1

	if arg_24_2 then
		var_24_1 = self.workUnitDic[var_24_0].work_unit or self.workUnitDic[var_24_0].idle_unit
	end

	local var_24_2 = self.unitDic[var_24_0]

	if self.unitDic[var_24_0] then
		var_24_2.modelId = var_24_1

		var_24_2:ChangeSlotType(IslandProductConst.ProductSlotType.HandPlant)
		var_24_2:StartPlantGrowthTime(arg_24_2)
	else
		var_24_2 = self:ProductSlotObj2IslandUnit((not pg.island_world_objects[var_24_0] or nil) and {}, {
			unitId = var_24_1,
			typ = IslandConst.UNIT_TYPE_ITEM_HANDLE_PLANTING,
			formula_id = arg_24_2,
			slotId = arg_24_1,
			slotType = IslandProductConst.ProductSlotType.HandPlant
		})
	end

	return var_24_2
end

function IslandProductSystemVO:GetUnitIdBySlotId(arg_25_1)
	return self.slotToUnitDic[arg_25_1]
end

function IslandProductSystemVO:GetUnitVOByUnitId(arg_26_1)
	return self.unitDic[arg_26_1]
end

function IslandProductSystemVO:ProductSlotObj2IslandUnit(arg_27_1, arg_27_2)
	arg_27_2 = arg_27_2 or {}

	local var_27_0 = {
		id = arg_27_1.id
	}

	var_27_0.modelId = arg_27_2.unitId or arg_27_1.unitId
	var_27_0.type = arg_27_2.typ or arg_27_1.type
	var_27_0.name = arg_27_1.name
	var_27_0.position = arg_27_1.param.position
	var_27_0.rotation = arg_27_1.param.rotation
	var_27_0.scale = arg_27_1.param.scale or {
		1,
		1,
		1
	}
	var_27_0.behaviourTree = arg_27_1.behaviourTree
	var_27_0.isDynamic = arg_27_1.gen_type == IslandConst.UNIT_GEN_TYPE_DYNAMIC
	var_27_0.showCondition = arg_27_1.show_param or {}
	var_27_0.hideCondition = arg_27_1.hide_param or {}
	var_27_0.formula_id = arg_27_2.formula_id
	var_27_0.slotId = arg_27_2.slotId
	var_27_0.slotType = arg_27_2.slotType
	var_27_0.isSelfIsland = self.isSelf

	local var_27_1 = IslandProductSlotUnitVO.New(var_27_0)

	self.unitDic[var_27_1.id] = var_27_1

	return var_27_1
end

function IslandProductSystemVO:CollectSlotObj2IslandUnit(arg_28_1, arg_28_2)
	arg_28_2 = arg_28_2 or {}

	local var_28_0 = {
		id = arg_28_1.id
	}

	var_28_0.modelId = arg_28_2.unitId or arg_28_1.unitId
	var_28_0.type = arg_28_2.typ or arg_28_1.type
	var_28_0.name = arg_28_1.name
	var_28_0.position = arg_28_1.param.position
	var_28_0.rotation = arg_28_1.param.rotation
	var_28_0.scale = arg_28_1.param.scale or {
		1,
		1,
		1
	}
	var_28_0.behaviourTree = arg_28_1.behaviourTree
	var_28_0.isDynamic = arg_28_1.gen_type == IslandConst.UNIT_GEN_TYPE_DYNAMIC
	var_28_0.showCondition = arg_28_1.show_param or {}
	var_28_0.hideCondition = arg_28_1.hide_param or {}
	var_28_0.formula_id = arg_28_2.formula_id
	var_28_0.slotId = arg_28_2.slotId
	var_28_0.slotType = arg_28_2.slotType
	var_28_0.isSelfIsland = self.isSelf

	return (IslandCollectSlotUnitVO.New(var_28_0))
end

function IslandProductSystemVO:ProductAniObj2IslandUnit(arg_29_1, arg_29_2)
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

function IslandProductSystemVO:GetDelegateUnitsByBuildIdAndSlotId(arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = {}

	switch(arg_30_1, {
		[IslandProductConst.FisheryPlaceId] = function()
			var_30_0 = self:GetDelegateFishUnits(arg_30_2, arg_30_3)

			return
		end
	})

	return var_30_0
end

function IslandProductSystemVO:GetDelegateEffectsByCommissonId(arg_32_1)
	return self.commissionEffectDic[self:GetCommissionSlotId(arg_32_1)]
end

function IslandProductSystemVO:GenUnitByDelegateEffectId(arg_33_1)
	if pg.island_world_objects[arg_33_1] then
		return (IslandDataConvertor.WorldObj2IslandUnit(pg.island_world_objects[arg_33_1], {
			typ = IslandConst.UNIT_TYPE_ITEM
		}))
	end

	return
end

function IslandProductSystemVO:GetDelegateFishUnits(arg_34_1, arg_34_2)
	local var_34_0 = {}
	local var_34_1 = self:GetCommissionSlotId(arg_34_1)

	for iter_34_0 = 1, math.random(pg.island_formula[arg_34_2].unitid[2][1], pg.island_formula[arg_34_2].unitid[2][2]) do
		self.delegateSlotUnits[var_34_1] = self.delegateSlotUnits[var_34_1] or {}

		table.insert(self.delegateSlotUnits[var_34_1], self.delegateUnitsId)

		self.delegateUnitsId = self.delegateUnitsId + 1

		table.insert(var_34_0, (self:GenDelegateFishUnit(self.delegateUnitsId, pg.island_formula[arg_34_2].unitid[1][1], pg.island_world_objects[pg.island_production_commission[var_34_1].performanceObjid], pg.island_formula[arg_34_2].unitid[2][3])))
	end

	return var_34_0
end

function IslandProductSystemVO:GetDelegatUnitsBySlotId(arg_35_1)
	return self.delegateSlotUnits[self:GetCommissionSlotId(arg_35_1)] or {}
end

function IslandProductSystemVO:GetDelegateSlotUnits()
	return self.delegateSlotUnits
end

function IslandProductSystemVO:GenDelegateFishUnit(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
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

return IslandProductSystemVO
