class = var_0_10000

local var_0_0 = "TrainingCampMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_GET = "TrainingCampMediator:ON_GET"
var_0_1.ON_GO = "TrainingCampMediator:ON_GO"
var_0_1.ON_TRIGGER = "TrainingCampMediator:ON_TRIGGER"
var_0_1.ON_SELECTABLE_GET = "TrainingCampMediator:ON_SELECTABLE_GET"
var_0_1.ON_UPDATE = "TrainingCampMediator:ON_UPDATE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_UPDATE, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.UPDATE_TASK_PROGRESS, {
			taskId = arg_2_1.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SELECTABLE_GET, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10006

		var_3_1(var_3_0, var_2_10006.SUBMIT_TASK, {
			taskId = arg_3_1.id,
			index = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_GET, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.SUBMIT_TASK, arg_4_1.id)

		return
	end)
	arg_1_0:bind(var_0_1.ON_GO, function(arg_5_0, arg_5_1)
		if arg_5_1:getConfig("scene") and #var_2 > 0 then
			if var_2[1] == "LEVEL" and var_2[2] and var_2[2].chapterid then
				local var_5_0 = arg_1_0

				var_3.goToLevel(var_5_0, var_2[2].chapterid)
			else
				SCENE = var_3

				if var_3[var_2[1]] then
					local var_5_1 = arg_1_0
					local var_5_2 = var_3.sendNotification

					GAME = var_2_10006
					var_2_10006 = var_2_10006.GO_SCENE
					SCENE = var_2_10007

					var_5_2(var_5_1, var_2_10006, var_2_10007[var_2[1]], var_2[2])
				end
			end
		else
			local var_5_3 = arg_1_0
			local var_5_4 = var_3.sendNotification

			GAME = var_2_10006

			var_5_4(var_5_3, var_2_10006.TASK_GO, {
				taskVO = arg_5_1
			})
		end

		return
	end)
	arg_1_0:bind(var_0_1.ON_TRIGGER, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10005

		var_6_1(var_6_0, var_2_10005.ACTIVITY_OPERATION, arg_6_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	TaskProxy = var_1_10002
	var_7_0[1] = var_1_10002.TASK_UPDATED
	TaskProxy = var_2
	var_7_0[2] = var_2.TASK_REMOVED
	TaskProxy = var_2
	var_7_0[3] = var_2.TASK_DELETE
	GAME = var_2
	var_7_0[4] = var_2.SUBMIT_TASK_DONE
	ActivityProxy = var_2
	var_7_0[5] = var_2.ACTIVITY_OPERATION_DONE

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.getName(var_8_0)
	local var_8_2 = arg_8_1:getBody()

	TaskProxy = var_8_0

	if var_8_1 ~= var_8_0.TASK_UPDATED then
		TaskProxy = var_4

		if var_8_1 ~= var_4.TASK_REMOVED then
			TaskProxy = var_4

			if var_8_1 == var_4.TASK_DELETE then
				local var_8_3 = arg_8_0.viewComponent

				var_4.switchPageByMediator(var_8_3)

				local var_8_4 = arg_8_0.viewComponent

				var_4.updateSwitchBtnsTag(var_8_4)
			else
				GAME = var_4

				local var_8_6

				if var_8_1 == var_4.SUBMIT_TASK_DONE then
					local var_8_5 = arg_8_0.viewComponent

					var_8_6 = var_8_6.emit
					BaseUI = var_1_10007

					var_8_6(var_8_5, var_1_10007.ON_ACHIEVE, var_8_2)

					local var_8_7 = arg_8_0.viewComponent

					var_8_6.switchPageByMediator(var_8_7)

					local var_8_8 = arg_8_0.viewComponent

					var_8_6.updateSwitchBtnsTag(var_8_8)
				else
					ActivityProxy = var_8_6

					if var_8_1 == var_8_6.ACTIVITY_OPERATION_DONE then
						local var_8_9 = arg_8_0.viewComponent

						var_4.tryShowTecFixTip(var_8_9, var_8_2)

						local var_8_10 = arg_8_0.viewComponent

						var_4.switchPageByMediator(var_8_10)

						local var_8_11 = arg_8_0.viewComponent

						var_4.updateSwitchBtnsTag(var_8_11)
					end
				end
			end

			return
		end
	end
end

return var_0_1
