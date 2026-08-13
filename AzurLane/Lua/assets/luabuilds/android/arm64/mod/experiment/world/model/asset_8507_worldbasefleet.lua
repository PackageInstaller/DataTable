class = var_0_10000

local var_0_0 = "WorldBaseFleet"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))
local var_0_2 = {
	id = "number",
	commanderIds = "table"
}

TeamType = var_0_0
var_0_2[var_0_0.Main] = "table"
TeamType = var_2
var_0_2[var_2.Vanguard] = "table"
TeamType = var_2
var_0_2[var_2.Submarine] = "table"
var_0_1.Fields = var_0_2

function var_0_1.Build(arg_1_0)
	TeamType = var_1_10001
	arg_1_0[var_1_10001.Main] = {}
	TeamType = var_1
	arg_1_0[var_1.Vanguard] = {}
	TeamType = var_1
	arg_1_0[var_1.Submarine] = {}
	arg_1_0.commanderIds = {}

	return
end

function var_0_1.Setup(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	_ = var_2

	local var_2_0 = var_2.map(arg_2_1.ship_list, function(arg_3_0)
		WPool = var_2_10001

		local var_3_0 = var_2_10001
		local var_3_1 = var_2_10001.Get

		WorldMapShip = var_2_10004

		local var_3_2 = var_3_1(var_3_0, var_2_10004)

		var_3_2.id = arg_3_0

		return var_3_2
	end)

	arg_2_0:UpdateShips(var_2_0)

	arg_2_0.commanderIds = {}
	ipairs = var_3

	local var_2_1

	if not arg_2_1.commanders then
		var_2_1 = {}
	end

	for iter_2_0, iter_2_1 in var_3(var_2_1) do
		arg_2_0.commanderIds[iter_2_1.pos] = iter_2_1.id
	end

	return
end

function var_0_1.UpdateShips(arg_4_0, arg_4_1)
	TeamType = var_1_10002
	arg_4_0[var_1_10002.Main] = {}
	TeamType = var_2
	arg_4_0[var_2.Vanguard] = {}
	TeamType = var_2
	arg_4_0[var_2.Submarine] = {}
	_ = var_2

	var_2.each(arg_4_1, function(arg_5_0)
		assert = var_2_10001

		local var_5_0 = arg_5_0.class

		WorldMapShip = var_2_10004

		var_2_10001(var_5_0 == var_2_10004)

		if arg_5_0:IsValid() then
			arg_5_0.fleetId = arg_4_0.id
			table = var_1

			local var_5_1 = var_1.insert
			local var_5_2 = arg_4_0

			WorldConst = var_2_10004

			local var_5_3 = var_2_10004.FetchRawShipVO(arg_5_0.id)

			var_5_1(var_5_2[var_4.getTeamType(var_5_3)], arg_5_0)
		end

		return
	end)

	ipairs = var_2

	local var_4_0 = {}

	TeamType = var_5
	var_4_0[1] = var_5.Main
	TeamType = var_5
	var_4_0[2] = var_5.Vanguard
	TeamType = var_5
	var_4_0[3] = var_5.Submarine

	for iter_4_0, iter_4_1 in var_2(var_4_0) do
		underscore = var_1_10007

		var_1_10007.each(arg_4_0[iter_4_1], function(arg_6_0)
			arg_6_0.triggers.TeamNumbers = #arg_4_0[iter_4_1]

			return
		end)
	end

	return
end

function var_0_1.IsValid(arg_7_0)
	local var_7_0 = arg_7_0:GetFleetType()

	FleetType = var_1_10002

	if var_7_0 == var_1_10002.Submarine then
		local var_7_1 = arg_7_0
		local var_7_2 = arg_7_0.GetTeamShips

		TeamType = var_1_10004

		do return #var_7_2(var_7_1, var_1_10004.Submarine, true) > 0 end

		goto label_7_0
	end

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.GetTeamShips

	TeamType = var_1_10004

	if #var_7_4(var_7_3, var_1_10004.Vanguard, true) > 0 then
		do
			local var_7_5 = arg_7_0
			local var_7_6 = arg_7_0.GetTeamShips

			TeamType = var_4

			local var_7_7

			if not (#var_7_6(var_7_5, var_4.Main, true) > 0) then
				var_7_7 = false
			else
				var_7_7 = true
			end

			return var_7_7
		end

		::label_7_0::

		return
	end
end

function var_0_1.GetFleetType(arg_8_0)
	TeamType = var_1_10001

	if #arg_8_0[var_1_10001.Submarine] > 0 then
		FleetType = var_8_0

		local var_8_0

		if not var_8_0.Submarine then
			FleetType = var_8_0
			var_8_0 = var_8_0.Normal
		end

		return var_8_0
	end
end

function var_0_1.GetPrefab(arg_9_0)
	local var_9_0 = arg_9_0:GetFlagShipVO()

	return var_1.getPrefab(var_9_0)
end

function var_0_1.GetShip(arg_10_0, arg_10_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_10_0:GetShips(true), function(arg_11_0)
		return arg_11_0.id == arg_10_1
	end)
end

function var_0_1.GetShips(arg_12_0, arg_12_1)
	local var_12_0 = {}

	_ = var_1_10003

	local var_12_1 = var_1_10003.each
	local var_12_2 = {}

	TeamType = var_1_10006
	var_12_2[1] = var_1_10006.Main
	TeamType = var_6
	var_12_2[2] = var_6.Vanguard
	TeamType = var_6
	var_12_2[3] = var_6.Submarine

	var_12_1(var_12_2, function(arg_13_0)
		ipairs = var_2_10001

		for iter_13_0, iter_13_1 in var_2_10001(arg_12_0[arg_13_0]) do
			if arg_12_1 or iter_13_1:IsAlive() then
				table = var_6

				var_6.insert(var_12_0, iter_13_1)
			end
		end

		return
	end)

	return var_12_0
end

function var_0_1.GetShipVOs(arg_14_0, arg_14_1)
	_ = var_1_10002

	return var_1_10002.map(arg_14_0:GetShips(arg_14_1), function(arg_15_0)
		WorldConst = var_2_10001

		return var_2_10001.FetchShipVO(arg_15_0.id)
	end)
end

function var_0_1.GetTeamShips(arg_16_0, arg_16_1, arg_16_2)
	_ = var_1_10003

	local var_16_0 = var_1_10003(arg_16_0[arg_16_1])
	local var_16_1 = var_3.chain(var_16_0)
	local var_16_2 = var_3.filter(var_16_1, function(arg_17_0)
		local var_17_0

		if not arg_16_2 then
			var_17_0 = arg_17_0:IsAlive()
		end

		return var_17_0
	end)

	return var_3.value(var_16_2)
end

function var_0_1.GetTeamShipVOs(arg_18_0, arg_18_1, arg_18_2)
	_ = var_1_10003

	return var_1_10003.map(arg_18_0:GetTeamShips(arg_18_1, arg_18_2), function(arg_19_0)
		WorldConst = var_2_10001

		return var_2_10001.FetchShipVO(arg_19_0.id)
	end)
end

function var_0_1.GetFlagShipVO(arg_20_0)
	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.GetFleetType(var_20_0)

	FleetType = var_1_10002

	if var_20_1 == var_1_10002.Submarine then
		WorldConst = var_20_1
		var_20_1 = var_20_1.FetchShipVO
		_ = var_20_0
		var_20_0 = var_20_0.detect
		TeamType = var_1_10005

		return var_20_1(var_20_0(arg_20_0[var_1_10005.Submarine], function(arg_21_0)
			return arg_21_0:IsAlive()
		end).id)
	else
		WorldConst = var_20_1

		local var_20_2 = var_20_1.FetchShipVO

		_ = var_20_0

		local var_20_3 = var_20_0.detect

		TeamType = var_1_10005

		return var_20_2(var_20_3(arg_20_0[var_1_10005.Main], function(arg_22_0)
			return arg_22_0:IsAlive()
		end).id)
	end

	return
end

function var_0_1.IsAlive(arg_23_0)
	_ = var_1_10001

	local var_23_0 = var_1_10001.any

	TeamType = var_1_10003

	local var_23_1

	if var_23_0(arg_23_0[var_1_10003.Main], function(arg_24_0)
		return arg_24_0:IsAlive()
	end) then
		_ = var_23_1
		var_23_1 = var_23_1.any
		TeamType = var_3
		var_23_1 = var_23_1(arg_23_0[var_3.Vanguard], function(arg_25_0)
			return arg_25_0:IsAlive()
		end)
	end

	return var_23_1
end

function var_0_1.GetLevel(arg_26_0)
	local var_26_0 = arg_26_0:GetShips(true)

	math = var_1_10002

	local var_26_1 = var_1_10002.floor

	_ = var_4

	return var_26_1(var_4.reduce(var_26_0, 0, function(arg_27_0, arg_27_1)
		WorldConst = var_2_10002

		return arg_27_0 + var_2_10002.FetchRawShipVO(arg_27_1.id).level
	end) / #var_26_0)
end

function var_0_1.BuildFormationIds(arg_28_0)
	local var_28_0 = {}

	TeamType = var_1_10002
	var_28_0[var_1_10002.Main] = {}
	TeamType = var_2
	var_28_0[var_2.Vanguard] = {}
	TeamType = var_2
	var_28_0[var_2.Submarine] = {}
	pairs = var_2

	for iter_28_0, iter_28_1 in var_2(var_28_0) do
		_ = var_1_10007
		var_28_0[iter_28_0] = var_1_10007.map(arg_28_0:GetTeamShips(iter_28_0), function(arg_29_0)
			return arg_29_0.id
		end)
	end

	var_28_0.commanders = {}
	pairs = var_2

	for iter_28_2, iter_28_3 in var_2(arg_28_0.commanderIds) do
		table = var_1_10007

		var_1_10007.insert(var_28_0.commanders, {
			pos = iter_28_2,
			id = iter_28_3
		})
	end

	return var_28_0
end

function var_0_1.getTeamByName(arg_30_0, arg_30_1)
	local var_30_0 = {}

	ipairs = var_1_10003

	for iter_30_0, iter_30_1 in var_1_10003(arg_30_0[arg_30_1]) do
		if iter_30_1:IsAlive() then
			table = var_8

			var_8.insert(var_30_0, iter_30_1.id)
		end
	end

	return var_30_0
end

function var_0_1.getFleetType(arg_31_0)
	return arg_31_0:GetFleetType()
end

function var_0_1.getShipVOsDic(arg_32_0)
	local var_32_0 = {}
	local var_32_1 = arg_32_0:GetShipVOs()

	ipairs = var_1_10003

	for iter_32_0, iter_32_1 in var_1_10003(var_32_1) do
		var_32_0[iter_32_1.id] = iter_32_1
	end

	return var_32_0
end

return var_0_1
