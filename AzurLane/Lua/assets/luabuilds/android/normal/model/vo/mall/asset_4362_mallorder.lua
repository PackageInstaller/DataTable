class = var_0_10000

local var_0_0 = var_0_10000("MallOrder")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.cur_order
	arg_1_0.startTime = arg_1_1.active_time

	arg_1_0:UpdateEndTime()

	arg_1_0.staffList = arg_1_1.employee_list
	arg_1_0.finishedList = arg_1_1.finish_order_list

	return
end

function var_0_0.GetEndTime(arg_2_0)
	return arg_2_0.endTime
end

function var_0_0.GetFinishedList(arg_3_0)
	return arg_3_0.finishedList
end

function var_0_0.IsFinishedAll(arg_4_0)
	local var_4_0 = #arg_4_0.finishedList

	pg = var_1_10002

	return var_4_0 == #var_1_10002.activity_mall_custom_order.all
end

function var_0_0.GetStaffList(arg_5_0)
	return arg_5_0.staffList
end

function var_0_0.UpdateEndTime(arg_6_0)
	if arg_6_0.id == 0 or arg_6_0.startTime == 0 then
		arg_6_0.endTime = 0
	else
		local var_6_0 = arg_6_0.startTime

		pg = var_1_10002
		arg_6_0.endTime = var_6_0 + var_1_10002.activity_mall_custom_order[arg_6_0.id].cost_time
	end

	return
end

function var_0_0.StartOrder(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.id = arg_7_1
	arg_7_0.startTime = arg_7_2

	arg_7_0:UpdateEndTime()

	arg_7_0.staffList = arg_7_3

	return
end

function var_0_0.CompleteOrder(arg_8_0, arg_8_1)
	table = var_1_10002

	var_1_10002.insert(arg_8_0.finishedList, arg_8_1)

	arg_8_0.id = 0
	arg_8_0.startTime = 0
	arg_8_0.endTime = 0
	arg_8_0.staffList = {}

	return
end

function var_0_0.GetCostGold(arg_9_0)
	pg = var_1_10001

	return var_1_10001.activity_mall_custom_order[arg_9_0].order_cost_gold
end

function var_0_0.GetCost(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.activity_mall_custom_order[arg_10_0].order_cost_show

	underscore = var_1_10002

	return var_1_10002.map(var_10_0, function(arg_11_0)
		Drop = var_2_10001

		return var_2_10001.Create(arg_11_0)
	end)
end

return var_0_0
