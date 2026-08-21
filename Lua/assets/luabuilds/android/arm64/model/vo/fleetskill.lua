local var_0_0 = class("FleetSkill", import(".BaseVO"))

var_0_0.SystemCommanderNeko = 1
var_0_0.TypeMoveSpeed = "move_speed"
var_0_0.TypeHuntingLv = "hunt_lv"
var_0_0.TypeAmbushDodge = "ambush_dodge"
var_0_0.TypeAirStrikeDodge = "airfight_doge"
var_0_0.TypeStrategy = "strategy"
var_0_0.TypeBattleBuff = "battle_buff"
var_0_0.TypeAttack = "attack"
var_0_0.TypeTorpedoPowerUp = "torpedo_power_up"
var_0_0.TriggerDDHead = "dd_head"
var_0_0.TriggerAroundEnemy = "around_enemy"
var_0_0.TriggerVanCount = "vang_count"
var_0_0.TriggerNekoPos = "pos"
var_0_0.TriggerAroundLand = "around_land"
var_0_0.TriggerAroundCombatAlly = "around_combat_ally"
var_0_0.TriggerShipCount = "count"
var_0_0.TriggerInSubTeam = "insubteam"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.system = arg_1_1
	arg_1_0.id = arg_1_2
	arg_1_0.configId = arg_1_0.id

	return
end

function var_0_0.GetSystem(arg_2_0)
	return arg_2_0.system
end

function var_0_0.bindConfigTable(arg_3_0)
	if arg_3_0:GetSystem() == var_0_0.SystemCommanderNeko then
		return pg.commander_skill_effect_template
	end

	assert(false, "Do not support exception.")

	return
end

function var_0_0.GetType(arg_4_0)
	if arg_4_0:GetSystem() == var_0_0.SystemCommanderNeko then
		return arg_4_0:getConfig("effect_type")
	end

	assert(false, "Do not support exception.")

	return
end

function var_0_0.GetArgs(arg_5_0)
	if arg_5_0:GetSystem() == var_0_0.SystemCommanderNeko then
		return arg_5_0:getConfig("args")
	end

	assert(false, "Do not support exception.")

	return
end

function var_0_0.GetTriggers(arg_6_0)
	if arg_6_0:GetSystem() == var_0_0.SystemCommanderNeko then
		return arg_6_0:getConfig("condition")
	end

	assert(false, "Do not support exception.")

	return
end

function var_0_0.triggerSkill(arg_7_0, arg_7_1)
	local var_7_0 = _.filter(arg_7_0:findSkills(arg_7_1), function(arg_8_0)
		return _.any(arg_8_0:GetTriggers(), function(arg_9_0)
			return arg_9_0[1] == FleetSkill.TriggerInSubTeam and arg_9_0[2] == 1
		end) == (arg_7_0:getFleetType() == FleetType.Submarine) and _.all(arg_8_0:GetTriggers(), function(arg_10_0)
			return var_0_0.NoneChapterFleetCheck(arg_7_0, arg_8_0, arg_10_0)
		end)
	end)

	return _.reduce(var_7_0, nil, function(arg_11_0, arg_11_1)
		if arg_11_1:GetType() == FleetSkill.TypeBattleBuff then
			arg_11_0 = arg_11_0 or {}

			table.insert(arg_11_0, arg_11_1:GetArgs()[1])

			return arg_11_0
		end

		return
	end), var_7_0
end

function var_0_0.NoneChapterFleetCheck(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = getProxy(BayProxy)

	if arg_12_2[1] == FleetSkill.TriggerDDHead then
		local var_12_1 = var_12_0:getShipByTeam(arg_12_0, TeamType.Vanguard)

		return #var_12_1 > 0 and ShipType.IsTypeQuZhu(var_12_1[1]:getShipType())
	elseif arg_12_2[1] == FleetSkill.TriggerVanCount then
		local var_12_2 = var_12_0:getShipByTeam(arg_12_0, TeamType.Vanguard)

		return #var_12_2 >= arg_12_2[2] and #var_12_2 <= arg_12_2[3]
	elseif arg_12_2[1] == FleetSkill.TriggerShipCount then
		local var_12_3 = _.filter(var_12_0:getShipsByFleet(arg_12_0), function(arg_13_0)
			return table.contains(arg_12_2[2], arg_13_0:getShipType())
		end)

		return #var_12_3 >= arg_12_2[3] and #var_12_3 <= arg_12_2[4]
	elseif arg_12_2[1] == FleetSkill.TriggerNekoPos then
		local var_12_4 = arg_12_0:findCommanderBySkillId(arg_12_1.id)

		for iter_12_0, iter_12_1 in pairs(arg_12_0:getCommanders()) do
			if var_12_4.id == iter_12_1.id and iter_12_0 == arg_12_2[2] then
				return true
			end
		end
	elseif arg_12_2[1] == FleetSkill.TriggerInSubTeam then
		return true
	else
		return false
	end

	return
end

function var_0_0.triggerMirrorSkill(arg_14_0, arg_14_1)
	local var_14_0 = _.filter(arg_14_0:findSkills(arg_14_1), function(arg_15_0)
		return _.any(arg_15_0:GetTriggers(), function(arg_16_0)
			return arg_16_0[1] == FleetSkill.TriggerInSubTeam and arg_16_0[2] == 1
		end) == (arg_14_0:getFleetType() == FleetType.Submarine) and _.all(arg_15_0:GetTriggers(), function(arg_17_0)
			return var_0_0.MirrorFleetCheck(arg_14_0, arg_15_0, arg_17_0)
		end)
	end)

	return _.reduce(var_14_0, nil, function(arg_18_0, arg_18_1)
		if arg_18_1:GetType() == FleetSkill.TypeBattleBuff then
			arg_18_0 = arg_18_0 or {}

			table.insert(arg_18_0, arg_18_1:GetArgs()[1])

			return arg_18_0
		end

		return
	end), var_14_0
end

function var_0_0.MirrorFleetCheck(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = getProxy(BayProxy)

	if arg_19_2[1] == FleetSkill.TriggerDDHead then
		local var_19_1 = arg_19_0:getShipsByTeam(TeamType.Vanguard, false)

		return #var_19_1 > 0 and ShipType.IsTypeQuZhu(var_19_1[1]:getShipType())
	elseif arg_19_2[1] == FleetSkill.TriggerVanCount then
		local var_19_2 = arg_19_0:getShipsByTeam(TeamType.Vanguard, false)

		return #var_19_2 >= arg_19_2[2] and #var_19_2 <= arg_19_2[3]
	elseif arg_19_2[1] == FleetSkill.TriggerShipCount then
		local var_19_3 = _.filter(arg_19_0:getShips(false), function(arg_20_0)
			return table.contains(arg_19_2[2], arg_20_0:getShipType())
		end)

		return #var_19_3 >= arg_19_2[3] and #var_19_3 <= arg_19_2[4]
	elseif arg_19_2[1] == FleetSkill.TriggerNekoPos then
		local var_19_4 = arg_19_0:findCommanderBySkillId(arg_19_1.id)

		for iter_19_0, iter_19_1 in pairs(arg_19_0:getCommanders()) do
			if var_19_4.id == iter_19_1.id and iter_19_0 == arg_19_2[2] then
				return true
			end
		end
	elseif arg_19_2[1] == FleetSkill.TriggerInSubTeam then
		return true
	else
		return false
	end

	return
end

function var_0_0.GuildBossTriggerSkill(arg_21_0, arg_21_1)
	local var_21_0 = _.filter(arg_21_0:findSkills(arg_21_1), function(arg_22_0)
		return _.any(arg_22_0:GetTriggers(), function(arg_23_0)
			return arg_23_0[1] == FleetSkill.TriggerInSubTeam and arg_23_0[2] == 1
		end) == (arg_21_0:getFleetType() == FleetType.Submarine) and _.all(arg_22_0:GetTriggers(), function(arg_24_0)
			return var_0_0.GuildBossFleetCheck(arg_21_0, arg_22_0, arg_24_0)
		end)
	end)

	return _.reduce(var_21_0, nil, function(arg_25_0, arg_25_1)
		if arg_25_1:GetType() == FleetSkill.TypeBattleBuff then
			arg_25_0 = arg_25_0 or {}

			table.insert(arg_25_0, arg_25_1:GetArgs()[1])

			return arg_25_0
		end

		return
	end), var_21_0
end

function var_0_0.GuildBossFleetCheck(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_2[1] == FleetSkill.TriggerDDHead then
		local var_26_0 = arg_26_0:GetTeamTypeShips(TeamType.Vanguard)

		return #var_26_0 > 0 and ShipType.IsTypeQuZhu(var_26_0[1]:getShipType())
	elseif arg_26_2[1] == FleetSkill.TriggerVanCount then
		local var_26_1 = arg_26_0:GetTeamTypeShips(TeamType.Vanguard)

		return #var_26_1 >= arg_26_2[2] and #var_26_1 <= arg_26_2[3]
	elseif arg_26_2[1] == FleetSkill.TriggerShipCount then
		local var_26_2 = _.filter(arg_26_0:GetShips(), function(arg_27_0)
			return table.contains(arg_26_2[2], arg_27_0.ship:getShipType())
		end)

		return #var_26_2 >= arg_26_2[3] and #var_26_2 <= arg_26_2[4]
	elseif arg_26_2[1] == FleetSkill.TriggerNekoPos then
		local var_26_3 = arg_26_0:findCommanderBySkillId(arg_26_1.id)

		for iter_26_0, iter_26_1 in pairs(arg_26_0:getCommanders()) do
			if var_26_3.id == iter_26_1.id and iter_26_0 == arg_26_2[2] then
				return true
			end
		end
	elseif arg_26_2[1] == FleetSkill.TriggerInSubTeam then
		return true
	else
		return false
	end

	return
end

return var_0_0
