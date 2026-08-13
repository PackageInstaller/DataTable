class = var_0_10000

local var_0_0 = "WorkBenchFormula"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.activity_workbench_recipe
end

function var_0_1.Ctor(arg_2_0, ...)
	var_0_1.super.Ctor(arg_2_0, ...)

	local var_2_0

	if not arg_2_0.times then
		var_2_0 = 0
	end

	arg_2_0.times = var_2_0
	arg_2_0.unlock = true

	return
end

function var_0_1.GetName(arg_3_0)
	return arg_3_0:getConfig("name")
end

function var_0_1.GetIconPath(arg_4_0)
	return arg_4_0:getConfig("icon")
end

function var_0_1.GetLockLimit(arg_5_0)
	FilterVarchar = var_1_10001

	return var_1_10001(arg_5_0:getConfig("recipe_lock"))
end

function var_0_1.GetLockDesc(arg_6_0)
	return (arg_6_0:getConfig("lock_display"))
end

function var_0_1.BuildFromActivity(arg_7_0)
	arg_7_0.unlock = (function()
		local var_8_0 = arg_7_0

		if var_0.GetLockLimit(var_8_0) and var_0[1] == 1 then
			getProxy = var_1
			ActivityProxy = var_2_10002

			local var_8_1 = var_1(var_2_10002)
			local var_8_2 = var_1.getActivityByType

			ActivityConst = var_2_10003

			local var_8_3 = var_8_2(var_8_1, var_2_10003.ACTIVITY_TYPE_BUILDING_BUFF_2)

			assert = var_8_1

			var_8_1(var_8_3)

			return var_8_3:GetBuildingLevel(var_0[2]) >= var_0[3]
		end

		return true
	end)()
	getProxy = var_2
	ActivityProxy = var_1_10003

	local var_7_0 = var_2(var_1_10003)
	local var_7_1 = var_2.getActivityByType

	ActivityConst = var_1_10004

	local var_7_2 = var_7_1(var_7_0, var_1_10004.ACTIVITY_TYPE_WORKBENCH)

	assert = var_7_0

	var_7_0(var_7_2)

	arg_7_0.times = var_7_2:GetFormulaUseCount(arg_7_0:GetConfigID())

	return
end

function var_0_1.IsUnlock(arg_9_0)
	return arg_9_0.unlock
end

function var_0_1.GetMaxLimit(arg_10_0)
	return arg_10_0:getConfig("item_num")
end

function var_0_1.SetUsedCount(arg_11_0, arg_11_1)
	arg_11_0.times = arg_11_1

	return
end

function var_0_1.GetUsedCount(arg_12_0)
	return arg_12_0.times
end

function var_0_1.IsAvaliable(arg_13_0)
	return arg_13_0:GetMaxLimit() <= 0 or arg_13_0:GetUsedCount() < arg_13_0:GetMaxLimit()
end

function var_0_1.GetProduction(arg_14_0)
	return arg_14_0:getConfig("item_id")
end

function var_0_1.GetMaterials(arg_15_0)
	return arg_15_0:getConfig("recipe")
end

return var_0_1
