class = var_0_10000

local var_0_0 = "AirForceOfDragonEmperyMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_BATTLE = "AirForceOfDragonEmperyMediator ON_BATTLE"
var_0_1.ON_ACTIVITY_OPREATION = "AirForceOfDragonEmperyMediator ON_ACTIVITY_OPREATION"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_BATTLE, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_2_2 = var_2_10005.BEGIN_STAGE
		local var_2_3 = {}

		SYSTEM_AIRFIGHT = var_2_10007
		var_2_3.system = var_2_10007
		var_2_3.stageId = arg_2_1

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_ACTIVITY_OPREATION, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.ACTIVITY_OPERATION, arg_3_1)

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_5

	local var_1_3 = var_1_2(var_1_1, var_5.ACTIVITY_TYPE_AIRFIGHT_BATTLE)

	var_2.RecordTip(var_1_3)

	local var_1_4 = arg_1_0.viewComponent

	var_3.SetActivityData(var_1_4, var_2)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	ActivityProxy = var_1_10002
	var_4_0[1] = var_1_10002.ACTIVITY_UPDATED
	GAME = var_2
	var_4_0[2] = var_2.BEGIN_STAGE_DONE
	ActivityProxy = var_2
	var_4_0[3] = var_2.ACTIVITY_SHOW_AWARDS

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getName(var_5_0)
	local var_5_2 = arg_5_1
	local var_5_3 = arg_5_1.getBody(var_5_2)

	ActivityProxy = var_5_0

	local var_5_4

	if var_5_1 == var_5_0.ACTIVITY_UPDATED then
		var_5_4 = var_5_3:getConfig("type")
		ActivityConst = var_5_2

		if var_5_4 == var_5_2.ACTIVITY_TYPE_AIRFIGHT_BATTLE then
			local var_5_5 = arg_5_0:getViewComponent()

			var_5_4.SetActivityData(var_5_5, var_5_3)

			local var_5_6 = arg_5_0:getViewComponent()

			var_5_4.UpdateView(var_5_6)
		end
	else
		GAME = var_5_4

		local var_5_8

		if var_5_1 == var_5_4.BEGIN_STAGE_DONE then
			local var_5_7 = arg_5_0

			var_5_8 = arg_5_0.sendNotification
			GAME = var_1_10007
			var_1_10007 = var_1_10007.GO_SCENE
			SCENE = var_1_10008

			var_5_8(var_5_7, var_1_10007, var_1_10008.COMBATLOAD, var_5_3)
		else
			ActivityProxy = var_5_8

			if var_5_1 == var_5_8.ACTIVITY_SHOW_AWARDS then
				local var_5_9 = arg_5_0.viewComponent
				local var_5_10 = var_4.emit

				BaseUI = var_1_10007

				var_5_10(var_5_9, var_1_10007.ON_ACHIEVE, var_5_3.awards, var_5_3.callback)
			end
		end
	end

	return
end

return var_0_1
