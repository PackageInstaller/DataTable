local var_0_0 = class("WorldMapFleet", import(".WorldBaseFleet"))

var_0_0.Fields = {
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
var_0_0.EventUpdateLocation = "WorldMapFleet.EventUpdateLocation"
var_0_0.EventUpdateShipOrder = "WorldMapFleet.EventUpdateShipOrder"
var_0_0.EventAddShip = "WorldMapFleet.EventAddShip"
var_0_0.EventRemoveShip = "WorldMapFleet.EventRemoveShip"
var_0_0.EventAddCarry = "WorldMapFleet.EventAddCarry"
var_0_0.EventRemoveCarry = "WorldMapFleet.EventRemoveCarry"
var_0_0.EventUpdateBuff = "WorldMapFleet.EventUpdateBuff"
var_0_0.EventUpdateDamageLevel = "WorldMapFleet.EventUpdateDamageLevel"
var_0_0.EventUpdateDefeat = "WorldMapFleet.EventUpdateDefeat"
var_0_0.EventUpdateCatSalvage = "WorldMapFleet.EventUpdateCatSalvage"
var_0_0.EventUpdateFlashTips = "WorldMapFleet.EventUpdateFlashTips"

function var_0_0.GetName(arg_1_0)
	return "fleet_" .. arg_1_0
end

function var_0_0.DebugPrint(arg_2_0)
	local var_2_0, var_2_1 = arg_2_0:GetAmmo()

	for iter_2_0, iter_2_1 in ipairs(arg_2_0:GetShips(true)) do
		local var_2_2 = WorldConst.FetchShipVO(iter_2_1.id)

		table.insert({}, (string.format("\t\t[%s] [id: %s] [config_id: %s] [%s] [hp: %s%%] [buff: %s]" .. " <material=underline c=#A9F548 event=ShipProperty args=%s><color=#A9F548>属性</color></material>", var_2_2:getName(), var_2_2.id, var_2_2.configId, ({
			[TeamType.Main] = "主力",
			[TeamType.Vanguard] = "先锋",
			[TeamType.Submarine] = "潜艇"
		})[var_2_2:getTeamType()], iter_2_1.hpRant / 100, table.concat(_.map(iter_2_1:GetBuffList(), function(arg_5_0)
			return arg_5_0.id .. "#" .. arg_5_0:GetFloor()
		end), ", "), var_2_2.id)))
	end

	return string.format("[第%s舰队] [id: %s] [位置: %s, %s] [弹药: %s/%s] [携带物: %s] [战损: %s] [buff: %s]", arg_2_0.index, arg_2_0.id, arg_2_0.row, arg_2_0.column, var_2_0, var_2_1, table.concat(_.map(arg_2_0.carries, function(arg_4_0)
		return "carries"
	end), ", "), arg_2_0.damageLevel, table.concat(_.map(arg_2_0:GetBuffList(), function(arg_3_0)
		return arg_3_0.id .. "#" .. arg_3_0:GetFloor()
	end), ", ")) .. "\n" .. table.concat({}, "\n")
end

function var_0_0.Build(arg_6_0)
	var_0_0.super.Build(arg_6_0)

	arg_6_0.carries = {}

	return
end

function var_0_0.Setup(arg_7_0, arg_7_1)
	arg_7_0.id = arg_7_1.id

	arg_7_0:UpdateShips((_.map(arg_7_1.ship_list, function(arg_8_0)
		local var_8_0 = WPool:Get(WorldMapShip)

		var_8_0:Setup(arg_8_0)

		return var_8_0
	end)))

	arg_7_0.commanderIds = {}

	local var_7_0 = arg_7_1.commander_list or {}

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		arg_7_0.commanderIds[iter_7_1.pos] = iter_7_1.id
	end

	arg_7_0.skills = {}

	arg_7_0:updateCommanderSkills()

	arg_7_0.row = arg_7_1.pos.row
	arg_7_0.column = arg_7_1.pos.column
	arg_7_0.ammo = arg_7_1.bullet
	arg_7_0.ammoMax = arg_7_1.bullet_max
	arg_7_0.damageLevel = math.clamp(arg_7_1.damage_level, 0, #WorldConst.DamageBuffList)

	_.each(arg_7_1.attach_list, function(arg_9_0)
		local var_9_0 = WPool:Get(WorldCarryItem)

		var_9_0:Setup(arg_9_0)
		table.insert(arg_7_0.carries, var_9_0)

		return
	end)

	arg_7_0.buffs = WorldConst.ParsingBuffs(arg_7_1.buff_list)
	arg_7_0.defeatEnemies = arg_7_1.kill_count
	arg_7_0.catSalvageStep = arg_7_1.cmd_collection.progress
	arg_7_0.catSalvageList = arg_7_1.cmd_collection.progress_list
	arg_7_0.catSalvageFrom = arg_7_1.cmd_collection.random_id

	if arg_7_0:GetFleetType() == FleetType.Submarine then
		arg_7_0.row = -1
		arg_7_0.column = -1
	end

	return
end

function var_0_0.GetCost(arg_10_0)
	return {
		gold = 0,
		oil = 0
	}, {
		gold = 0,
		oil = 0
	}
end

function var_0_0.GetFleetIndex(arg_11_0)
	return arg_11_0.index
end

function var_0_0.GetDefaultName(arg_12_0)
	local var_12_0 = Fleet.DEFAULT_NAME

	if #arg_12_0[TeamType.Submarine] > 0 then
		local var_12_1 = arg_12_0.index + 10 or arg_12_0.index

		return var_12_0[var_12_1]
	end
end

function var_0_0.FormationEqual(arg_13_0, arg_13_1)
	local var_13_0 = _.map(arg_13_0:GetShips(true), function(arg_14_0)
		return arg_14_0.id
	end)
	local var_13_1 = _.map(arg_13_1:GetShips(true), function(arg_15_0)
		return arg_15_0.id
	end)

	for iter_13_0 = 1, math.max(#var_13_0, #var_13_1) do
		if var_13_0[iter_13_0] ~= var_13_1[iter_13_0] then
			return false
		end
	end

	return true
end

function var_0_0.GetPropertiesSum(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs((arg_16_0:GetShipVOs(true))) do
		local var_16_0 = iter_16_1:getProperties()

		;({
			cannon = 0,
			antiAir = 0,
			air = 0,
			torpedo = 0
		}).cannon = ({
			cannon = 0,
			antiAir = 0,
			air = 0,
			torpedo = 0
		}).cannon + math.floor(var_16_0.cannon)
		;({
			cannon = 0,
			antiAir = 0,
			air = 0,
			torpedo = 0
		}).torpedo = ({
			cannon = 0,
			antiAir = 0,
			air = 0,
			torpedo = 0
		}).torpedo + math.floor(var_16_0.torpedo)
		;({
			cannon = 0,
			antiAir = 0,
			air = 0,
			torpedo = 0
		}).antiAir = ({
			cannon = 0,
			antiAir = 0,
			air = 0,
			torpedo = 0
		}).antiAir + math.floor(var_16_0.antiaircraft)
		;({
			cannon = 0,
			antiAir = 0,
			air = 0,
			torpedo = 0
		}).air = ({
			cannon = 0,
			antiAir = 0,
			air = 0,
			torpedo = 0
		}).air + math.floor(var_16_0.air)
	end

	return {
		cannon = 0,
		antiAir = 0,
		air = 0,
		torpedo = 0
	}
end

function var_0_0.GetGearScoreSum(arg_17_0, arg_17_1)
	local var_17_0 = 0
	local var_17_1 = arg_17_1 and arg_17_0:GetTeamShipVOs(arg_17_1) or arg_17_0:GetShipVOs()

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		var_17_0 = var_17_0 + iter_17_1:getShipCombatPower()
	end

	return var_17_0
end

function var_0_0.GetLevelCount(arg_18_0)
	local var_18_0 = 0

	underscore.each(arg_18_0:GetShipVOs(), function(arg_19_0)
		var_18_0 = var_18_0 + arg_19_0.level

		return
	end)

	return 0
end

function var_0_0.AddShip(arg_20_0, arg_20_1, arg_20_2)
	assert(arg_20_1.class == WorldMapShip)
	assert(not _.any(arg_20_0:GetShips(true), function(arg_21_0)
		return arg_21_0.id == arg_20_1.id
	end), "ship exist in port: " .. arg_20_1.id)

	local var_20_0 = WorldConst.FetchRawShipVO(arg_20_1.id)

	assert(var_20_0, "ship not exist: " .. arg_20_1.id)

	local var_20_1 = arg_20_0[var_20_0:getTeamType()]

	arg_20_2 = arg_20_2 or #var_20_1 + 1
	arg_20_1.fleetId = arg_20_0.id

	table.insert(var_20_1, arg_20_2, arg_20_1)
	arg_20_0:DispatchEvent(var_0_0.EventAddShip, arg_20_1)

	return
end

function var_0_0.RemoveShip(arg_22_0, arg_22_1)
	local var_22_0 = WorldConst.FetchRawShipVO(arg_22_1)

	assert(var_22_0, "ship not exist: " .. arg_22_1)

	local var_22_1 = arg_22_0[var_22_0:getTeamType()]

	for iter_22_0 = #var_22_1, 1, -1 do
		if var_22_1[iter_22_0].id == arg_22_1 then
			local var_22_2 = table.remove(var_22_1, iter_22_0)

			var_22_2.fleetId = nil

			arg_22_0:DispatchEvent(var_0_0.EventRemoveShip, var_22_2)

			return var_22_2, iter_22_0
		end
	end

	return
end

function var_0_0.ReplaceShip(arg_23_0, arg_23_1, arg_23_2)
	assert(arg_23_0:GetShip(arg_23_1))

	if arg_23_0:GetShip(arg_23_2.id) then
		arg_23_0:SwitchShip(arg_23_1, arg_23_2.id)
	else
		local var_23_0, var_23_1 = arg_23_0:RemoveShip(arg_23_1)

		arg_23_0:AddShip(arg_23_2, var_23_1)
	end

	return
end

function var_0_0.SwitchShip(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = WorldConst.FetchRawShipVO(arg_24_1)
	local var_24_1 = WorldConst.FetchRawShipVO(arg_24_2)

	assert(var_24_0 and var_24_1)

	local var_24_2 = var_24_0:getTeamType()
	local var_24_3 = var_24_1:getTeamType()

	assert(var_24_2 == var_24_3)

	local var_24_4
	local var_24_5

	for iter_24_0, iter_24_1 in ipairs(arg_24_0[var_24_2]) do
		if iter_24_1.id == arg_24_1 then
			var_24_4 = iter_24_0
		end

		if iter_24_1.id == arg_24_2 then
			var_24_5 = iter_24_0
		end
	end

	if var_24_4 ~= nil then
		arg_24_0[var_24_2][var_24_4], arg_24_0[var_24_3][var_24_5] = arg_24_0[var_24_3][nil], arg_24_0[var_24_2][var_24_4]

		arg_24_0:DispatchEvent(var_0_0.EventUpdateShipOrder)
	end

	return
end

function var_0_0.CheckRemoveShip(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1:getTeamType()

	if #arg_25_0:GetTeamShips(var_25_0, true) == 1 then
		local var_25_2 = i18n("ship_formationUI_removeError_onlyShip", arg_25_1:getConfig("name"), "", Fleet.C_TEAM_NAME[var_25_0])

		return
	end

	return true
end

function var_0_0.CheckChangeShip(arg_26_0, arg_26_1, arg_26_2)
	if not (arg_26_1 and WorldConst.FetchWorldShip(arg_26_1.id).fleetId == WorldConst.FetchWorldShip(arg_26_2.id).fleetId) and (not arg_26_1 or not arg_26_1:isSameKind(arg_26_2)) and _.any(arg_26_0:GetShips(true), function(arg_27_0)
		return WorldConst.FetchRawShipVO(arg_27_0.id):isSameKind(arg_26_2)
	end) then
		local var_26_1 = i18n("ship_formationMediator_changeNameError_sameShip")

		return
	end

	return true
end

function var_0_0.GetAmmo(arg_28_0)
	return arg_28_0.ammo, arg_28_0.ammoMax
end

function var_0_0.UseAmmo(arg_29_0)
	assert(arg_29_0.ammo > 0, "without ammo")

	arg_29_0.ammo = arg_29_0.ammo - 1

	return
end

function var_0_0.GetTotalAmmo(arg_30_0)
	return _.reduce(arg_30_0:GetShips(true), 0, function(arg_31_0, arg_31_1)
		return arg_31_0 + arg_31_1:GetImportWorldShipVO():getShipAmmo()
	end)
end

function var_0_0.RepairSubmarine(arg_32_0)
	_.each(arg_32_0:GetTeamShips(TeamType.Submarine, true), function(arg_33_0)
		arg_33_0:Repair()

		return
	end)

	arg_32_0.ammo = arg_32_0:GetTotalAmmo()
	arg_32_0.ammoMax = arg_32_0.ammo

	return
end

function var_0_0.GetSpeed(arg_34_0)
	local var_34_0 = pg.gameset.world_move_initial_step.key_value

	if #arg_34_0:GetBuffsByTrap(WorldBuff.TrapVortex) > 0 then
		var_34_0 = math.min(var_34_0, 1)
	end

	for iter_34_0, iter_34_1 in ipairs(arg_34_0:GetBuffsByTrap(WorldBuff.TrapCripple)) do
		var_34_0 = math.min(var_34_0, iter_34_1:GetTrapParams()[2])
	end

	return var_34_0
end

function var_0_0.GetStepDurationRate(arg_35_0)
	local var_35_0 = 1

	for iter_35_0, iter_35_1 in ipairs(arg_35_0:GetBuffsByTrap(WorldBuff.TrapCripple)) do
		var_35_0 = math.min(var_35_0, iter_35_1:GetTrapParams()[3] / 100)
	end

	return 1 / var_35_0
end

function var_0_0.GetFOVRange(arg_36_0)
	local var_36_0 = 1

	for iter_36_0, iter_36_1 in ipairs(arg_36_0:GetBuffsByTrap(WorldBuff.TrapCripple)) do
		var_36_0 = math.min(var_36_0, iter_36_1:GetTrapParams()[1] / 100)
	end

	return math.floor(WorldConst.GetFOVRadius() * var_36_0)
end

function var_0_0.GetCarries(arg_37_0)
	return arg_37_0.carries
end

function var_0_0.ExistCarry(arg_38_0, arg_38_1)
	return _.any(arg_38_0.carries, function(arg_39_0)
		return arg_39_0.id == arg_38_1
	end)
end

function var_0_0.AddCarry(arg_40_0, arg_40_1)
	table.insert(arg_40_0.carries, arg_40_1)
	arg_40_0:DispatchEvent(WorldMapFleet.EventAddCarry, arg_40_1)

	return
end

function var_0_0.RemoveCarry(arg_41_0, arg_41_1)
	for iter_41_0, iter_41_1 in ipairs(arg_41_0.carries) do
		if iter_41_1.id == arg_41_1 then
			for iter_41_2 = #arg_41_0.carries, iter_41_0 + 1, -1 do
				arg_41_0.carries[iter_41_2]:UpdateOffset(arg_41_0.carries[iter_41_2 - 1].offsetRow, arg_41_0.carries[iter_41_2 - 1].offsetColumn)
			end

			table.remove(arg_41_0.carries, iter_41_0)
			arg_41_0:DispatchEvent(WorldMapFleet.EventRemoveCarry, iter_41_1)

			break
		end
	end

	return
end

function var_0_0.RemoveAllCarries(arg_42_0)
	for iter_42_0 = #arg_42_0.carries, 1, -1 do
		arg_42_0:DispatchEvent(WorldMapFleet.EventRemoveCarry, (table.remove(arg_42_0.carries)))
	end

	return
end

function var_0_0.BuildCarryPath(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	local var_43_0 = arg_43_0:GetCarries()
	local var_43_1 = table.indexof(var_43_0, arg_43_1)

	assert(var_43_1, "can not find carry item: " .. arg_43_1.id)

	local var_43_2 = _.map(arg_43_3, function(arg_44_0)
		return {
			row = arg_44_0.row,
			column = arg_44_0.column
		}
	end)

	table.insert(var_43_2, 1, {
		row = arg_43_2.row,
		column = arg_43_2.column
	})

	for iter_43_0 = 1, var_43_1 - 1 do
		table.insert(var_43_2, 1, {
			row = arg_43_2.row + var_43_0[iter_43_0].offsetRow,
			column = arg_43_2.column + var_43_0[iter_43_0].offsetColumn
		})
	end

	while #var_43_2 > #arg_43_3 do
		table.remove(var_43_2, #var_43_2)
	end

	for iter_43_1, iter_43_2 in ipairs(var_43_2) do
		var_43_2[iter_43_1].duration = arg_43_3[iter_43_1].duration
	end

	return var_43_2
end

function var_0_0.HasDamageLevel(arg_45_0)
	return arg_45_0.damageLevel > 0
end

function var_0_0.IncDamageLevel(arg_46_0, arg_46_1)
	local var_46_0 = math.min(#WorldConst.DamageBuffList, arg_46_0.damageLevel + (pg.world_expedition_data[arg_46_1:GetBattleStageId()].failed_morale or 1))

	if var_46_0 ~= arg_46_0.damageLevel then
		arg_46_0.damageLevel = var_46_0

		arg_46_0:DispatchEvent(var_0_0.EventUpdateDamageLevel)
	end

	return
end

function var_0_0.ClearDamageLevel(arg_47_0)
	if 0 ~= arg_47_0.damageLevel then
		arg_47_0.damageLevel = 0

		arg_47_0:DispatchEvent(var_0_0.EventUpdateDamageLevel)
	end

	return
end

function var_0_0.GetDamageBuff(arg_48_0)
	if arg_48_0.damageLevel > 0 then
		local var_48_0 = WorldBuff.New()

		var_48_0:Setup({
			floor = 1,
			id = WorldConst.DamageBuffList[arg_48_0.damageLevel]
		})

		return var_48_0
	end

	return
end

function var_0_0.GetBuffList(arg_49_0)
	return table.mergeArray(_.filter(_.values(arg_49_0.buffs), function(arg_50_0)
		return arg_50_0:GetFloor() > 0
	end), nowWorld():GetActiveMap():GetBuffList(WorldMap.FactionSelf))
end

function var_0_0.UpdateBuffs(arg_51_0, arg_51_1)
	if arg_51_0.buffs ~= arg_51_1 then
		local var_51_0 = nowWorld():GetActiveMap()

		for iter_51_0, iter_51_1 in pairs(WorldConst.CompareBuffs(arg_51_0.buffs, arg_51_1).add) do
			if noEmptyStr(iter_51_1.config.trap_lua) then
				arg_51_0:DispatchEvent(var_0_0.EventUpdateFlashTips, iter_51_1.config.trap_lua)
			end
		end

		arg_51_0.buffs = arg_51_1

		arg_51_0:DispatchEvent(var_0_0.EventUpdateBuff)
	end

	return
end

function var_0_0.GetBuff(arg_52_0, arg_52_1)
	return arg_52_0.buffs[arg_52_1]
end

function var_0_0.GetBuffsByTrap(arg_53_0, arg_53_1)
	return underscore.filter(arg_53_0:GetBuffList(), function(arg_54_0)
		return arg_54_0:GetTrapType() == arg_53_1
	end)
end

function var_0_0.HasTrapBuff(arg_55_0)
	for iter_55_0, iter_55_1 in ipairs(arg_55_0:GetBuffList()) do
		if iter_55_1:GetTrapType() ~= 0 then
			return true
		end
	end

	return false
end

function var_0_0.GetBuffFxList(arg_56_0)
	local var_56_0 = {}

	_.each(arg_56_0:GetBuffList(), function(arg_57_0)
		if arg_57_0.config.buff_fx and #arg_57_0.config.buff_fx > 0 then
			table.insert(var_56_0, arg_57_0.config.buff_fx)
		end

		return
	end)

	return {}
end

function var_0_0.GetWatchingBuff(arg_58_0)
	for iter_58_0, iter_58_1 in ipairs(pg.gameset.world_sairenbuff_fleeticon.description) do
		({})[iter_58_1] = true
	end

	for iter_58_2, iter_58_3 in ipairs(arg_58_0:GetBuffList()) do
		if ({})[iter_58_3.id] then
			return iter_58_3
		end
	end

	return nil
end

function var_0_0.AddDefeatEnemies(arg_59_0, arg_59_1)
	if arg_59_1 then
		arg_59_0.defeatEnemies = arg_59_0.defeatEnemies + 1

		arg_59_0:DispatchEvent(var_0_0.EventUpdateDefeat)
	end

	return
end

function var_0_0.ClearDefeatEnemies(arg_60_0)
	arg_60_0.defeatEnemies = 0

	arg_60_0:DispatchEvent(var_0_0.EventUpdateDefeat)

	return
end

function var_0_0.getDefeatCount(arg_61_0)
	return arg_61_0.defeatEnemies
end

function var_0_0.getMapAura(arg_62_0)
	local var_62_0 = {}

	for iter_62_0, iter_62_1 in ipairs(arg_62_0:GetShips(true)) do
		local var_62_1 = iter_62_1:GetImportWorldShipVO()

		var_62_0 = table.mergeArray(var_62_0, var_62_1:getMapAuras())
	end

	return var_62_0
end

function var_0_0.getMapAid(arg_63_0)
	for iter_63_0, iter_63_1 in ipairs(arg_63_0:GetShips(true)) do
		local var_63_0 = iter_63_1:GetImportWorldShipVO()

		for iter_63_2, iter_63_3 in ipairs((var_63_0:getMapAids())) do
			local var_63_1 = ({})[iter_63_1]

			if not ({})[iter_63_1] then
				var_63_1 = {}
			end

			;({})[iter_63_1] = var_63_1

			table.insert(({})[iter_63_1], iter_63_3)
		end
	end

	return {}
end

function var_0_0.outputCommanders(arg_64_0)
	for iter_64_0, iter_64_1 in pairs(arg_64_0.commanderIds) do
		assert(iter_64_1, "id is nil")
		table.insert({}, {
			pos = iter_64_0,
			id = iter_64_1
		})
	end

	return {}
end

function var_0_0.getCommanders(arg_65_0, arg_65_1)
	if arg_65_1 and arg_65_0:IsCatSalvage() then
		-- block empty
	else
		for iter_65_0, iter_65_1 in pairs(arg_65_0.commanderIds) do
			({})[iter_65_0] = getProxy(CommanderProxy):getCommanderById(iter_65_1)
		end
	end

	return {}
end

function var_0_0.getCommanderByPos(arg_66_0, arg_66_1)
	return arg_66_0:getCommanders()[arg_66_1]
end

function var_0_0.updateCommanderByPos(arg_67_0, arg_67_1, arg_67_2)
	arg_67_0.commanderIds[arg_67_1] = arg_67_2 and arg_67_2.id or nil

	arg_67_0:updateCommanderSkills()

	return
end

function var_0_0.getCommandersAddition(arg_68_0)
	for iter_68_0, iter_68_1 in pairs(CommanderConst.PROPERTIES) do
		local var_68_0 = 0

		for iter_68_2, iter_68_3 in pairs(arg_68_0:getCommanders()) do
			var_68_0 = var_68_0 + iter_68_3:getAbilitysAddition()[iter_68_1]
		end

		if var_68_0 > 0 then
			table.insert({}, {
				attrName = iter_68_1,
				value = var_68_0
			})
		end
	end

	return {}
end

function var_0_0.getCommandersTalentDesc(arg_69_0)
	for iter_69_0, iter_69_1 in pairs(arg_69_0:getCommanders()) do
		for iter_69_2, iter_69_3 in pairs((iter_69_1:getTalentsDesc())) do
			if ({})[iter_69_2] then
				({})[iter_69_2].value = ({})[iter_69_2].value + iter_69_3.value
			else
				({})[iter_69_2] = {
					name = iter_69_2,
					value = iter_69_3.value,
					type = iter_69_3.type
				}
			end
		end
	end

	return {}
end

function var_0_0.findCommanderBySkillId(arg_70_0, arg_70_1)
	for iter_70_0, iter_70_1 in pairs((arg_70_0:getCommanders())) do
		if _.any(iter_70_1:getSkills(), function(arg_71_0)
			return _.any(arg_71_0:GetTacticSkillForWorld(), function(arg_72_0)
				return arg_72_0 == arg_70_1
			end)
		end) then
			return iter_70_1
		end
	end

	return
end

function var_0_0.updateCommanderSkills(arg_73_0)
	while #arg_73_0.skills > 0 do
		if not arg_73_0:findCommanderBySkillId(arg_73_0.skills[#arg_73_0.skills].id) and arg_73_0.skills[#arg_73_0.skills]:GetSystem() == FleetSkill.SystemCommanderNeko then
			table.remove(arg_73_0.skills, #arg_73_0.skills)
		end
	end

	for iter_73_0, iter_73_1 in pairs((arg_73_0:getCommanders())) do
		for iter_73_2, iter_73_3 in ipairs(iter_73_1:getSkills()) do
			for iter_73_4, iter_73_5 in ipairs(iter_73_3:GetTacticSkillForWorld()) do
				table.insert(arg_73_0.skills, FleetSkill.New(FleetSkill.SystemCommanderNeko, iter_73_5))
			end
		end
	end

	return
end

function var_0_0.getSkills(arg_74_0)
	return arg_74_0.skills
end

function var_0_0.getSkill(arg_75_0, arg_75_1)
	return _.detect(arg_75_0:getSkills(), function(arg_76_0)
		return arg_76_0.id == arg_75_1
	end)
end

function var_0_0.findSkills(arg_77_0, arg_77_1)
	return _.filter(arg_77_0:getSkills(), function(arg_78_0)
		return arg_78_0:GetType() == arg_77_1
	end)
end

function var_0_0.IsCatSalvage(arg_79_0)
	return arg_79_0.catSalvageFrom and arg_79_0.catSalvageFrom > 0
end

function var_0_0.UpdateCatSalvage(arg_80_0, arg_80_1, arg_80_2, arg_80_3)
	arg_80_0.catSalvageStep = arg_80_1
	arg_80_0.catSalvageList = arg_80_2
	arg_80_0.catSalvageFrom = arg_80_3

	local var_80_0 = nowWorld()

	if arg_80_0:GetRarityState() == 2 and not var_80_0.isAutoFight then
		var_80_0:GetActiveMap():AddPhaseDisplay({
			story = pg.gameset.world_catsearch_raritytip.description[1]
		})
	end

	arg_80_0:DispatchEvent(var_0_0.EventUpdateCatSalvage)

	return
end

function var_0_0.IsSalvageFinish(arg_81_0)
	return arg_81_0.catSalvageStep == #arg_81_0.catSalvageList
end

local function var_0_1(arg_82_0)
	return pg.world_catsearch_node[arg_82_0].special_drop == 1
end

function var_0_0.GetRarityState(arg_83_0)
	if arg_83_0.catSalvageStep == 0 then
		return 0
	end

	if var_0_1(arg_83_0.catSalvageList[arg_83_0.catSalvageStep]) then
		return 2
	else
		for iter_83_0 = 1, arg_83_0.catSalvageStep - 1 do
			if var_0_1(arg_83_0.catSalvageList[iter_83_0]) then
				return 1
			end
		end
	end

	return 0
end

function var_0_0.GetSalvageScoreRarity(arg_84_0)
	local var_84_0 = 0

	for iter_84_0, iter_84_1 in ipairs(arg_84_0.catSalvageList) do
		var_84_0 = var_84_0 + pg.world_catsearch_node[iter_84_1].score
	end

	local var_84_1

	for iter_84_2, iter_84_3 in ipairs(pg.gameset.world_catsearch_score.description) do
		if iter_84_3 < var_84_0 then
			var_84_1 = iter_84_2
		else
			break
		end
	end

	return var_84_1
end

function var_0_0.GetDisplayCommander(arg_85_0)
	local var_85_0 = arg_85_0:getCommanders()

	for iter_85_0 = 1, 2 do
		if arg_85_0.commanderIds[iter_85_0] then
			return getProxy(CommanderProxy):getCommanderById(arg_85_0.commanderIds[iter_85_0])
		end
	end

	return
end

function var_0_0.HasCommander(arg_86_0, arg_86_1)
	for iter_86_0, iter_86_1 in pairs(arg_86_0.commanderIds) do
		if arg_86_1 == iter_86_1 then
			return true
		end
	end

	return false
end

function var_0_0.switchShip(arg_87_0, arg_87_1, arg_87_2, arg_87_3, arg_87_4, arg_87_5)
	arg_87_0:SwitchShip(arg_87_4, arg_87_5)

	return
end

return var_0_0
