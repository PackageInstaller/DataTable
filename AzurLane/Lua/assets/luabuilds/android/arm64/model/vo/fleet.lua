local var_0_0 = class("Fleet", import(".BaseVO"))

var_0_0.C_TEAM_NAME = {
	vanguard = i18n("word_vanguard_fleet"),
	main = i18n("word_main_fleet"),
	submarine = i18n("word_sub_fleet")
}
var_0_0.DEFAULT_NAME = {
	i18n("ship_formationUI_fleetName1"),
	i18n("ship_formationUI_fleetName2"),
	i18n("ship_formationUI_fleetName3"),
	i18n("ship_formationUI_fleetName4"),
	i18n("ship_formationUI_fleetName5"),
	i18n("ship_formationUI_fleetName6"),
	[11] = i18n("ship_formationUI_fleetName11"),
	[12] = i18n("ship_formationUI_fleetName12"),
	[101] = i18n("ship_formationUI_exercise_fleetName"),
	[102] = i18n("ship_formationUI_fleetName_challenge"),
	[103] = i18n("ship_formationUI_fleetName_challenge_sub")
}
var_0_0.DEFAULT_NAME_FOR_DOCKYARD = {
	i18n("ship_formationUI_fleetName1"),
	i18n("ship_formationUI_fleetName2"),
	i18n("ship_formationUI_fleetName3"),
	i18n("ship_formationUI_fleetName4"),
	i18n("ship_formationUI_fleetName5"),
	i18n("ship_formationUI_fleetName6"),
	[11] = i18n("ship_formationUI_fleetName1"),
	[12] = i18n("ship_formationUI_fleetName2"),
	[101] = i18n("ship_formationUI_exercise_fleetName"),
	[102] = i18n("ship_formationUI_fleetName_challenge"),
	[103] = i18n("ship_formationUI_fleetName_challenge_sub")
}
var_0_0.DEFAULT_NAME_BOSS_ACT = {
	i18n("ship_formationUI_fleetName_easy"),
	i18n("ship_formationUI_fleetName_normal"),
	i18n("ship_formationUI_fleetName_hard"),
	i18n("ship_formationUI_fleetName_extra"),
	i18n("ship_formationUI_fleetName_sp"),
	[11] = i18n("ship_formationUI_fleetName_easy_ss"),
	[12] = i18n("ship_formationUI_fleetName_normal_ss"),
	[13] = i18n("ship_formationUI_fleetName_hard_ss"),
	[14] = i18n("ship_formationUI_fleetName_extra_ss"),
	[15] = i18n("ship_formationUI_fleetName_sp_ss")
}
var_0_0.DEFAULT_NAME_BOSS_SINGLE_ACT = {
	i18n("ship_formationUI_fleetName_easy"),
	i18n("ship_formationUI_fleetName_normal"),
	i18n("ship_formationUI_fleetName_hard"),
	i18n("ship_formationUI_fleetName_sp"),
	i18n("ship_formationUI_fleetName_extra"),
	[11] = i18n("ship_formationUI_fleetName_easy_ss"),
	[12] = i18n("ship_formationUI_fleetName_normal_ss"),
	[13] = i18n("ship_formationUI_fleetName_hard_ss"),
	[14] = i18n("ship_formationUI_fleetName_sp_ss"),
	[15] = i18n("ship_formationUI_fleetName_extra_ss")
}
var_0_0.DEFAULT_NAME_BOSS_SINGLE_VARIABLE_ACT = {
	i18n("ship_formationUI_fleetName_1"),
	i18n("ship_formationUI_fleetName_2"),
	i18n("ship_formationUI_fleetName_3"),
	i18n("ship_formationUI_fleetName_4"),
	i18n("ship_formationUI_fleetName_5"),
	i18n("ship_formationUI_fleetName_6"),
	i18n("ship_formationUI_fleetName_7"),
	i18n("ship_formationUI_fleetName_8"),
	i18n("ship_formationUI_fleetName_9"),
	i18n("ship_formationUI_fleetName_10"),
	i18n("ship_formationUI_fleetName_11"),
	i18n("ship_formationUI_fleetName_12"),
	(i18n("ship_formationUI_fleetName_13"))
}
var_0_0.DEFAULT_ELITE_NAME = {
	i18n("ship_formationUI_fleetName1"),
	i18n("ship_formationUI_fleetName2"),
	i18n("ship_formationUI_fleetName11"),
	(i18n("ship_formationUI_fleetName13"))
}
var_0_0.REGULAR_FLEET_ID = 1
var_0_0.REGULAR_FLEET_NUMS = 6
var_0_0.SUBMARINE_FLEET_ID = 11
var_0_0.SUBMARINE_FLEET_NUMS = 4
var_0_0.MEGA_SUBMARINE_FLEET_OFFSET = 100

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.name = arg_1_1.name or ""
	arg_1_0.defaultName = var_0_0.DEFAULT_NAME[arg_1_0.id]

	arg_1_0:updateShips(arg_1_1.ship_list)

	arg_1_0.commanderIds = {}

	local var_1_0 = arg_1_1.commanders or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		arg_1_0.commanderIds[iter_1_1.pos] = iter_1_1.id
	end

	arg_1_0.skills = {}

	arg_1_0:updateCommanderSkills()

	return
end

function var_0_0.SeparateOut(arg_2_0)
	local var_2_0 = {
		id = arg_2_0.id,
		name = arg_2_0.name,
		ship_list = underscore.to_array(arg_2_0.ships)
	}

	var_2_0.commanders = underscore(arg_2_0.commanderIds):chain():keys():map(function(arg_3_0)
		return {
			pos = arg_3_0,
			id = arg_2_0.commanderIds[arg_3_0]
		}
	end):value()

	return var_2_0
end

function var_0_0.isUnlock(arg_4_0)
	if ({
		nil,
		nil,
		404,
		504,
		604,
		704
	})[arg_4_0.id] then
		local var_4_0 = getProxy(ChapterProxy):getChapterById(({
			nil,
			nil,
			404,
			504,
			604,
			704
		})[arg_4_0.id])
		local var_4_1 = var_4_0 and var_4_0:isClear()
		local var_4_2 = i18n("formation_chapter_lock", string.sub(tostring(({
			nil,
			nil,
			404,
			504,
			604,
			704
		})[arg_4_0.id]), 1, 1), arg_4_0.id)

		return
	end

	return true
end

function var_0_0.containShip(arg_5_0, arg_5_1)
	return table.contains(arg_5_0.ships, arg_5_1.id)
end

function var_0_0.isFirstFleet(arg_6_0)
	return arg_6_0.id == var_0_0.REGULAR_FLEET_ID
end

function var_0_0.outputCommanders(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.commanderIds) do
		assert(iter_7_1, "id is nil")
		table.insert({}, {
			pos = iter_7_0,
			id = iter_7_1
		})
	end

	return {}
end

function var_0_0.clearCommanders(arg_8_0)
	arg_8_0.commanderIds = {}

	arg_8_0:updateCommanderSkills()

	return
end

function var_0_0.getCommanders(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.commanderIds) do
		({})[iter_9_0] = getProxy(CommanderProxy):getCommanderById(iter_9_1)
	end

	return {}
end

function var_0_0.getCommanderByPos(arg_10_0, arg_10_1)
	return arg_10_0:getCommanders()[arg_10_1]
end

function var_0_0.updateCommanderByPos(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.commanderIds[arg_11_1] = arg_11_2 and arg_11_2.id or nil

	arg_11_0:updateCommanderSkills()

	return
end

function var_0_0.getCommandersAddition(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(CommanderConst.PROPERTIES) do
		local var_12_0 = 0

		for iter_12_2, iter_12_3 in pairs(arg_12_0:getCommanders()) do
			var_12_0 = var_12_0 + iter_12_3:getAbilitysAddition()[iter_12_1]
		end

		if var_12_0 > 0 then
			table.insert({}, {
				attrName = iter_12_1,
				value = var_12_0
			})
		end
	end

	return {}
end

function var_0_0.getCommandersTalentDesc(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0:getCommanders()) do
		for iter_13_2, iter_13_3 in pairs((iter_13_1:getTalentsDesc())) do
			if ({})[iter_13_2] then
				({})[iter_13_2].value = ({})[iter_13_2].value + iter_13_3.value
			else
				({})[iter_13_2] = {
					name = iter_13_2,
					value = iter_13_3.value,
					type = iter_13_3.type
				}
			end
		end
	end

	return {}
end

function var_0_0.findCommanderBySkillId(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in pairs((arg_14_0:getCommanders())) do
		if _.any(iter_14_1:getSkills(), function(arg_15_0)
			return _.any(arg_15_0:getTacticSkill(), function(arg_16_0)
				return arg_16_0 == arg_14_1
			end)
		end) then
			return iter_14_1
		end
	end

	return
end

function var_0_0.updateCommanderSkills(arg_17_0)
	while #arg_17_0.skills > 0 do
		if not arg_17_0:findCommanderBySkillId(arg_17_0.skills[#arg_17_0.skills].id) and arg_17_0.skills[#arg_17_0.skills]:GetSystem() == FleetSkill.SystemCommanderNeko then
			table.remove(arg_17_0.skills, #arg_17_0.skills)
		end
	end

	for iter_17_0, iter_17_1 in pairs((arg_17_0:getCommanders())) do
		for iter_17_2, iter_17_3 in ipairs(iter_17_1:getSkills()) do
			for iter_17_4, iter_17_5 in ipairs(iter_17_3:getTacticSkill()) do
				table.insert(arg_17_0.skills, FleetSkill.New(FleetSkill.SystemCommanderNeko, iter_17_5))
			end
		end
	end

	return
end

function var_0_0.buildBattleBuffList(arg_18_0)
	local var_18_0, var_18_1 = FleetSkill.triggerSkill(arg_18_0, FleetSkill.TypeBattleBuff)

	if var_18_0 and #var_18_0 > 0 then
		for iter_18_0, iter_18_1 in ipairs(var_18_0) do
			local var_18_2 = arg_18_0:findCommanderBySkillId(var_18_1[iter_18_0].id)
			local var_18_3 = ({})[var_18_2]

			if not ({})[var_18_2] then
				var_18_3 = {}
			end

			;({})[var_18_2] = var_18_3

			table.insert(({})[var_18_2], iter_18_1)
		end

		for iter_18_2, iter_18_3 in pairs({}) do
			table.insert({}, {
				iter_18_2,
				iter_18_3
			})
		end
	end

	for iter_18_4, iter_18_5 in pairs((arg_18_0:getCommanders())) do
		for iter_18_6, iter_18_7 in ipairs((iter_18_5:getTalents())) do
			local var_18_4 = iter_18_7:getBuffsAddition()

			if #var_18_4 > 0 then
				local var_18_5

				for iter_18_8, iter_18_9 in ipairs({}) do
					if iter_18_9[1] == iter_18_5 then
						var_18_5 = iter_18_9[2]

						break
					end
				end

				if not var_18_5 then
					var_18_5 = {}

					table.insert({}, {
						iter_18_5,
						{}
					})
				end

				for iter_18_10, iter_18_11 in ipairs(var_18_4) do
					table.insert(var_18_5, iter_18_11)
				end
			end
		end
	end

	return {}
end

function var_0_0.getSkills(arg_19_0)
	return arg_19_0.skills
end

function var_0_0.getShipIds(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs({
		arg_20_0.mainShips,
		arg_20_0.vanguardShips,
		arg_20_0.subShips
	}) do
		for iter_20_2, iter_20_3 in ipairs(iter_20_1) do
			table.insert({}, iter_20_3)
		end
	end

	return {}
end

function var_0_0.GetRawShipIds(arg_21_0)
	return arg_21_0.ships
end

function var_0_0.GetRawCommanderIds(arg_22_0)
	return arg_22_0.commanderIds
end

function var_0_0.findSkills(arg_23_0, arg_23_1)
	return _.filter(arg_23_0:getSkills(), function(arg_24_0)
		return arg_24_0:GetType() == arg_23_1
	end)
end

function var_0_0.updateShips(arg_25_0, arg_25_1)
	arg_25_0.ships = {}
	arg_25_0.vanguardShips = {}
	arg_25_0.mainShips = {}
	arg_25_0.subShips = {}

	local var_25_0 = getProxy(BayProxy)

	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		local var_25_1 = var_25_0:getShipById(iter_25_1)

		if var_25_1 then
			arg_25_0:insertShip(var_25_1, nil, var_25_1:getTeamType())
		end
	end

	return
end

function var_0_0.switchShip(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = arg_26_0:getTeamByName(arg_26_1)

	var_26_0[arg_26_2], var_26_0[arg_26_3] = var_26_0[arg_26_3], var_26_0[arg_26_2]

	return
end

function var_0_0.getShipPos(arg_27_0, arg_27_1)
	if not arg_27_1 then
		return
	end

	local var_27_0 = arg_27_1:getTeamType()
	local var_27_1 = table.indexof(arg_27_0:getTeamByName(var_27_0), arg_27_1.id) or -1

	return var_27_1, var_27_0
end

function var_0_0.getTeamByName(arg_28_0, arg_28_1)
	if arg_28_1 == TeamType.Vanguard then
		return arg_28_0.vanguardShips
	elseif arg_28_1 == TeamType.Main then
		return arg_28_0.mainShips
	elseif arg_28_1 == TeamType.Submarine then
		return arg_28_0.subShips
	end

	return
end

function var_0_0.CanInsertShip(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_0:isFull() or arg_29_0:containShip(arg_29_1) or not arg_29_1:isAvaiable() or #arg_29_0:getTeamByName(arg_29_2) >= TeamType.GetTeamShipMax(arg_29_2) then
		return false
	end

	return true
end

function var_0_0.insertShip(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = arg_30_0:getTeamByName(arg_30_3)

	if not arg_30_0:CanInsertShip(arg_30_1, arg_30_3) then
		errorMsg("fleet insert error")
		pg.TipsMgr.GetInstance():ShowTips("fleet insert error")

		goto label_30_0
	end

	arg_30_2 = arg_30_2 or #var_30_0 + 1

	::label_30_0::

	if arg_30_3 == TeamType.Main then
		do
			local var_30_1 = #arg_30_0.vanguardShips or 0

			table.insert(var_30_0, arg_30_2, arg_30_1.id)
			table.insert(arg_30_0.ships, var_30_1 + arg_30_2, arg_30_1.id)
		end

		return
	end
end

function var_0_0.canRemove(arg_31_0, arg_31_1)
	local var_31_0, var_31_1 = arg_31_0:getShipPos(arg_31_1)

	if var_31_0 > 0 then
		local var_31_2 = arg_31_0:getTeamByName(var_31_1) or {}

		if #var_31_2 == 1 and arg_31_0:isFirstFleet() then
			do return false end

			goto label_31_0
		end
	end

	do return true end

	::label_31_0::

	return
end

function var_0_0.isRegularFleet(arg_32_0)
	return arg_32_0.id >= var_0_0.SUBMARINE_FLEET_ID and arg_32_0.id < var_0_0.SUBMARINE_FLEET_ID + var_0_0.SUBMARINE_FLEET_NUMS or arg_32_0.id >= var_0_0.REGULAR_FLEET_ID and arg_32_0.id < var_0_0.REGULAR_FLEET_ID + var_0_0.REGULAR_FLEET_NUMS
end

function var_0_0.isSubmarineFleet(arg_33_0)
	return arg_33_0.id >= var_0_0.SUBMARINE_FLEET_ID and arg_33_0.id < var_0_0.SUBMARINE_FLEET_ID + var_0_0.SUBMARINE_FLEET_NUMS
end

function var_0_0.isPVPFleet(arg_34_0)
	return arg_34_0.id == FleetProxy.PVP_FLEET_ID
end

function var_0_0.getFleetType(arg_35_0)
	assert(false)

	return
end

function var_0_0.removeShip(arg_36_0, arg_36_1)
	assert(arg_36_0:containShip(arg_36_1), "ship are not in fleet")

	for iter_36_0, iter_36_1 in ipairs(arg_36_0.ships) do
		if iter_36_1 == arg_36_1.id then
			table.remove(arg_36_0.ships, iter_36_0)

			break
		end
	end

	for iter_36_2, iter_36_3 in ipairs(arg_36_0.vanguardShips) do
		if iter_36_3 == arg_36_1.id then
			return table.remove(arg_36_0.vanguardShips, iter_36_2), TeamType.Vanguard
		end
	end

	for iter_36_4, iter_36_5 in ipairs(arg_36_0.mainShips) do
		if iter_36_5 == arg_36_1.id then
			return table.remove(arg_36_0.mainShips, iter_36_4), TeamType.Main
		end
	end

	for iter_36_6, iter_36_7 in ipairs(arg_36_0.subShips) do
		if iter_36_7 == arg_36_1.id then
			return table.remove(arg_36_0.subShips, iter_36_6), TeamType.Submarine
		end
	end

	return nil
end

function var_0_0.isFull(arg_37_0)
	local var_37_0 = arg_37_0:getFleetType()

	if var_37_0 == FleetType.Normal then
		assert(#arg_37_0.vanguardShips <= TeamType.VanguardMax and #arg_37_0.mainShips <= TeamType.MainMax)

		return #arg_37_0.vanguardShips == TeamType.VanguardMax and #arg_37_0.mainShips == TeamType.MainMax
	elseif var_37_0 == FleetType.Submarine then
		assert(#arg_37_0.subShips <= TeamType.SubmarineMax)

		return #arg_37_0.subShips == TeamType.SubmarineMax
	end

	return false
end

function var_0_0.isEmpty(arg_38_0)
	return #arg_38_0.ships == 0
end

function var_0_0.isCommanderEmpty(arg_39_0)
	for iter_39_0, iter_39_1 in pairs(arg_39_0.commanderIds) do
		if iter_39_1 and iter_39_1 ~= 0 then
			return false
		end
	end

	return true
end

function var_0_0.isLegalToFight(arg_40_0)
	local var_40_0 = arg_40_0:getFleetType()

	if var_40_0 == FleetType.Normal then
		if #arg_40_0.vanguardShips == 0 then
			return TeamType.Vanguard, 1
		elseif #arg_40_0.mainShips == 0 then
			return TeamType.Main, 1
		end
	elseif var_40_0 == FleetType.Submarine and #arg_40_0.subShips == 0 then
		return TeamType.Submarine, 1
	end

	return true
end

function var_0_0.getSkillNum(arg_41_0)
	for iter_41_0, iter_41_1 in pairs({
		"zhupao",
		"yulei",
		"fangkongpao",
		"jianzaiji"
	}) do
		({})[iter_41_1] = 0
	end

	local var_41_0 = getProxy(BayProxy):getRawData()

	for iter_41_2, iter_41_3 in ipairs(arg_41_0.ships) do
		for iter_41_4, iter_41_5 in ipairs(var_41_0[iter_41_3]:getActiveEquipments()) do
			if iter_41_5 > 0 then
				local var_41_1 = Equipment.New({
					id = iter_41_5
				})

				for iter_41_6, iter_41_7 in ipairs((var_41_1:getConfig("weapon_id"))) do
					if iter_41_7 > 0 then
						if pg.weapon_property[iter_41_7].type == ys.Battle.BattleConst.EquipmentType.POINT_HIT_AND_LOCK then
							({}).zhupao = ({}).zhupao + 1
						elseif pg.weapon_property[iter_41_7].type == ys.Battle.BattleConst.EquipmentType.TORPEDO or pg.weapon_property[iter_41_7].type == ys.Battle.BattleConst.EquipmentType.MANUAL_TORPEDO then
							({}).yulei = ({}).yulei + 1
						elseif pg.weapon_property[iter_41_7].type == ys.Battle.BattleConst.EquipmentType.ANTI_AIR then
							({}).fangkongpao = ({}).fangkongpao + 1
						elseif pg.weapon_property[iter_41_7].type == ys.Battle.BattleConst.EquipmentType.INTERCEPT_AIRCRAFT then
							({}).jianzaiji = ({}).jianzaiji + 1
						end
					end
				end
			end
		end
	end

	return {}
end

function var_0_0.GetPropertiesSum(arg_42_0)
	local var_42_0 = getProxy(BayProxy):getRawData()

	for iter_42_0, iter_42_1 in ipairs(arg_42_0.ships) do
		local var_42_1 = var_42_0[iter_42_1]:getProperties(arg_42_0:getCommanders())

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
		}).cannon + math.floor(var_42_1.cannon)
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
		}).torpedo + math.floor(var_42_1.torpedo)
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
		}).antiAir + math.floor(var_42_1.antiaircraft)
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
		}).air + math.floor(var_42_1.air)
	end

	return {
		cannon = 0,
		antiAir = 0,
		air = 0,
		torpedo = 0
	}
end

function var_0_0.GetCostSum(arg_43_0)
	local var_43_0 = arg_43_0:getEndCost()

	if arg_43_0:getFleetType() == FleetType.Submarine then
		({
			gold = 0,
			oil = 0
		}).oil = var_43_0.oil
	else
		({
			gold = 0,
			oil = 0
		}).oil = arg_43_0:getStartCost().oil + var_43_0.oil
	end

	return {
		gold = 0,
		oil = 0
	}
end

function var_0_0.getStartCost(arg_44_0)
	local var_44_0 = getProxy(BayProxy):getRawData()

	for iter_44_0, iter_44_1 in ipairs(arg_44_0.ships) do
		({
			gold = 0,
			oil = 0
		}).oil = ({
			gold = 0,
			oil = 0
		}).oil + var_44_0[iter_44_1]:getStartBattleExpend()
	end

	return {
		gold = 0,
		oil = 0
	}
end

function var_0_0.getEndCost(arg_45_0)
	local var_45_0 = getProxy(BayProxy):getRawData()

	for iter_45_0, iter_45_1 in ipairs(arg_45_0.ships) do
		({
			gold = 0,
			oil = 0
		}).oil = ({
			gold = 0,
			oil = 0
		}).oil + var_45_0[iter_45_1]:getEndBattleExpend()
	end

	return {
		gold = 0,
		oil = 0
	}
end

function var_0_0.GetGearScoreSum(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_1 == nil and arg_46_0.ships or arg_46_0:getTeamByName(arg_46_1)
	local var_46_1 = 0
	local var_46_2 = getProxy(BayProxy):getRawData()

	for iter_46_0, iter_46_1 in ipairs(var_46_0) do
		var_46_1 = var_46_1 + var_46_2[iter_46_1]:getShipCombatPower(arg_46_0:getCommanders())
	end

	return var_46_1
end

function var_0_0.GetEnergyStatus(arg_47_0)
	local var_47_0 = false
	local var_47_1 = ""
	local var_47_2 = ""
	local var_47_3 = getProxy(BayProxy)

	;(function(arg_48_0)
		for iter_48_0 = 1, 3 do
			if arg_48_0[iter_48_0] then
				local var_48_0 = var_47_3:getShipById(arg_48_0[iter_48_0])

				if var_48_0.energy == Ship.ENERGY_LOW then
					var_47_0 = true
					var_47_2 = var_47_2 .. "「" .. var_48_0:getConfig("name") .. "」"
				end
			end
		end

		return
	end)(arg_47_0.mainShips)
	;(function(arg_48_0)
		for iter_48_0 = 1, 3 do
			if arg_48_0[iter_48_0] then
				local var_48_0 = var_47_3:getShipById(arg_48_0[iter_48_0])

				if var_48_0.energy == Ship.ENERGY_LOW then
					var_47_0 = true
					var_47_2 = var_47_2 .. "「" .. var_48_0:getConfig("name") .. "」"
				end
			end
		end

		return
	end)(arg_47_0.vanguardShips)
	;(function(arg_48_0)
		for iter_48_0 = 1, 3 do
			if arg_48_0[iter_48_0] then
				local var_48_0 = var_47_3:getShipById(arg_48_0[iter_48_0])

				if var_48_0.energy == Ship.ENERGY_LOW then
					var_47_0 = true
					var_47_2 = var_47_2 .. "「" .. var_48_0:getConfig("name") .. "」"
				end
			end
		end

		return
	end)(arg_47_0.subShips)

	if false then
		var_47_1 = arg_47_0:GetName()
	end

	local var_47_5 = i18n("ship_energy_low_warn", var_47_1, "")
end

function var_0_0.genRobotDataString(arg_49_0)
	local var_49_0 = getProxy(BayProxy):getRawData()
	local var_49_1 = "99999,"

	for iter_49_0 = 1, 3 do
		if arg_49_0.vanguardShips[iter_49_0] and arg_49_0.vanguardShips[iter_49_0] > 0 then
			var_49_1 = var_49_1 .. var_49_0[arg_49_0.vanguardShips[iter_49_0]].configId .. "," .. var_49_0[arg_49_0.vanguardShips[iter_49_0]].level .. ",\"{"

			for iter_49_1, iter_49_2 in pairs(var_49_0[arg_49_0.vanguardShips[iter_49_0]]:getActiveEquipments()) do
				local var_49_2 = var_49_1

				if iter_49_2 then
					local var_49_3 = iter_49_2.id or 0

					var_49_1 = var_49_2 .. var_49_3

					if iter_49_1 < 5 then
						var_49_1 = var_49_1 .. ","
					end
				end
			end

			var_49_1 = var_49_1 .. "}\","
		else
			var_49_1 = var_49_1 .. "" .. "," .. "" .. ",{" .. "},"
		end
	end

	for iter_49_3 = 1, 3 do
		if arg_49_0.mainShips[iter_49_3] and arg_49_0.mainShips[iter_49_3] > 0 then
			var_49_1 = var_49_1 .. var_49_0[arg_49_0.mainShips[iter_49_3]].configId .. "," .. var_49_0[arg_49_0.mainShips[iter_49_3]].level .. ",\"{"

			for iter_49_4, iter_49_5 in pairs(var_49_0[arg_49_0.mainShips[iter_49_3]]:getActiveEquipments()) do
				local var_49_4 = var_49_1

				if iter_49_5 then
					local var_49_5 = iter_49_5.id or 0

					var_49_1 = var_49_4 .. var_49_5

					if iter_49_4 < 5 then
						var_49_1 = var_49_1 .. ","
					end
				end
			end

			var_49_1 = var_49_1 .. "}\","
		else
			var_49_1 = var_49_1 .. "" .. "," .. "" .. ",{" .. "},"
		end
	end

	return var_49_1 .. math.floor(arg_49_0:GetGearScoreSum(TeamType.Vanguard) + arg_49_0:GetGearScoreSum(TeamType.Main)) .. ","
end

function var_0_0.getIndex(arg_50_0)
	if arg_50_0.id >= var_0_0.SUBMARINE_FLEET_ID and arg_50_0.id < var_0_0.SUBMARINE_FLEET_ID + var_0_0.SUBMARINE_FLEET_NUMS then
		return arg_50_0.id - var_0_0.SUBMARINE_FLEET_ID + 1
	elseif arg_50_0.id >= var_0_0.REGULAR_FLEET_ID and arg_50_0.id < var_0_0.REGULAR_FLEET_ID + var_0_0.REGULAR_FLEET_NUMS then
		return arg_50_0.id - var_0_0.REGULAR_FLEET_ID + 1
	end

	return arg_50_0.id
end

function var_0_0.getShipCount(arg_51_0)
	return #arg_51_0.ships
end

function var_0_0.avgLevel(arg_52_0)
	local var_52_0 = 0

	for iter_52_0, iter_52_1 in ipairs(arg_52_0.ships) do
		local var_52_1 = getProxy(BayProxy)

		var_52_0 = var_52_1:getShipById(iter_52_1).level + var_52_0
	end

	return math.floor(var_52_0 / #arg_52_0.ships)
end

function var_0_0.clearFleet(arg_53_0)
	local var_53_0 = getProxy(BayProxy)

	for iter_53_0, iter_53_1 in ipairs((Clone(arg_53_0.ships))) do
		arg_53_0:removeShip((var_53_0:getShipById(iter_53_1)))
	end

	return
end

function var_0_0.EnergyCheck(arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_4)
	arg_54_4 = arg_54_4 or "ship_energy_low_warn"

	local var_54_0 = {}

	for iter_54_0, iter_54_1 in ipairs(arg_54_0) do
		if iter_54_1.energy == Ship.ENERGY_LOW then
			table.insert(var_54_0, iter_54_1)
		end
	end

	if #var_54_0 > 0 then
		local var_54_1 = ""
		local var_54_2 = _.map(var_54_0, function(arg_55_0)
			return "「" .. arg_55_0:getConfig("name") .. "」"
		end)

		if PLATFORM_CODE ~= PLATFORM_US or #var_54_2 == 1 then
			for iter_54_2, iter_54_3 in ipairs(var_54_2) do
				var_54_1 = var_54_1 .. iter_54_3
			end
		else
			if arg_54_4 == "ship_energy_low_warn_no_exp" or arg_54_4 == "ship_energy_low_warn" or arg_54_4 == "ship_energy_low_desc" then
				arg_54_4 = "multiple_" .. arg_54_4
			end

			for iter_54_4 = 1, #var_54_2 - 2 do
				var_54_1 = var_54_1 .. var_54_2[iter_54_4] .. ", "
			end

			var_54_1 = var_54_1 .. var_54_2[#var_54_2 - 1] .. " and " .. var_54_2[#var_54_2]
		end

		existCall(arg_54_3, false)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n(arg_54_4, arg_54_1, var_54_1),
			onYes = function()
				arg_54_2(true)

				return
			end,
			onNo = function()
				arg_54_2(false)

				return
			end
		})
	else
		existCall(arg_54_3, true)
		arg_54_2(true)
	end

	return
end

function var_0_0.getFleetAirDominanceValue(arg_58_0)
	local var_58_0 = getProxy(BayProxy)
	local var_58_1 = arg_58_0:getCommanders()
	local var_58_2 = 0

	for iter_58_0, iter_58_1 in ipairs(arg_58_0.ships) do
		var_58_2 = (function(arg_59_0, arg_59_1)
			return arg_59_0 + calcAirDominanceValue(var_58_0:getShipById(arg_59_1), var_58_1)
		end)(var_58_2, iter_58_1)
	end

	return var_58_2
end

function var_0_0.RemoveUnusedItems(arg_60_0)
	local var_60_0 = getProxy(BayProxy)

	for iter_60_0, iter_60_1 in ipairs((Clone(arg_60_0.ships))) do
		if not var_60_0:getShipById(iter_60_1) then
			arg_60_0:removeShipById(iter_60_1)
		end
	end

	local var_60_1 = getProxy(CommanderProxy)

	for iter_60_2, iter_60_3 in pairs(arg_60_0.commanderIds) do
		if not var_60_1:getCommanderById(iter_60_3) then
			table.insert({}, iter_60_2)
		end
	end

	if #{} > 0 then
		for iter_60_4, iter_60_5 in pairs({}) do
			arg_60_0.commanderIds[iter_60_5] = nil
		end

		arg_60_0.skills = {}

		arg_60_0:updateCommanderSkills()
	end

	return
end

function var_0_0.removeShipById(arg_61_0, arg_61_1)
	for iter_61_0, iter_61_1 in ipairs(arg_61_0.ships) do
		if iter_61_1 == arg_61_1 then
			table.remove(arg_61_0.ships, iter_61_0)

			break
		end
	end

	for iter_61_2, iter_61_3 in ipairs(arg_61_0.vanguardShips) do
		if iter_61_3 == arg_61_1 then
			return table.remove(arg_61_0.vanguardShips, iter_61_2), TeamType.Vanguard
		end
	end

	for iter_61_4, iter_61_5 in ipairs(arg_61_0.mainShips) do
		if iter_61_5 == arg_61_1 then
			return table.remove(arg_61_0.mainShips, iter_61_4), TeamType.Main
		end
	end

	for iter_61_6, iter_61_7 in ipairs(arg_61_0.subShips) do
		if iter_61_7 == arg_61_1 then
			return table.remove(arg_61_0.subShips, iter_61_6), TeamType.Submarine
		end
	end

	return
end

function var_0_0.HaveShipsInEvent(arg_62_0)
	local var_62_0 = getProxy(BayProxy):getRawData()

	for iter_62_0, iter_62_1 in ipairs(arg_62_0.ships) do
		if var_62_0[iter_62_1]:getFlag("inEvent") then
			local var_62_2 = i18n("elite_disable_ship_escort")

			return
		end
	end

	return
end

function var_0_0.GetFleetSonarRange(arg_63_0)
	local var_63_0 = getProxy(BayProxy)
	local var_63_1 = 0
	local var_63_2 = 0
	local var_63_3 = 0
	local var_63_4 = 0

	for iter_63_0, iter_63_1 in ipairs(arg_63_0.ships) do
		local var_63_5 = var_63_0:getShipById(iter_63_1)

		if var_63_5 then
			local var_63_6 = var_63_5:getShipType()

			if ys.Battle.BattleConfig.VAN_SONAR_PROPERTY[var_63_6] then
				local var_63_7 = var_63_5:getShipProperties()[AttributeType.AntiSub] or 0

				var_63_1 = math.max(var_63_1, Mathf.Clamp(var_63_7 / ys.Battle.BattleConfig.VAN_SONAR_PROPERTY[var_63_6].a - ys.Battle.BattleConfig.VAN_SONAR_PROPERTY[var_63_6].b, ys.Battle.BattleConfig.VAN_SONAR_PROPERTY[var_63_6].minRange, ys.Battle.BattleConfig.VAN_SONAR_PROPERTY[var_63_6].maxRange))
			end

			if table.contains(ShipType.MainShipType, var_63_6) then
				local var_63_8 = var_63_5:getShipProperties()[AttributeType.AntiSub] or 0

				var_63_4 = var_63_4 + var_63_8
			end

			for iter_63_2, iter_63_3 in ipairs(var_63_5:getActiveEquipments()) do
				if iter_63_3 then
					local var_63_9 = iter_63_3:getConfig("equip_parameters").range or 0

					var_63_3 = var_63_3 + var_63_9
				end
			end
		end
	end

	if var_63_1 ~= 0 then
		var_63_2 = var_63_3 + Mathf.Clamp(var_63_4 / ys.Battle.BattleConfig.MAIN_SONAR_PROPERTY.a, ys.Battle.BattleConfig.MAIN_SONAR_PROPERTY.minRange, ys.Battle.BattleConfig.MAIN_SONAR_PROPERTY.maxRange)
	end

	return var_63_1 + var_63_2
end

function var_0_0.getInvestSums(arg_64_0)
	local var_64_0 = getProxy(BayProxy)

	return math.pow(_.reduce(arg_64_0.ships, 0, function(arg_65_0, arg_65_1)
		local var_65_0 = var_64_0:getShipById(arg_65_1):getProperties(arg_64_0:getCommanders())

		return arg_65_0 + var_65_0[AttributeType.Air] + var_65_0[AttributeType.Dodge]
	end), 0.6666666666666666)
end

function var_0_0.ExistActNpcShip(arg_66_0)
	local var_66_0 = getProxy(BayProxy)

	for iter_66_0, iter_66_1 in ipairs(arg_66_0.ships) do
		local var_66_1 = var_66_0:RawGetShipById(iter_66_1)

		if var_66_1 and var_66_1:isActivityNpc() then
			return true
		end
	end

	return false
end

function var_0_0.GetName(arg_67_0)
	return noEmptyStr(arg_67_0.name) or var_0_0.DEFAULT_NAME[arg_67_0.id]
end

function var_0_0.ChangeToElite(arg_68_0)
	local var_68_0 = arg_68_0:getFleetType()
	local var_68_1 = {
		id = arg_68_0.id,
		[TeamType.FormShips] = {},
		[TeamType.FormCommander] = {
			0,
			0
		}
	}

	for iter_68_0, iter_68_1 in ipairs(arg_68_0.commanderIds) do
		({
			id = arg_68_0.id,
			[TeamType.FormShips] = {},
			[TeamType.FormCommander] = {
				0,
				0
			}
		})[TeamType.FormCommander][iter_68_0] = iter_68_1
	end

	switch(var_68_0, {
		[FleetType.Normal] = function()
			var_68_1[TeamType.FormShips] = table.mergeArray(arg_68_0.mainShips, arg_68_0.vanguardShips)

			return
		end,
		[FleetType.Submarine] = function()
			var_68_1[TeamType.FormShips] = underscore.to_array(arg_68_0.subShips)

			return
		end,
		[FleetType.Support] = function()
			var_68_1[TeamType.FormShips] = underscore.to_array(arg_68_0.mainShips)

			return
		end
	})

	return {
		id = arg_68_0.id,
		[TeamType.FormShips] = {},
		[TeamType.FormCommander] = {
			0,
			0
		}
	}, var_68_0
end

function var_0_0.allClear(arg_72_0)
	arg_72_0:clearFleet()
	arg_72_0:clearCommanders()

	return
end

function var_0_0.isAllEmpty(arg_73_0)
	return arg_73_0:isEmpty() and arg_73_0:isCommanderEmpty()
end

return var_0_0
