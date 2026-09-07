local WorldBaseFleet = class("WorldBaseFleet", import("...BaseEntity"))

WorldBaseFleet.Fields = {
	id = "number",
	commanderIds = "table",
	[TeamType.Main] = "table",
	[TeamType.Vanguard] = "table",
	[TeamType.Submarine] = "table"
}

function WorldBaseFleet:Build()
	self[TeamType.Main] = {}
	self[TeamType.Vanguard] = {}
	self[TeamType.Submarine] = {}
	self.commanderIds = {}

	return
end

function WorldBaseFleet:Setup(arg_2_1)
	self.id = arg_2_1.id

	self:UpdateShips((_.map(arg_2_1.ship_list, function(arg_3_0)
		local var_3_0 = WPool:Get(WorldMapShip)

		var_3_0.id = arg_3_0

		return var_3_0
	end)))

	self.commanderIds = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.commanders or {}) do
		self.commanderIds[iter_2_1.pos] = iter_2_1.id
	end

	return
end

function WorldBaseFleet:UpdateShips(arg_4_1)
	self[TeamType.Main] = {}
	self[TeamType.Vanguard] = {}
	self[TeamType.Submarine] = {}

	_.each(arg_4_1, function(arg_5_0)
		assert(arg_5_0.class == WorldMapShip)

		if arg_5_0:IsValid() then
			arg_5_0.fleetId = self.id

			table.insert(self[WorldConst.FetchRawShipVO(arg_5_0.id):getTeamType()], arg_5_0)
		end

		return
	end)

	for iter_4_0, iter_4_1 in ipairs({
		TeamType.Main,
		TeamType.Vanguard,
		TeamType.Submarine
	}) do
		underscore.each(self[iter_4_1], function(arg_6_0)
			arg_6_0.triggers.TeamNumbers = #self[iter_4_1]

			return
		end)
	end

	return
end

function WorldBaseFleet:IsValid()
	if self:GetFleetType() == FleetType.Submarine then
		return #self:GetTeamShips(TeamType.Submarine, true) > 0
	else
		return #self:GetTeamShips(TeamType.Vanguard, true) > 0 and #self:GetTeamShips(TeamType.Main, true) > 0
	end

	return
end

function WorldBaseFleet:GetFleetType()
	return (#self[TeamType.Submarine] > 0 or nil) and (FleetType.Submarine or FleetType.Normal)
end

function WorldBaseFleet:GetPrefab()
	return self:GetFlagShipVO():getPrefab()
end

function WorldBaseFleet:GetShip(arg_10_1)
	return _.detect(self:GetShips(true), function(arg_11_0)
		return arg_11_0.id == arg_10_1
	end)
end

function WorldBaseFleet:GetShips(arg_12_1)
	local var_12_0 = {}

	_.each({
		TeamType.Main,
		TeamType.Vanguard,
		TeamType.Submarine
	}, function(arg_13_0)
		for iter_13_0, iter_13_1 in ipairs(self[arg_13_0]) do
			if arg_12_1 or iter_13_1:IsAlive() then
				table.insert(var_12_0, iter_13_1)
			end
		end

		return
	end)

	return var_12_0
end

function WorldBaseFleet:GetShipVOs(arg_14_1)
	return _.map(self:GetShips(arg_14_1), function(arg_15_0)
		return WorldConst.FetchShipVO(arg_15_0.id)
	end)
end

function WorldBaseFleet:GetTeamShips(arg_16_1, arg_16_2)
	return _(self[arg_16_1]):chain():filter(function(arg_17_0)
		return arg_16_2 or arg_17_0:IsAlive()
	end):value()
end

function WorldBaseFleet:GetTeamShipVOs(arg_18_1, arg_18_2)
	return _.map(self:GetTeamShips(arg_18_1, arg_18_2), function(arg_19_0)
		return WorldConst.FetchShipVO(arg_19_0.id)
	end)
end

function WorldBaseFleet:GetFlagShipVO()
	if self:GetFleetType() == FleetType.Submarine then
		return WorldConst.FetchShipVO(_.detect(self[TeamType.Submarine], function(arg_21_0)
			return arg_21_0:IsAlive()
		end).id)
	else
		return WorldConst.FetchShipVO(_.detect(self[TeamType.Main], function(arg_22_0)
			return arg_22_0:IsAlive()
		end).id)
	end

	return
end

function WorldBaseFleet:IsAlive()
	return _.any(self[TeamType.Main], function(arg_24_0)
		return arg_24_0:IsAlive()
	end) and _.any(self[TeamType.Vanguard], function(arg_25_0)
		return arg_25_0:IsAlive()
	end)
end

function WorldBaseFleet:GetLevel()
	local var_26_0 = self:GetShips(true)

	return math.floor(_.reduce(var_26_0, 0, function(arg_27_0, arg_27_1)
		return arg_27_0 + WorldConst.FetchRawShipVO(arg_27_1.id).level
	end) / #var_26_0)
end

function WorldBaseFleet:BuildFormationIds()
	local var_28_0 = {
		[TeamType.Main] = {},
		[TeamType.Vanguard] = {},
		[TeamType.Submarine] = {}
	}

	for iter_28_0, iter_28_1 in pairs(var_28_0) do
		var_28_0[iter_28_0] = _.map(self:GetTeamShips(iter_28_0), function(arg_29_0)
			return arg_29_0.id
		end)
	end

	var_28_0.commanders = {}

	for iter_28_2, iter_28_3 in pairs(self.commanderIds) do
		table.insert(var_28_0.commanders, {
			pos = iter_28_2,
			id = iter_28_3
		})
	end

	return var_28_0
end

function WorldBaseFleet:getTeamByName(arg_30_1)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(self[arg_30_1]) do
		if iter_30_1:IsAlive() then
			table.insert(var_30_0, iter_30_1.id)
		end
	end

	return var_30_0
end

function WorldBaseFleet:getFleetType()
	return self:GetFleetType()
end

function WorldBaseFleet:getShipVOsDic()
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in ipairs((self:GetShipVOs())) do
		var_32_0[iter_32_1.id] = iter_32_1
	end

	return var_32_0
end

return WorldBaseFleet
