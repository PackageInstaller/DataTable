class = var_0_10000

local var_0_0 = "CrusingTaskMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_TASK_GO = "CrusingTaskMediator.ON_TASK_GO"
var_0_1.ON_TASK_SUBMIT = "CrusingTaskMediator.ON_TASK_SUBMIT"
var_0_1.ON_TASK_QUICK_SUBMIT = "CrusingTaskMediator.ON_TASK_QUICK_SUBMIT"
var_0_1.ON_BUY_QUICK_TASK_ITEM = "CrusingTaskMediator.ON_BUY_QUICK_TASK_ITEM"
var_0_1.ON_EXIT = "CrusingTaskMediator.ON_EXIT"
var_0_1.quickTaskGoodId = 61017

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_TASK_GO, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.SUBMIT_TASK, arg_3_1.id)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_QUICK_SUBMIT, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.QUICK_TASK, arg_4_1.id)

		return
	end)
	arg_1_0:bind(var_0_1.ON_BUY_QUICK_TASK_ITEM, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.SHOPPING, {
			id = var_0_1.quickTaskGoodId,
			count = arg_5_1
		})

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_EXIT, function(arg_6_0)
		local var_6_0 = arg_1_0
		local var_6_1 = var_1.sendNotification

		CrusingMediator = var_2_10004

		var_6_1(var_6_0, var_2_10004.UNFROZEN_MAP_UPDATE)

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getAliveActivityByType

	ActivityConst = var_4

	local var_1_3 = var_1_2(var_1_1, var_4.ACTIVITY_TYPE_PT_CRUSING)
	local var_1_4 = arg_1_0.viewComponent

	var_2.setActivity(var_1_4, var_1_3)

	updateCrusingActivityTask = var_2

	var_2(var_1_3)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	ActivityProxy = var_1_10002
	var_7_0[1] = var_1_10002.ACTIVITY_UPDATED
	BagProxy = var_2
	var_7_0[2] = var_2.ITEM_UPDATED
	GAME = var_2
	var_7_0[3] = var_2.SUBMIT_TASK_DONE
	GAME = var_2
	var_7_0[4] = var_2.SUBMIT_ACTIVITY_TASK_DONE

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1
	local var_8_2 = arg_8_1.getBody(var_8_1)
	local var_8_3 = arg_8_1
	local var_8_4 = arg_8_1.getType(var_8_3)

	ActivityProxy = var_8_1

	local var_8_7

	if var_8_0 == var_8_1.ACTIVITY_UPDATED then
		if var_8_2.id == arg_8_0.viewComponent.activity.id then
			local var_8_5 = arg_8_0.viewComponent

			var_8_7.setActivity(var_8_5, var_8_2)

			if arg_8_0.viewComponent.phase == #arg_8_0.viewComponent.awardList then
				pg = var_8_7

				local var_8_6 = var_8_7.TipsMgr.GetInstance()

				var_8_7 = var_8_7.ShowTips
				i18n = var_8

				var_8_7(var_8_6, var_8("battlepass_complete"))

				local var_8_8 = arg_8_0.viewComponent

				var_8_7.closeView(var_8_8)
			else
				local var_8_9 = arg_8_0.viewComponent

				var_8_7.updatePhaseInfo(var_8_9)
			end
		end

		goto label_8_0
	end

	BagProxy = var_8_7

	local var_8_10

	if var_8_0 == var_8_7.ITEM_UPDATED then
		var_8_10 = var_8_2.id
		Item = var_8_3

		if var_8_10 == var_8_3.QUICK_TASK_PASS_TICKET_ID then
			local var_8_11 = arg_8_0.viewComponent

			var_8_10.updateItemInfo(var_8_11)
		end

		goto label_8_0
	end

	GAME = var_8_10

	if var_8_0 ~= var_8_10.SUBMIT_TASK_DONE then
		GAME = var_5

		if var_8_0 == var_5.SUBMIT_ACTIVITY_TASK_DONE then
			local var_8_12 = {}

			ipairs = var_8_3

			for iter_8_0, iter_8_1 in var_8_3(var_8_4) do
				var_8_12[iter_8_1] = true
			end

			underscore = var_6

			if var_6.any(arg_8_0.viewComponent.tempTaskGroup, function(arg_9_0)
				underscore = var_2_10001

				return var_2_10001.any(arg_9_0, function(arg_10_0)
					return var_8_12[arg_10_0.id]
				end)
			end) then
				local var_8_13 = arg_8_0.viewComponent

				var_6.updateCurrentTaskGroup(var_8_13)
			end
		end

		::label_8_0::

		return
	end
end

return var_0_1
