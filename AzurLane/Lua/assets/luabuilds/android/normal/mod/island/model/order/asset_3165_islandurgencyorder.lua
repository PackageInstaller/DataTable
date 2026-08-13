class = var_0_10000

local var_0_0 = "IslandUrgencyOrder"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandOrder"))

function var_0_1.IsUrgency(arg_1_0)
	return true
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("island_order_type_2")
end

function var_0_1.IsEmpty(arg_3_0)
	local var_3_0 = arg_3_0.showFlag

	IslandOrderSlot = var_1_10002

	local var_3_2

	if var_3_0 ~= var_1_10002.SHOW_FLAG_TOMORROW then
		pg = var_3_0

		local var_3_1 = var_3_0.TimeMgr.GetInstance()

		if not (var_1.GetServerTime(var_3_1) >= arg_3_0:GetDisappearTime()) then
			var_3_2 = false

			goto label_3_0
		end
	end

	var_3_2 = true

	::label_3_0::

	return var_3_2
end

function var_0_1.Clear(arg_4_0)
	IslandOrderSlot = var_1_10001
	arg_4_0.showFlag = var_1_10001.SHOW_FLAG_TOMORROW

	return
end

function var_0_1.IsLoading(arg_5_0)
	return false
end

function var_0_1.CanReplace(arg_6_0)
	return false
end

function var_0_1.GetTotalTime(arg_7_0)
	return -1
end

function var_0_1.GetDisappearTime(arg_8_0)
	return arg_8_0.submitTime
end

function var_0_1.GetCanSubmitTime(arg_9_0)
	return -1
end

return var_0_1
