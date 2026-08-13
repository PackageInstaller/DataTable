class = var_0_10000

local var_0_0 = "AnniversaryIslandSpringTask2023Mediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.SUBMIT_TASK = "activity submit task "
var_0_1.TASK_GO = "activity task go "
var_0_1.SHOW_DETAIL = "activity task show detail"
var_0_1.SHOW_SUBMIT_WINDOW = "AnniversaryIslandSpringTask2023Mediator:SHOW_SUBMIT_WINDOW"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.SUBMIT_TASK, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_2_1.actId,
			task_ids = {
				arg_2_1.id
			}
		})

		return
	end)
	arg_1_0:bind(var_0_1.TASK_GO, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.TASK_GO, {
			taskVO = arg_3_1.taskVO
		})

		return
	end)
	arg_1_0:bind(var_0_1.SHOW_DETAIL, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_4_2 = var_2_10004.New
		local var_4_3 = {}

		WorkBenchItemDetailMediator = var_2_10006
		var_4_3.mediator = var_2_10006
		WorkBenchItemDetailLayer = var_2_10006
		var_4_3.viewComponent = var_2_10006
		var_4_3.data = {
			material = arg_4_1
		}

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)
	arg_1_0:bind(var_0_1.SHOW_SUBMIT_WINDOW, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_5_2 = var_2_10004.New
		local var_5_3 = {}

		AnniversaryIslandSpringTaskSubmitWindowMediator = var_2_10006
		var_5_3.mediator = var_2_10006
		AnniversaryIslandSpringTaskSubmitWindow = var_2_10006
		var_5_3.viewComponent = var_2_10006
		var_5_3.data = {
			task = arg_5_1
		}

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_6_0)
	local var_6_0 = {}

	AnniversaryIslandSpringTask2023Mediator = var_1_10002
	var_6_0[1] = var_1_10002.SUBMIT_TASK
	GAME = var_2
	var_6_0[2] = var_2.SUBMIT_ACTIVITY_TASK_DONE
	ActivityProxy = var_2
	var_6_0[3] = var_2.ACTIVITY_UPDATED

	return var_6_0
end

function var_0_1.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1
	local var_7_2 = arg_7_1.getBody(var_7_1)

	AnniversaryIslandSpringTask2023Mediator = var_7_1

	local var_7_4

	if var_7_0 == var_7_1.SUBMIT_TASK then
		local var_7_3 = arg_7_0.viewComponent

		var_7_4 = var_7_4.emit
		AnniversaryIslandSpringTask2023Mediator = var_1_10006

		var_7_4(var_7_3, var_1_10006.SUBMIT_TASK, var_7_2)
	else
		GAME = var_7_4

		local var_7_6

		if var_7_0 == var_7_4.SUBMIT_ACTIVITY_TASK_DONE then
			local var_7_5 = arg_7_0.viewComponent

			var_7_6 = var_7_6.emit
			BaseUI = var_1_10006

			var_7_6(var_7_5, var_1_10006.ON_ACHIEVE, var_7_2.awards, function()
				existCall = var_2_10000

				var_2_10000(var_7_2.callback)

				getProxy = var_2_10000
				ActivityProxy = var_1

				local var_8_0 = var_2_10000(var_1)
				local var_8_1 = var_0.getActivityByType

				ActivityConst = var_2_10002

				local var_8_2 = var_8_1(var_8_0, var_2_10002.ACTIVITY_TYPE_HOTSPRING_2)
				local var_8_3 = var_0.GetUnlockTaskIds(var_8_2)
				local var_8_4 = var_0
				local var_8_5 = var_0.GetConfigID(var_8_4)

				getProxy = var_8_4
				ActivityTaskProxy = var_2_10004

				local var_8_6 = var_8_4(var_2_10004)
				local var_8_7 = var_3.getTaskVOsByActId(var_8_6, var_8_5)

				_ = var_8_6

				if var_8_6.all(var_8_3, function(arg_9_0)
					_ = var_3_10001

					return var_3_10001.detect(var_8_7, function(arg_10_0)
						return arg_10_0:GetConfigID() == arg_9_0
					end) and var_1:isOver()
				end) then
					local var_8_8 = arg_7_0
					local var_8_9 = var_4.sendNotification

					GAME = var_6

					local var_8_10 = var_6.CHANGE_SCENE

					SCENE = var_2_10007

					var_8_9(var_8_8, var_8_10, var_2_10007.ANNIVERSARY_ISLAND_SPRING)
				end

				return
			end)
		else
			ActivityProxy = var_7_6

			if var_7_0 == var_7_6.ACTIVITY_UPDATED then
				local var_7_7 = arg_7_0.viewComponent

				var_4.BuildTaskVOs(var_7_7)

				local var_7_8 = arg_7_0.viewComponent

				var_4.UpdateView(var_7_8)
			end
		end
	end

	return
end

function var_0_1.remove(arg_11_0)
	return
end

return var_0_1
