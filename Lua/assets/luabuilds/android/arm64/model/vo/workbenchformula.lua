local var_0_0 = class("WorkBenchFormula", import("model.vo.BaseVO"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.activity_workbench_recipe
end

function var_0_0.Ctor(arg_2_0, ...)
	var_0_0.super.Ctor(arg_2_0, ...)

	arg_2_0.times = arg_2_0.times or 0
	arg_2_0.unlock = true

	return
end

function var_0_0.GetName(arg_3_0)
	return arg_3_0:getConfig("name")
end

function var_0_0.GetIconPath(arg_4_0)
	return arg_4_0:getConfig("icon")
end

function var_0_0.GetLockLimit(arg_5_0)
	return FilterVarchar(arg_5_0:getConfig("recipe_lock"))
end

function var_0_0.GetLockDesc(arg_6_0)
	return (arg_6_0:getConfig("lock_display"))
end

function var_0_0.BuildFromActivity(arg_7_0)
	arg_7_0.unlock = (function()
		local var_8_0 = arg_7_0:GetLockLimit()

		if var_8_0 and var_8_0[1] == 1 then
			local var_8_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2)

			assert(var_8_1)

			return var_8_1:GetBuildingLevel(var_8_0[2]) >= var_8_0[3]
		end

		return true
	end)()

	local var_7_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_WORKBENCH)

	assert(var_7_0)

	arg_7_0.times = var_7_0:GetFormulaUseCount(arg_7_0:GetConfigID())

	return
end

function var_0_0.IsUnlock(arg_9_0)
	return arg_9_0.unlock
end

function var_0_0.GetMaxLimit(arg_10_0)
	return arg_10_0:getConfig("item_num")
end

function var_0_0.SetUsedCount(arg_11_0, arg_11_1)
	arg_11_0.times = arg_11_1

	return
end

function var_0_0.GetUsedCount(arg_12_0)
	return arg_12_0.times
end

function var_0_0.IsAvaliable(arg_13_0)
	return arg_13_0:GetMaxLimit() <= 0 or arg_13_0:GetUsedCount() < arg_13_0:GetMaxLimit()
end

function var_0_0.GetProduction(arg_14_0)
	return arg_14_0:getConfig("item_id")
end

function var_0_0.GetMaterials(arg_15_0)
	return arg_15_0:getConfig("recipe")
end

return var_0_0
