class = var_0_10000

local var_0_0 = "FleetSkill"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

var_0_1.SystemCommanderNeko = 1
var_0_1.TypeMoveSpeed = "move_speed"
var_0_1.TypeHuntingLv = "hunt_lv"
var_0_1.TypeAmbushDodge = "ambush_dodge"
var_0_1.TypeAirStrikeDodge = "airfight_doge"
var_0_1.TypeStrategy = "strategy"
var_0_1.TypeBattleBuff = "battle_buff"
var_0_1.TypeAttack = "attack"
var_0_1.TypeTorpedoPowerUp = "torpedo_power_up"
var_0_1.TriggerDDHead = "dd_head"
var_0_1.TriggerAroundEnemy = "around_enemy"
var_0_1.TriggerVanCount = "vang_count"
var_0_1.TriggerNekoPos = "pos"
var_0_1.TriggerAroundLand = "around_land"
var_0_1.TriggerAroundCombatAlly = "around_combat_ally"
var_0_1.TriggerShipCount = "count"
var_0_1.TriggerInSubTeam = "insubteam"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.system = arg_1_1
	arg_1_0.id = arg_1_2
	arg_1_0.configId = arg_1_0.id

	return
end

function var_0_1.GetSystem(arg_2_0)
	return arg_2_0.system
end

function var_0_1.bindConfigTable(arg_3_0)
	if arg_3_0:GetSystem() == var_0_1.SystemCommanderNeko then
		pg = var_1

		return var_1.commander_skill_effect_template
	end

	assert = var_1

	var_1(false, "Do not support exception.")

	return
end

function var_0_1.GetType(arg_4_0)
	if arg_4_0:GetSystem() == var_0_1.SystemCommanderNeko then
		return arg_4_0:getConfig("effect_type")
	end

	assert = var_1

	var_1(false, "Do not support exception.")

	return
end

function var_0_1.GetArgs(arg_5_0)
	if arg_5_0:GetSystem() == var_0_1.SystemCommanderNeko then
		return arg_5_0:getConfig("args")
	end

	assert = var_1

	var_1(false, "Do not support exception.")

	return
end

function var_0_1.GetTriggers(arg_6_0)
	if arg_6_0:GetSystem() == var_0_1.SystemCommanderNeko then
		return arg_6_0:getConfig("condition")
	end

	assert = var_1

	var_1(false, "Do not support exception.")

	return
end

function var_0_1.triggerSkill(arg_7_0, arg_7_1)
	_ = var_1_10002

	local var_7_0 = var_1_10002.filter(arg_7_0:findSkills(arg_7_1), function(arg_8_0)
		local var_8_0 = arg_8_0:GetTriggers()

		_ = var_2_10002

		local var_8_1 = var_2_10002.any(var_8_0, function(arg_9_0)
			local var_9_0 = arg_9_0[1]

			FleetSkill = var_3_10002

			return var_9_0 == var_3_10002.TriggerInSubTeam and arg_9_0[2] == 1
		end)
		local var_8_2 = arg_7_0
		local var_8_3 = var_3.getFleetType(var_8_2)

		FleetType = var_4

		local var_8_4

		if var_8_1 == (var_8_3 == var_4.Submarine) then
			_ = var_4
			var_8_4 = var_4.all(arg_8_0:GetTriggers(), function(arg_10_0)
				return var_0_1.NoneChapterFleetCheck(arg_7_0, arg_8_0, arg_10_0)
			end)
		else
			var_8_4 = false
		end

		if false then
			var_8_4 = true
		end

		return var_8_4
	end)

	_ = var_1_10003

	return var_1_10003.reduce(var_7_0, nil, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_1
		local var_11_1 = arg_11_1.GetType(var_11_0)
		local var_11_2 = arg_11_1:GetArgs()

		FleetSkill = var_11_0

		if var_11_1 == var_11_0.TypeBattleBuff then
			arg_11_0 = arg_11_0 or {}
			table = var_4

			var_4.insert(arg_11_0, var_11_2[1])

			return arg_11_0
		end

		return
	end), var_7_0
end

function var_0_1.NoneChapterFleetCheck(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2[1]

	getProxy = var_1_10004
	BayProxy = var_1_10006

	local var_12_1 = var_1_10004(var_1_10006)

	FleetSkill = var_1_10005

	local var_12_3

	if var_12_0 == var_1_10005.TriggerDDHead then
		local var_12_2 = var_12_1

		var_12_3 = var_12_1.getShipByTeam

		local var_12_4 = arg_12_0

		TeamType = var_1_10009

		if #var_12_3(var_12_2, var_12_4, var_1_10009.Vanguard) > 0 then
			ShipType = var_1_10006
			var_1_10006 = var_1_10006.IsTypeQuZhu

			local var_12_5 = var_12_3[1]

			var_1_10006 = var_1_10006(var_8.getShipType(var_12_5))
		else
			var_1_10006 = false
		end

		if false then
			var_1_10006 = true
		end

		return var_1_10006
	else
		FleetSkill = var_12_3

		local var_12_7

		if var_12_0 == var_12_3.TriggerVanCount then
			local var_12_6 = var_12_1

			var_12_7 = var_12_1.getShipByTeam

			local var_12_8 = arg_12_0

			TeamType = var_1_10009
			var_1_10006 = #var_12_7(var_12_6, var_12_8, var_1_10009.Vanguard) >= arg_12_2[2] and #var_12_7 <= arg_12_2[3]

			return var_1_10006
		else
			FleetSkill = var_12_7

			if var_12_0 == var_12_7.TriggerShipCount then
				_ = var_5
				var_1_10006 = #var_5.filter(var_12_1:getShipsByFleet(arg_12_0), function(arg_13_0)
					table = var_2_10001

					return var_2_10001.contains(arg_12_2[2], arg_13_0:getShipType())
				end) >= arg_12_2[3] and #var_5 <= arg_12_2[4]

				return var_1_10006
			else
				FleetSkill = var_5

				local var_12_9

				if var_12_0 == var_5.TriggerNekoPos then
					var_12_9 = arg_12_0:findCommanderBySkillId(arg_12_1.id)
					pairs = var_1_10006

					for iter_12_0, iter_12_1 in var_1_10006(arg_12_0:getCommanders()) do
						if var_12_9.id == iter_12_1.id and iter_12_0 == arg_12_2[2] then
							return true
						end
					end
				else
					FleetSkill = var_12_9

					if var_12_0 == var_12_9.TriggerInSubTeam then
						return true
					else
						return false
					end
				end
			end
		end
	end

	return
end

function var_0_1.triggerMirrorSkill(arg_14_0, arg_14_1)
	_ = var_1_10002

	local var_14_0 = var_1_10002.filter(arg_14_0:findSkills(arg_14_1), function(arg_15_0)
		local var_15_0 = arg_15_0:GetTriggers()

		_ = var_2_10002

		local var_15_1 = var_2_10002.any(var_15_0, function(arg_16_0)
			local var_16_0 = arg_16_0[1]

			FleetSkill = var_3_10002

			return var_16_0 == var_3_10002.TriggerInSubTeam and arg_16_0[2] == 1
		end)
		local var_15_2 = arg_14_0
		local var_15_3 = var_3.getFleetType(var_15_2)

		FleetType = var_4

		local var_15_4

		if var_15_1 == (var_15_3 == var_4.Submarine) then
			_ = var_4
			var_15_4 = var_4.all(arg_15_0:GetTriggers(), function(arg_17_0)
				return var_0_1.MirrorFleetCheck(arg_14_0, arg_15_0, arg_17_0)
			end)
		else
			var_15_4 = false
		end

		if false then
			var_15_4 = true
		end

		return var_15_4
	end)

	_ = var_1_10003

	return var_1_10003.reduce(var_14_0, nil, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_18_1
		local var_18_1 = arg_18_1.GetType(var_18_0)
		local var_18_2 = arg_18_1:GetArgs()

		FleetSkill = var_18_0

		if var_18_1 == var_18_0.TypeBattleBuff then
			arg_18_0 = arg_18_0 or {}
			table = var_4

			var_4.insert(arg_18_0, var_18_2[1])

			return arg_18_0
		end

		return
	end), var_14_0
end

function var_0_1.MirrorFleetCheck(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_2[1]

	getProxy = var_1_10004
	BayProxy = var_1_10006

	local var_19_1 = var_1_10004(var_1_10006)

	FleetSkill = var_1_10005

	local var_19_3

	if var_19_0 == var_1_10005.TriggerDDHead then
		local var_19_2 = arg_19_0

		var_19_3 = arg_19_0.getShipsByTeam
		TeamType = var_1_10008

		if #var_19_3(var_19_2, var_1_10008.Vanguard, false) > 0 then
			ShipType = var_1_10006
			var_1_10006 = var_1_10006.IsTypeQuZhu

			local var_19_4 = var_19_3[1]

			var_1_10006 = var_1_10006(var_1_10008.getShipType(var_19_4))
		else
			var_1_10006 = false
		end

		if false then
			var_1_10006 = true
		end

		return var_1_10006
	else
		FleetSkill = var_19_3

		local var_19_6

		if var_19_0 == var_19_3.TriggerVanCount then
			local var_19_5 = arg_19_0

			var_19_6 = arg_19_0.getShipsByTeam
			TeamType = var_1_10008
			var_1_10006 = #var_19_6(var_19_5, var_1_10008.Vanguard, false) >= arg_19_2[2] and #var_19_6 <= arg_19_2[3]

			return var_1_10006
		else
			FleetSkill = var_19_6

			if var_19_0 == var_19_6.TriggerShipCount then
				_ = var_5
				var_1_10006 = #var_5.filter(arg_19_0:getShips(false), function(arg_20_0)
					table = var_2_10001

					return var_2_10001.contains(arg_19_2[2], arg_20_0:getShipType())
				end) >= arg_19_2[3] and #var_5 <= arg_19_2[4]

				return var_1_10006
			else
				FleetSkill = var_5

				local var_19_7

				if var_19_0 == var_5.TriggerNekoPos then
					var_19_7 = arg_19_0:findCommanderBySkillId(arg_19_1.id)
					pairs = var_1_10006

					for iter_19_0, iter_19_1 in var_1_10006(arg_19_0:getCommanders()) do
						if var_19_7.id == iter_19_1.id and iter_19_0 == arg_19_2[2] then
							return true
						end
					end
				else
					FleetSkill = var_19_7

					if var_19_0 == var_19_7.TriggerInSubTeam then
						return true
					else
						return false
					end
				end
			end
		end
	end

	return
end

function var_0_1.GuildBossTriggerSkill(arg_21_0, arg_21_1)
	_ = var_1_10002

	local var_21_0 = var_1_10002.filter(arg_21_0:findSkills(arg_21_1), function(arg_22_0)
		local var_22_0 = arg_22_0:GetTriggers()

		_ = var_2_10002

		local var_22_1 = var_2_10002.any(var_22_0, function(arg_23_0)
			local var_23_0 = arg_23_0[1]

			FleetSkill = var_3_10002

			return var_23_0 == var_3_10002.TriggerInSubTeam and arg_23_0[2] == 1
		end)
		local var_22_2 = arg_21_0
		local var_22_3 = var_3.getFleetType(var_22_2)

		FleetType = var_4

		local var_22_4

		if var_22_1 == (var_22_3 == var_4.Submarine) then
			_ = var_4
			var_22_4 = var_4.all(arg_22_0:GetTriggers(), function(arg_24_0)
				return var_0_1.GuildBossFleetCheck(arg_21_0, arg_22_0, arg_24_0)
			end)
		else
			var_22_4 = false
		end

		if false then
			var_22_4 = true
		end

		return var_22_4
	end)

	_ = var_1_10003

	return var_1_10003.reduce(var_21_0, nil, function(arg_25_0, arg_25_1)
		local var_25_0 = arg_25_1
		local var_25_1 = arg_25_1.GetType(var_25_0)
		local var_25_2 = arg_25_1:GetArgs()

		FleetSkill = var_25_0

		if var_25_1 == var_25_0.TypeBattleBuff then
			arg_25_0 = arg_25_0 or {}
			table = var_4

			var_4.insert(arg_25_0, var_25_2[1])

			return arg_25_0
		end

		return
	end), var_21_0
end

function var_0_1.GuildBossFleetCheck(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_2[1]

	FleetSkill = var_1_10004

	local var_26_2

	if var_26_0 == var_1_10004.TriggerDDHead then
		local var_26_1 = arg_26_0

		var_26_2 = arg_26_0.GetTeamTypeShips
		TeamType = var_1_10007

		if #var_26_2(var_26_1, var_1_10007.Vanguard) > 0 then
			ShipType = var_1_10005
			var_1_10005 = var_1_10005.IsTypeQuZhu

			local var_26_3 = var_26_2[1]

			var_1_10005 = var_1_10005(var_1_10007.getShipType(var_26_3))
		else
			var_1_10005 = false
		end

		if false then
			var_1_10005 = true
		end

		return var_1_10005
	else
		FleetSkill = var_26_2

		local var_26_5

		if var_26_0 == var_26_2.TriggerVanCount then
			local var_26_4 = arg_26_0

			var_26_5 = arg_26_0.GetTeamTypeShips
			TeamType = var_1_10007
			var_1_10005 = #var_26_5(var_26_4, var_1_10007.Vanguard) >= arg_26_2[2] and #var_26_5 <= arg_26_2[3]

			return var_1_10005
		else
			FleetSkill = var_26_5

			if var_26_0 == var_26_5.TriggerShipCount then
				_ = var_4
				var_1_10005 = #var_4.filter(arg_26_0:GetShips(), function(arg_27_0)
					local var_27_0 = arg_27_0.ship

					table = var_2_10002

					return var_2_10002.contains(arg_26_2[2], var_27_0:getShipType())
				end) >= arg_26_2[3] and #var_4 <= arg_26_2[4]

				return var_1_10005
			else
				FleetSkill = var_4

				local var_26_6

				if var_26_0 == var_4.TriggerNekoPos then
					var_26_6 = arg_26_0:findCommanderBySkillId(arg_26_1.id)
					pairs = var_1_10005

					for iter_26_0, iter_26_1 in var_1_10005(arg_26_0:getCommanders()) do
						if var_26_6.id == iter_26_1.id and iter_26_0 == arg_26_2[2] then
							return true
						end
					end
				else
					FleetSkill = var_26_6

					if var_26_0 == var_26_6.TriggerInSubTeam then
						return true
					else
						return false
					end
				end
			end
		end
	end

	return
end

return var_0_1
