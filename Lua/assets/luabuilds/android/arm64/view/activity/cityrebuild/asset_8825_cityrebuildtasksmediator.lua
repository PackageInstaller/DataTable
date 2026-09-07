local CityRebuildTasksMediator = class("CityRebuildTasksMediator", import("view.base.ContextMediator"))

CityRebuildTasksMediator.ON_SUBMIT_TASK = "CityRebuildTasksMediator.ON_SUBMIT_TASK"
CityRebuildTasksMediator.ON_TASK_SUBMIT_ONESTEP = "CityRebuildTasksMediator.ON_TASK_SUBMIT_ONESTEP"
CityRebuildTasksMediator.ON_TASK_GO = "CityRebuildTasksMediator.ON_TASK_GO"
CityRebuildTasksMediator.STORE_ACTIVITY_AWARDS = "CityRebuildTasksMediator.STORE_ACTIVITY_AWARDS"

function CityRebuildTasksMediator:register()
	self:BindEvent()

	self.submitTaskIndex = 0
	self.tempAwards = {}

	return
end

function CityRebuildTasksMediator:BindEvent()
	self:bind(CityRebuildTasksMediator.ON_SUBMIT_TASK, function(arg_3_0, arg_3_1, arg_3_2)
		self.submitTaskIndex = self.submitTaskIndex + 1

		self:sendNotification(GAME.SUBMIT_TASK, arg_3_1, arg_3_2)

		return
	end)
	self:bind(CityRebuildTasksMediator.ON_TASK_SUBMIT_ONESTEP, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		self.submitTaskIndex = self.submitTaskIndex + 1

		self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_4_1,
			task_ids = arg_4_2,
			callback = arg_4_3
		})

		return
	end)
	self:bind(CityRebuildTasksMediator.ON_TASK_GO, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_5_1
		})

		return
	end)
	self:bind(CityRebuildTasksMediator.STORE_ACTIVITY_AWARDS, function(arg_6_0, arg_6_1, arg_6_2)
		self.storeActivityAwardFlag = arg_6_1
		self.taskCount = arg_6_2

		return
	end)

	return
end

function CityRebuildTasksMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_TASK_AWARD_DOWN,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function CityRebuildTasksMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GAME.SUBMIT_TASK_AWARD_DOWN then
		self.submitTaskIndex = self.submitTaskIndex - 1

		if #var_8_1.awards > 0 then
			for iter_8_0, iter_8_1 in ipairs(var_8_1.awards) do
				table.insert(self.tempAwards, iter_8_1)
			end
		end

		onNextTick(function()
			if self.submitTaskIndex == 0 and #self.tempAwards > 0 then
				self.viewComponent:emit(BaseUI.ON_ACHIEVE, self.tempAwards, function()
					self.viewComponent:InitData()

					return
				end)

				self.tempAwards = {}
			end

			return
		end)
	elseif var_8_0 == ActivityProxy.ACTIVITY_UPDATED then
		onNextTick(function()
			if self.submitTaskIndex == 0 and #self.tempAwards > 0 then
				self.viewComponent:InitData()
			end

			return
		end)
	end

	return
end

return CityRebuildTasksMediator
