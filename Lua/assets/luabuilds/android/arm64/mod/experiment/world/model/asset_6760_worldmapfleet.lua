local WorldMapFleet = class("WorldMapFleet", import(".WorldBaseFleet"))

WorldMapFleet.Fields = {
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
WorldMapFleet.EventUpdateLocation = "WorldMapFleet.EventUpdateLocation"
WorldMapFleet.EventUpdateShipOrder = "WorldMapFleet.EventUpdateShipOrder"
WorldMapFleet.EventAddShip = "WorldMapFleet.EventAddShip"
WorldMapFleet.EventRemoveShip = "WorldMapFleet.EventRemoveShip"
WorldMapFleet.EventAddCarry = "WorldMapFleet.EventAddCarry"
WorldMapFleet.EventRemoveCarry = "WorldMapFleet.EventRemoveCarry"
WorldMapFleet.EventUpdateBuff = "WorldMapFleet.EventUpdateBuff"
WorldMapFleet.EventUpdateDamageLevel = "WorldMapFleet.EventUpdateDamageLevel"
WorldMapFleet.EventUpdateDefeat = "WorldMapFleet.EventUpdateDefeat"
WorldMapFleet.EventUpdateCatSalvage = "WorldMapFleet.EventUpdateCatSalvage"
WorldMapFleet.EventUpdateFlashTips = "WorldMapFleet.EventUpdateFlashTips"

function WorldMapFleet:GetName()
	return "fleet_" .. self
end

function WorldMapFleet:DebugPrint()
	local var_2_0, var_2_1 = self:GetAmmo()
	local var_2_2 = {
		[TeamType.Main] = "主力",
		[TeamType.Vanguard] = "先锋",
		[TeamType.Submarine] = "潜艇"
	}
	local var_2_3 = {}

	for iter_2_0, iter_2_1 in ipairs(self:GetShips(true)) do
		local var_2_4 = WorldConst.FetchShipVO(iter_2_1.id)

		table.insert(var_2_3, (string.format("\t\t[%s] [id: %s] [config_id: %s] [%s] [hp: %s%%] [buff: %s]" .. " <material=underline c=#A9F548 event=ShipProperty args=%s><color=#A9F548>属性</color></material>", var_2_4:getName(), var_2_4.id, var_2_4.configId, var_2_2[var_2_4:getTeamType()], iter_2_1.hpRant / 100, table.concat(_.map(iter_2_1:GetBuffList(), function(arg_5_0)
			return arg_5_0.id .. "#" .. arg_5_0:GetFloor()
		end), ", "), var_2_4.id)))
	end

	return string.format("[第%s舰队] [id: %s] [位置: %s, %s] [弹药: %s/%s] [携带物: %s] [战损: %s] [buff: %s]", self.index, self.id, self.row, self.column, var_2_0, var_2_1, table.concat(_.map(self.carries, function(arg_4_0)
		return "carries"
	end), ", "), self.damageLevel, table.concat(_.map(self:GetBuffList(), function(arg_3_0)
		return arg_3_0.id .. "#" .. arg_3_0:GetFloor()
	end), ", ")) .. "\n" .. table.concat(var_2_3, "\n")
end

function WorldMapFleet:Build()
	WorldMapFleet.super.Build(self)

	self.carries = {}

	return
end

function WorldMapFleet:Setup(arg_7_1)
	self.id = arg_7_1.id

	self:UpdateShips((_.map(arg_7_1.ship_list, function(arg_8_0)
		local var_8_0 = WPool:Get(WorldMapShip)

		var_8_0:Setup(arg_8_0)

		return var_8_0
	end)))

	self.commanderIds = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.commander_list or {}) do
		self.commanderIds[iter_7_1.pos] = iter_7_1.id
	end

	self.skills = {}

	self:updateCommanderSkills()

	self.row = arg_7_1.pos.row
	self.column = arg_7_1.pos.column
	self.ammo = arg_7_1.bullet
	self.ammoMax = arg_7_1.bullet_max
	self.damageLevel = math.clamp(arg_7_1.damage_level, 0, #WorldConst.DamageBuffList)

	_.each(arg_7_1.attach_list, function(arg_9_0)
		local var_9_0 = WPool:Get(WorldCarryItem)

		var_9_0:Setup(arg_9_0)
		table.insert(self.carries, var_9_0)

		return
	end)

	self.buffs = WorldConst.ParsingBuffs(arg_7_1.buff_list)
	self.defeatEnemies = arg_7_1.kill_count
	self.catSalvageStep = arg_7_1.cmd_collection.progress
	self.catSalvageList = arg_7_1.cmd_collection.progress_list
	self.catSalvageFrom = arg_7_1.cmd_collection.random_id

	if self:GetFleetType() == FleetType.Submarine then
		self.row = -1
		self.column = -1
	end

	return
end

function WorldMapFleet:GetCost()
	return {
		gold = 0,
		oil = 0
	}, {
		gold = 0,
		oil = 0
	}
end

function WorldMapFleet:GetFleetIndex()
	return self.index
end

function WorldMapFleet:GetDefaultName()
	return Fleet.DEFAULT_NAME[(#self[TeamType.Submarine] > 0 or nil) and (self.index + 10 or self.index)]
end

function WorldMapFleet:FormationEqual(arg_13_1)
	local var_13_0 = _.map(self:GetShips(true), function(arg_14_0)
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

function WorldMapFleet:GetPropertiesSum()
	local var_16_0 = {
		cannon = 0,
		antiAir = 0,
		air = 0,
		torpedo = 0
	}

	for iter_16_0, iter_16_1 in ipairs((self:GetShipVOs(true))) do
		local var_16_1 = iter_16_1:getProperties()

		var_16_0.cannon = var_16_0.cannon + math.floor(var_16_1.cannon)
		var_16_0.torpedo = var_16_0.torpedo + math.floor(var_16_1.torpedo)
		var_16_0.antiAir = var_16_0.antiAir + math.floor(var_16_1.antiaircraft)
		var_16_0.air = var_16_0.air + math.floor(var_16_1.air)
	end

	return var_16_0
end

function WorldMapFleet:GetGearScoreSum(arg_17_1)
	local var_17_0 = 0

	for iter_17_0, iter_17_1 in ipairs(arg_17_1 and self:GetTeamShipVOs(arg_17_1) or self:GetShipVOs()) do
		var_17_0 = var_17_0 + iter_17_1:getShipCombatPower()
	end

	return var_17_0
end

function WorldMapFleet:GetLevelCount()
	local var_18_0 = 0

	underscore.each(self:GetShipVOs(), function(arg_19_0)
		var_18_0 = var_18_0 + arg_19_0.level

		return
	end)

	return 0
end

function WorldMapFleet:AddShip(arg_20_1, arg_20_2)
	assert(arg_20_1.class == WorldMapShip)
	assert(not _.any(self:GetShips(true), function(arg_21_0)
		return arg_21_0.id == arg_20_1.id
	end), "ship exist in port: " .. arg_20_1.id)

	local var_20_0 = WorldConst.FetchRawShipVO(arg_20_1.id)

	assert(var_20_0, "ship not exist: " .. arg_20_1.id)

	local var_20_1 = self[var_20_0:getTeamType()]

	arg_20_2 = arg_20_2 or #var_20_1 + 1
	arg_20_1.fleetId = self.id

	table.insert(var_20_1, arg_20_2, arg_20_1)
	self:DispatchEvent(WorldMapFleet.EventAddShip, arg_20_1)

	return
end

function WorldMapFleet:RemoveShip(arg_22_1)
	local var_22_0 = WorldConst.FetchRawShipVO(arg_22_1)

	assert(var_22_0, "ship not exist: " .. arg_22_1)

	local var_22_1 = self[var_22_0:getTeamType()]

	for iter_22_0 = #var_22_1, 1, -1 do
		if var_22_1[iter_22_0].id == arg_22_1 then
			local var_22_2 = table.remove(var_22_1, iter_22_0)

			var_22_2.fleetId = nil

			self:DispatchEvent(WorldMapFleet.EventRemoveShip, var_22_2)

			return var_22_2, iter_22_0
		end
	end

	return
end

function WorldMapFleet:ReplaceShip(arg_23_1, arg_23_2)
	assert(self:GetShip(arg_23_1))

	if self:GetShip(arg_23_2.id) then
		self:SwitchShip(arg_23_1, arg_23_2.id)
	else
		local var_23_0, var_23_1 = self:RemoveShip(arg_23_1)

		self:AddShip(arg_23_2, var_23_1)
	end

	return
end

function WorldMapFleet:SwitchShip(arg_24_1, arg_24_2)
	local var_24_0 = WorldConst.FetchRawShipVO(arg_24_1)
	local var_24_1 = WorldConst.FetchRawShipVO(arg_24_2)

	assert(var_24_0 and var_24_1)

	local var_24_2 = var_24_0:getTeamType()
	local var_24_3 = var_24_1:getTeamType()

	assert(var_24_2 == var_24_3)

	local var_24_4
	local var_24_5

	for iter_24_0, iter_24_1 in ipairs(self[var_24_2]) do
		if iter_24_1.id == arg_24_1 then
			var_24_4 = iter_24_0
		end

		if iter_24_1.id == arg_24_2 then
			var_24_5 = iter_24_0
		end
	end

	if var_24_4 ~= nil then
		self[var_24_2][var_24_4], self[var_24_3][var_24_5] = self[var_24_3][nil], self[var_24_2][var_24_4]

		self:DispatchEvent(WorldMapFleet.EventUpdateShipOrder)
	end

	return
end

function WorldMapFleet:CheckRemoveShip(arg_25_1)
	local var_25_0 = arg_25_1:getTeamType()

	if #self:GetTeamShips(var_25_0, true) == 1 then
		local var_25_2 = i18n("ship_formationUI_removeError_onlyShip", arg_25_1:getConfig("name"), "", Fleet.C_TEAM_NAME[var_25_0])

		return
	end

	return true
end

function WorldMapFleet:CheckChangeShip(arg_26_1, arg_26_2)
	if not (arg_26_1 and WorldConst.FetchWorldShip(arg_26_1.id).fleetId == WorldConst.FetchWorldShip(arg_26_2.id).fleetId) and (not arg_26_1 or not arg_26_1:isSameKind(arg_26_2)) and _.any(self:GetShips(true), function(arg_27_0)
		return WorldConst.FetchRawShipVO(arg_27_0.id):isSameKind(arg_26_2)
	end) then
		local var_26_1 = i18n("ship_formationMediator_changeNameError_sameShip")

		return
	end

	return true
end

function WorldMapFleet:GetAmmo()
	return self.ammo, self.ammoMax
end

function WorldMapFleet:UseAmmo()
	assert(self.ammo > 0, "without ammo")

	self.ammo = self.ammo - 1

	return
end

function WorldMapFleet:GetTotalAmmo()
	return _.reduce(self:GetShips(true), 0, function(arg_31_0, arg_31_1)
		return arg_31_0 + arg_31_1:GetImportWorldShipVO():getShipAmmo()
	end)
end

function WorldMapFleet:RepairSubmarine()
	_.each(self:GetTeamShips(TeamType.Submarine, true), function(arg_33_0)
		arg_33_0:Repair()

		return
	end)

	self.ammo = self:GetTotalAmmo()
	self.ammoMax = self.ammo

	return
end

function WorldMapFleet:GetSpeed()
	local var_34_0 = pg.gameset.world_move_initial_step.key_value

	if #self:GetBuffsByTrap(WorldBuff.TrapVortex) > 0 then
		var_34_0 = math.min(var_34_0, 1)
	end

	for iter_34_0, iter_34_1 in ipairs(self:GetBuffsByTrap(WorldBuff.TrapCripple)) do
		var_34_0 = math.min(var_34_0, iter_34_1:GetTrapParams()[2])
	end

	return var_34_0
end

function WorldMapFleet:GetStepDurationRate()
	local var_35_0 = 1

	for iter_35_0, iter_35_1 in ipairs(self:GetBuffsByTrap(WorldBuff.TrapCripple)) do
		var_35_0 = math.min(var_35_0, iter_35_1:GetTrapParams()[3] / 100)
	end

	return 1 / var_35_0
end

function WorldMapFleet:GetFOVRange()
	local var_36_0 = 1

	for iter_36_0, iter_36_1 in ipairs(self:GetBuffsByTrap(WorldBuff.TrapCripple)) do
		var_36_0 = math.min(var_36_0, iter_36_1:GetTrapParams()[1] / 100)
	end

	return math.floor(WorldConst.GetFOVRadius() * var_36_0)
end

function WorldMapFleet:GetCarries()
	return self.carries
end

function WorldMapFleet:ExistCarry(arg_38_1)
	return _.any(self.carries, function(arg_39_0)
		return arg_39_0.id == arg_38_1
	end)
end

function WorldMapFleet:AddCarry(arg_40_1)
	table.insert(self.carries, arg_40_1)
	self:DispatchEvent(WorldMapFleet.EventAddCarry, arg_40_1)

	return
end

function WorldMapFleet:RemoveCarry(arg_41_1)
	for iter_41_0, iter_41_1 in ipairs(self.carries) do
		if iter_41_1.id == arg_41_1 then
			for iter_41_2 = #self.carries, iter_41_0 + 1, -1 do
				self.carries[iter_41_2]:UpdateOffset(self.carries[iter_41_2 - 1].offsetRow, self.carries[iter_41_2 - 1].offsetColumn)
			end

			table.remove(self.carries, iter_41_0)
			self:DispatchEvent(WorldMapFleet.EventRemoveCarry, iter_41_1)

			break
		end
	end

	return
end

function WorldMapFleet:RemoveAllCarries()
	for iter_42_0 = #self.carries, 1, -1 do
		self:DispatchEvent(WorldMapFleet.EventRemoveCarry, (table.remove(self.carries)))
	end

	return
end

function WorldMapFleet:BuildCarryPath(arg_43_1, arg_43_2, arg_43_3)
	local var_43_0 = self:GetCarries()
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

function WorldMapFleet:HasDamageLevel()
	return self.damageLevel > 0
end

function WorldMapFleet:IncDamageLevel(arg_46_1)
	local var_46_0 = math.min(#WorldConst.DamageBuffList, self.damageLevel + (pg.world_expedition_data[arg_46_1:GetBattleStageId()].failed_morale or 1))

	if var_46_0 ~= self.damageLevel then
		self.damageLevel = var_46_0

		self:DispatchEvent(WorldMapFleet.EventUpdateDamageLevel)
	end

	return
end

function WorldMapFleet:ClearDamageLevel()
	if 0 ~= self.damageLevel then
		self.damageLevel = 0

		self:DispatchEvent(WorldMapFleet.EventUpdateDamageLevel)
	end

	return
end

function WorldMapFleet:GetDamageBuff()
	if self.damageLevel > 0 then
		local var_48_0 = WorldBuff.New()

		var_48_0:Setup({
			floor = 1,
			id = WorldConst.DamageBuffList[self.damageLevel]
		})

		return var_48_0
	end

	return
end

function WorldMapFleet:GetBuffList()
	return table.mergeArray(_.filter(_.values(self.buffs), function(arg_50_0)
		return arg_50_0:GetFloor() > 0
	end), nowWorld():GetActiveMap():GetBuffList(WorldMap.FactionSelf))
end

function WorldMapFleet:UpdateBuffs(arg_51_1)
	if self.buffs ~= arg_51_1 then
		local var_51_0 = nowWorld():GetActiveMap()

		for iter_51_0, iter_51_1 in pairs(WorldConst.CompareBuffs(self.buffs, arg_51_1).add) do
			if noEmptyStr(iter_51_1.config.trap_lua) then
				self:DispatchEvent(WorldMapFleet.EventUpdateFlashTips, iter_51_1.config.trap_lua)
			end
		end

		self.buffs = arg_51_1

		self:DispatchEvent(WorldMapFleet.EventUpdateBuff)
	end

	return
end

function WorldMapFleet:GetBuff(arg_52_1)
	return self.buffs[arg_52_1]
end

function WorldMapFleet:GetBuffsByTrap(arg_53_1)
	return underscore.filter(self:GetBuffList(), function(arg_54_0)
		return arg_54_0:GetTrapType() == arg_53_1
	end)
end

function WorldMapFleet:HasTrapBuff()
	for iter_55_0, iter_55_1 in ipairs(self:GetBuffList()) do
		if iter_55_1:GetTrapType() ~= 0 then
			return true
		end
	end

	return false
end

function WorldMapFleet:GetBuffFxList()
	local var_56_0 = {}

	_.each(self:GetBuffList(), function(arg_57_0)
		if arg_57_0.config.buff_fx and #arg_57_0.config.buff_fx > 0 then
			table.insert(var_56_0, arg_57_0.config.buff_fx)
		end

		return
	end)

	return var_56_0
end

function WorldMapFleet:GetWatchingBuff()
	local var_58_0 = {}

	for iter_58_0, iter_58_1 in ipairs(pg.gameset.world_sairenbuff_fleeticon.description) do
		var_58_0[iter_58_1] = true
	end

	for iter_58_2, iter_58_3 in ipairs(self:GetBuffList()) do
		if var_58_0[iter_58_3.id] then
			return iter_58_3
		end
	end

	return nil
end

function WorldMapFleet:AddDefeatEnemies(arg_59_1)
	if arg_59_1 then
		self.defeatEnemies = self.defeatEnemies + 1

		self:DispatchEvent(WorldMapFleet.EventUpdateDefeat)
	end

	return
end

function WorldMapFleet:ClearDefeatEnemies()
	self.defeatEnemies = 0

	self:DispatchEvent(WorldMapFleet.EventUpdateDefeat)

	return
end

function WorldMapFleet:getDefeatCount()
	return self.defeatEnemies
end

function WorldMapFleet:getMapAura()
	local var_62_0 = {}

	for iter_62_0, iter_62_1 in ipairs(self:GetShips(true)) do
		var_62_0 = table.mergeArray(var_62_0, iter_62_1:GetImportWorldShipVO():getMapAuras())
	end

	return var_62_0
end

function WorldMapFleet:getMapAid()
	local var_63_0 = {}

	for iter_63_0, iter_63_1 in ipairs(self:GetShips(true)) do
		for iter_63_2, iter_63_3 in ipairs((iter_63_1:GetImportWorldShipVO():getMapAids())) do
			var_63_0[iter_63_1] = var_63_0[iter_63_1] or {}

			table.insert(var_63_0[iter_63_1], iter_63_3)
		end
	end

	return var_63_0
end

function WorldMapFleet:outputCommanders()
	local var_64_0 = {}

	for iter_64_0, iter_64_1 in pairs(self.commanderIds) do
		assert(iter_64_1, "id is nil")
		table.insert(var_64_0, {
			pos = iter_64_0,
			id = iter_64_1
		})
	end

	return var_64_0
end

function WorldMapFleet:getCommanders(arg_65_1)
	local var_65_0 = {}

	if arg_65_1 and self:IsCatSalvage() then
		-- block empty
	else
		for iter_65_0, iter_65_1 in pairs(self.commanderIds) do
			var_65_0[iter_65_0] = getProxy(CommanderProxy):getCommanderById(iter_65_1)
		end
	end

	return var_65_0
end

function WorldMapFleet:getCommanderByPos(arg_66_1)
	return self:getCommanders()[arg_66_1]
end

function WorldMapFleet:updateCommanderByPos(arg_67_1, arg_67_2)
	self.commanderIds[arg_67_1] = arg_67_2 and arg_67_2.id or nil

	self:updateCommanderSkills()

	return
end

function WorldMapFleet:getCommandersAddition()
	local var_68_0 = {}

	for iter_68_0, iter_68_1 in pairs(CommanderConst.PROPERTIES) do
		local var_68_1 = 0

		for iter_68_2, iter_68_3 in pairs(self:getCommanders()) do
			var_68_1 = var_68_1 + iter_68_3:getAbilitysAddition()[iter_68_1]
		end

		if var_68_1 > 0 then
			table.insert(var_68_0, {
				attrName = iter_68_1,
				value = var_68_1
			})
		end
	end

	return var_68_0
end

function WorldMapFleet:getCommandersTalentDesc()
	local var_69_0 = {}

	for iter_69_0, iter_69_1 in pairs(self:getCommanders()) do
		for iter_69_2, iter_69_3 in pairs((iter_69_1:getTalentsDesc())) do
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

function WorldMapFleet:findCommanderBySkillId(arg_70_1)
	for iter_70_0, iter_70_1 in pairs((self:getCommanders())) do
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

function WorldMapFleet:updateCommanderSkills()
	while #self.skills > 0 do
		if not self:findCommanderBySkillId(self.skills[#self.skills].id) and self.skills[#self.skills]:GetSystem() == FleetSkill.SystemCommanderNeko then
			table.remove(self.skills, #self.skills)
		end
	end

	for iter_73_0, iter_73_1 in pairs((self:getCommanders())) do
		for iter_73_2, iter_73_3 in ipairs(iter_73_1:getSkills()) do
			for iter_73_4, iter_73_5 in ipairs(iter_73_3:GetTacticSkillForWorld()) do
				table.insert(self.skills, FleetSkill.New(FleetSkill.SystemCommanderNeko, iter_73_5))
			end
		end
	end

	return
end

function WorldMapFleet:getSkills()
	return self.skills
end

function WorldMapFleet:getSkill(arg_75_1)
	return _.detect(self:getSkills(), function(arg_76_0)
		return arg_76_0.id == arg_75_1
	end)
end

function WorldMapFleet:findSkills(arg_77_1)
	return _.filter(self:getSkills(), function(arg_78_0)
		return arg_78_0:GetType() == arg_77_1
	end)
end

function WorldMapFleet:IsCatSalvage()
	return self.catSalvageFrom and self.catSalvageFrom > 0
end

function WorldMapFleet:UpdateCatSalvage(arg_80_1, arg_80_2, arg_80_3)
	self.catSalvageStep = arg_80_1
	self.catSalvageList = arg_80_2
	self.catSalvageFrom = arg_80_3

	local var_80_0 = nowWorld()

	if self:GetRarityState() == 2 and not var_80_0.isAutoFight then
		var_80_0:GetActiveMap():AddPhaseDisplay({
			story = pg.gameset.world_catsearch_raritytip.description[1]
		})
	end

	self:DispatchEvent(WorldMapFleet.EventUpdateCatSalvage)

	return
end

function WorldMapFleet:IsSalvageFinish()
	return self.catSalvageStep == #self.catSalvageList
end

local function var_0_1(arg_82_0)
	return pg.world_catsearch_node[arg_82_0].special_drop == 1
end

function WorldMapFleet:GetRarityState()
	if self.catSalvageStep == 0 then
		return 0
	end

	if var_0_1(self.catSalvageList[self.catSalvageStep]) then
		return 2
	else
		for iter_83_0 = 1, self.catSalvageStep - 1 do
			if var_0_1(self.catSalvageList[iter_83_0]) then
				return 1
			end
		end
	end

	return 0
end

function WorldMapFleet:GetSalvageScoreRarity()
	local var_84_0 = 0

	for iter_84_0, iter_84_1 in ipairs(self.catSalvageList) do
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

function WorldMapFleet:GetDisplayCommander()
	local var_85_0 = self:getCommanders()

	for iter_85_0 = 1, 2 do
		if self.commanderIds[iter_85_0] then
			return getProxy(CommanderProxy):getCommanderById(self.commanderIds[iter_85_0])
		end
	end

	return
end

function WorldMapFleet:HasCommander(arg_86_1)
	for iter_86_0, iter_86_1 in pairs(self.commanderIds) do
		if arg_86_1 == iter_86_1 then
			return true
		end
	end

	return false
end

function WorldMapFleet:switchShip(arg_87_1, arg_87_2, arg_87_3, arg_87_4, arg_87_5)
	self:SwitchShip(arg_87_4, arg_87_5)

	return
end

return WorldMapFleet
