class = var_0_10000

local var_0_0 = "ClueBookMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_TASK_SUBMIT_ONESTEP = "ClueBookMediator.ON_TASK_SUBMIT_ONESTEP"
var_0_1.OPEN_SINGLE_CLUE_GROUP = "ClueBookMediator.OPEN_SINGLE_CLUE_GROUP"
var_0_1.OPEN_CLUE_JUMP = "ClueBookMediator.OPEN_CLUE_JUMP"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT_ONESTEP, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0
		local var_2_1 = var_4.sendNotification

		GAME = var_2_10007

		var_2_1(var_2_0, var_2_10007.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_2_1,
			task_ids = arg_2_2,
			callback = arg_2_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_SINGLE_CLUE_GROUP, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_3_2 = var_2_10005.New
		local var_3_3 = {}

		ClueGroupSingleView = var_2_10008
		var_3_3.viewComponent = var_2_10008
		ClueGroupSingleMediator = var_2_10008
		var_3_3.mediator = var_2_10008
		var_3_3.data = {
			clueGroupId = arg_3_1
		}

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CLUE_JUMP, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		ClueMapMediator = var_2_10005

		var_4_1(var_4_0, var_2_10005.OPEN_CLUE_JUMP, {
			jumpID = arg_4_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.SUBMIT_ACTIVITY_TASK_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1:getBody()

	GAME = var_6_0

	if var_6_1 == var_6_0.SUBMIT_ACTIVITY_TASK_DONE then
		if #var_6_2.awards > 0 then
			local var_6_3 = arg_6_0.viewComponent
			local var_6_4 = var_4.emit

			BaseUI = var_1_10007

			var_6_4(var_6_3, var_1_10007.ON_ACHIEVE, var_6_2.awards)
		end

		local var_6_5 = arg_6_0.viewComponent

		var_4.UpdateView(var_6_5)
	end

	return
end

return var_0_1
