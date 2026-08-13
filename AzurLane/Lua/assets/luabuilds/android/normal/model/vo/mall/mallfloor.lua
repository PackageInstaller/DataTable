class = var_0_10000

local var_0_0 = "MallFloor"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id

	local var_1_0

	if not arg_1_1.employee_list then
		var_1_0 = {}
	end

	arg_1_0.staffList = {}

	for iter_1_0 = 1, arg_1_0:getConfig("need_staff_count") do
		local var_1_1 = arg_1_0.staffList
		local var_1_2

		if not var_1_0[iter_1_0] then
			var_1_2 = 0
		end

		var_1_1[iter_1_0] = var_1_2
	end

	arg_1_0.isUnlock = arg_1_2

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.activity_mall_template
end

function var_0_1.IsUnlock(arg_3_0)
	return arg_3_0.isUnlock
end

function var_0_1.CheckUnlock(arg_4_0, arg_4_1)
	arg_4_0.isUnlock = arg_4_1 >= arg_4_0:getConfig("need_mall_level")

	return
end

function var_0_1.SetLastIncome(arg_5_0, arg_5_1)
	arg_5_0.lastIncome = arg_5_1

	return
end

function var_0_1.GetLastIncome(arg_6_0)
	local var_6_0

	if not arg_6_0.lastIncome then
		var_6_0 = 0
	end

	return var_6_0
end

function var_0_1.SetStaff(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.staffList[arg_7_1] = arg_7_2

	return
end

function var_0_1.GetStaffList(arg_8_0)
	return arg_8_0.staffList
end

function var_0_1.GetEmptyIdx(arg_9_0)
	ipairs = var_1_10001

	for iter_9_0, iter_9_1 in var_1_10001(arg_9_0.staffList) do
		if iter_9_1 == 0 then
			return iter_9_0
		end
	end

	return nil
end

function var_0_1.GetTargetInfos(arg_10_0, arg_10_1)
	underscore = var_1_10002

	return var_1_10002.detect(arg_10_0:getConfig("floor_target"), function(arg_11_0)
		return arg_10_1 >= arg_11_0[1][1] and arg_10_1 <= arg_11_0[1][2]
	end) and var_2[2]
end

function var_0_1.GetBaseIncome(arg_12_0, arg_12_1)
	underscore = var_1_10002

	return var_1_10002.detect(arg_12_0:getConfig("floor_basic_profit"), function(arg_13_0)
		return arg_12_1 >= arg_13_0[1][1] and arg_12_1 <= arg_13_0[1][2]
	end) and var_2[3]
end

return var_0_1
