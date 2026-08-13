class = var_0_10000

local var_0_0 = "CastleMainMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.CASTLE_ACT_OP = "castle act op"
var_0_1.ADD_ITEM = "add item"
var_0_1.UPDATE_ACTIVITY = "update activity"
var_0_1.CASTLE_FIRST_STORY_OP_DONE = "castle first story op done"
var_0_1.ON_TASK_SUBMIT = "on task submit"
var_0_1.UPDATE_GUIDE = "CastleMainMediator.UPDATE_GUIDE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.CASTLE_ACT_OP, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.CASTLE_ACT_OP, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.SUBMIT_TASK_ONESTEP, {
			resultList = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ADD_ITEM, function(arg_4_0, arg_4_1)
		return
	end)
	arg_1_0:bind(var_0_1.UPDATE_ACTIVITY, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10004

		var_5_1(var_5_0, var_2_10004.ACTIVITY_OPERATION, {
			cmd = 2,
			activity_id = arg_5_1.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.UPDATE_GUIDE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		var_6_1(var_6_0, var_2_10004.STORY_UPDATE, {
			storyId = arg_6_1
		})

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_7_0)
	local var_7_0 = {}

	GAME = var_1_10002
	var_7_0[var_1_10002.CASTLE_STORY_OP_DONE] = function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_1:getBody()
		local var_8_1 = arg_8_0.viewComponent

		var_3.StoryActEnd(var_8_1, var_8_0.number[1])

		return
	end
	GAME = var_2
	var_7_0[var_2.CASTLE_DICE_OP_DONE] = function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_1:getBody()
		local var_9_1 = arg_9_0.viewComponent

		var_3.RollDice(var_9_1, var_9_0.number[1], var_9_0.number[2])

		return
	end
	GAME = var_2
	var_7_0[var_2.CASTLE_FIRST_STORY_OP_DONE] = function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0.viewComponent

		var_2.FirstStory(var_10_0)

		return
	end
	GAME = var_2
	var_7_0[var_2.SUBMIT_TASK_DONE] = function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_1:getBody()
		local var_11_1 = arg_11_0.viewComponent
		local var_11_2 = var_3.emit

		BaseUI = var_2_10005

		var_11_2(var_11_1, var_2_10005.ON_ACHIEVE, var_11_0, function()
			local var_12_0 = arg_11_0.viewComponent

			var_0.UpdateFlush(var_12_0)

			return
		end)

		return
	end
	arg_7_0.handleDic = var_7_0

	return
end

return var_0_1
