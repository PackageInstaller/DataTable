class = var_0_10000

local var_0_0 = "IslandBuildingAgency"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseAgency"))

var_0_1.COLLECT_SlOT_UNIT_INIT = "IslandBuildingAgency:COLLECT_SlOT_UNIT_INIT"
var_0_1.COLLECT_SlOT_UNIT_UPDATE = "IslandBuildingAgency:COLLECT_SlOT_UNIT_UPDATE"
var_0_1.COLLECT_SLOT_UNIT_REMOVE = "IslandBuildingAgency:COLLECT_SLOT_UNIT_REMOVE"
var_0_1.SLOT_HANDPLABT_SLOT_UNIT_CHANGE = "IslandBuildingAgency:SLOT_HANDPLABT_SLOT_UNIT_CHANGE"
var_0_1.SLOT_RESET_DELEGATION_STATE_DONE = "IslandBuildingAgency:SLOT_RESET_DELEGATION_STATE_DONE"
var_0_1.GEN_ANIMAL_INT = "IslandBuildingAgency:GEN_ANIMAL_INT"
var_0_1.CHANGE_PRODUCT_MODEL = "IslandBuildingAgency:CHANGE_PRODUCT_MODEL"
var_0_1.SLOT_DELEGATE_INIT = "IslandBuildingAgency:SLOT_DELEGATE_INIT"

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0.buildings = {}
	ipairs = var_2

	local var_1_0

	if not arg_1_1.build_list then
		var_1_0 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_0) do
		IslandBuilding = var_1_10007
		var_1_10007 = var_1_10007.New(iter_1_1, arg_1_0:IsSelf(arg_1_1.id))
		arg_1_0.buildings[iter_1_1.id] = var_1_10007
	end

	return
end

function var_0_1.InitPrivateData(arg_2_0, arg_2_1)
	arg_2_0.formulaNums = {}
	ipairs = var_2

	local var_2_0

	if not arg_2_1.formula_num then
		var_2_0 = {}
	end

	for iter_2_0, iter_2_1 in var_2(var_2_0) do
		arg_2_0.formulaNums[iter_2_1.id] = iter_2_1.num
	end

	return
end

function var_0_1.IsSelf(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_3_0 = var_1_10002(var_1_10004)

	return arg_3_1 == var_2.getRawData(var_3_0).id
end

function var_0_1.GetBuilding(arg_4_0, arg_4_1)
	return arg_4_0.buildings[arg_4_1]
end

function var_0_1.GetBuildings(arg_5_0)
	return arg_5_0.buildings
end

function var_0_1.GetBuildingList(arg_6_0)
	local var_6_0 = {}

	pairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.buildings) do
		table = var_1_10007

		var_1_10007.insert(var_6_0, iter_6_1)
	end

	return var_6_0
end

function var_0_1.UpdateBuilding(arg_7_0, arg_7_1)
	arg_7_0.buildings[arg_7_1.id] = arg_7_1

	return
end

function var_0_1.UpdatePerSecond(arg_8_0)
	pairs = var_1_10001

	for iter_8_0, iter_8_1 in var_1_10001(arg_8_0.buildings) do
		iter_8_1:UpdatePerSecond()
	end

	return
end

function var_0_1.InitSlotDataByAbility(arg_9_0, arg_9_1)
	pg = var_1_10002

	local var_9_0 = var_1_10002.island_ability_template[arg_9_1].effect

	pg = var_1_10004

	local var_9_1 = var_1_10004.island_production_slot[var_9_0].place

	if not arg_9_0:GetBuilding(var_9_1) then
		warning = var_1_10007

		var_1_10007("需要先解锁产地,再解锁产地上的槽位")

		return
	end

	if var_4.type == 1 then
		local var_9_2 = var_6

		var_6.InitSlotHandPlantByAbility(var_9_2, var_9_0)

		getProxy = var_7
		IslandProxy = var_9_2

		local var_9_3 = var_7(var_9_2)
		local var_9_4 = var_7.GetIsland(var_9_3)
		local var_9_5 = var_7.DispatchEvent

		IslandBuildingAgency = var_1_10011

		var_9_5(var_9_4, var_1_10011.SLOT_HANDPLABT_SLOT_UNIT_CHANGE, {
			build_id = var_9_1,
			slotId = var_9_0
		})
	elseif var_4.type == 9 or var_4.type == 3 then
		var_6:InitSlotRoleDataByAbility(var_9_0)
	end

	return
end

function var_0_1.InitBuildData(arg_10_0, arg_10_1)
	if arg_10_0.buildings[arg_10_1.id] then
		warning = var_2

		var_2("产地已经解锁过了,下发的产地id是" .. arg_10_1.id)

		return
	end

	IslandBuilding = var_2

	local var_10_0 = var_2.New(arg_10_1, true)
	local var_10_1 = arg_10_0.buildings

	var_10_1[arg_10_1.id] = var_10_0
	getProxy = var_10_1
	IslandProxy = var_5

	local var_10_2 = var_10_1(var_5)
	local var_10_3 = var_3.GetIsland(var_10_2)

	table = var_4

	local var_10_4 = var_4.contains

	IslandProductConst = var_1_10006

	local var_10_6

	if var_10_4(var_1_10006.haveModelPlaces, arg_10_1.id) then
		local var_10_5 = var_10_3

		var_10_6 = var_10_3.DispatchEvent
		IslandBuildingAgency = var_7

		var_10_6(var_10_5, var_7.CHANGE_PRODUCT_MODEL, {
			build_id = arg_10_1.id
		})
	end

	ipairs = var_10_6

	local var_10_7

	if not arg_10_1.build_collect.collect_list then
		var_10_7 = {}
	end

	for iter_10_0, iter_10_1 in var_10_6(var_10_7) do
		local var_10_8 = var_10_3
		local var_10_9 = var_10_3.DispatchEvent

		IslandBuildingAgency = var_1_10012

		var_10_9(var_10_8, var_1_10012.COLLECT_SlOT_UNIT_INIT, {
			slotId = iter_10_1
		})
	end

	ipairs = var_4

	local var_10_10

	if not arg_10_1.hand_list then
		var_10_10 = {}
	end

	for iter_10_2, iter_10_3 in var_4(var_10_10) do
		local var_10_11 = var_10_3
		local var_10_12 = var_10_3.DispatchEvent

		IslandBuildingAgency = var_1_10012

		var_10_12(var_10_11, var_1_10012.SLOT_HANDPLABT_SLOT_UNIT_CHANGE, {
			build_id = arg_10_1.id,
			slotId = iter_10_3.id
		})
	end

	ipairs = var_4

	local var_10_13

	if not arg_10_1.appoint_list then
		var_10_13 = {}
	end

	for iter_10_4, iter_10_5 in var_4(var_10_13) do
		local var_10_14 = {}

		ipairs = var_1_10010

		for iter_10_6, iter_10_7 in var_1_10010(iter_10_5.part_list) do
			table = var_1_10015

			var_1_10015.insert(var_10_14, iter_10_7)
		end

		if #var_10_14 > 0 then
			local var_10_15 = var_10_3

			var_1_10010 = var_10_3.DispatchEvent
			IslandBuildingAgency = iter_10_6

			var_1_10010(var_10_15, iter_10_6.GEN_ANIMAL_INT, {
				aniList = var_10_14,
				slotId = iter_10_5.id
			})
		end

		local var_10_16 = var_10_3

		var_1_10010 = var_10_3.DispatchEvent
		IslandBuildingAgency = iter_10_6

		var_1_10010(var_10_16, iter_10_6.SLOT_DELEGATE_INIT, {
			slotId = iter_10_5.id
		})
	end

	return
end

function var_0_1.InitBuildAnimalDataByAbility(arg_11_0, arg_11_1)
	pg = var_1_10002

	local var_11_0 = var_1_10002.island_ranch_animal[arg_11_1].slot_id

	pg = var_1_10003

	local var_11_1 = var_1_10003.island_production_slot[var_11_0].place

	if not arg_11_0.buildings[var_11_1] then
		return
	end

	if not var_4:GetDelegationSlotData(var_11_0) then
		return
	end

	local var_11_2 = var_5

	var_5.AddAnimal(var_11_2, arg_11_1)

	getProxy = var_6
	IslandProxy = var_11_2

	local var_11_3 = var_6(var_11_2)
	local var_11_4 = var_6.GetIsland(var_11_3)
	local var_11_5 = var_6.DispatchEvent

	IslandBuildingAgency = var_1_10010

	var_11_5(var_11_4, var_1_10010.GEN_ANIMAL_INT, {
		aniList = {
			arg_11_1
		},
		slotId = var_11_0
	})

	return
end

function var_0_1.InitHandSlotData(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.id

	pg = var_1_10003

	local var_12_1 = var_1_10003.island_production_slot[var_12_0].place

	if not arg_12_0:GetBuilding(var_12_1) then
		warning = var_1_10006

		var_1_10006("需要先解锁产地,再解锁产地上的槽位")

		return
	end

	var_5:InitHandSlotData(arg_12_1)

	return
end

function var_0_1.GetMinimumDelegationCompletionTimeByMapId(arg_13_0, arg_13_1)
	pg = var_1_10002

	local var_13_0

	if not var_1_10002.island_production_place.get_id_list_by_map_id[arg_13_1] then
		var_13_0 = {}
	end

	local var_13_1

	ipairs = var_1_10004

	for iter_13_0, iter_13_1 in var_1_10004(var_13_0) do
		if arg_13_0.buildings[iter_13_1] and var_9:GetMinRoleDeleGationTime() ~= -1 then
			if var_13_1 then
				math = var_1_10011

				if not var_1_10011.min(var_10, var_13_1) then
					::label_13_0::

					var_13_1 = var_10
				end
			end
		end
	end

	return var_13_1 and var_13_1 or -1
end

function var_0_1.GetDelegationSlotDataByTechId(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.buildings

	IslandTechnologyAgency = var_1_10003

	if not var_14_0[var_1_10003.PLACE_ID] then
		return
	end

	pg = var_3

	local var_14_1 = var_3.island_technology_template[arg_14_1].formula_id

	return var_2:GetDelegationSlotDataByFormulaId(var_14_1)
end

function var_0_1.GetDelegationSlotDataBySlotId(arg_15_0, arg_15_1)
	pg = var_1_10002

	local var_15_0 = var_1_10002.island_production_slot[arg_15_1].place

	return arg_15_0.buildings[var_15_0] and var_3:GetDelegationSlotData(arg_15_1)
end

function var_0_1.GetBuildingListByMap(arg_16_0, arg_16_1)
	pg = var_1_10002

	local var_16_0

	if not var_1_10002.island_production_place.get_id_list_by_map_id[arg_16_1] then
		var_16_0 = {}
	end

	local var_16_1 = {}

	ipairs = var_1_10004

	for iter_16_0, iter_16_1 in var_1_10004(var_16_0) do
		local var_16_2 = arg_16_0.buildings[iter_16_1]

		table = var_1_10010

		var_1_10010.insert(var_16_1, var_16_2)
	end

	return var_16_1
end

function var_0_1.OnSeasonReset(arg_17_0)
	return
end

function var_0_1.GetFormulaNums(arg_18_0)
	return arg_18_0.formulaNums
end

function var_0_1.AddFormulaNum(arg_19_0, arg_19_1, arg_19_2)
	pg = var_1_10003

	if var_1_10003.island_formula[arg_19_1].is_condition ~= 1 then
		return
	end

	if arg_19_0.formulaNums[arg_19_1] then
		arg_19_0.formulaNums[arg_19_1] = arg_19_0.formulaNums[arg_19_1] + arg_19_2
	else
		arg_19_0.formulaNums[arg_19_1] = arg_19_2
	end

	return
end

function var_0_1.GetTipInfos(arg_20_0)
	local var_20_0 = 0
	local var_20_1 = 0
	local var_20_2 = {}

	ipairs = var_1_10004
	pg = var_1_10006

	for iter_20_0, iter_20_1 in var_1_10004(var_1_10006.island_set.post_manage_produce.key_value_varchar) do
		if arg_20_0.buildings[iter_20_1] then
			pairs = var_1_10010

			for iter_20_2, iter_20_3 in var_1_10010(var_9:GetDelegationSlotDatas()) do
				if iter_20_3:GetSlotRewardData() then
					var_20_0 = var_20_0 + 1
				elseif iter_20_3:CanStartDelegationTip() then
					var_20_1 = var_20_1 + 1
				elseif iter_20_3:GetSlotRoleData() then
					table = var_15

					local var_20_3 = var_15.insert
					local var_20_4 = var_20_2
					local var_20_5 = iter_20_3:GetSlotRoleData()

					var_20_3(var_20_4, var_18.GetFinishTime(var_20_5))
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

return var_0_1
