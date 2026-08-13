class = var_0_10000

local var_0_0 = "PSSHei5Mediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.EVENT_GET_AWARD_ALL = "PSSHei5Mediator.EVENT_GET_AWARD_ALL"
var_0_1.EVENT_OPEN_BIRTHDAY = "PSSHei5Mediator.EVENT_OPEN_BIRTHDAY"
var_0_1.ON_TASK_GO = "PSSHei5Mediator.ON_TASK_GO"
var_0_1.ON_TASK_SUBMIT = "PSSHei5Mediator.ON_TASK_SUBMIT"
var_0_1.ON_TASK_QUICK_SUBMIT = "PSSHei5Mediator.ON_TASK_QUICK_SUBMIT"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.EVENT_GET_AWARD_ALL, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10003

		var_2_1(var_2_0, var_2_10003.CRUSING_CMD, {
			cmd = 1,
			activity_id = arg_1_0.viewComponent.activity.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.EVENT_OPEN_BIRTHDAY, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_3_2 = var_2_10004.New
		local var_3_3 = {}

		ChargeBirthdayMediator = var_2_10006
		var_3_3.mediator = var_2_10006
		ChargeBirthdayLayer = var_2_10006
		var_3_3.viewComponent = var_2_10006
		var_3_3.data = {}

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_GO, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.TASK_GO, {
			taskVO = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10004

		var_5_1(var_5_0, var_2_10004.SUBMIT_TASK, arg_5_1.id)

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_TASK_QUICK_SUBMIT, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		var_6_1(var_6_0, var_2_10004.QUICK_TASK, arg_6_1.id)

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getAliveActivityByType

	ActivityConst = var_3

	local var_1_3 = var_1_2(var_1_1, var_3.ACTIVITY_TYPE_PT_HEI5)
	local var_1_4 = arg_1_0.viewComponent

	var_2.setActivity(var_1_4, var_1_3)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	ActivityProxy = var_1_10002
	var_7_0[1] = var_1_10002.ACTIVITY_UPDATED
	GAME = var_2
	var_7_0[2] = var_2.CRUSING_CMD_DONE
	GAME = var_2
	var_7_0[3] = var_2.CHARGE_SUCCESS
	GAME = var_2
	var_7_0[4] = var_2.SUBMIT_TASK_DONE
	GAME = var_2
	var_7_0[5] = var_2.SUBMIT_ACTIVITY_TASK_DONE

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1
	local var_8_2 = arg_8_1.getBody(var_8_1)

	ActivityProxy = var_8_1

	if var_8_0 == var_8_1.ACTIVITY_UPDATED then
		if var_8_2.id == arg_8_0.viewComponent.activity.id then
			local var_8_3 = arg_8_0.viewComponent

			var_4.setActivity(var_8_3, var_8_2)

			local var_8_4 = arg_8_0.viewComponent

			var_4.UpdatePhase(var_8_4)

			local var_8_5 = arg_8_0.viewComponent

			var_4.UpdateAwardPage(var_8_5)

			local var_8_6 = arg_8_0.viewComponent

			var_4.UpdateTaskPage(var_8_6)

			local var_8_7 = arg_8_0.viewComponent

			var_4.UpdateView(var_8_7)
		end

		goto label_8_0
	end

	GAME = var_4

	local var_8_9

	if var_8_0 == var_4.CRUSING_CMD_DONE then
		local var_8_8 = arg_8_0.viewComponent

		var_8_9 = var_8_9.emit
		BaseUI = var_1_10006

		var_8_9(var_8_8, var_1_10006.ON_ACHIEVE, var_8_2.awards)

		local var_8_10 = arg_8_0.viewComponent

		var_8_9.UpdateAwardPage(var_8_10)

		local var_8_11 = arg_8_0.viewComponent

		var_8_9.UpdateView(var_8_11)

		goto label_8_0
	end

	GAME = var_8_9

	local var_8_12

	if var_8_0 == var_8_9.CHARGE_SUCCESS then
		Goods = var_8_12
		var_8_12 = var_8_12.Create

		local var_8_13 = {
			shop_id = var_8_2.shopId
		}

		Goods = var_6
		var_8_12 = var_8_12(var_8_13, var_6.TYPE_CHARGE)

		local var_8_14 = arg_8_0.viewComponent

		var_5.OnChargeSuccess(var_8_14, var_8_12)

		goto label_8_0
	end

	GAME = var_8_12

	if var_8_0 ~= var_8_12.SUBMIT_TASK_DONE then
		GAME = var_4

		if var_8_0 == var_4.SUBMIT_ACTIVITY_TASK_DONE then
			local var_8_15 = arg_8_0.viewComponent

			var_4.UpdateTaskPage(var_8_15)

			local var_8_16 = arg_8_0.viewComponent

			var_4.UpdateView(var_8_16)
		end

		::label_8_0::

		return
	end
end

return var_0_1
