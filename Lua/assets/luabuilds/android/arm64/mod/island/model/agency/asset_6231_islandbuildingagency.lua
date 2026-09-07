local IslandBuildingAgency = class("IslandBuildingAgency", import(".IslandBaseAgency"))

IslandBuildingAgency.COLLECT_SlOT_UNIT_INIT = "IslandBuildingAgency:COLLECT_SlOT_UNIT_INIT"
IslandBuildingAgency.COLLECT_SlOT_UNIT_UPDATE = "IslandBuildingAgency:COLLECT_SlOT_UNIT_UPDATE"
IslandBuildingAgency.COLLECT_SLOT_UNIT_REMOVE = "IslandBuildingAgency:COLLECT_SLOT_UNIT_REMOVE"
IslandBuildingAgency.SLOT_HANDPLABT_SLOT_UNIT_CHANGE = "IslandBuildingAgency:SLOT_HANDPLABT_SLOT_UNIT_CHANGE"
IslandBuildingAgency.SLOT_RESET_DELEGATION_STATE_DONE = "IslandBuildingAgency:SLOT_RESET_DELEGATION_STATE_DONE"
IslandBuildingAgency.GEN_ANIMAL_INT = "IslandBuildingAgency:GEN_ANIMAL_INT"
IslandBuildingAgency.CHANGE_PRODUCT_MODEL = "IslandBuildingAgency:CHANGE_PRODUCT_MODEL"
IslandBuildingAgency.SLOT_DELEGATE_INIT = "IslandBuildingAgency:SLOT_DELEGATE_INIT"

function IslandBuildingAgency:OnInit(arg_1_1)
	self.buildings = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.build_list or {}) do
		self.buildings[iter_1_1.id] = IslandBuilding.New(iter_1_1, self:IsSelf(arg_1_1.id))
	end

	return
end

function IslandBuildingAgency:InitPrivateData(arg_2_1)
	self.formulaNums = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.formula_num or {}) do
		self.formulaNums[iter_2_1.id] = iter_2_1.num
	end

	return
end

function IslandBuildingAgency:IsSelf(arg_3_1)
	return arg_3_1 == getProxy(PlayerProxy):getRawData().id
end

function IslandBuildingAgency:GetBuilding(arg_4_1)
	return self.buildings[arg_4_1]
end

function IslandBuildingAgency:GetBuildings()
	return self.buildings
end

function IslandBuildingAgency:GetBuildingList()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(self.buildings) do
		table.insert(var_6_0, iter_6_1)
	end

	return var_6_0
end

function IslandBuildingAgency:UpdateBuilding(arg_7_1)
	self.buildings[arg_7_1.id] = arg_7_1

	return
end

function IslandBuildingAgency:UpdatePerSecond()
	for iter_8_0, iter_8_1 in pairs(self.buildings) do
		iter_8_1:UpdatePerSecond()
	end

	return
end

function IslandBuildingAgency:InitSlotDataByAbility(arg_9_1)
	local var_9_0 = self:GetBuilding(pg.island_production_slot[pg.island_ability_template[arg_9_1].effect].place)

	if not var_9_0 then
		warning("需要先解锁产地,再解锁产地上的槽位")

		return
	end

	if pg.island_production_slot[pg.island_ability_template[arg_9_1].effect].type == 1 then
		var_9_0:InitSlotHandPlantByAbility(pg.island_ability_template[arg_9_1].effect)
		getProxy(IslandProxy):GetIsland():DispatchEvent(IslandBuildingAgency.SLOT_HANDPLABT_SLOT_UNIT_CHANGE, {
			build_id = pg.island_production_slot[pg.island_ability_template[arg_9_1].effect].place,
			slotId = pg.island_ability_template[arg_9_1].effect
		})
	elseif pg.island_production_slot[pg.island_ability_template[arg_9_1].effect].type == 9 or pg.island_production_slot[pg.island_ability_template[arg_9_1].effect].type == 3 then
		var_9_0:InitSlotRoleDataByAbility(pg.island_ability_template[arg_9_1].effect)
	end

	return
end

function IslandBuildingAgency:InitBuildData(arg_10_1)
	if self.buildings[arg_10_1.id] then
		warning("产地已经解锁过了,下发的产地id是" .. arg_10_1.id)

		return
	end

	self.buildings[arg_10_1.id] = IslandBuilding.New(arg_10_1, true)

	local var_10_0 = getProxy(IslandProxy):GetIsland()

	if table.contains(IslandProductConst.haveModelPlaces, arg_10_1.id) then
		var_10_0:DispatchEvent(IslandBuildingAgency.CHANGE_PRODUCT_MODEL, {
			build_id = arg_10_1.id
		})
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.build_collect.collect_list or {}) do
		var_10_0:DispatchEvent(IslandBuildingAgency.COLLECT_SlOT_UNIT_INIT, {
			slotId = iter_10_1
		})
	end

	for iter_10_2, iter_10_3 in ipairs(arg_10_1.hand_list or {}) do
		var_10_0:DispatchEvent(IslandBuildingAgency.SLOT_HANDPLABT_SLOT_UNIT_CHANGE, {
			build_id = arg_10_1.id,
			slotId = iter_10_3.id
		})
	end

	for iter_10_4, iter_10_5 in ipairs(arg_10_1.appoint_list or {}) do
		local var_10_1 = {}

		for iter_10_6, iter_10_7 in ipairs(iter_10_5.part_list) do
			table.insert(var_10_1, iter_10_7)
		end

		if #var_10_1 > 0 then
			var_10_0:DispatchEvent(IslandBuildingAgency.GEN_ANIMAL_INT, {
				aniList = var_10_1,
				slotId = iter_10_5.id
			})
		end

		var_10_0:DispatchEvent(IslandBuildingAgency.SLOT_DELEGATE_INIT, {
			slotId = iter_10_5.id
		})
	end

	return
end

function IslandBuildingAgency:InitBuildAnimalDataByAbility(arg_11_1)
	if not self.buildings[pg.island_production_slot[pg.island_ranch_animal[arg_11_1].slot_id].place] then
		return
	end

	local var_11_0 = self.buildings[pg.island_production_slot[pg.island_ranch_animal[arg_11_1].slot_id].place]:GetDelegationSlotData(pg.island_ranch_animal[arg_11_1].slot_id)

	if not var_11_0 then
		return
	end

	var_11_0:AddAnimal(arg_11_1)
	getProxy(IslandProxy):GetIsland():DispatchEvent(IslandBuildingAgency.GEN_ANIMAL_INT, {
		aniList = {
			arg_11_1
		},
		slotId = pg.island_ranch_animal[arg_11_1].slot_id
	})

	return
end

function IslandBuildingAgency:InitHandSlotData(arg_12_1)
	local var_12_0 = self:GetBuilding(pg.island_production_slot[arg_12_1.id].place)

	if not var_12_0 then
		warning("需要先解锁产地,再解锁产地上的槽位")

		return
	end

	var_12_0:InitHandSlotData(arg_12_1)

	return
end

function IslandBuildingAgency:GetMinimumDelegationCompletionTimeByMapId(arg_13_1)
	local var_13_1

	for iter_13_0, iter_13_1 in ipairs(pg.island_production_place.get_id_list_by_map_id[arg_13_1] or {}) do
		if self.buildings[iter_13_1] then
			local var_13_2 = self.buildings[iter_13_1]:GetMinRoleDeleGationTime()

			if var_13_2 ~= -1 then
				var_13_1 = var_13_1 and math.min(var_13_2, var_13_1) or var_13_2
			end
		end
	end

	return var_13_1 and var_13_1 or -1
end

function IslandBuildingAgency:GetDelegationSlotDataByTechId(arg_14_1)
	if not self.buildings[IslandTechnologyAgency.PLACE_ID] then
		return
	end

	return self.buildings[IslandTechnologyAgency.PLACE_ID]:GetDelegationSlotDataByFormulaId(pg.island_technology_template[arg_14_1].formula_id)
end

function IslandBuildingAgency:GetDelegationSlotDataBySlotId(arg_15_1)
	return self.buildings[pg.island_production_slot[arg_15_1].place] and self.buildings[pg.island_production_slot[arg_15_1].place]:GetDelegationSlotData(arg_15_1)
end

function IslandBuildingAgency:GetBuildingListByMap(arg_16_1)
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(pg.island_production_place.get_id_list_by_map_id[arg_16_1] or {}) do
		table.insert(var_16_1, self.buildings[iter_16_1])
	end

	return var_16_1
end

function IslandBuildingAgency:OnSeasonReset()
	return
end

function IslandBuildingAgency:GetFormulaNums()
	return self.formulaNums
end

function IslandBuildingAgency:AddFormulaNum(arg_19_1, arg_19_2)
	if pg.island_formula[arg_19_1].is_condition ~= 1 then
		return
	end

	self.formulaNums[arg_19_1] = self.formulaNums[arg_19_1] and self.formulaNums[arg_19_1] + arg_19_2 or arg_19_2

	return
end

function IslandBuildingAgency:GetTipInfos()
	local var_20_0 = 0
	local var_20_1 = 0
	local var_20_2 = {}

	for iter_20_0, iter_20_1 in ipairs(pg.island_set.post_manage_produce.key_value_varchar) do
		if self.buildings[iter_20_1] then
			for iter_20_2, iter_20_3 in pairs(self.buildings[iter_20_1]:GetDelegationSlotDatas()) do
				if iter_20_3:GetSlotRewardData() then
					var_20_0 = var_20_0 + 1
				elseif iter_20_3:CanStartDelegationTip() then
					var_20_1 = var_20_1 + 1
				elseif iter_20_3:GetSlotRoleData() then
					table.insert(var_20_2, iter_20_3:GetSlotRoleData():GetFinishTime())
				end
			end
		end
	end

	return {
		awardCnt = var_20_0,
		emptyCnt = var_20_1,
		timestamps = var_20_2
	}
end

return IslandBuildingAgency
