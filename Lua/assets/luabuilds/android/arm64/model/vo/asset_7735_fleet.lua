local Fleet = class("Fleet", import(".BaseVO"))

Fleet.C_TEAM_NAME = {
	vanguard = i18n("word_vanguard_fleet"),
	main = i18n("word_main_fleet"),
	submarine = i18n("word_sub_fleet")
}
Fleet.DEFAULT_NAME = {
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
Fleet.DEFAULT_NAME_FOR_DOCKYARD = {
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
Fleet.DEFAULT_NAME_BOSS_ACT = {
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
Fleet.DEFAULT_NAME_BOSS_SINGLE_ACT = {
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
Fleet.DEFAULT_NAME_BOSS_SINGLE_VARIABLE_ACT = {
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
Fleet.DEFAULT_ELITE_NAME = {
	i18n("ship_formationUI_fleetName1"),
	i18n("ship_formationUI_fleetName2"),
	i18n("ship_formationUI_fleetName11"),
	(i18n("ship_formationUI_fleetName13"))
}
Fleet.REGULAR_FLEET_ID = 1
Fleet.REGULAR_FLEET_NUMS = 6
Fleet.SUBMARINE_FLEET_ID = 11
Fleet.SUBMARINE_FLEET_NUMS = 4
Fleet.MEGA_SUBMARINE_FLEET_OFFSET = 100

function Fleet:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.name = arg_1_1.name or ""
	self.defaultName = Fleet.DEFAULT_NAME[self.id]

	self:updateShips(arg_1_1.ship_list)

	self.commanderIds = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.commanders or {}) do
		self.commanderIds[iter_1_1.pos] = iter_1_1.id
	end

	self.skills = {}

	self:updateCommanderSkills()

	return
end

function Fleet:SeparateOut()
	local var_2_0 = {
		id = self.id,
		name = self.name,
		ship_list = underscore.to_array(self.ships)
	}

	var_2_0.commanders = underscore(self.commanderIds):chain():keys():map(function(arg_3_0)
		return {
			pos = arg_3_0,
			id = self.commanderIds[arg_3_0]
		}
	end):value()

	return var_2_0
end

function Fleet:isUnlock()
	local var_4_0 = ({
		nil,
		nil,
		404,
		504,
		604,
		704
	})[self.id]

	if var_4_0 then
		local var_4_1 = getProxy(ChapterProxy):getChapterById(var_4_0)
		local var_4_2 = var_4_1 and var_4_1:isClear()
		local var_4_3 = i18n("formation_chapter_lock", string.sub(tostring(var_4_0), 1, 1), self.id)

		return
	end

	return true
end

function Fleet:containShip(arg_5_1)
	return table.contains(self.ships, arg_5_1.id)
end

function Fleet:isFirstFleet()
	return self.id == Fleet.REGULAR_FLEET_ID
end

function Fleet:outputCommanders()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(self.commanderIds) do
		assert(iter_7_1, "id is nil")
		table.insert(var_7_0, {
			pos = iter_7_0,
			id = iter_7_1
		})
	end

	return var_7_0
end

function Fleet:clearCommanders()
	self.commanderIds = {}

	self:updateCommanderSkills()

	return
end

function Fleet:getCommanders()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self.commanderIds) do
		var_9_0[iter_9_0] = getProxy(CommanderProxy):getCommanderById(iter_9_1)
	end

	return var_9_0
end

function Fleet:getCommanderByPos(arg_10_1)
	return self:getCommanders()[arg_10_1]
end

function Fleet:updateCommanderByPos(arg_11_1, arg_11_2)
	self.commanderIds[arg_11_1] = arg_11_2 and arg_11_2.id or nil

	self:updateCommanderSkills()

	return
end

function Fleet:getCommandersAddition()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(CommanderConst.PROPERTIES) do
		local var_12_1 = 0

		for iter_12_2, iter_12_3 in pairs(self:getCommanders()) do
			var_12_1 = var_12_1 + iter_12_3:getAbilitysAddition()[iter_12_1]
		end

		if var_12_1 > 0 then
			table.insert(var_12_0, {
				attrName = iter_12_1,
				value = var_12_1
			})
		end
	end

	return var_12_0
end

function Fleet:getCommandersTalentDesc()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(self:getCommanders()) do
		for iter_13_2, iter_13_3 in pairs((iter_13_1:getTalentsDesc())) do
			if var_13_0[iter_13_2] then
				var_13_0[iter_13_2].value = var_13_0[iter_13_2].value + iter_13_3.value
			else
				var_13_0[iter_13_2] = {
					name = iter_13_2,
					value = iter_13_3.value,
					type = iter_13_3.type
				}
			end
		end
	end

	return var_13_0
end

function Fleet:findCommanderBySkillId(arg_14_1)
	for iter_14_0, iter_14_1 in pairs((self:getCommanders())) do
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

function Fleet:updateCommanderSkills()
	while #self.skills > 0 do
		if not self:findCommanderBySkillId(self.skills[#self.skills].id) and self.skills[#self.skills]:GetSystem() == FleetSkill.SystemCommanderNeko then
			table.remove(self.skills, #self.skills)
		end
	end

	for iter_17_0, iter_17_1 in pairs((self:getCommanders())) do
		for iter_17_2, iter_17_3 in ipairs(iter_17_1:getSkills()) do
			for iter_17_4, iter_17_5 in ipairs(iter_17_3:getTacticSkill()) do
				table.insert(self.skills, FleetSkill.New(FleetSkill.SystemCommanderNeko, iter_17_5))
			end
		end
	end

	return
end

function Fleet:buildBattleBuffList()
	local var_18_0 = {}
	local var_18_1, var_18_2 = FleetSkill.triggerSkill(self, FleetSkill.TypeBattleBuff)

	if var_18_1 and #var_18_1 > 0 then
		local var_18_3 = {}

		for iter_18_0, iter_18_1 in ipairs(var_18_1) do
			local var_18_4 = self:findCommanderBySkillId(var_18_2[iter_18_0].id)

			var_18_3[var_18_4] = var_18_3[var_18_4] or {}

			table.insert(var_18_3[var_18_4], iter_18_1)
		end

		for iter_18_2, iter_18_3 in pairs(var_18_3) do
			table.insert(var_18_0, {
				iter_18_2,
				iter_18_3
			})
		end
	end

	for iter_18_4, iter_18_5 in pairs((self:getCommanders())) do
		for iter_18_6, iter_18_7 in ipairs((iter_18_5:getTalents())) do
			local var_18_5 = iter_18_7:getBuffsAddition()

			if #var_18_5 > 0 then
				local var_18_6

				for iter_18_8, iter_18_9 in ipairs(var_18_0) do
					if iter_18_9[1] == iter_18_5 then
						var_18_6 = iter_18_9[2]

						break
					end
				end

				if not var_18_6 then
					var_18_6 = {}

					table.insert(var_18_0, {
						iter_18_5,
						var_18_6
					})
				end

				for iter_18_10, iter_18_11 in ipairs(var_18_5) do
					table.insert(var_18_6, iter_18_11)
				end
			end
		end
	end

	return var_18_0
end

function Fleet:getSkills()
	return self.skills
end

function Fleet:getShipIds()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs({
		self.mainShips,
		self.vanguardShips,
		self.subShips
	}) do
		for iter_20_2, iter_20_3 in ipairs(iter_20_1) do
			table.insert(var_20_0, iter_20_3)
		end
	end

	return var_20_0
end

function Fleet:GetRawShipIds()
	return self.ships
end

function Fleet:GetRawCommanderIds()
	return self.commanderIds
end

function Fleet:findSkills(arg_23_1)
	return _.filter(self:getSkills(), function(arg_24_0)
		return arg_24_0:GetType() == arg_23_1
	end)
end

function Fleet:updateShips(arg_25_1)
	self.ships = {}
	self.vanguardShips = {}
	self.mainShips = {}
	self.subShips = {}

	local var_25_0 = getProxy(BayProxy)

	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		local var_25_1 = var_25_0:getShipById(iter_25_1)

		if var_25_1 then
			self:insertShip(var_25_1, nil, var_25_1:getTeamType())
		end
	end

	return
end

function Fleet:switchShip(arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = self:getTeamByName(arg_26_1)

	var_26_0[arg_26_2], var_26_0[arg_26_3] = var_26_0[arg_26_3], var_26_0[arg_26_2]

	return
end

function Fleet:getShipPos(arg_27_1)
	if not arg_27_1 then
		return
	end

	local var_27_0 = arg_27_1:getTeamType()

	return table.indexof(self:getTeamByName(var_27_0), arg_27_1.id) or -1, var_27_0
end

function Fleet:getTeamByName(arg_28_1)
	if arg_28_1 == TeamType.Vanguard then
		return self.vanguardShips
	elseif arg_28_1 == TeamType.Main then
		return self.mainShips
	elseif arg_28_1 == TeamType.Submarine then
		return self.subShips
	end

	return
end

function Fleet:CanInsertShip(arg_29_1, arg_29_2)
	if self:isFull() or self:containShip(arg_29_1) or not arg_29_1:isAvaiable() or #self:getTeamByName(arg_29_2) >= TeamType.GetTeamShipMax(arg_29_2) then
		return false
	end

	return true
end

function Fleet:insertShip(arg_30_1, arg_30_2, arg_30_3)
	if not self:CanInsertShip(arg_30_1, arg_30_3) then
		errorMsg("fleet insert error")
		pg.TipsMgr.GetInstance():ShowTips("fleet insert error")
	else
		local var_30_0 = self:getTeamByName(arg_30_3)

		arg_30_2 = arg_30_2 or #var_30_0 + 1

		local var_30_1

		if arg_30_3 == TeamType.Main then
			var_30_1 = #self.vanguardShips or 0
		end

		table.insert(var_30_0, arg_30_2, arg_30_1.id)
		table.insert(self.ships, var_30_1 + arg_30_2, arg_30_1.id)
	end

	return
end

function Fleet:canRemove(arg_31_1)
	local var_31_0, var_31_1 = self:getShipPos(arg_31_1)

	if var_31_0 > 0 then
		if #(self:getTeamByName(var_31_1) or {}) == 1 and self:isFirstFleet() then
			do return false end

			goto label_31_0
		end
	end

	do return true end

	::label_31_0::

	return
end

function Fleet:isRegularFleet()
	return self.id >= Fleet.SUBMARINE_FLEET_ID and self.id < Fleet.SUBMARINE_FLEET_ID + Fleet.SUBMARINE_FLEET_NUMS or self.id >= Fleet.REGULAR_FLEET_ID and self.id < Fleet.REGULAR_FLEET_ID + Fleet.REGULAR_FLEET_NUMS
end

function Fleet:isSubmarineFleet()
	return self.id >= Fleet.SUBMARINE_FLEET_ID and self.id < Fleet.SUBMARINE_FLEET_ID + Fleet.SUBMARINE_FLEET_NUMS
end

function Fleet:isPVPFleet()
	return self.id == FleetProxy.PVP_FLEET_ID
end

function Fleet:getFleetType()
	assert(false)

	return
end

function Fleet:removeShip(arg_36_1)
	assert(self:containShip(arg_36_1), "ship are not in fleet")

	for iter_36_0, iter_36_1 in ipairs(self.ships) do
		if iter_36_1 == arg_36_1.id then
			table.remove(self.ships, iter_36_0)

			break
		end
	end

	for iter_36_2, iter_36_3 in ipairs(self.vanguardShips) do
		if iter_36_3 == arg_36_1.id then
			return table.remove(self.vanguardShips, iter_36_2), TeamType.Vanguard
		end
	end

	for iter_36_4, iter_36_5 in ipairs(self.mainShips) do
		if iter_36_5 == arg_36_1.id then
			return table.remove(self.mainShips, iter_36_4), TeamType.Main
		end
	end

	for iter_36_6, iter_36_7 in ipairs(self.subShips) do
		if iter_36_7 == arg_36_1.id then
			return table.remove(self.subShips, iter_36_6), TeamType.Submarine
		end
	end

	return nil
end

function Fleet:isFull()
	local var_37_0 = self:getFleetType()

	if var_37_0 == FleetType.Normal then
		assert(#self.vanguardShips <= TeamType.VanguardMax and #self.mainShips <= TeamType.MainMax)

		return #self.vanguardShips == TeamType.VanguardMax and #self.mainShips == TeamType.MainMax
	elseif var_37_0 == FleetType.Submarine then
		assert(#self.subShips <= TeamType.SubmarineMax)

		return #self.subShips == TeamType.SubmarineMax
	end

	return false
end

function Fleet:isEmpty()
	return #self.ships == 0
end

function Fleet:isCommanderEmpty()
	for iter_39_0, iter_39_1 in pairs(self.commanderIds) do
		if iter_39_1 and iter_39_1 ~= 0 then
			return false
		end
	end

	return true
end

function Fleet:isLegalToFight()
	local var_40_0 = self:getFleetType()

	if var_40_0 == FleetType.Normal then
		if #self.vanguardShips == 0 then
			return TeamType.Vanguard, 1
		elseif #self.mainShips == 0 then
			return TeamType.Main, 1
		end
	elseif var_40_0 == FleetType.Submarine and #self.subShips == 0 then
		return TeamType.Submarine, 1
	end

	return true
end

function Fleet:getSkillNum()
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in pairs({
		"zhupao",
		"yulei",
		"fangkongpao",
		"jianzaiji"
	}) do
		var_41_0[iter_41_1] = 0
	end

	local var_41_1 = getProxy(BayProxy):getRawData()

	for iter_41_2, iter_41_3 in ipairs(self.ships) do
		for iter_41_4, iter_41_5 in ipairs(var_41_1[iter_41_3]:getActiveEquipments()) do
			if iter_41_5 > 0 then
				for iter_41_6, iter_41_7 in ipairs((Equipment.New({
					id = iter_41_5
				}):getConfig("weapon_id"))) do
					if iter_41_7 > 0 then
						if pg.weapon_property[iter_41_7].type == ys.Battle.BattleConst.EquipmentType.POINT_HIT_AND_LOCK then
							var_41_0.zhupao = var_41_0.zhupao + 1
						elseif pg.weapon_property[iter_41_7].type == ys.Battle.BattleConst.EquipmentType.TORPEDO or pg.weapon_property[iter_41_7].type == ys.Battle.BattleConst.EquipmentType.MANUAL_TORPEDO then
							var_41_0.yulei = var_41_0.yulei + 1
						elseif pg.weapon_property[iter_41_7].type == ys.Battle.BattleConst.EquipmentType.ANTI_AIR then
							var_41_0.fangkongpao = var_41_0.fangkongpao + 1
						elseif pg.weapon_property[iter_41_7].type == ys.Battle.BattleConst.EquipmentType.INTERCEPT_AIRCRAFT then
							var_41_0.jianzaiji = var_41_0.jianzaiji + 1
						end
					end
				end
			end
		end
	end

	return var_41_0
end

function Fleet:GetPropertiesSum()
	local var_42_0 = {
		cannon = 0,
		antiAir = 0,
		air = 0,
		torpedo = 0
	}
	local var_42_1 = getProxy(BayProxy):getRawData()

	for iter_42_0, iter_42_1 in ipairs(self.ships) do
		local var_42_2 = var_42_1[iter_42_1]:getProperties(self:getCommanders())

		var_42_0.cannon = var_42_0.cannon + math.floor(var_42_2.cannon)
		var_42_0.torpedo = var_42_0.torpedo + math.floor(var_42_2.torpedo)
		var_42_0.antiAir = var_42_0.antiAir + math.floor(var_42_2.antiaircraft)
		var_42_0.air = var_42_0.air + math.floor(var_42_2.air)
	end

	return var_42_0
end

function Fleet:GetCostSum()
	local var_43_0 = {
		gold = 0,
		oil = 0
	}
	local var_43_1 = self:getEndCost()

	var_43_0.oil = self:getFleetType() == FleetType.Submarine and var_43_1.oil or self:getStartCost().oil + var_43_1.oil

	return var_43_0
end

function Fleet:getStartCost()
	local var_44_0 = {
		gold = 0,
		oil = 0
	}
	local var_44_1 = getProxy(BayProxy):getRawData()

	for iter_44_0, iter_44_1 in ipairs(self.ships) do
		var_44_0.oil = var_44_0.oil + var_44_1[iter_44_1]:getStartBattleExpend()
	end

	return var_44_0
end

function Fleet:getEndCost()
	local var_45_0 = {
		gold = 0,
		oil = 0
	}
	local var_45_1 = getProxy(BayProxy):getRawData()

	for iter_45_0, iter_45_1 in ipairs(self.ships) do
		var_45_0.oil = var_45_0.oil + var_45_1[iter_45_1]:getEndBattleExpend()
	end

	return var_45_0
end

function Fleet:GetGearScoreSum(arg_46_1)
	local var_46_0 = arg_46_1 == nil and self.ships or self:getTeamByName(arg_46_1)
	local var_46_1 = 0
	local var_46_2 = getProxy(BayProxy):getRawData()

	for iter_46_0, iter_46_1 in ipairs(var_46_0) do
		var_46_1 = var_46_1 + var_46_2[iter_46_1]:getShipCombatPower(self:getCommanders())
	end

	return var_46_1
end

function Fleet:GetEnergyStatus()
	local var_47_0 = false
	local var_47_1 = ""
	local var_47_2 = ""
	local var_47_3 = getProxy(BayProxy)

	local function var_47_4(arg_48_0)
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
	end

	var_47_4(self.mainShips)
	var_47_4(self.vanguardShips)
	var_47_4(self.subShips)

	local var_47_6 = i18n("ship_energy_low_warn", var_47_1, "")
end

function Fleet:genRobotDataString()
	local var_49_0 = getProxy(BayProxy):getRawData()
	local var_49_1 = "99999,"

	for iter_49_0 = 1, 3 do
		if self.vanguardShips[iter_49_0] and self.vanguardShips[iter_49_0] > 0 then
			var_49_1 = var_49_1 .. var_49_0[self.vanguardShips[iter_49_0]].configId .. "," .. var_49_0[self.vanguardShips[iter_49_0]].level .. ",\"{"

			for iter_49_1, iter_49_2 in pairs(var_49_0[self.vanguardShips[iter_49_0]]:getActiveEquipments()) do
				var_49_1 = var_49_1 .. ((iter_49_2 or nil) and (iter_49_2.id or 0))

				if iter_49_1 < 5 then
					var_49_1 = var_49_1 .. ","
				end
			end

			var_49_1 = var_49_1 .. "}\","
		else
			var_49_1 = var_49_1 .. "" .. "," .. "" .. ",{" .. "},"
		end
	end

	for iter_49_3 = 1, 3 do
		if self.mainShips[iter_49_3] and self.mainShips[iter_49_3] > 0 then
			var_49_1 = var_49_1 .. var_49_0[self.mainShips[iter_49_3]].configId .. "," .. var_49_0[self.mainShips[iter_49_3]].level .. ",\"{"

			for iter_49_4, iter_49_5 in pairs(var_49_0[self.mainShips[iter_49_3]]:getActiveEquipments()) do
				var_49_1 = var_49_1 .. ((iter_49_5 or nil) and (iter_49_5.id or 0))

				if iter_49_4 < 5 then
					var_49_1 = var_49_1 .. ","
				end
			end

			var_49_1 = var_49_1 .. "}\","
		else
			var_49_1 = var_49_1 .. "" .. "," .. "" .. ",{" .. "},"
		end
	end

	return var_49_1 .. math.floor(self:GetGearScoreSum(TeamType.Vanguard) + self:GetGearScoreSum(TeamType.Main)) .. ","
end

function Fleet:getIndex()
	if self.id >= Fleet.SUBMARINE_FLEET_ID and self.id < Fleet.SUBMARINE_FLEET_ID + Fleet.SUBMARINE_FLEET_NUMS then
		return self.id - Fleet.SUBMARINE_FLEET_ID + 1
	elseif self.id >= Fleet.REGULAR_FLEET_ID and self.id < Fleet.REGULAR_FLEET_ID + Fleet.REGULAR_FLEET_NUMS then
		return self.id - Fleet.REGULAR_FLEET_ID + 1
	end

	return self.id
end

function Fleet:getShipCount()
	return #self.ships
end

function Fleet:avgLevel()
	local var_52_0 = 0

	for iter_52_0, iter_52_1 in ipairs(self.ships) do
		var_52_0 = getProxy(BayProxy):getShipById(iter_52_1).level + var_52_0
	end

	return math.floor(var_52_0 / #self.ships)
end

function Fleet:clearFleet()
	local var_53_0 = getProxy(BayProxy)

	for iter_53_0, iter_53_1 in ipairs((Clone(self.ships))) do
		self:removeShip((var_53_0:getShipById(iter_53_1)))
	end

	return
end

function Fleet:EnergyCheck(arg_54_1, arg_54_2, arg_54_3, arg_54_4)
	arg_54_4 = arg_54_4 or "ship_energy_low_warn"

	local var_54_0 = {}

	for iter_54_0, iter_54_1 in ipairs(self) do
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

function Fleet:getFleetAirDominanceValue()
	local var_58_0 = getProxy(BayProxy)
	local var_58_1 = self:getCommanders()
	local var_58_2 = 0

	for iter_58_0, iter_58_1 in ipairs(self.ships) do
		var_58_2 = (function(arg_59_0, arg_59_1)
			return arg_59_0 + calcAirDominanceValue(var_58_0:getShipById(arg_59_1), var_58_1)
		end)(var_58_2, iter_58_1)
	end

	return var_58_2
end

function Fleet:RemoveUnusedItems()
	local var_60_0 = getProxy(BayProxy)

	for iter_60_0, iter_60_1 in ipairs((Clone(self.ships))) do
		if not var_60_0:getShipById(iter_60_1) then
			self:removeShipById(iter_60_1)
		end
	end

	local var_60_1 = getProxy(CommanderProxy)
	local var_60_2 = {}

	for iter_60_2, iter_60_3 in pairs(self.commanderIds) do
		if not var_60_1:getCommanderById(iter_60_3) then
			table.insert(var_60_2, iter_60_2)
		end
	end

	if #var_60_2 > 0 then
		for iter_60_4, iter_60_5 in pairs(var_60_2) do
			self.commanderIds[iter_60_5] = nil
		end

		self.skills = {}

		self:updateCommanderSkills()
	end

	return
end

function Fleet:removeShipById(arg_61_1)
	for iter_61_0, iter_61_1 in ipairs(self.ships) do
		if iter_61_1 == arg_61_1 then
			table.remove(self.ships, iter_61_0)

			break
		end
	end

	for iter_61_2, iter_61_3 in ipairs(self.vanguardShips) do
		if iter_61_3 == arg_61_1 then
			return table.remove(self.vanguardShips, iter_61_2), TeamType.Vanguard
		end
	end

	for iter_61_4, iter_61_5 in ipairs(self.mainShips) do
		if iter_61_5 == arg_61_1 then
			return table.remove(self.mainShips, iter_61_4), TeamType.Main
		end
	end

	for iter_61_6, iter_61_7 in ipairs(self.subShips) do
		if iter_61_7 == arg_61_1 then
			return table.remove(self.subShips, iter_61_6), TeamType.Submarine
		end
	end

	return
end

function Fleet:HaveShipsInEvent()
	local var_62_0 = getProxy(BayProxy):getRawData()

	for iter_62_0, iter_62_1 in ipairs(self.ships) do
		if var_62_0[iter_62_1]:getFlag("inEvent") then
			local var_62_2 = i18n("elite_disable_ship_escort")

			return
		end
	end

	return
end

function Fleet:GetFleetSonarRange()
	local var_63_0 = getProxy(BayProxy)
	local var_63_1 = 0
	local var_63_3 = 0
	local var_63_4 = 0

	for iter_63_0, iter_63_1 in ipairs(self.ships) do
		local var_63_5 = var_63_0:getShipById(iter_63_1)

		if var_63_5 then
			local var_63_6 = var_63_5:getShipType()

			if ys.Battle.BattleConfig.VAN_SONAR_PROPERTY[var_63_6] then
				var_63_1 = math.max(var_63_1, Mathf.Clamp((var_63_5:getShipProperties()[AttributeType.AntiSub] or 0) / ys.Battle.BattleConfig.VAN_SONAR_PROPERTY[var_63_6].a - ys.Battle.BattleConfig.VAN_SONAR_PROPERTY[var_63_6].b, ys.Battle.BattleConfig.VAN_SONAR_PROPERTY[var_63_6].minRange, ys.Battle.BattleConfig.VAN_SONAR_PROPERTY[var_63_6].maxRange))
			end

			if table.contains(ShipType.MainShipType, var_63_6) then
				var_63_4 = var_63_4 + (var_63_5:getShipProperties()[AttributeType.AntiSub] or 0)
			end

			for iter_63_2, iter_63_3 in ipairs(var_63_5:getActiveEquipments()) do
				if iter_63_3 then
					var_63_3 = var_63_3 + (iter_63_3:getConfig("equip_parameters").range or 0)
				end
			end
		end
	end

	return var_63_1 + ((var_63_1 ~= 0 or nil) and var_63_3 + Mathf.Clamp(var_63_4 / ys.Battle.BattleConfig.MAIN_SONAR_PROPERTY.a, ys.Battle.BattleConfig.MAIN_SONAR_PROPERTY.minRange, ys.Battle.BattleConfig.MAIN_SONAR_PROPERTY.maxRange))
end

function Fleet:getInvestSums()
	local var_64_0 = getProxy(BayProxy)

	return math.pow(_.reduce(self.ships, 0, function(arg_65_0, arg_65_1)
		local var_65_0 = var_64_0:getShipById(arg_65_1):getProperties(self:getCommanders())

		return arg_65_0 + var_65_0[AttributeType.Air] + var_65_0[AttributeType.Dodge]
	end), 0.6666666666666666)
end

function Fleet:ExistActNpcShip()
	local var_66_0 = getProxy(BayProxy)

	for iter_66_0, iter_66_1 in ipairs(self.ships) do
		local var_66_1 = var_66_0:RawGetShipById(iter_66_1)

		if var_66_1 and var_66_1:isActivityNpc() then
			return true
		end
	end

	return false
end

function Fleet:GetName()
	return noEmptyStr(self.name) or Fleet.DEFAULT_NAME[self.id]
end

function Fleet:ChangeToElite()
	local var_68_0 = self:getFleetType()
	local var_68_1 = {
		id = self.id,
		[TeamType.FormShips] = {},
		[TeamType.FormCommander] = {
			0,
			0
		}
	}

	for iter_68_0, iter_68_1 in ipairs(self.commanderIds) do
		var_68_1[TeamType.FormCommander][iter_68_0] = iter_68_1
	end

	switch(var_68_0, {
		[FleetType.Normal] = function()
			var_68_1[TeamType.FormShips] = table.mergeArray(self.mainShips, self.vanguardShips)

			return
		end,
		[FleetType.Submarine] = function()
			var_68_1[TeamType.FormShips] = underscore.to_array(self.subShips)

			return
		end,
		[FleetType.Support] = function()
			var_68_1[TeamType.FormShips] = underscore.to_array(self.mainShips)

			return
		end
	})

	return var_68_1, var_68_0
end

function Fleet:allClear()
	self:clearFleet()
	self:clearCommanders()

	return
end

function Fleet:isAllEmpty()
	return self:isEmpty() and self:isCommanderEmpty()
end

return Fleet
