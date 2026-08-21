local var_0_0 = class("StockingTrigger")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1

	local var_1_0 = pg.dorm3d_stocking_trigger[arg_1_1]

	arg_1_0.triggerPos = pg.dorm3d_stocking_trigger[arg_1_1].trigger_pos
	arg_1_0.compareType = var_1_0.compare_type
	arg_1_0.triggerType = var_1_0.trigger_type
	arg_1_0.shouldExit = var_1_0.exit == 1
	arg_1_0.triggerParam = var_1_0.trigger_param
	arg_1_0.isTriggered = false

	return
end

function var_0_0.Check(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_0.isTriggered then
		return false
	end

	if arg_2_0.compareType == 0 then
		if arg_2_1 >= arg_2_0.triggerPos and arg_2_3 < arg_2_0.triggerPos then
			return true
		end
	elseif arg_2_1 <= arg_2_0.triggerPos and arg_2_2 > arg_2_0.triggerPos then
		return true
	end

	return false
end

function var_0_0.Trigger(arg_3_0)
	arg_3_0.isTriggered = true

	return arg_3_0.triggerType, arg_3_0.triggerParam, arg_3_0.shouldExit
end

function var_0_0.GetCompareType(arg_4_0)
	return arg_4_0.compareType
end

function var_0_0.Sort(arg_5_0)
	table.sort(arg_5_0, function(arg_6_0, arg_6_1)
		if arg_6_0.compareType == 0 then
			return arg_6_0.triggerPos > arg_6_1.triggerPos
		else
			return arg_6_0.triggerPos < arg_6_1.triggerPos
		end

		return
	end)

	return
end

return var_0_0
