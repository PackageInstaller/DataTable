class = var_0_10000

local var_0_0 = "CollectionBookMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

ActivityConst = var_0_0
var_0_1.ACT_ID = var_0_0.HOLIDAY_ACT_ID

function var_0_1.register(arg_1_0)
	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	local var_2_0 = {}

	GAME = var_1_10002
	var_2_0[1] = var_1_10002.SUBMIT_TASK_AWARD_DOWN

	return var_2_0
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1
	local var_3_2 = arg_3_1.getBody(var_3_1)

	GAME = var_3_1

	if var_3_0 == var_3_1.SUBMIT_TASK_AWARD_DOWN then
		local var_3_3 = arg_3_0.viewComponent
		local var_3_4 = var_4.emit

		BaseUI = var_1_10006

		var_3_4(var_3_3, var_1_10006.ON_ACHIEVE, var_3_2.awards, function()
			local var_4_0 = arg_3_0.viewComponent

			var_0.updateAwardPanel(var_4_0)

			local var_4_1 = arg_3_0.viewComponent

			var_0.updateTag(var_4_1)

			return
		end)
	end

	return
end

function var_0_1.GetCollectionBookTip()
	CollectionBookMediator = var_1_10000

	local var_5_0 = var_1_10000.ACT_ID

	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_5_1 = var_1_10001(var_1_10002)
	local var_5_2 = var_1.getActivityById(var_5_1, var_5_0)
	local var_5_3 = var_1.getConfig(var_5_2, "config_client").collect_task

	for iter_5_0 = 1, #var_5_3 do
		getProxy = var_1_10007
		TaskProxy = var_1_10008
		var_1_10008 = var_1_10007(var_1_10008)

		if var_1_10007.getTaskById(var_1_10008, var_5_3[iter_5_0]) and var_1_10007:getTaskStatus() == 1 then
			return true
		end
	end

	return false
end

return var_0_1
