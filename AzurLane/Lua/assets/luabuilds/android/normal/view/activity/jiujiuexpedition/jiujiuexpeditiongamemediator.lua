class = var_0_10000

local var_0_0 = "JiuJiuExpeditionGameMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.OPEN_LAYER = "OPEN_LAYER"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OPEN_LAYER, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0

		var_2.addSubLayers(var_2_0, arg_2_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	ActivityProxy = var_1_10002
	var_3_0[1] = var_1_10002.ACTIVITY_UPDATED
	GAME = var_2
	var_3_0[2] = var_2.BEGIN_STAGE_DONE
	ActivityProxy = var_2
	var_3_0[3] = var_2.ACTIVITY_SHOW_AWARDS
	table = var_2

	var_2.insertto(var_3_0, var_0_1.super.listNotificationInterests(arg_3_0))

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	var_0_1.super.handleNotification(arg_4_0, arg_4_1)

	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	ActivityProxy = var_4_1

	local var_4_4

	if var_4_0 == var_4_1.ACTIVITY_UPDATED then
		local var_4_3 = var_4_2

		var_4_4 = var_4_2.getConfig(var_4_3, "type")
		ActivityConst = var_4_3

		if var_4_4 == var_4_3.ACTIVITY_TYPE_EXPEDITION then
			local var_4_5 = arg_4_0.viewComponent

			var_4_4.activityUpdate(var_4_5)

			goto label_4_0
		end
	end

	GAME = var_4_4

	do
		local var_4_7

		if var_4_0 == var_4_4.BEGIN_STAGE_DONE then
			local var_4_6 = arg_4_0

			var_4_7 = arg_4_0.sendNotification
			GAME = var_1_10006
			var_1_10006 = var_1_10006.GO_SCENE
			SCENE = var_1_10007

			var_4_7(var_4_6, var_1_10006, var_1_10007.COMBATLOAD, var_4_2)
		else
			ActivityProxy = var_4_7

			if var_4_0 == var_4_7.ACTIVITY_SHOW_AWARDS then
				local var_4_8 = arg_4_0.viewComponent
				local var_4_9 = var_4.emit

				BaseUI = var_1_10006

				var_4_9(var_4_8, var_1_10006.ON_ACHIEVE, var_4_2.awards, var_4_2.callback)
			end
		end
	end

	::label_4_0::

	return
end

return var_0_1
