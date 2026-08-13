class = var_0_10000

local var_0_0 = "MainSubActBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseActivityBtn"))

function var_0_1.GetEventName(arg_1_0)
	return "event_sub_act"
end

function var_0_1.GetActivity(arg_2_0)
	if arg_2_0.config and arg_2_0.config.time and arg_2_0.config.time[1] == "default" then
		local var_2_0 = arg_2_0.config.time[2]

		getProxy = var_1_10002
		ActivityProxy = var_1_10004

		local var_2_1 = var_1_10002(var_1_10004)

		if var_2.getActivityById(var_2_1, var_2_0) and not var_2:isEnd() then
			return var_2
		end
	end

	return nil
end

function var_0_1.GetActivityID(arg_3_0)
	return arg_3_0:GetActivity() and var_1.id
end

function var_0_1.OnInit(arg_4_0)
	setActive = var_1_10001

	var_1_10001(arg_4_0.tipTr, arg_4_0:IsShowTip())

	return
end

function var_0_1.IsShowTip(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.GetActivity(var_5_0)
	local var_5_2

	var_5_2, switch = var_1.getConfig(var_5_1, "type"), var_5_0

	local var_5_3 = {}

	ActivityConst = var_1_10007
	var_5_3[var_1_10007.ACTIVITY_TYPE_TOWN2] = function()
		LiquorFloorMapScene = var_2_10000

		return var_2_10000.ShouldShowTaskTip()
	end

	return var_5_0(var_5_2, var_5_3, function()
		local var_7_0 = var_0

		return var_0.readyToAchieve(var_7_0)
	end)
end

return var_0_1
