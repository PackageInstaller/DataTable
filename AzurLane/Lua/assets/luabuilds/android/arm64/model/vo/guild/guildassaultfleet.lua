class = var_0_10000

local var_0_0 = "GuildAssaultFleet"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseVO"))

function var_0_1.GetRealId(arg_1_0)
	tonumber = var_1_10001
	string = var_1_10003

	local var_1_0 = var_1_10003.split

	tostring = var_1_10005

	return var_1_10001(var_1_0(var_1_10005(arg_1_0), "_")[1])
end

function var_0_1.GetUserId(arg_2_0)
	tonumber = var_1_10001
	string = var_1_10003

	local var_2_0 = var_1_10003.split

	tostring = var_1_10005

	return var_1_10001(var_2_0(var_1_10005(arg_2_0), "_")[2])
end

function var_0_1.GetVirtualId(arg_3_0, arg_3_1)
	return arg_3_1 .. "_" .. arg_3_0
end

function var_0_1.IsSameUserId(arg_4_0, arg_4_1)
	return var_0_1.GetUserId(arg_4_0) == var_0_1.GetUserId(arg_4_1)
end

function var_0_1.Ctor(arg_5_0, arg_5_1)
	local var_5_0 = {}

	ipairs = var_1_10003

	local var_5_1

	if not arg_5_1.ships then
		var_5_1 = {}
	end

	for iter_5_0, iter_5_1 in var_1_10003(var_5_1) do
		GuildAssaultShip = var_1_10008
		var_5_0[iter_5_0] = var_1_10008.New(iter_5_1)
	end

	arg_5_0:InitShips(arg_5_1.user_id, var_5_0)

	return
end

function var_0_1.InitShips(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.ships = {}
	arg_6_0.userId = arg_6_1
	pairs = var_3

	for iter_6_0, iter_6_1 in var_3(arg_6_2) do
		iter_6_1.id = var_0_1.GetVirtualId(arg_6_0.userId, iter_6_1.id)
		arg_6_0.ships[iter_6_0] = iter_6_1
	end

	return
end

function var_0_1.ClearAllRecommandShip(arg_7_0)
	ipairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.ships) do
		arg_7_0:MarkShipBeRecommanded(iter_7_1, false)
	end

	return
end

function var_0_1.SetRecommendList(arg_8_0, arg_8_1)
	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.ships) do
		local var_8_0 = var_0_1.GetRealId(iter_8_1.id)

		_ = var_1_10008

		if var_1_10008.any(arg_8_1, function(arg_9_0)
			return arg_9_0 == var_8_0
		end) then
			arg_8_0:MarkShipBeRecommanded(iter_8_1, true)
		end
	end

	return
end

function var_0_1.MarkShipBeRecommanded(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1.guildRecommand = arg_10_2

	return
end

function var_0_1.SetShipBeRecommanded(arg_11_0, arg_11_1, arg_11_2)
	ipairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(arg_11_0.ships) do
		if arg_11_1 == var_0_1.GetRealId(iter_11_1.id) then
			arg_11_0:MarkShipBeRecommanded(iter_11_1, arg_11_2)

			break
		end
	end

	return
end

function var_0_1.GetStrongestShip(arg_12_0, arg_12_1)
	local var_12_0 = {}

	pairs = var_1_10003

	for iter_12_0, iter_12_1 in var_1_10003(arg_12_0.ships) do
		if iter_12_1:getTeamType() == arg_12_1 then
			table = var_8

			var_8.insert(var_12_0, iter_12_1)
		end
	end

	table = var_3

	var_3.sort(var_12_0, function(arg_13_0, arg_13_1)
		return arg_13_0.level > arg_13_1.level
	end)

	return var_12_0[1]
end

function var_0_1.GetShipList(arg_14_0)
	return arg_14_0.ships
end

function var_0_1.IsEmpty(arg_15_0)
	table = var_1_10001

	return var_1_10001.getCount(arg_15_0.ships) == 0
end

function var_0_1.ExistShip(arg_16_0, arg_16_1)
	pairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_0.ships) do
		if arg_16_1 == iter_16_1.id then
			return true
		end
	end

	return false
end

function var_0_1.GetShipIds(arg_17_0)
	local var_17_0 = {}

	pairs = var_1_10002

	for iter_17_0, iter_17_1 in var_1_10002(arg_17_0.ships) do
		table = var_1_10007

		var_1_10007.insert(var_17_0, iter_17_1.id)
	end

	return var_17_0
end

function var_0_1.GetShipById(arg_18_0, arg_18_1)
	pairs = var_1_10002

	for iter_18_0, iter_18_1 in var_1_10002(arg_18_0.ships) do
		if iter_18_1.id == arg_18_1 then
			return iter_18_1
		end
	end

	return
end

function var_0_1.GetShipByRealId(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = var_0_1.GetVirtualId(arg_19_1, arg_19_2)

	pairs = var_1_10004

	for iter_19_0, iter_19_1 in var_1_10004(arg_19_0.ships) do
		if iter_19_1.id == var_19_0 then
			return iter_19_1
		end
	end

	return
end

function var_0_1.GetShipByPos(arg_20_0, arg_20_1)
	return arg_20_0.ships[arg_20_1]
end

function var_0_1.InsertBayShip(arg_21_0, arg_21_1, arg_21_2)
	arg_21_2.id = var_0_1.GetVirtualId(arg_21_0.userId, arg_21_2.id)
	arg_21_0.ships[arg_21_1] = arg_21_2

	return
end

function var_0_1.AnyShipChanged(arg_22_0, arg_22_1)
	for iter_22_0 = 1, 2 do
		if arg_22_0:PositionIsChanged(arg_22_1, iter_22_0) then
			return true
		end
	end

	return false
end

function var_0_1.PositionIsChanged(arg_23_0, arg_23_1, arg_23_2)
	local function var_23_0(arg_24_0, arg_24_1)
		if arg_24_0 and arg_24_1 and arg_24_0.id == arg_24_1.id then
			ipairs = var_2

			for iter_24_0, iter_24_1 in var_2(arg_24_0.equipments) do
				local var_24_0 = arg_24_1.equipments[iter_24_0]

				if (iter_24_1 and 1 or 0) ~= (var_24_0 and 1 or 0) or var_8 == var_9 and var_8 == 1 and iter_24_1.id ~= var_24_0.id then
					return true
				end
			end
		end

		return false
	end

	local var_23_1 = arg_23_1:GetShipByPos(arg_23_2)
	local var_23_2 = arg_23_0:GetShipByPos(arg_23_2)
	local var_23_3

	if not var_23_1 or not var_23_1.id then
		var_23_3 = 0
	end

	local var_23_4

	if not var_23_2 or not var_23_2.id then
		var_23_4 = 0
	end

	if var_23_3 ~= var_23_4 or var_23_0(var_23_1, var_23_2) then
		return true
	end

	return false
end

return var_0_1
