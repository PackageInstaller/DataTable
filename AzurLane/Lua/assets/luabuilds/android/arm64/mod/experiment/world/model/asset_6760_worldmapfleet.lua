class = var_0_10000

local var_0_0 = "WorldMapFleet"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".WorldBaseFleet"))

var_0_1.Fields = {
	ammo = "number",
	lossFlag = "number",
	catSalvageList = "table",
	skills = "table",
	index = "number",
	column = "number",
	buffs = "table",
	catSalvageStep = "number",
	row = "number",
	damageLevel = "number",
	defeatEnemies = "number",
	ammoMax = "number",
	catSalvageFrom = "number",
	carries = "table"
}
var_0_1.EventUpdateLocation = "WorldMapFleet.EventUpdateLocation"
var_0_1.EventUpdateShipOrder = "WorldMapFleet.EventUpdateShipOrder"
var_0_1.EventAddShip = "WorldMapFleet.EventAddShip"
var_0_1.EventRemoveShip = "WorldMapFleet.EventRemoveShip"
var_0_1.EventAddCarry = "WorldMapFleet.EventAddCarry"
var_0_1.EventRemoveCarry = "WorldMapFleet.EventRemoveCarry"
var_0_1.EventUpdateBuff = "WorldMapFleet.EventUpdateBuff"
var_0_1.EventUpdateDamageLevel = "WorldMapFleet.EventUpdateDamageLevel"
var_0_1.EventUpdateDefeat = "WorldMapFleet.EventUpdateDefeat"
var_0_1.EventUpdateCatSalvage = "WorldMapFleet.EventUpdateCatSalvage"
var_0_1.EventUpdateFlashTips = "WorldMapFleet.EventUpdateFlashTips"

function var_0_1.GetName(arg_1_0)
	return "fleet_" .. arg_1_0
end

function var_0_1.DebugPrint(arg_2_0)
	_ = var_1_10001

	local var_2_0 = var_1_10001.map(arg_2_0:GetBuffList(), function(arg_3_0)
		return arg_3_0.id .. "#" .. arg_3_0:GetFloor()
	end)

	_ = var_1_10002

	local var_2_1 = var_1_10002.map(arg_2_0.carries, function(arg_4_0)
		return "carries"
	end)
	local var_2_2 = arg_2_0
	local var_2_3, var_2_4 = arg_2_0.GetAmmo(var_2_2)

	string = var_2_2

	local var_2_5 = var_2_2.format
	local var_2_6 = "[第%s舰队] [id: %s] [位置: %s, %s] [弹药: %s/%s] [携带物: %s] [战损: %s] [buff: %s]"
	local var_2_7 = arg_2_0.index
	local var_2_8 = arg_2_0.id
	local var_2_9 = arg_2_0.row
	local var_2_10 = arg_2_0.column
	local var_2_11 = var_2_3
	local var_2_12 = var_2_4

	table = var_1_10014

	local var_2_13 = var_1_10014.concat(var_2_1, ", ")
	local var_2_14 = arg_2_0.damageLevel

	table = var_16

	local var_2_15 = var_2_5(var_2_6, var_2_7, var_2_8, var_2_9, var_2_10, var_2_11, var_2_12, var_2_13, var_2_14, var_16.concat(var_2_0, ", "))
	local var_2_16 = {}

	TeamType = var_2_6
	var_2_16[var_2_6.Main] = "主力"
	TeamType = var_7
	var_2_16[var_7.Vanguard] = "先锋"
	TeamType = var_7
	var_2_16[var_7.Submarine] = "潜艇"

	local var_2_17 = {}

	ipairs = var_8

	for iter_2_0, iter_2_1 in var_8(arg_2_0:GetShips(true)) do
		WorldConst = var_2_18

		local var_2_18 = var_2_18.FetchShipVO(iter_2_1.id)

		_ = var_2_13
		var_2_13 = var_2_13.map(iter_2_1:GetBuffList(), function(arg_5_0)
			return arg_5_0.id .. "#" .. arg_5_0:GetFloor()
		end)
		string = var_15

		local var_2_19 = var_15.format
		local var_2_20 = "\t\t[%s] [id: %s] [config_id: %s] [%s] [hp: %s%%] [buff: %s]" .. " <material=underline c=#A9F548 event=ShipProperty args=%s><color=#A9F548>属性</color></material>"
		local var_2_21 = var_2_18:getName()
		local var_2_22 = var_2_18.id
		local var_2_23 = var_2_18.configId
		local var_2_24 = var_2_18
		local var_2_25 = var_2_16[var_2_18.getTeamType(var_2_24)]
		local var_2_26 = iter_2_1.hpRant / 100

		table = var_2_24

		local var_2_27 = var_2_19(var_2_20, var_2_21, var_2_22, var_2_23, var_2_25, var_2_26, var_2_24.concat(var_2_13, ", "), var_2_18.id)

		table = var_16

		var_16.insert(var_2_17, var_2_27)
	end

	local var_2_28 = var_2_15
	local var_2_29 = "\n"

	table = var_10

	return var_2_28 .. var_2_29 .. var_10.concat(var_2_17, "\n")
end

function var_0_1.Build(arg_6_0)
	var_0_1.super.Build(arg_6_0)

	arg_6_0.carries = {}

	return
end

function var_0_1.Setup(arg_7_0, arg_7_1)
	arg_7_0.id = arg_7_1.id
	_ = var_2

	local var_7_0 = var_2.map(arg_7_1.ship_list, function(arg_8_0)
		WPool = var_2_10001

		local var_8_0 = var_2_10001
		local var_8_1 = var_2_10001.Get

		WorldMapShip = var_2_10004

		local var_8_2 = var_8_1(var_8_0, var_2_10004)

		var_1.Setup(var_8_2, arg_8_0)

		return var_1
	end)

	arg_7_0:UpdateShips(var_7_0)

	arg_7_0.commanderIds = {}
	ipairs = var_3

	local var_7_1

	if not arg_7_1.commander_list then
		var_7_1 = {}
	end

	for iter_7_0, iter_7_1 in var_3(var_7_1) do
		arg_7_0.commanderIds[iter_7_1.pos] = iter_7_1.id
	end

	arg_7_0.skills = {}

	arg_7_0:updateCommanderSkills()

	arg_7_0.row = arg_7_1.pos.row
	arg_7_0.column = arg_7_1.pos.column
	arg_7_0.ammo = arg_7_1.bullet
	arg_7_0.ammoMax = arg_7_1.bullet_max
	math = var_3

	local var_7_2 = var_3.clamp
	local var_7_3 = arg_7_1.damage_level
	local var_7_4 = 0

	WorldConst = iter_7_1
	arg_7_0.damageLevel = var_7_2(var_7_3, var_7_4, #iter_7_1.DamageBuffList)
	_ = var_3

	var_3.each(arg_7_1.attach_list, function(arg_9_0)
		WPool = var_2_10001

		local var_9_0 = var_2_10001
		local var_9_1 = var_2_10001.Get

		WorldCarryItem = var_2_10004

		local var_9_2 = var_9_1(var_9_0, var_2_10004)

		var_1.Setup(var_9_2, arg_9_0)

		table = var_2

		var_2.insert(arg_7_0.carries, var_1)

		return
	end)

	WorldConst = var_3
	arg_7_0.buffs = var_3.ParsingBuffs(arg_7_1.buff_list)
	arg_7_0.defeatEnemies = arg_7_1.kill_count
	arg_7_0.catSalvageStep = arg_7_1.cmd_collection.progress
	arg_7_0.catSalvageList = arg_7_1.cmd_collection.progress_list
	arg_7_0.catSalvageFrom = arg_7_1.cmd_collection.random_id

	local var_7_5 = arg_7_0:GetFleetType()

	FleetType = var_4

	if var_7_5 == var_4.Submarine then
		arg_7_0.row = -1
		arg_7_0.column = -1
	end

	return
end

function var_0_1.GetCost(arg_10_0)
	local var_10_0 = {
		gold = 0,
		oil = 0
	}
	local var_10_1 = {
		gold = 0,
		oil = 0
	}

	return var_10_0, var_10_1
end

function var_0_1.GetFleetIndex(arg_11_0)
	return arg_11_0.index
end

function var_0_1.GetDefaultName(arg_12_0)
	Fleet = var_1_10001

	local var_12_0 = var_1_10001.DEFAULT_NAME

	TeamType = var_1_10002

	local var_12_1

	if not (#arg_12_0[var_1_10002.Submarine] > 0) or not (arg_12_0.index + 10) then
		var_12_1 = arg_12_0.index
	end

	return var_12_0[var_12_1]
end

function var_0_1.FormationEqual(arg_13_0, arg_13_1)
	_ = var_1_10002

	local var_13_0 = var_1_10002.map(arg_13_0:GetShips(true), function(arg_14_0)
		return arg_14_0.id
	end)

	_ = var_1_10003

	local var_13_1 = var_1_10003.map(arg_13_1:GetShips(true), function(arg_15_0)
		return arg_15_0.id
	end)
	local var_13_2 = 1

	math = var_5

	for iter_13_0 = var_13_2, var_5.max(#var_13_0, #var_13_1) do
		if var_13_0[iter_13_0] ~= var_13_1[iter_13_0] then
			return false
		end
	end

	return true
end

function var_0_1.GetPropertiesSum(arg_16_0)
	local var_16_0 = {
		cannon = 0,
		antiAir = 0,
		air = 0,
		torpedo = 0
	}
	local var_16_1 = arg_16_0:GetShipVOs(true)

	ipairs = var_1_10003

	for iter_16_0, iter_16_1 in var_1_10003(var_16_1) do
		local var_16_2 = iter_16_1
		local var_16_3 = iter_16_1.getProperties(var_16_2)
		local var_16_4 = var_16_0.cannon

		math = var_16_2
		var_16_0.cannon = var_16_4 + var_16_2.floor(var_16_3.cannon)

		local var_16_5 = var_16_0.torpedo

		math = var_10
		var_16_0.torpedo = var_16_5 + var_10.floor(var_16_3.torpedo)

		local var_16_6 = var_16_0.antiAir

		math = var_10
		var_16_0.antiAir = var_16_6 + var_10.floor(var_16_3.antiaircraft)

		local var_16_7 = var_16_0.air

		math = var_10
		var_16_0.air = var_16_7 + var_10.floor(var_16_3.air)
	end

	return var_16_0
end

function var_0_1.GetGearScoreSum(arg_17_0, arg_17_1)
	local var_17_0 = 0
	local var_17_1

	if not arg_17_1 or not arg_17_0:GetTeamShipVOs(arg_17_1) then
		var_17_1 = arg_17_0:GetShipVOs()
	end

	ipairs = var_1_10004

	for iter_17_0, iter_17_1 in var_1_10004(var_17_1) do
		var_17_0 = var_17_0 + iter_17_1:getShipCombatPower()
	end

	return var_17_0
end

function var_0_1.GetLevelCount(arg_18_0)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.GetShipVOs(var_18_0)
	local var_18_2 = 0

	underscore = var_18_0

	var_18_0.each(var_18_1, function(arg_19_0)
		var_18_2 = var_18_2 + arg_19_0.level

		return
	end)

	return var_18_2
end

function var_0_1.AddShip(arg_20_0, arg_20_1, arg_20_2)
	assert = var_1_10003

	local var_20_0 = arg_20_1.class

	WorldMapShip = var_1_10006

	var_1_10003(var_20_0 == var_1_10006)

	assert = var_1_10003
	_ = var_5

	var_1_10003(not var_5.any(arg_20_0:GetShips(true), function(arg_21_0)
		return arg_21_0.id == arg_20_1.id
	end), "ship exist in port: " .. arg_20_1.id)

	WorldConst = var_1_10003

	local var_20_1 = var_1_10003.FetchRawShipVO(arg_20_1.id)

	assert = var_1_10004

	var_1_10004(var_20_1, "ship not exist: " .. arg_20_1.id)

	local var_20_2 = arg_20_0[var_20_1:getTeamType()]

	arg_20_2 = arg_20_2 or #var_20_2 + 1
	arg_20_1.fleetId = arg_20_0.id
	table = var_5

	var_5.insert(var_20_2, arg_20_2, arg_20_1)
	arg_20_0:DispatchEvent(var_0_1.EventAddShip, arg_20_1)

	return
end

function var_0_1.RemoveShip(arg_22_0, arg_22_1)
	WorldConst = var_1_10002

	local var_22_0 = var_1_10002.FetchRawShipVO(arg_22_1)

	assert = var_1_10003

	var_1_10003(var_22_0, "ship not exist: " .. arg_22_1)

	for iter_22_0 = #arg_22_0[var_22_0:getTeamType()], 1, -1 do
		if var_3[iter_22_0].id == arg_22_1 then
			table = var_8

			local var_22_1 = var_8.remove(var_3, iter_22_0)

			var_22_1.fleetId = nil

			arg_22_0:DispatchEvent(var_0_1.EventRemoveShip, var_22_1)

			return var_22_1, iter_22_0
		end
	end

	return
end

function var_0_1.ReplaceShip(arg_23_0, arg_23_1, arg_23_2)
	assert = var_1_10003

	var_1_10003(arg_23_0:GetShip(arg_23_1))

	if arg_23_0:GetShip(arg_23_2.id) then
		arg_23_0:SwitchShip(arg_23_1, arg_23_2.id)
	else
		local var_23_0, var_23_1 = arg_23_0:RemoveShip(arg_23_1)

		arg_23_0:AddShip(arg_23_2, var_23_1)
	end

	return
end

function var_0_1.SwitchShip(arg_24_0, arg_24_1, arg_24_2)
	WorldConst = var_1_10003

	local var_24_0 = var_1_10003.FetchRawShipVO(arg_24_1)

	WorldConst = var_1_10004

	local var_24_1 = var_1_10004.FetchRawShipVO(arg_24_2)

	assert = var_5

	var_5(var_24_0 and var_24_1)

	local var_24_2 = var_24_0
	local var_24_3 = var_24_0.getTeamType(var_24_2)
	local var_24_4 = var_24_1:getTeamType()

	assert = var_24_2

	var_24_2(var_24_3 == var_24_4)

	local var_24_5
	local var_24_6

	ipairs = var_9

	for iter_24_0, iter_24_1 in var_9(arg_24_0[var_24_3]) do
		if iter_24_1.id == arg_24_1 then
			var_24_5 = iter_24_0
		end

		if iter_24_1.id == arg_24_2 then
			var_24_6 = iter_24_0
		end
	end

	if var_24_5 ~= var_24_6 then
		arg_24_0[var_24_3][var_24_5], arg_24_0[var_24_4][var_24_6] = arg_24_0[var_24_4][var_24_6], arg_24_0[var_24_3][var_24_5]

		arg_24_0:DispatchEvent(var_0_1.EventUpdateShipOrder)
	end

	return
end

function var_0_1.CheckRemoveShip(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1
	local var_25_1 = arg_25_1.getTeamType(var_25_0)

	if #arg_25_0:GetTeamShips(var_25_1, true) == 1 then
		local var_25_2 = false

		i18n = var_25_0

		local var_25_3 = "ship_formationUI_removeError_onlyShip"
		local var_25_4 = arg_25_1
		local var_25_5 = arg_25_1.getConfig(var_25_4, "name")
		local var_25_6 = ""

		Fleet = var_25_4

		local var_25_7 = var_25_0(var_25_3, var_25_5, var_25_6, var_25_4.C_TEAM_NAME[var_25_1])

		return
	end

	return true
end

function var_0_1.CheckChangeShip(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0

	if arg_26_1 then
		::label_26_0::

		WorldConst = var_26_0
		var_26_0 = var_26_0.FetchWorldShip(arg_26_1.id).fleetId
		WorldConst = var_1_10004
		var_26_0 = var_26_0 == var_1_10004.FetchWorldShip(arg_26_2.id).fleetId
	end

	if not var_26_0 and (not arg_26_1 or not arg_26_1:isSameKind(arg_26_2)) then
		_ = var_1_10004

		if var_1_10004.any(arg_26_0:GetShips(true), function(arg_27_0)
			WorldConst = var_2_10001

			local var_27_0 = var_2_10001.FetchRawShipVO(arg_27_0.id)

			return var_1.isSameKind(var_27_0, arg_26_2)
		end) then
			local var_26_1 = false

			i18n = var_1_10005

			local var_26_2 = var_1_10005("ship_formationMediator_changeNameError_sameShip")

			return
		end
	end

	return true
end

function var_0_1.GetAmmo(arg_28_0)
	return arg_28_0.ammo, arg_28_0.ammoMax
end

function var_0_1.UseAmmo(arg_29_0)
	assert = var_1_10001

	var_1_10001(arg_29_0.ammo > 0, "without ammo")

	arg_29_0.ammo = arg_29_0.ammo - 1

	return
end

function var_0_1.GetTotalAmmo(arg_30_0)
	_ = var_1_10001

	return var_1_10001.reduce(arg_30_0:GetShips(true), 0, function(arg_31_0, arg_31_1)
		local var_31_0 = arg_31_1:GetImportWorldShipVO()

		return arg_31_0 + var_2.getShipAmmo(var_31_0)
	end)
end

function var_0_1.RepairSubmarine(arg_32_0)
	_ = var_1_10001

	local var_32_0 = var_1_10001.each
	local var_32_1 = arg_32_0
	local var_32_2 = arg_32_0.GetTeamShips

	TeamType = var_1_10006

	var_32_0(var_32_2(var_32_1, var_1_10006.Submarine, true), function(arg_33_0)
		arg_33_0:Repair()

		return
	end)

	arg_32_0.ammo = arg_32_0:GetTotalAmmo()
	arg_32_0.ammoMax = arg_32_0.ammo

	return
end

function var_0_1.GetSpeed(arg_34_0)
	pg = var_1_10001

	local var_34_0 = var_1_10001.gameset.world_move_initial_step.key_value
	local var_34_1 = arg_34_0
	local var_34_2 = arg_34_0.GetBuffsByTrap

	WorldBuff = var_1_10005

	if #var_34_2(var_34_1, var_1_10005.TrapVortex) > 0 then
		math = var_2
		var_34_0 = var_2.min(var_34_0, 1)
	end

	ipairs = var_2

	local var_34_3 = arg_34_0
	local var_34_4 = arg_34_0.GetBuffsByTrap

	WorldBuff = var_1_10007

	for iter_34_0, iter_34_1 in var_2(var_34_4(var_34_3, var_1_10007.TrapCripple)) do
		math = var_7
		var_34_0 = var_7.min(var_34_0, iter_34_1:GetTrapParams()[2])
	end

	return var_34_0
end

function var_0_1.GetStepDurationRate(arg_35_0)
	local var_35_0 = 1

	ipairs = var_1_10002

	local var_35_1 = arg_35_0
	local var_35_2 = arg_35_0.GetBuffsByTrap

	WorldBuff = var_1_10007

	for iter_35_0, iter_35_1 in var_1_10002(var_35_2(var_35_1, var_1_10007.TrapCripple)) do
		math = var_7
		var_35_0 = var_7.min(var_35_0, iter_35_1:GetTrapParams()[3] / 100)
	end

	return 1 / var_35_0
end

function var_0_1.GetFOVRange(arg_36_0)
	local var_36_0 = 1

	ipairs = var_1_10002

	local var_36_1 = arg_36_0
	local var_36_2 = arg_36_0.GetBuffsByTrap

	WorldBuff = var_1_10007

	for iter_36_0, iter_36_1 in var_1_10002(var_36_2(var_36_1, var_1_10007.TrapCripple)) do
		math = var_7
		var_36_0 = var_7.min(var_36_0, iter_36_1:GetTrapParams()[1] / 100)
	end

	math = var_2

	local var_36_3 = var_2.floor

	WorldConst = var_4

	return var_36_3(var_4.GetFOVRadius() * var_36_0)
end

function var_0_1.GetCarries(arg_37_0)
	return arg_37_0.carries
end

function var_0_1.ExistCarry(arg_38_0, arg_38_1)
	_ = var_1_10002

	return var_1_10002.any(arg_38_0.carries, function(arg_39_0)
		return arg_39_0.id == arg_38_1
	end)
end

function var_0_1.AddCarry(arg_40_0, arg_40_1)
	table = var_1_10002

	var_1_10002.insert(arg_40_0.carries, arg_40_1)

	local var_40_0 = arg_40_0
	local var_40_1 = arg_40_0.DispatchEvent

	WorldMapFleet = var_5

	var_40_1(var_40_0, var_5.EventAddCarry, arg_40_1)

	return
end

function var_0_1.RemoveCarry(arg_41_0, arg_41_1)
	ipairs = var_1_10002

	for iter_41_0, iter_41_1 in var_1_10002(arg_41_0.carries) do
		if iter_41_1.id == arg_41_1 then
			for iter_41_2 = #arg_41_0.carries, iter_41_0 + 1, -1 do
				local var_41_0 = arg_41_0.carries[iter_41_2]

				var_11.UpdateOffset(var_41_0, arg_41_0.carries[iter_41_2 - 1].offsetRow, arg_41_0.carries[iter_41_2 - 1].offsetColumn)
			end

			table = var_7

			var_7.remove(arg_41_0.carries, iter_41_0)

			local var_41_1 = arg_41_0
			local var_41_2 = arg_41_0.DispatchEvent

			WorldMapFleet = var_10

			var_41_2(var_41_1, var_10.EventRemoveCarry, iter_41_1)

			break
		end
	end

	return
end

function var_0_1.RemoveAllCarries(arg_42_0)
	local var_42_0

	for iter_42_0 = #arg_42_0.carries, 1, -1 do
		table = var_1_10006

		local var_42_1 = var_1_10006.remove(arg_42_0.carries)
		local var_42_2 = arg_42_0

		var_1_10006 = arg_42_0.DispatchEvent
		WorldMapFleet = var_1_10009

		var_1_10006(var_42_2, var_1_10009.EventRemoveCarry, var_42_1)
	end

	return
end

function var_0_1.BuildCarryPath(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	local var_43_0 = arg_43_0
	local var_43_1 = arg_43_0.GetCarries(var_43_0)

	table = var_1_10005

	local var_43_2 = var_1_10005.indexof(var_43_1, arg_43_1)

	assert = var_43_0

	var_43_0(var_43_2, "can not find carry item: " .. arg_43_1.id)

	_ = var_43_0

	local var_43_3 = var_43_0.map(arg_43_3, function(arg_44_0)
		return {
			row = arg_44_0.row,
			column = arg_44_0.column
		}
	end)

	table = var_7

	var_7.insert(var_43_3, 1, {
		row = arg_43_2.row,
		column = arg_43_2.column
	})

	for iter_43_0 = 1, var_43_2 - 1 do
		table = var_11

		var_11.insert(var_43_3, 1, {
			row = arg_43_2.row + var_43_1[iter_43_0].offsetRow,
			column = arg_43_2.column + var_43_1[iter_43_0].offsetColumn
		})
	end

	while #var_43_3 > #arg_43_3 do
		table = var_7

		var_7.remove(var_43_3, #var_43_3)
	end

	ipairs = var_7

	for iter_43_1, iter_43_2 in var_7(var_43_3) do
		var_43_3[iter_43_1].duration = arg_43_3[iter_43_1].duration
	end

	return var_43_3
end

function var_0_1.HasDamageLevel(arg_45_0)
	return arg_45_0.damageLevel > 0
end

function var_0_1.IncDamageLevel(arg_46_0, arg_46_1)
	pg = var_1_10002

	local var_46_0 = var_1_10002.world_expedition_data
	local var_46_1 = arg_46_1
	local var_46_2 = var_46_0[arg_46_1.GetBattleStageId(var_46_1)].failed_morale

	math = var_3

	local var_46_3 = var_3.min

	WorldConst = var_46_1

	if var_46_3(#var_46_1.DamageBuffList, arg_46_0.damageLevel + (var_46_2 or 1)) ~= arg_46_0.damageLevel then
		arg_46_0.damageLevel = var_3

		arg_46_0:DispatchEvent(var_0_1.EventUpdateDamageLevel)
	end

	return
end

function var_0_1.ClearDamageLevel(arg_47_0)
	if 0 ~= arg_47_0.damageLevel then
		arg_47_0.damageLevel = var_1

		arg_47_0:DispatchEvent(var_0_1.EventUpdateDamageLevel)
	end

	return
end

function var_0_1.GetDamageBuff(arg_48_0)
	if arg_48_0.damageLevel > 0 then
		WorldBuff = var_1

		local var_48_0 = var_1.New()
		local var_48_1 = var_1.Setup
		local var_48_2 = {
			floor = 1
		}

		WorldConst = var_1_10006
		var_48_2.id = var_1_10006.DamageBuffList[arg_48_0.damageLevel]

		var_48_1(var_48_0, var_48_2)

		return var_1
	end

	return
end

function var_0_1.GetBuffList(arg_49_0)
	_ = var_1_10001

	local var_49_0 = var_1_10001.filter

	_ = var_1_10003

	local var_49_1 = var_49_0(var_1_10003.values(arg_49_0.buffs), function(arg_50_0)
		return arg_50_0:GetFloor() > 0
	end)

	nowWorld = var_1_10002

	local var_49_2 = var_1_10002()
	local var_49_3 = var_2.GetActiveMap(var_49_2)

	table = var_3

	local var_49_4 = var_3.mergeArray
	local var_49_5 = var_49_1
	local var_49_6 = var_49_3
	local var_49_7 = var_49_3.GetBuffList

	WorldMap = var_1_10009

	return var_49_4(var_49_5, var_49_7(var_49_6, var_1_10009.FactionSelf))
end

function var_0_1.UpdateBuffs(arg_51_0, arg_51_1)
	if arg_51_0.buffs ~= arg_51_1 then
		nowWorld = var_2

		local var_51_0 = var_2()
		local var_51_1 = var_2.GetActiveMap(var_51_0)

		pairs = var_1_10004
		WorldConst = var_1_10006

		for iter_51_0, iter_51_1 in var_1_10004(var_1_10006.CompareBuffs(arg_51_0.buffs, arg_51_1).add) do
			noEmptyStr = var_9

			if var_9(iter_51_1.config.trap_lua) then
				arg_51_0:DispatchEvent(var_0_1.EventUpdateFlashTips, iter_51_1.config.trap_lua)
			end
		end

		arg_51_0.buffs = arg_51_1

		arg_51_0:DispatchEvent(var_0_1.EventUpdateBuff)
	end

	return
end

function var_0_1.GetBuff(arg_52_0, arg_52_1)
	return arg_52_0.buffs[arg_52_1]
end

function var_0_1.GetBuffsByTrap(arg_53_0, arg_53_1)
	underscore = var_1_10002

	return var_1_10002.filter(arg_53_0:GetBuffList(), function(arg_54_0)
		return arg_54_0:GetTrapType() == arg_53_1
	end)
end

function var_0_1.HasTrapBuff(arg_55_0)
	ipairs = var_1_10001

	for iter_55_0, iter_55_1 in var_1_10001(arg_55_0:GetBuffList()) do
		if iter_55_1:GetTrapType() ~= 0 then
			return true
		end
	end

	return false
end

function var_0_1.GetBuffFxList(arg_56_0)
	local var_56_0 = {}

	_ = var_1_10002

	var_1_10002.each(arg_56_0:GetBuffList(), function(arg_57_0)
		if arg_57_0.config.buff_fx and #arg_57_0.config.buff_fx > 0 then
			table = var_1

			var_1.insert(var_56_0, arg_57_0.config.buff_fx)
		end

		return
	end)

	return var_56_0
end

function var_0_1.GetWatchingBuff(arg_58_0)
	local var_58_0 = {}

	ipairs = var_1_10002
	pg = var_1_10004

	for iter_58_0, iter_58_1 in var_1_10002(var_1_10004.gameset.world_sairenbuff_fleeticon.description) do
		var_58_0[iter_58_1] = true
	end

	ipairs = var_2

	for iter_58_2, iter_58_3 in var_2(arg_58_0:GetBuffList()) do
		if var_58_0[iter_58_3.id] then
			return iter_58_3
		end
	end

	return nil
end

function var_0_1.AddDefeatEnemies(arg_59_0, arg_59_1)
	if arg_59_1 then
		arg_59_0.defeatEnemies = arg_59_0.defeatEnemies + 1

		arg_59_0:DispatchEvent(var_0_1.EventUpdateDefeat)
	end

	return
end

function var_0_1.ClearDefeatEnemies(arg_60_0)
	arg_60_0.defeatEnemies = 0

	arg_60_0:DispatchEvent(var_0_1.EventUpdateDefeat)

	return
end

function var_0_1.getDefeatCount(arg_61_0)
	return arg_61_0.defeatEnemies
end

function var_0_1.getMapAura(arg_62_0)
	local var_62_0 = {}

	ipairs = var_1_10002

	for iter_62_0, iter_62_1 in var_1_10002(arg_62_0:GetShips(true)) do
		table = var_62_1

		local var_62_1 = var_62_1.mergeArray
		local var_62_2 = var_62_0
		local var_62_3 = iter_62_1:GetImportWorldShipVO()

		var_62_0 = var_62_1(var_62_2, var_10.getMapAuras(var_62_3))
	end

	return var_62_0
end

function var_0_1.getMapAid(arg_63_0)
	local var_63_0 = {}

	ipairs = var_1_10002

	for iter_63_0, iter_63_1 in var_1_10002(arg_63_0:GetShips(true)) do
		local var_63_1 = iter_63_1:GetImportWorldShipVO()
		local var_63_2 = var_7.getMapAids(var_63_1)

		ipairs = var_1_10008

		for iter_63_2, iter_63_3 in var_1_10008(var_63_2) do
			local var_63_3

			if not var_63_0[iter_63_1] then
				var_63_3 = {}
			end

			var_63_0[iter_63_1] = var_63_3
			table = var_63_3

			var_63_3.insert(var_63_0[iter_63_1], iter_63_3)
		end
	end

	return var_63_0
end

function var_0_1.outputCommanders(arg_64_0)
	local var_64_0 = {}

	pairs = var_1_10002

	for iter_64_0, iter_64_1 in var_1_10002(arg_64_0.commanderIds) do
		assert = var_1_10007

		var_1_10007(iter_64_1, "id is nil")

		table = var_1_10007

		var_1_10007.insert(var_64_0, {
			pos = iter_64_0,
			id = iter_64_1
		})
	end

	return var_64_0
end

function var_0_1.getCommanders(arg_65_0, arg_65_1)
	local var_65_0 = {}

	if arg_65_1 and arg_65_0:IsCatSalvage() then
		-- block empty
	else
		pairs = var_1_10003

		for iter_65_0, iter_65_1 in var_1_10003(arg_65_0.commanderIds) do
			getProxy = var_1_10008
			CommanderProxy = var_1_10010
			var_1_10010 = var_1_10008(var_1_10010)
			var_65_0[iter_65_0] = var_1_10008.getCommanderById(var_1_10010, iter_65_1)
		end
	end

	return var_65_0
end

function var_0_1.getCommanderByPos(arg_66_0, arg_66_1)
	return arg_66_0:getCommanders()[arg_66_1]
end

function var_0_1.updateCommanderByPos(arg_67_0, arg_67_1, arg_67_2)
	if arg_67_2 then
		arg_67_0.commanderIds[arg_67_1] = arg_67_2.id
	else
		arg_67_0.commanderIds[arg_67_1] = nil
	end

	arg_67_0:updateCommanderSkills()

	return
end

function var_0_1.getCommandersAddition(arg_68_0)
	local var_68_0 = {}

	pairs = var_1_10002
	CommanderConst = var_1_10004

	for iter_68_0, iter_68_1 in var_1_10002(var_1_10004.PROPERTIES) do
		local var_68_1 = 0

		pairs = var_1_10008

		for iter_68_2, iter_68_3 in var_1_10008(arg_68_0:getCommanders()) do
			var_68_1 = var_68_1 + iter_68_3:getAbilitysAddition()[iter_68_1]
		end

		if 0 < var_68_1 then
			table = var_1_10008

			var_1_10008.insert(var_68_0, {
				attrName = iter_68_1,
				value = var_68_1
			})
		end
	end

	return var_68_0
end

function var_0_1.getCommandersTalentDesc(arg_69_0)
	local var_69_0 = {}

	pairs = var_1_10002

	for iter_69_0, iter_69_1 in var_1_10002(arg_69_0:getCommanders()) do
		local var_69_1 = iter_69_1:getTalentsDesc()

		pairs = var_1_10008

		for iter_69_2, iter_69_3 in var_1_10008(var_69_1) do
			if var_69_0[iter_69_2] then
				var_69_0[iter_69_2].value = var_69_0[iter_69_2].value + iter_69_3.value
			else
				var_69_0[iter_69_2] = {
					name = iter_69_2,
					value = iter_69_3.value,
					type = iter_69_3.type
				}
			end
		end
	end

	return var_69_0
end

function var_0_1.findCommanderBySkillId(arg_70_0, arg_70_1)
	local var_70_0 = arg_70_0:getCommanders()

	pairs = var_1_10003

	for iter_70_0, iter_70_1 in var_1_10003(var_70_0) do
		_ = var_1_10008

		if var_1_10008.any(iter_70_1:getSkills(), function(arg_71_0)
			_ = var_2_10001

			return var_2_10001.any(arg_71_0:GetTacticSkillForWorld(), function(arg_72_0)
				return arg_72_0 == arg_70_1
			end)
		end) then
			return iter_70_1
		end
	end

	return
end

function var_0_1.updateCommanderSkills(arg_73_0)
	local var_73_0 = #arg_73_0.skills

	while var_73_0 > 0 do
		local var_73_1 = arg_73_0.skills[var_73_0]
		local var_73_2 = arg_73_0

		if not arg_73_0.findCommanderBySkillId(var_73_2, var_73_1.id) then
			local var_73_3 = var_73_1:GetSystem()

			FleetSkill = var_73_2

			if var_73_3 == var_73_2.SystemCommanderNeko then
				table = var_73_3

				var_73_3.remove(arg_73_0.skills, var_73_0)
			end
		end

		var_73_0 = var_73_0 - 1
	end

	local var_73_4 = arg_73_0:getCommanders()

	pairs = var_1_10003

	for iter_73_0, iter_73_1 in var_1_10003(var_73_4) do
		ipairs = var_1_10008

		for iter_73_2, iter_73_3 in var_1_10008(iter_73_1:getSkills()) do
			ipairs = var_1_10013

			for iter_73_4, iter_73_5 in var_1_10013(iter_73_3:GetTacticSkillForWorld()) do
				table = var_1_10018
				var_1_10018 = var_1_10018.insert

				local var_73_5 = arg_73_0.skills

				FleetSkill = var_1_10021
				var_1_10021 = var_1_10021.New
				FleetSkill = var_1_10023

				var_1_10018(var_73_5, var_1_10021(var_1_10023.SystemCommanderNeko, iter_73_5))
			end
		end
	end

	return
end

function var_0_1.getSkills(arg_74_0)
	return arg_74_0.skills
end

function var_0_1.getSkill(arg_75_0, arg_75_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_75_0:getSkills(), function(arg_76_0)
		return arg_76_0.id == arg_75_1
	end)
end

function var_0_1.findSkills(arg_77_0, arg_77_1)
	_ = var_1_10002

	return var_1_10002.filter(arg_77_0:getSkills(), function(arg_78_0)
		return arg_78_0:GetType() == arg_77_1
	end)
end

function var_0_1.IsCatSalvage(arg_79_0)
	local var_79_0

	if arg_79_0.catSalvageFrom then
		var_79_0 = arg_79_0.catSalvageFrom > 0
	end

	return var_79_0
end

function var_0_1.UpdateCatSalvage(arg_80_0, arg_80_1, arg_80_2, arg_80_3)
	arg_80_0.catSalvageStep = arg_80_1
	arg_80_0.catSalvageList = arg_80_2
	arg_80_0.catSalvageFrom = arg_80_3
	nowWorld = var_1_10004

	local var_80_0 = var_1_10004()

	if arg_80_0:GetRarityState() == 2 and not var_80_0.isAutoFight then
		local var_80_1 = var_80_0:GetActiveMap()
		local var_80_2 = var_5.AddPhaseDisplay
		local var_80_3 = {}

		pg = var_1_10010
		var_80_3.story = var_1_10010.gameset.world_catsearch_raritytip.description[1]

		var_80_2(var_80_1, var_80_3)
	end

	arg_80_0:DispatchEvent(var_0_1.EventUpdateCatSalvage)

	return
end

function var_0_1.IsSalvageFinish(arg_81_0)
	return arg_81_0.catSalvageStep == #arg_81_0.catSalvageList
end

local function var_0_2(arg_82_0)
	pg = var_1_10001

	return var_1_10001.world_catsearch_node[arg_82_0].special_drop == 1
end

function var_0_1.GetRarityState(arg_83_0)
	if arg_83_0.catSalvageStep == 0 then
		return 0
	end

	if var_0_2(arg_83_0.catSalvageList[arg_83_0.catSalvageStep]) then
		return 2
	else
		for iter_83_0 = 1, arg_83_0.catSalvageStep - 1 do
			if var_0_2(arg_83_0.catSalvageList[iter_83_0]) then
				return 1
			end
		end
	end

	return 0
end

function var_0_1.GetSalvageScoreRarity(arg_84_0)
	local var_84_0 = 0

	ipairs = var_1_10002

	for iter_84_0, iter_84_1 in var_1_10002(arg_84_0.catSalvageList) do
		pg = var_1_10007
		var_84_0 = var_84_0 + var_1_10007.world_catsearch_node[iter_84_1].score
	end

	local var_84_1

	ipairs = var_3
	pg = iter_84_0

	for iter_84_2, iter_84_3 in var_3(iter_84_0.gameset.world_catsearch_score.description) do
		if iter_84_3 < var_84_0 then
			var_84_1 = iter_84_2
		else
			break
		end
	end

	return var_84_1
end

function var_0_1.GetDisplayCommander(arg_85_0)
	local var_85_0 = arg_85_0:getCommanders()

	for iter_85_0 = 1, 2 do
		if arg_85_0.commanderIds[iter_85_0] then
			getProxy = var_6
			CommanderProxy = var_1_10008
			var_1_10008 = var_6(var_1_10008)

			return var_6.getCommanderById(var_1_10008, arg_85_0.commanderIds[iter_85_0])
		end
	end

	return
end

function var_0_1.HasCommander(arg_86_0, arg_86_1)
	pairs = var_1_10002

	for iter_86_0, iter_86_1 in var_1_10002(arg_86_0.commanderIds) do
		if arg_86_1 == iter_86_1 then
			return true
		end
	end

	return false
end

function var_0_1.switchShip(arg_87_0, arg_87_1, arg_87_2, arg_87_3, arg_87_4, arg_87_5)
	arg_87_0:SwitchShip(arg_87_4, arg_87_5)

	return
end

return var_0_1
