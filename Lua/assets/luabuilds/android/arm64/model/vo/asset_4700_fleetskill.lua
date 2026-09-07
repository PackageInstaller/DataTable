local FleetSkill = class("FleetSkill", import(".BaseVO"))

FleetSkill.SystemCommanderNeko = 1
FleetSkill.TypeMoveSpeed = "move_speed"
FleetSkill.TypeHuntingLv = "hunt_lv"
FleetSkill.TypeAmbushDodge = "ambush_dodge"
FleetSkill.TypeAirStrikeDodge = "airfight_doge"
FleetSkill.TypeStrategy = "strategy"
FleetSkill.TypeBattleBuff = "battle_buff"
FleetSkill.TypeAttack = "attack"
FleetSkill.TypeTorpedoPowerUp = "torpedo_power_up"
FleetSkill.TriggerDDHead = "dd_head"
FleetSkill.TriggerAroundEnemy = "around_enemy"
FleetSkill.TriggerVanCount = "vang_count"
FleetSkill.TriggerNekoPos = "pos"
FleetSkill.TriggerAroundLand = "around_land"
FleetSkill.TriggerAroundCombatAlly = "around_combat_ally"
FleetSkill.TriggerShipCount = "count"
FleetSkill.TriggerInSubTeam = "insubteam"

function FleetSkill:Ctor(arg_1_1, arg_1_2)
	self.system = arg_1_1
	self.id = arg_1_2
	self.configId = self.id

	return
end

function FleetSkill:GetSystem()
	return self.system
end

function FleetSkill:bindConfigTable()
	if self:GetSystem() == FleetSkill.SystemCommanderNeko then
		return pg.commander_skill_effect_template
	end

	assert(false, "Do not support exception.")

	return
end

function FleetSkill:GetType()
	if self:GetSystem() == FleetSkill.SystemCommanderNeko then
		return self:getConfig("effect_type")
	end

	assert(false, "Do not support exception.")

	return
end

function FleetSkill:GetArgs()
	if self:GetSystem() == FleetSkill.SystemCommanderNeko then
		return self:getConfig("args")
	end

	assert(false, "Do not support exception.")

	return
end

function FleetSkill:GetTriggers()
	if self:GetSystem() == FleetSkill.SystemCommanderNeko then
		return self:getConfig("condition")
	end

	assert(false, "Do not support exception.")

	return
end

function FleetSkill:triggerSkill(arg_7_1)
	local var_7_0 = _.filter(self:findSkills(arg_7_1), function(arg_8_0)
		return _.any(arg_8_0:GetTriggers(), function(arg_9_0)
			return arg_9_0[1] == FleetSkill.TriggerInSubTeam and arg_9_0[2] == 1
		end) == (self:getFleetType() == FleetType.Submarine) and _.all(arg_8_0:GetTriggers(), function(arg_10_0)
			return FleetSkill.NoneChapterFleetCheck(self, arg_8_0, arg_10_0)
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

function FleetSkill:NoneChapterFleetCheck(arg_12_1, arg_12_2)
	local var_12_0 = getProxy(BayProxy)

	if arg_12_2[1] == FleetSkill.TriggerDDHead then
		local var_12_1 = var_12_0:getShipByTeam(self, TeamType.Vanguard)

		return #var_12_1 > 0 and ShipType.IsTypeQuZhu(var_12_1[1]:getShipType())
	elseif arg_12_2[1] == FleetSkill.TriggerVanCount then
		local var_12_2 = var_12_0:getShipByTeam(self, TeamType.Vanguard)

		return #var_12_2 >= arg_12_2[2] and #var_12_2 <= arg_12_2[3]
	elseif arg_12_2[1] == FleetSkill.TriggerShipCount then
		local var_12_3 = _.filter(var_12_0:getShipsByFleet(self), function(arg_13_0)
			return table.contains(arg_12_2[2], arg_13_0:getShipType())
		end)

		return #var_12_3 >= arg_12_2[3] and #var_12_3 <= arg_12_2[4]
	elseif arg_12_2[1] == FleetSkill.TriggerNekoPos then
		local var_12_4 = self:findCommanderBySkillId(arg_12_1.id)

		for iter_12_0, iter_12_1 in pairs(self:getCommanders()) do
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

function FleetSkill:triggerMirrorSkill(arg_14_1)
	local var_14_0 = _.filter(self:findSkills(arg_14_1), function(arg_15_0)
		return _.any(arg_15_0:GetTriggers(), function(arg_16_0)
			return arg_16_0[1] == FleetSkill.TriggerInSubTeam and arg_16_0[2] == 1
		end) == (self:getFleetType() == FleetType.Submarine) and _.all(arg_15_0:GetTriggers(), function(arg_17_0)
			return FleetSkill.MirrorFleetCheck(self, arg_15_0, arg_17_0)
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

function FleetSkill:MirrorFleetCheck(arg_19_1, arg_19_2)
	local var_19_0 = getProxy(BayProxy)

	if arg_19_2[1] == FleetSkill.TriggerDDHead then
		local var_19_1 = self:getShipsByTeam(TeamType.Vanguard, false)

		return #var_19_1 > 0 and ShipType.IsTypeQuZhu(var_19_1[1]:getShipType())
	elseif arg_19_2[1] == FleetSkill.TriggerVanCount then
		local var_19_2 = self:getShipsByTeam(TeamType.Vanguard, false)

		return #var_19_2 >= arg_19_2[2] and #var_19_2 <= arg_19_2[3]
	elseif arg_19_2[1] == FleetSkill.TriggerShipCount then
		local var_19_3 = _.filter(self:getShips(false), function(arg_20_0)
			return table.contains(arg_19_2[2], arg_20_0:getShipType())
		end)

		return #var_19_3 >= arg_19_2[3] and #var_19_3 <= arg_19_2[4]
	elseif arg_19_2[1] == FleetSkill.TriggerNekoPos then
		local var_19_4 = self:findCommanderBySkillId(arg_19_1.id)

		for iter_19_0, iter_19_1 in pairs(self:getCommanders()) do
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

function FleetSkill:GuildBossTriggerSkill(arg_21_1)
	local var_21_0 = _.filter(self:findSkills(arg_21_1), function(arg_22_0)
		return _.any(arg_22_0:GetTriggers(), function(arg_23_0)
			return arg_23_0[1] == FleetSkill.TriggerInSubTeam and arg_23_0[2] == 1
		end) == (self:getFleetType() == FleetType.Submarine) and _.all(arg_22_0:GetTriggers(), function(arg_24_0)
			return FleetSkill.GuildBossFleetCheck(self, arg_22_0, arg_24_0)
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

function FleetSkill:GuildBossFleetCheck(arg_26_1, arg_26_2)
	if arg_26_2[1] == FleetSkill.TriggerDDHead then
		local var_26_0 = self:GetTeamTypeShips(TeamType.Vanguard)

		return #var_26_0 > 0 and ShipType.IsTypeQuZhu(var_26_0[1]:getShipType())
	elseif arg_26_2[1] == FleetSkill.TriggerVanCount then
		local var_26_1 = self:GetTeamTypeShips(TeamType.Vanguard)

		return #var_26_1 >= arg_26_2[2] and #var_26_1 <= arg_26_2[3]
	elseif arg_26_2[1] == FleetSkill.TriggerShipCount then
		local var_26_2 = _.filter(self:GetShips(), function(arg_27_0)
			return table.contains(arg_26_2[2], arg_27_0.ship:getShipType())
		end)

		return #var_26_2 >= arg_26_2[3] and #var_26_2 <= arg_26_2[4]
	elseif arg_26_2[1] == FleetSkill.TriggerNekoPos then
		local var_26_3 = self:findCommanderBySkillId(arg_26_1.id)

		for iter_26_0, iter_26_1 in pairs(self:getCommanders()) do
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

return FleetSkill
