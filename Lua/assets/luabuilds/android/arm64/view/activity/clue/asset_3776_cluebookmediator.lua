local ClueBookMediator = class("ClueBookMediator", import("view.base.ContextMediator"))

ClueBookMediator.ON_TASK_SUBMIT_ONESTEP = "ClueBookMediator.ON_TASK_SUBMIT_ONESTEP"
ClueBookMediator.OPEN_SINGLE_CLUE_GROUP = "ClueBookMediator.OPEN_SINGLE_CLUE_GROUP"
ClueBookMediator.OPEN_CLUE_JUMP = "ClueBookMediator.OPEN_CLUE_JUMP"

function ClueBookMediator:register()
	self:bind(ClueBookMediator.ON_TASK_SUBMIT_ONESTEP, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_2_1,
			task_ids = arg_2_2,
			callback = arg_2_3
		})

		return
	end)
	self:bind(ClueBookMediator.OPEN_SINGLE_CLUE_GROUP, function(arg_3_0, arg_3_1)
		self:addSubLayers(Context.New({
			viewComponent = ClueGroupSingleView,
			mediator = ClueGroupSingleMediator,
			data = {
				clueGroupId = arg_3_1
			}
		}))

		return
	end)
	self:bind(ClueBookMediator.OPEN_CLUE_JUMP, function(arg_4_0, arg_4_1)
		self:sendNotification(ClueMapMediator.OPEN_CLUE_JUMP, {
			jumpID = arg_4_1
		})

		return
	end)

	return
end

function ClueBookMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function ClueBookMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getBody()

	if arg_6_1:getName() == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		if #var_6_0.awards > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_0.awards)
		end

		self.viewComponent:UpdateView()
	end

	return
end

return ClueBookMediator
