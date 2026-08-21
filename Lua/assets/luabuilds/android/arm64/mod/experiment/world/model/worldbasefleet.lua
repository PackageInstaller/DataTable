local var_0_0 = class("WorldBaseFleet", import("...BaseEntity"))

var_0_0.Fields = {
	id = "number",
	commanderIds = "table",
	[TeamType.Main] = "table",
	[TeamType.Vanguard] = "table",
	[TeamType.Submarine] = "table"
}

function var_0_0.Build(arg_1_0)
	arg_1_0[TeamType.Main] = {}
	arg_1_0[TeamType.Vanguard] = {}
	arg_1_0[TeamType.Submarine] = {}
	arg_1_0.commanderIds = {}

	return
end

function var_0_0.Setup(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id

	arg_2_0:UpdateShips((_.map(arg_2_1.ship_list, function(arg_3_0)
		local var_3_0 = WPool:Get(WorldMapShip)

		var_3_0.id = arg_3_0

		return var_3_0
	end)))

	arg_2_0.commanderIds = {}

	local var_2_0 = arg_2_1.commanders or {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		arg_2_0.commanderIds[iter_2_1.pos] = iter_2_1.id
	end

	return
end

function var_0_0.UpdateShips(arg_4_0, arg_4_1)
	arg_4_0[TeamType.Main] = {}
	arg_4_0[TeamType.Vanguard] = {}
	arg_4_0[TeamType.Submarine] = {}

	_.each(arg_4_1, function(arg_5_0)
		assert(arg_5_0.class == WorldMapShip)

		if arg_5_0:IsValid() then
			arg_5_0.fleetId = arg_4_0.id

			table.insert(arg_4_0[WorldConst.FetchRawShipVO(arg_5_0.id):getTeamType()], arg_5_0)
		end

		return
	end)

	for iter_4_0, iter_4_1 in ipairs({
		TeamType.Main,
		TeamType.Vanguard,
		TeamType.Submarine
	}) do
		underscore.each(arg_4_0[iter_4_1], function(arg_6_0)
			arg_6_0.triggers.TeamNumbers = #arg_4_0[iter_4_1]

			return
		end)
	end

	return
end

function var_0_0.IsValid(arg_7_0)
	if arg_7_0:GetFleetType() == FleetType.Submarine then
		return #arg_7_0:GetTeamShips(TeamType.Submarine, true) > 0
	else
		return #arg_7_0:GetTeamShips(TeamType.Vanguard, true) > 0 and #arg_7_0:GetTeamShips(TeamType.Main, true) > 0
	end

	return
end

function var_0_0.GetFleetType(arg_8_0)
	if #arg_8_0[TeamType.Submarine] > 0 then
		return FleetType.Submarine or FleetType.Normal
	end
end

function var_0_0.GetPrefab(arg_9_0)
	return arg_9_0:GetFlagShipVO():getPrefab()
end

function var_0_0.GetShip(arg_10_0, arg_10_1)
	return _.detect(arg_10_0:GetShips(true), function(arg_11_0)
		return arg_11_0.id == arg_10_1
	end)
end

function var_0_0.GetShips(arg_12_0, arg_12_1)
	local var_12_0 = {}

	_.each({
		TeamType.Main,
		TeamType.Vanguard,
		TeamType.Submarine
	}, function(arg_13_0)
		for iter_13_0, iter_13_1 in ipairs(arg_12_0[arg_13_0]) do
			if arg_12_1 or iter_13_1:IsAlive() then
				table.insert(var_12_0, iter_13_1)
			end
		end

		return
	end)

	return {}
end

function var_0_0.GetShipVOs(arg_14_0, arg_14_1)
	return _.map(arg_14_0:GetShips(arg_14_1), function(arg_15_0)
		return WorldConst.FetchShipVO(arg_15_0.id)
	end)
end

function var_0_0.GetTeamShips(arg_16_0, arg_16_1, arg_16_2)
	return _(arg_16_0[arg_16_1]):chain():filter(function(arg_17_0)
		return arg_16_2 or arg_17_0:IsAlive()
	end):value()
end

function var_0_0.GetTeamShipVOs(arg_18_0, arg_18_1, arg_18_2)
	return _.map(arg_18_0:GetTeamShips(arg_18_1, arg_18_2), function(arg_19_0)
		return WorldConst.FetchShipVO(arg_19_0.id)
	end)
end

function var_0_0.GetFlagShipVO(arg_20_0)
	if arg_20_0:GetFleetType() == FleetType.Submarine then
		return WorldConst.FetchShipVO(_.detect(arg_20_0[TeamType.Submarine], function(arg_21_0)
			return arg_21_0:IsAlive()
		end).id)
	else
		return WorldConst.FetchShipVO(_.detect(arg_20_0[TeamType.Main], function(arg_22_0)
			return arg_22_0:IsAlive()
		end).id)
	end

	return
end

function var_0_0.IsAlive(arg_23_0)
	return _.any(arg_23_0[TeamType.Main], function(arg_24_0)
		return arg_24_0:IsAlive()
	end) and _.any(arg_23_0[TeamType.Vanguard], function(arg_25_0)
		return arg_25_0:IsAlive()
	end)
end

function var_0_0.GetLevel(arg_26_0)
	local var_26_0 = arg_26_0:GetShips(true)

	return math.floor(_.reduce(var_26_0, 0, function(arg_27_0, arg_27_1)
		return arg_27_0 + WorldConst.FetchRawShipVO(arg_27_1.id).level
	end) / #var_26_0)
end

function var_0_0.BuildFormationIds(arg_28_0)
	for iter_28_0, iter_28_1 in pairs({
		[TeamType.Main] = {},
		[TeamType.Vanguard] = {},
		[TeamType.Submarine] = {}
	}) do
		({
			[TeamType.Main] = {},
			[TeamType.Vanguard] = {},
			[TeamType.Submarine] = {}
		})[iter_28_0] = _.map(arg_28_0:GetTeamShips(iter_28_0), function(arg_29_0)
			return arg_29_0.id
		end)
	end

	;({
		[TeamType.Main] = {},
		[TeamType.Vanguard] = {},
		[TeamType.Submarine] = {}
	}).commanders = {}

	for iter_28_2, iter_28_3 in pairs(arg_28_0.commanderIds) do
		table.insert(({
			[TeamType.Main] = {},
			[TeamType.Vanguard] = {},
			[TeamType.Submarine] = {}
		}).commanders, {
			pos = iter_28_2,
			id = iter_28_3
		})
	end

	return {
		[TeamType.Main] = {},
		[TeamType.Vanguard] = {},
		[TeamType.Submarine] = {}
	}
end

function var_0_0.getTeamByName(arg_30_0, arg_30_1)
	for iter_30_0, iter_30_1 in ipairs(arg_30_0[arg_30_1]) do
		if iter_30_1:IsAlive() then
			table.insert({}, iter_30_1.id)
		end
	end

	return {}
end

function var_0_0.getFleetType(arg_31_0)
	return arg_31_0:GetFleetType()
end

function var_0_0.getShipVOsDic(arg_32_0)
	for iter_32_0, iter_32_1 in ipairs((arg_32_0:GetShipVOs())) do
		({})[iter_32_1.id] = iter_32_1
	end

	return {}
end

return var_0_0
