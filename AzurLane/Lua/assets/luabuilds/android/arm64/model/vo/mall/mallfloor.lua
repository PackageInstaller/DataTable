local var_0_0 = class("MallFloor", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id

	local var_1_0 = arg_1_1.employee_list or {}

	arg_1_0.staffList = {}

	for iter_1_0 = 1, arg_1_0:getConfig("need_staff_count") do
		arg_1_0.staffList[iter_1_0] = var_1_0[iter_1_0] or 0
	end

	arg_1_0.isUnlock = arg_1_2

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.activity_mall_template
end

function var_0_0.IsUnlock(arg_3_0)
	return arg_3_0.isUnlock
end

function var_0_0.CheckUnlock(arg_4_0, arg_4_1)
	arg_4_0.isUnlock = arg_4_1 >= arg_4_0:getConfig("need_mall_level")

	return
end

function var_0_0.SetLastIncome(arg_5_0, arg_5_1)
	arg_5_0.lastIncome = arg_5_1

	return
end

function var_0_0.GetLastIncome(arg_6_0)
	return arg_6_0.lastIncome or 0
end

function var_0_0.SetStaff(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.staffList[arg_7_1] = arg_7_2

	return
end

function var_0_0.GetStaffList(arg_8_0)
	return arg_8_0.staffList
end

function var_0_0.GetEmptyIdx(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.staffList) do
		if iter_9_1 == 0 then
			return iter_9_0
		end
	end

	return nil
end

function var_0_0.GetTargetInfos(arg_10_0, arg_10_1)
	local var_10_0 = underscore.detect(arg_10_0:getConfig("floor_target"), function(arg_11_0)
		return arg_10_1 >= arg_11_0[1][1] and arg_10_1 <= arg_11_0[1][2]
	end)

	return var_10_0 and var_10_0[2]
end

function var_0_0.GetBaseIncome(arg_12_0, arg_12_1)
	local var_12_0 = underscore.detect(arg_12_0:getConfig("floor_basic_profit"), function(arg_13_0)
		return arg_12_1 >= arg_13_0[1][1] and arg_12_1 <= arg_13_0[1][2]
	end)

	return var_12_0 and var_12_0[3]
end

return var_0_0
