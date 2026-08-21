local var_0_0 = class("ClueBookMediator", import("view.base.ContextMediator"))

var_0_0.ON_TASK_SUBMIT_ONESTEP = "ClueBookMediator.ON_TASK_SUBMIT_ONESTEP"
var_0_0.OPEN_SINGLE_CLUE_GROUP = "ClueBookMediator.OPEN_SINGLE_CLUE_GROUP"
var_0_0.OPEN_CLUE_JUMP = "ClueBookMediator.OPEN_CLUE_JUMP"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_TASK_SUBMIT_ONESTEP, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_2_1,
			task_ids = arg_2_2,
			callback = arg_2_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_SINGLE_CLUE_GROUP, function(arg_3_0, arg_3_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = ClueGroupSingleView,
			mediator = ClueGroupSingleMediator,
			data = {
				clueGroupId = arg_3_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CLUE_JUMP, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(ClueMapMediator.OPEN_CLUE_JUMP, {
			jumpID = arg_4_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getBody()

	if arg_6_1:getName() == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		if #var_6_0.awards > 0 then
			arg_6_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_0.awards)
		end

		arg_6_0.viewComponent:UpdateView()
	end

	return
end

return var_0_0
