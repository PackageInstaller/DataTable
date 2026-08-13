class = var_0_10000

local var_0_0 = "MainActBlackFridaySalesBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseActivityBtn"))

function var_0_1.InShowTime(arg_1_0)
	local var_1_0 = var_0_1.super.InShowTime(arg_1_0)

	getProxy = var_2
	ActivityProxy = var_1_10003

	local var_1_1 = var_2(var_1_10003)
	local var_1_2 = var_2.getActivityByType

	ActivityConst = var_1_10004

	local var_1_3 = var_1_2(var_1_1, var_1_10004.ACTIVITY_TYPE_BLACK_FRIDAY_SHOP)

	return var_1_0 and var_1_3 and not var_1_3:isEnd()
end

function var_0_1.GetEventName(arg_2_0)
	return "event_blackFriday"
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = false
	local var_3_1

	getProxy = var_1_10003
	ActivityProxy = var_1_10004

	local var_3_2 = var_1_10003(var_1_10004)
	local var_3_3 = var_3.getActivitiesByType

	ActivityConst = var_1_10005

	local var_3_4 = var_3_3(var_3_2, var_1_10005.ACTIVITY_TYPE_TASKS)

	ipairs = var_3_2

	for iter_3_0, iter_3_1 in var_3_2(var_3_4) do
		if iter_3_1:getConfig("config_client").blackFriday then
			var_3_1 = iter_3_1

			break
		end
	end

	local var_3_6

	if var_3_1 then
		local var_3_5 = var_3_1

		if not var_3_1.isEnd(var_3_5) then
			getProxy = var_3_6
			TaskProxy = var_3_5
			var_3_6 = var_3_6(var_3_5)

			local var_3_7 = var_3_1
			local var_3_8 = var_3_1.getConfig(var_3_7, "config_client").taskGroup

			ipairs = var_3_7

			for iter_3_2, iter_3_3 in var_3_7(var_3_8) do
				ipairs = var_1_10011

				for iter_3_4, iter_3_5 in var_1_10011(iter_3_3) do
					assert = var_1_10016

					var_1_10016(var_3_6:getTaskVO(iter_3_5), "without this task:" .. iter_3_5)

					local var_3_9 = var_3_6:getTaskVO(iter_3_5)

					if var_1_10016.getTaskStatus(var_3_9) == 1 then
						var_3_0 = true

						break
					end
				end
			end
		end
	end

	setActive = var_3_6

	var_3_6(arg_3_0.tipTr.gameObject, var_3_0)

	return
end

return var_0_1
