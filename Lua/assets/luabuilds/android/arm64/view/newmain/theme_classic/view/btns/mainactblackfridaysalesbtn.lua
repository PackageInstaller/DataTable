local var_0_0 = class("MainActBlackFridaySalesBtn", import(".MainBaseActivityBtn"))

function var_0_0.InShowTime(arg_1_0)
	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BLACK_FRIDAY_SHOP)

	return var_0_0.super.InShowTime(arg_1_0) and var_1_0 and not var_1_0:isEnd()
end

function var_0_0.GetEventName(arg_2_0)
	return "event_blackFriday"
end

function var_0_0.OnInit(arg_3_0)
	local var_3_0 = false
	local var_3_1

	for iter_3_0, iter_3_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_TASKS))) do
		if iter_3_1:getConfig("config_client").blackFriday then
			var_3_1 = iter_3_1

			break
		end
	end

	if var_3_1 and not var_3_1:isEnd() then
		local var_3_2 = getProxy(TaskProxy)

		for iter_3_2, iter_3_3 in ipairs(var_3_1:getConfig("config_client").taskGroup) do
			for iter_3_4, iter_3_5 in ipairs(iter_3_3) do
				assert(var_3_2:getTaskVO(iter_3_5), "without this task:" .. iter_3_5)

				local var_3_3 = var_3_2:getTaskVO(iter_3_5)

				if var_3_3:getTaskStatus() == 1 then
					var_3_0 = true

					break
				end
			end
		end
	end

	setActive(arg_3_0.tipTr.gameObject, var_3_0)

	return
end

return var_0_0
