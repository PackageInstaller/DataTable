local var_0_0 = class("IslandBuildingAgency", import(".IslandBaseAgency"))

var_0_0.COLLECT_SlOT_UNIT_INIT = "IslandBuildingAgency:COLLECT_SlOT_UNIT_INIT"
var_0_0.COLLECT_SlOT_UNIT_UPDATE = "IslandBuildingAgency:COLLECT_SlOT_UNIT_UPDATE"
var_0_0.COLLECT_SLOT_UNIT_REMOVE = "IslandBuildingAgency:COLLECT_SLOT_UNIT_REMOVE"
var_0_0.SLOT_HANDPLABT_SLOT_UNIT_CHANGE = "IslandBuildingAgency:SLOT_HANDPLABT_SLOT_UNIT_CHANGE"
var_0_0.SLOT_RESET_DELEGATION_STATE_DONE = "IslandBuildingAgency:SLOT_RESET_DELEGATION_STATE_DONE"
var_0_0.GEN_ANIMAL_INT = "IslandBuildingAgency:GEN_ANIMAL_INT"
var_0_0.CHANGE_PRODUCT_MODEL = "IslandBuildingAgency:CHANGE_PRODUCT_MODEL"
var_0_0.SLOT_DELEGATE_INIT = "IslandBuildingAgency:SLOT_DELEGATE_INIT"

function var_0_0.OnInit(arg_1_0, arg_1_1)
	arg_1_0.buildings = {}

	local var_1_0 = arg_1_1.build_list or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		arg_1_0.buildings[iter_1_1.id] = IslandBuilding.New(iter_1_1, arg_1_0:IsSelf(arg_1_1.id))
	end

	return
end

function var_0_0.InitPrivateData(arg_2_0, arg_2_1)
	arg_2_0.formulaNums = {}

	local var_2_0 = arg_2_1.formula_num or {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		arg_2_0.formulaNums[iter_2_1.id] = iter_2_1.num
	end

	return
end

function var_0_0.IsSelf(arg_3_0, arg_3_1)
	local var_3_0 = getProxy(PlayerProxy)

	return arg_3_1 == var_3_0:getRawData().id
end

function var_0_0.GetBuilding(arg_4_0, arg_4_1)
	return arg_4_0.buildings[arg_4_1]
end

function var_0_0.GetBuildings(arg_5_0)
	return arg_5_0.buildings
end

function var_0_0.GetBuildingList(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.buildings) do
		table.insert({}, iter_6_1)
	end

	return {}
end

function var_0_0.UpdateBuilding(arg_7_0, arg_7_1)
	arg_7_0.buildings[arg_7_1.id] = arg_7_1

	return
end

function var_0_0.UpdatePerSecond(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.buildings) do
		iter_8_1:UpdatePerSecond()
	end

	return
end

function var_0_0.InitSlotDataByAbility(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:GetBuilding(pg.island_production_slot[pg.island_ability_template[arg_9_1].effect].place)

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

function var_0_0.InitBuildData(arg_10_0, arg_10_1)
	if arg_10_0.buildings[arg_10_1.id] then
		warning("产地已经解锁过了,下发的产地id是" .. arg_10_1.id)

		return
	end

	arg_10_0.buildings[arg_10_1.id] = IslandBuilding.New(arg_10_1, true)

	local var_10_0 = getProxy(IslandProxy):GetIsland()

	if table.contains(IslandProductConst.haveModelPlaces, arg_10_1.id) then
		var_10_0:DispatchEvent(IslandBuildingAgency.CHANGE_PRODUCT_MODEL, {
			build_id = arg_10_1.id
		})
	end

	local var_10_2 = arg_10_1.build_collect.collect_list or {}

	for iter_10_0, iter_10_1 in var_10_1(var_10_2) do
		var_10_0:DispatchEvent(IslandBuildingAgency.COLLECT_SlOT_UNIT_INIT, {
			slotId = iter_10_1
		})
	end

	local var_10_3 = arg_10_1.hand_list or {}

	for iter_10_2, iter_10_3 in ipairs(var_10_3) do
		var_10_0:DispatchEvent(IslandBuildingAgency.SLOT_HANDPLABT_SLOT_UNIT_CHANGE, {
			build_id = arg_10_1.id,
			slotId = iter_10_3.id
		})
	end

	local var_10_4 = arg_10_1.appoint_list or {}

	for iter_10_4, iter_10_5 in ipairs(var_10_4) do
		for iter_10_6, iter_10_7 in ipairs(iter_10_5.part_list) do
			table.insert({}, iter_10_7)
		end

		if #{} > 0 then
			var_10_0:DispatchEvent(IslandBuildingAgency.GEN_ANIMAL_INT, {
				aniList = {},
				slotId = iter_10_5.id
			})
		end

		var_10_0:DispatchEvent(IslandBuildingAgency.SLOT_DELEGATE_INIT, {
			slotId = iter_10_5.id
		})
	end

	return
end

function var_0_0.InitBuildAnimalDataByAbility(arg_11_0, arg_11_1)
	if not arg_11_0.buildings[pg.island_production_slot[pg.island_ranch_animal[arg_11_1].slot_id].place] then
		return
	end

	local var_11_0 = arg_11_0.buildings[pg.island_production_slot[pg.island_ranch_animal[arg_11_1].slot_id].place]:GetDelegationSlotData(pg.island_ranch_animal[arg_11_1].slot_id)

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

function var_0_0.InitHandSlotData(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:GetBuilding(pg.island_production_slot[arg_12_1.id].place)

	if not var_12_0 then
		warning("需要先解锁产地,再解锁产地上的槽位")

		return
	end

	var_12_0:InitHandSlotData(arg_12_1)

	return
end

function var_0_0.GetMinimumDelegationCompletionTimeByMapId(arg_13_0, arg_13_1)
	local var_13_0 = pg.island_production_place.get_id_list_by_map_id[arg_13_1] or {}
	local var_13_1

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if arg_13_0.buildings[iter_13_1] then
			local var_13_2 = arg_13_0.buildings[iter_13_1]:GetMinRoleDeleGationTime()

			if var_13_2 ~= -1 then
				var_13_1 = var_13_1 and math.min(var_13_2, var_13_1) or var_13_2
			end
		end
	end

	return var_13_1 and var_13_1 or -1
end

function var_0_0.GetDelegationSlotDataByTechId(arg_14_0, arg_14_1)
	if not arg_14_0.buildings[IslandTechnologyAgency.PLACE_ID] then
		return
	end

	return arg_14_0.buildings[IslandTechnologyAgency.PLACE_ID]:GetDelegationSlotDataByFormulaId(pg.island_technology_template[arg_14_1].formula_id)
end

function var_0_0.GetDelegationSlotDataBySlotId(arg_15_0, arg_15_1)
	return arg_15_0.buildings[pg.island_production_slot[arg_15_1].place] and arg_15_0.buildings[pg.island_production_slot[arg_15_1].place]:GetDelegationSlotData(arg_15_1)
end

function var_0_0.GetBuildingListByMap(arg_16_0, arg_16_1)
	local var_16_0 = pg.island_production_place.get_id_list_by_map_id[arg_16_1] or {}
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		table.insert(var_16_1, arg_16_0.buildings[iter_16_1])
	end

	return var_16_1
end

function var_0_0.OnSeasonReset(arg_17_0)
	return
end

function var_0_0.GetFormulaNums(arg_18_0)
	return arg_18_0.formulaNums
end

function var_0_0.AddFormulaNum(arg_19_0, arg_19_1, arg_19_2)
	if pg.island_formula[arg_19_1].is_condition ~= 1 then
		return
	end

	arg_19_0.formulaNums[arg_19_1] = arg_19_0.formulaNums[arg_19_1] and arg_19_0.formulaNums[arg_19_1] + arg_19_2 or arg_19_2

	return
end

function var_0_0.GetTipInfos(arg_20_0)
	local var_20_0 = 0
	local var_20_1 = 0

	for iter_20_0, iter_20_1 in ipairs(pg.island_set.post_manage_produce.key_value_varchar) do
		if arg_20_0.buildings[iter_20_1] then
			for iter_20_2, iter_20_3 in pairs(arg_20_0.buildings[iter_20_1]:GetDelegationSlotDatas()) do
				if iter_20_3:GetSlotRewardData() then
					var_20_0 = var_20_0 + 1
				elseif iter_20_3:CanStartDelegationTip() then
					var_20_1 = var_20_1 + 1
				elseif iter_20_3:GetSlotRoleData() then
					local var_20_2 = iter_20_3:GetSlotRoleData()

					table.insert({}, var_20_2:GetFinishTime())
				end
			end
		end
	end

	return {
		awardCnt = var_20_0,
		emptyCnt = var_20_1,
		timestamps = {}
	}
end

return var_0_0
