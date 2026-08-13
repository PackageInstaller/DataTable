class = var_0_10000

local var_0_0 = "CommanderManualMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_TASK_GO = "CommanderManualMediator.ON_TASK_GO"
var_0_1.ON_TASK_SUBMIT = "CommanderManualMediator.ON_TASK_SUBMIT"
var_0_1.GET_PT_AWARD = "CommanderManualMediator.GET_PT_AWARD"
var_0_1.ON_TRIGGER = "CommanderManualMediator.ON_TRIGGER"
var_0_1.ON_UPDATE = "CommanderManualMediator.ON_UPDATE"

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
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10006

		var_3_1(var_3_0, var_2_10006.SUBMIT_TASK, {
			normal_submit = true,
			virtual = false,
			taskId = arg_3_1.id
		}, arg_3_2)

		return
	end)
	arg_1_0:bind(var_0_1.GET_PT_AWARD, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_4_2 = var_2_10005.COMMANDER_MANUAL_OP
		local var_4_3 = {}

		CommanderManualProxy = var_2_10007
		var_4_3.operation = var_2_10007.GET_PT_AWARD
		var_4_3.pageId = arg_4_1

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TRIGGER, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.ACTIVITY_OPERATION, arg_5_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_UPDATE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10005

		var_6_1(var_6_0, var_2_10005.UPDATE_TASK_PROGRESS, {
			taskId = arg_6_1.id
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	GAME = var_1_10002
	var_7_0[1] = var_1_10002.SUBMIT_TASK_DONE
	GAME = var_2
	var_7_0[2] = var_2.COMMANDER_MANUAL_OP_DONE
	ActivityProxy = var_2
	var_7_0[3] = var_2.ACTIVITY_OPERATION_DONE

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1
	local var_8_2 = arg_8_1.getBody(var_8_1)
	local var_8_3 = arg_8_1
	local var_8_4 = arg_8_1.getType(var_8_3)

	GAME = var_8_1

	local var_8_5

	if var_8_0 == var_8_1.SUBMIT_TASK_DONE then
		var_8_5 = #var_8_2

		if 0 < var_8_5 then
			var_1_10007 = arg_8_0.viewComponent
			var_8_5 = var_8_5.emit
			BaseUI = var_1_10008

			var_8_5(var_1_10007, var_1_10008.ON_ACHIEVE, var_8_2)
		end

		if arg_8_0.viewComponent.contextData.currentPageId then
			var_8_5 = var_8_4[1]
			getProxy = var_8_3
			CommanderManualProxy = var_1_10008
			var_1_10008 = var_8_3(var_1_10008)
			var_8_3 = var_8_3.GetPageById(var_1_10008, arg_8_0.viewComponent.contextData.currentPageId)
			table = var_1_10007

			if var_1_10007.contains(var_8_3.taskIdList, var_8_5) and not var_8_3:IsTaskComplete(var_8_5) then
				var_8_3:AddFinishedTaskId(var_8_5)
				var_8_3:AddPt()
			end
		end

		local var_8_6 = arg_8_0.viewComponent

		var_8_5.RefreshAll(var_8_6)
	else
		GAME = var_8_5

		local var_8_7

		if var_8_0 == var_8_5.COMMANDER_MANUAL_OP_DONE then
			var_8_7 = var_8_2.operation
			CommanderManualProxy = var_8_3

			if var_8_7 == var_8_3.GET_TASK then
				-- block empty
			else
				var_8_7 = var_8_2.operation
				CommanderManualProxy = var_6

				if var_8_7 == var_6.GET_PT_AWARD then
					local var_8_8 = arg_8_0.viewComponent

					var_8_7 = var_8_7.emit
					BaseUI = var_1_10008

					var_8_7(var_8_8, var_1_10008.ON_ACHIEVE, var_8_2.awards)
				end
			end

			local var_8_9 = arg_8_0.viewComponent

			var_8_7.RefreshAll(var_8_9)
		else
			ActivityProxy = var_8_7

			if var_8_0 == var_8_7.ACTIVITY_OPERATION_DONE and var_8_2 == arg_8_0.viewComponent.techActivity.id then
				local var_8_10 = arg_8_0.viewComponent

				var_5.UpdateTechActivity(var_8_10)

				isActive = var_5

				if var_5(arg_8_0.viewComponent.techPage) then
					local var_8_11 = arg_8_0.viewComponent

					var_5.ShowTechPage(var_8_11)
				end
			end
		end
	end

	return
end

return var_0_1
