local Rival = class("Rival", import(".PlayerAttire"))

function Rival:Ctor(arg_1_1)
	Rival.super.Ctor(self, arg_1_1)

	self.id = arg_1_1.id
	self.level = arg_1_1.level
	self.name = arg_1_1.name
	self.score = arg_1_1.score or 0
	self.rank = arg_1_1.rank
	self.vanguardShips = {}
	self.mainShips = {}

	local function var_1_0(arg_2_0)
		if arg_2_0:getTeamType() == TeamType.Vanguard then
			table.insert(self.vanguardShips, arg_2_0)
		elseif arg_2_0:getTeamType() == TeamType.Main then
			table.insert(self.mainShips, arg_2_0)
		end

		return
	end

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.vanguard_ship_list) do
		local var_1_1 = RivalShip.New(iter_1_1)

		var_1_1.isRival = true

		var_1_0(var_1_1)
	end

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.main_ship_list) do
		local var_1_2 = RivalShip.New(iter_1_3)

		var_1_2.isRival = true

		var_1_0(var_1_2)
	end

	self.score = self.score + SeasonInfo.INIT_POINT

	return
end

function Rival:getPainting()
	return (pg.ship_skin_template[self.skinId] or nil) and (pg.ship_skin_template[self.skinId].painting or "unknown")
end

function Rival:getShips()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(self.vanguardShips) do
		table.insert(var_4_0, iter_4_1)
	end

	for iter_4_2, iter_4_3 in ipairs(self.mainShips) do
		table.insert(var_4_0, iter_4_3)
	end

	return var_4_0
end

function Rival:GetGearScoreSum(arg_5_1)
	local var_5_0

	if arg_5_1 == "main" then
		var_5_0 = self.mainShips
	elseif arg_5_1 == "vanguard" then
		var_5_0 = self.vanguardShips
	end

	local var_5_1 = 0

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		var_5_1 = var_5_1 + iter_5_1:getShipCombatPower()
	end

	return var_5_1
end

return Rival
