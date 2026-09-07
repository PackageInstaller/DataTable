local ToLoveCollabTaskMediator = class("ToLoveCollabTaskMediator", import("view.base.ContextMediator"))

ToLoveCollabTaskMediator.ON_TASK_GO = "event on task go"
ToLoveCollabTaskMediator.ON_TASK_SUBMIT = "event on task submit"
ToLoveCollabTaskMediator.ON_TASK_SUBMIT_ONESTEP = "event on task submit one step"

function ToLoveCollabTaskMediator:register()
	self:bind(ToLoveCollabTaskMediator.ON_TASK_GO, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	self:bind(ToLoveCollabTaskMediator.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1, arg_3_2)
		seriesAsync({
			function(arg_4_0)
				self.awardIndex = 0
				self.showAwards = {}

				self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
					act_id = arg_3_1:getActId(),
					task_ids = {
						arg_3_1.id
					}
				}, arg_3_2)

				return
			end
		}, function()
			return
		end)

		return
	end)
	self:bind(ToLoveCollabTaskMediator.ON_TASK_SUBMIT_ONESTEP, function(arg_6_0, arg_6_1)
		seriesAsync({
			function(arg_7_0)
				self.awardIndex = 0
				self.showAwards = {}

				for iter_7_0, iter_7_1 in pairs((self:getSubmitDatas(arg_6_1))) do
					self.awardIndex = self.awardIndex + 1

					self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
						act_id = iter_7_0,
						task_ids = iter_7_1
					})
				end

				return
			end
		}, function()
			return
		end)

		return
	end)

	return
end

function ToLoveCollabTaskMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		GAME.ACTIVITY_UPDATED
	}
end

function ToLoveCollabTaskMediator:handleNotification(arg_10_1)
	local var_10_0 = arg_10_1:getName()

	if var_10_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		if self.awardIndex > 0 then
			self.awardIndex = self.awardIndex - 1
		end

		for iter_10_0, iter_10_1 in ipairs(arg_10_1:getBody().awards) do
			table.insert(self.showAwards, iter_10_1)
		end

		if self.awardIndex == 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, self.showAwards, function()
				self.viewComponent:Show()

				return
			end)

			self.showAwards = {}
		end
	elseif var_10_0 == GAME.ACTIVITY_UPDATED then
		self.viewComponent:Show()
	end

	return
end

function ToLoveCollabTaskMediator:getSubmitDatas(arg_12_1)
	local var_12_0 = getProxy(TaskProxy)
	local var_12_1 = {}

	for iter_12_0 = 1, #arg_12_1 do
		local var_12_2 = var_12_0:getTaskById(arg_12_1[iter_12_0])

		if var_12_2 and var_12_2:getActId() then
			local var_12_3 = var_12_2:getActId()

			var_12_1[var_12_3] = var_12_1[var_12_3] or {}

			table.insert(var_12_1[var_12_3], arg_12_1[iter_12_0])
		end
	end

	return var_12_1
end

function ToLoveCollabTaskMediator.GetTaskRedTip()
	local var_13_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.TOLOVE_TASK_ID)

	if var_13_0 and not var_13_0:isEnd() then
		for iter_13_0, iter_13_1 in pairs((var_13_0:getConfig("config_data"))) do
			local var_13_1 = getProxy(TaskProxy):getTaskVO(iter_13_1)

			if var_13_1 and var_13_1:getTaskStatus() == 1 then
				return true
			end
		end
	end

	return false
end

return ToLoveCollabTaskMediator
