local Challenge2Fleet = class("Challenge2Fleet", import(".Fleet"))

function Challenge2Fleet:Ctor(arg_1_1)
	self.id = arg_1_1.id

	self:updateShips(arg_1_1.ships)

	self.commanderList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.commanders or {}) do
		self.commanderList[iter_1_1.pos] = Commander.New(iter_1_1.commanderinfo)
	end

	self.skills = {}

	self:updateCommanderSkills()

	return
end

function Challenge2Fleet:getShipsByTeam(arg_2_1, arg_2_2)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(self[arg_2_1]) do
		if iter_2_1.hpRant > 0 then
			var_2_0[#var_2_0 + 1] = iter_2_1
		end
	end

	if arg_2_2 then
		for iter_2_2, iter_2_3 in ipairs(self[arg_2_1]) do
			if iter_2_3.hpRant <= 0 then
				var_2_0[#var_2_0 + 1] = iter_2_3
			end
		end
	end

	return var_2_0
end

function Challenge2Fleet:getTeamByName(arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(self[arg_3_1]) do
		table.insert(var_3_0, iter_3_1.id)
	end

	return var_3_0
end

function Challenge2Fleet:getFleetType()
	for iter_4_0, iter_4_1 in pairs(self.ships) do
		if iter_4_1:getTeamType() == TeamType.Submarine then
			return FleetType.Submarine
		end
	end

	return FleetType.Normal
end

function Challenge2Fleet:getShips(arg_5_1)
	local var_5_0 = {}
	local var_5_1 = self:getFleetType()

	if var_5_1 == FleetType.Normal then
		_.each(self:getShipsByTeam(TeamType.Main, arg_5_1), function(arg_6_0)
			table.insert(var_5_0, arg_6_0)

			return
		end)
		_.each(self:getShipsByTeam(TeamType.Vanguard, arg_5_1), function(arg_7_0)
			table.insert(var_5_0, arg_7_0)

			return
		end)
	elseif var_5_1 == FleetType.Submarine then
		_.each(self:getShipsByTeam(TeamType.Submarine, arg_5_1), function(arg_8_0)
			table.insert(var_5_0, arg_8_0)

			return
		end)
	end

	return var_5_0
end

function Challenge2Fleet:updateShips(arg_9_1)
	self[TeamType.Vanguard] = {}
	self[TeamType.Main] = {}
	self[TeamType.Submarine] = {}
	self.ships = {}

	_.each(arg_9_1 or {}, function(arg_10_0)
		local var_10_0 = Ship.New(arg_10_0.ship_info)

		var_10_0.hpRant = arg_10_0.hp_rant
		self.ships[var_10_0.id] = var_10_0

		table.insert(self[var_10_0:getTeamType()], var_10_0)

		return
	end)

	return
end

function Challenge2Fleet:updateShipsHP(arg_11_1, arg_11_2)
	if self.ships[arg_11_1] then
		self.ships[arg_11_1].hpRant = arg_11_2

		return true
	else
		return false
	end

	return
end

function Challenge2Fleet:getCommanders()
	return self.commanderList
end

function Challenge2Fleet:switchShip(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = self:getShipsByTeam(arg_13_1, false)
	local var_13_1
	local var_13_2
	local var_13_3
	local var_13_4

	for iter_13_0, iter_13_1 in pairs(self.ships) do
		if iter_13_0 == var_13_0[arg_13_2].id then
			var_13_1 = iter_13_1:getTeamType()
			var_13_2 = table.indexof(self[var_13_1], iter_13_1)
		end

		if iter_13_0 == var_13_0[arg_13_3].id then
			var_13_3 = iter_13_1:getTeamType()
			var_13_4 = table.indexof(self[var_13_3], iter_13_1)
		end
	end

	if var_13_1 == var_13_3 and nil ~= nil then
		self[var_13_1][var_13_2], self[var_13_3][var_13_4] = self[var_13_3][nil], self[var_13_1][nil]
	end

	return
end

function Challenge2Fleet:buildBattleBuffList()
	local var_14_0 = {}
	local var_14_1, var_14_2 = FleetSkill.triggerMirrorSkill(self, FleetSkill.TypeBattleBuff)

	if var_14_1 and #var_14_1 > 0 then
		local var_14_3 = {}

		for iter_14_0, iter_14_1 in ipairs(var_14_1) do
			local var_14_4 = self:findCommanderBySkillId(var_14_2[iter_14_0].id)

			var_14_3[var_14_4] = var_14_3[var_14_4] or {}

			table.insert(var_14_3[var_14_4], iter_14_1)
		end

		for iter_14_2, iter_14_3 in pairs(var_14_3) do
			table.insert(var_14_0, {
				iter_14_2,
				iter_14_3
			})
		end
	end

	for iter_14_4, iter_14_5 in pairs((self:getCommanders())) do
		for iter_14_6, iter_14_7 in ipairs((iter_14_5:getTalents())) do
			local var_14_5 = iter_14_7:getBuffsAddition()

			if #var_14_5 > 0 then
				local var_14_6

				for iter_14_8, iter_14_9 in ipairs(var_14_0) do
					if iter_14_9[1] == iter_14_5 then
						var_14_6 = iter_14_9[2]

						break
					end
				end

				if not var_14_6 then
					var_14_6 = {}

					table.insert(var_14_0, {
						iter_14_5,
						var_14_6
					})
				end

				for iter_14_10, iter_14_11 in ipairs(var_14_5) do
					table.insert(var_14_6, iter_14_11)
				end
			end
		end
	end

	return var_14_0
end

return Challenge2Fleet
