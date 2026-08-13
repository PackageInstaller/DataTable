class = var_0_10000

local var_0_0 = var_0_10000("IslandShipOrderDelegateSlot")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.showTime = arg_1_1.view_time
	arg_1_0.request = {}
	ipairs = var_2

	local var_1_0

	if not arg_1_1.cost then
		var_1_0 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_0) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_1_1 = arg_1_0.request
		local var_1_2 = {}

		DROP_TYPE_ISLAND_ITEM = var_1_10011
		var_1_2.type = var_1_10011
		var_1_2.id = iter_1_1.id
		var_1_2.count = iter_1_1.num

		var_1_10007(var_1_1, var_1_2)
	end

	arg_1_0.awards = {}
	ipairs = var_2

	local var_1_3

	if not arg_1_1.reward then
		var_1_3 = {}
	end

	for iter_1_2, iter_1_3 in var_2(var_1_3) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_1_4 = arg_1_0.awards
		local var_1_5 = {}

		DROP_TYPE_ISLAND_ITEM = var_1_10011
		var_1_5.type = var_1_10011
		var_1_5.id = iter_1_3.id
		var_1_5.count = iter_1_3.num

		var_1_10007(var_1_4, var_1_5)
	end

	return
end

function var_0_0.GetShowTime(arg_2_0)
	return arg_2_0.showTime
end

function var_0_0.CanShow(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_3_0) >= arg_3_0.showTime
end

function var_0_0.GetRequestList(arg_4_0)
	return arg_4_0.request
end

function var_0_0.GetAwardList(arg_5_0)
	return arg_5_0.awards
end

return var_0_0
