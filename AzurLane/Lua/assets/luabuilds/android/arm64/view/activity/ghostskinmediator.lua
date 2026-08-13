class = var_0_10000

local var_0_0 = "GhostSkinMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.UnlockStoryDone = "GhostSkinMediator.UnlockStoryDone"
var_0_1.ON_TASK_SUBMIT = "event on task submit"
var_0_1.ON_TASK_GO = "event on task go"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.SUBMIT_TASK, arg_2_1.id, arg_2_2)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_GO, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.TASK_GO, {
			taskVO = arg_3_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {
		var_0_1.UnlockStoryDone
	}

	ActivityProxy = var_2
	var_4_0[2] = var_2.ACTIVITY_UPDATED
	GAME = var_2
	var_4_0[3] = var_2.SUBMIT_TASK_DONE
	GAME = var_2
	var_4_0[4] = var_2.SUBMIT_ACTIVITY_TASK_DONE
	GAME = var_2
	var_4_0[5] = var_2.ACTIVITY_STORYUNLOCKED_DONE

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getName(var_5_0)
	local var_5_2 = arg_5_1
	local var_5_3 = arg_5_1.getBody(var_5_2)

	GAME = var_5_0

	if var_5_1 == var_5_0.ACTIVITY_STORYUNLOCKED_DONE then
		local var_5_4 = arg_5_0.viewComponent

		var_4.UpdataStoryState(var_5_4, var_5_3)
	else
		ActivityProxy = var_4

		local var_5_5

		if var_5_1 == var_4.ACTIVITY_UPDATED then
			var_5_5 = var_5_3:getConfig("type")
			ActivityConst = var_5_2

			if var_5_5 == var_5_2.ACTIVITY_TYPE_TownSkinStory then
				local var_5_6 = arg_5_0.viewComponent

				var_5_5.UpdateItemView(var_5_6, var_5_3)
			end
		else
			GAME = var_5_5

			if var_5_1 == var_5_5.SUBMIT_ACTIVITY_TASK_DONE then
				local var_5_7 = arg_5_0.viewComponent
				local var_5_8 = var_4.emit

				BaseUI = var_1_10007

				var_5_8(var_5_7, var_1_10007.ON_ACHIEVE, var_5_3.awards, function()
					local var_6_0 = arg_5_0.viewComponent

					var_0.OnUpdateFlush(var_6_0, var_5_3)

					local var_6_1 = arg_5_0.viewComponent

					var_0.DisplayBigTask(var_6_1)

					return
				end)
			end
		end
	end

	return
end

return var_0_1
