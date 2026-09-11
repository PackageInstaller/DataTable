local ReversePacmanTaskMediator = class("ReversePacmanTaskMediator", import("view.base.ContextMediator"))

ReversePacmanTaskMediator.ON_TASK_GO = "ReversePacmanTaskMediator::ON_TASK_GO"
ReversePacmanTaskMediator.ON_TASK_SUBMIT = "ReversePacmanTaskMediator::ON_TASK_SUBMIT"
ReversePacmanTaskMediator.ON_ACTIVITY_TASK_SUBMIT_ONESTEP = "ReversePacmanTaskMediator::ON_ACTIVITY_TASK_SUBMIT_ONESTEP"

function ReversePacmanTaskMediator:register()
	self:bind(ReversePacmanTaskMediator.ON_TASK_GO, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	self:bind(ReversePacmanTaskMediator.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_3_1.id)

		return
	end)
	self:bind(ReversePacmanTaskMediator.ON_ACTIVITY_TASK_SUBMIT_ONESTEP, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_4_1,
			task_ids = arg_4_2
		})

		return
	end)

	return
end

function ReversePacmanTaskMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.SUBMIT_TASK_DONE] = function(arg_6_0, arg_6_1)
			arg_6_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_6_1:getBody().awards)
			arg_6_0.viewComponent:RefreshUI()
			arg_6_0:sendNotification(GAME.REVERSE_PACMAN_REFRESH_TIP)

			return
		end,
		[GAME.SUBMIT_ACTIVITY_TASK_DONE] = function(arg_7_0, arg_7_1)
			arg_7_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_7_1:getBody().awards)
			arg_7_0.viewComponent:RefreshUI()
			arg_7_0:sendNotification(GAME.REVERSE_PACMAN_REFRESH_TIP)

			return
		end,
		[GAME.TOTAL_TASK_UPDATED] = function(arg_8_0, arg_8_1)
			arg_8_0.viewComponent:RefreshUI()
			arg_8_0:sendNotification(GAME.REVERSE_PACMAN_REFRESH_TIP)

			return
		end
	}

	return
end

function ReversePacmanTaskMediator:remove()
	return
end

return ReversePacmanTaskMediator
