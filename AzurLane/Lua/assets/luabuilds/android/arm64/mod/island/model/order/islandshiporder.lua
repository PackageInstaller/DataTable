class = var_0_10000

local var_0_0 = var_0_10000("IslandShipOrder")

var_0_0.OP_TYPE_UNLOCK = 1
var_0_0.OP_TYPE_GET_AWARD = 2
var_0_0.OP_TYPE_LOADUP = 3
var_0_0.OPOP_TYPE_LOADUP_ALL = 4

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.consumeList = {}
	ipairs = var_2

	local var_1_0

	if not arg_1_1.cost then
		var_1_0 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_0) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_1_1 = arg_1_0.consumeList
		local var_1_2 = {}

		DROP_TYPE_ISLAND_ITEM = var_1_10011
		var_1_2.type = var_1_10011
		var_1_2.id = iter_1_1.id
		var_1_2.count = iter_1_1.num
		var_1_2.state = iter_1_1.state

		var_1_10007(var_1_1, var_1_2)
	end

	arg_1_0.awardList = {}
	ipairs = var_2

	local var_1_3

	if not arg_1_1.reward then
		var_1_3 = {}
	end

	for iter_1_2, iter_1_3 in var_2(var_1_3) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_1_4 = arg_1_0.awardList
		local var_1_5 = {}

		DROP_TYPE_ISLAND_ITEM = var_1_10011
		var_1_5.type = var_1_10011
		var_1_5.id = iter_1_3.id
		var_1_5.count = iter_1_3.num

		var_1_10007(var_1_4, var_1_5)
	end

	return
end

function var_0_0.FillConsumeList(arg_2_0, arg_2_1)
	arg_2_0.consumeList = arg_2_1

	return
end

function var_0_0.FillAwardList(arg_3_0, arg_3_1)
	arg_3_0.awardList = arg_3_1

	return
end

function var_0_0.IsAnyLoadUp(arg_4_0)
	_ = var_1_10001

	return var_1_10001.any(arg_4_0.consumeList, function(arg_5_0)
		return arg_5_0.state == 1
	end)
end

function var_0_0.IsLoadUpAll(arg_6_0)
	_ = var_1_10001

	return var_1_10001.all(arg_6_0.consumeList, function(arg_7_0)
		return arg_7_0.state == 1
	end)
end

function var_0_0.MarkLoadUp(arg_8_0, arg_8_1)
	arg_8_0:GetComsume(arg_8_1).state = 1

	return
end

function var_0_0.GetConsumeList(arg_9_0)
	return arg_9_0.consumeList
end

function var_0_0.GetComsume(arg_10_0, arg_10_1)
	local var_10_0

	if not arg_10_0.consumeList[arg_10_1] then
		var_10_0 = {}
	end

	return var_10_0
end

function var_0_0.AnyCanLoadUp(arg_11_0)
	if arg_11_0:IsLoadUpAll() then
		return false
	end

	_ = var_1

	return var_1.any(arg_11_0.consumeList, function(arg_12_0)
		Drop = var_2_10001

		local var_12_0 = var_2_10001.New(arg_12_0)

		return arg_12_0.state ~= 1 and var_12_0:getOwnedCount() >= arg_12_0.count
	end)
end

function var_0_0.ItemIsSubmited(arg_13_0, arg_13_1)
	return arg_13_0.consumeList[arg_13_1] and var_2.state == 1
end

function var_0_0.GetConsumeAwards(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetComsume(arg_14_1)

	pg = var_1_10003

	local var_14_1 = var_1_10003.island_item_data_template[var_14_0.id]

	pg = var_4

	local var_14_2 = var_4.island_set.order_ship_award_coefficient.key_value_varchar
	local var_14_3 = var_14_1.order_price * var_14_0.count
	local var_14_4 = {}
	local var_14_5 = {}

	DROP_TYPE_ISLAND_ITEM = var_1_10008
	var_14_5.type = var_1_10008
	var_14_5.id = var_14_2[1]
	math = var_8
	var_14_5.count = var_8.floor(var_14_3 * (var_14_2[2] / 100))
	var_14_4[1] = var_14_5

	local var_14_6 = {
		id = 2
	}

	DROP_TYPE_ISLAND_ITEM = var_8
	var_14_6.type = var_8
	math = var_8
	var_14_6.count = var_8.floor(var_14_3 * (var_14_2[3] / 100))
	var_14_4[2] = var_14_6

	return var_14_4
end

function var_0_0.GetAwardList(arg_15_0)
	_ = var_1_10001

	return var_1_10001.select(arg_15_0.awardList, function(arg_16_0)
		return arg_16_0.count > 0
	end)
end

return var_0_0
