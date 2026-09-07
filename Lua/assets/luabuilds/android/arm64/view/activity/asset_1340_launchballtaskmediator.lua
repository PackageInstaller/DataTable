local LaunchBallTaskMediator = class("LaunchBallTaskMediator", import("..base.ContextMediator"))

LaunchBallTaskMediator.SUBMIT_ALL = "SUBMIT_ALL"

function LaunchBallTaskMediator:register()
	self:bind(LaunchBallTaskMediator.SUBMIT_ALL, function(arg_2_0, arg_2_1)
		self.submit = #arg_2_1
		self.awards = {}

		for iter_2_0 = 1, #arg_2_1 do
			self:sendNotification(GAME.SUBMIT_TASK, arg_2_1[iter_2_0].id)
		end

		return
	end)

	return
end

function LaunchBallTaskMediator:onUIAvalible()
	return
end

function LaunchBallTaskMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_TASK_DONE
	}
end

function LaunchBallTaskMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		if #var_5_1.awards > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_1.awards)
		end

		if var_5_1.callback then
			-- block empty
		end

		self.viewComponent:updateTask(true)
	elseif var_5_0 == GAME.SUBMIT_TASK_DONE then
		if self.submit and self.submit > 0 then
			for iter_5_0 = 1, #var_5_1 do
				table.insert(self.awards, var_5_1[iter_5_0])
			end

			self.submit = self.submit - 1

			if self.submit == 0 then
				self.viewComponent:emit(BaseUI.ON_ACHIEVE, self.awards, function()
					self.viewComponent:updateTasks()

					return
				end)
			end
		else
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_1, function()
				self.viewComponent:updateTasks()

				return
			end)
		end
	end

	return
end

return LaunchBallTaskMediator
