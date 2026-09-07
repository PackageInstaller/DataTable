local SixYearUsTaskMediator = class("SixYearUsTaskMediator", import("view.base.ContextMediator"))

SixYearUsTaskMediator.ON_TASK_GO = "event on task go"
SixYearUsTaskMediator.ON_TASK_SUBMIT = "event on task submit"
SixYearUsTaskMediator.ON_TASK_SUBMIT_ONESTEP = "event on task submit one step"

function SixYearUsTaskMediator:register()
	self:bind(SixYearUsTaskMediator.ON_TASK_GO, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	self:bind(SixYearUsTaskMediator.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1, arg_3_2)
		seriesAsync({
			function(arg_4_0)
				self:settleTownGold({
					arg_3_1.id
				}, arg_4_0)

				return
			end,
			function(arg_5_0)
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
	self:bind(SixYearUsTaskMediator.ON_TASK_SUBMIT_ONESTEP, function(arg_7_0, arg_7_1)
		seriesAsync({
			function(arg_8_0)
				self:settleTownGold(arg_7_1, arg_8_0)

				return
			end,
			function(arg_9_0)
				self.awardIndex = 0
				self.showAwards = {}

				for iter_9_0, iter_9_1 in pairs((self:getSubmitDatas(arg_7_1))) do
					self.awardIndex = self.awardIndex + 1

					self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
						act_id = iter_9_0,
						task_ids = iter_9_1
					})
				end

				return
			end
		}, function()
			return
		end)

		return
	end)

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN)

	if not var_1_0 or var_1_0:isEnd() then
		assert(nil, "not exist act")

		return
	end

	self.townActId = var_1_0.id

	return
end

function SixYearUsTaskMediator:isSubmitTownGoldTask(arg_11_1)
	return pg.task_data_template[arg_11_1].sub_type == 1006 and pg.task_data_template[arg_11_1].target_id == "1004"
end

function SixYearUsTaskMediator:settleTownGold(arg_12_1, arg_12_2)
	if underscore.any(arg_12_1, function(arg_13_0)
		return self:isSubmitTownGoldTask(arg_13_0)
	end) then
		self:sendNotification(GAME.ACTIVITY_TOWN_OP, {
			activity_id = self.townActId,
			cmd = TownActivity.OPERATION.SETTLE_GOLD,
			callback = arg_12_2
		})
	else
		arg_12_2()
	end

	return
end

function SixYearUsTaskMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		GAME.ACTIVITY_UPDATED
	}
end

function SixYearUsTaskMediator:handleNotification(arg_15_1)
	local var_15_0 = arg_15_1:getName()

	if var_15_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		if self.awardIndex > 0 then
			self.awardIndex = self.awardIndex - 1
		end

		for iter_15_0, iter_15_1 in ipairs(arg_15_1:getBody().awards) do
			table.insert(self.showAwards, iter_15_1)
		end

		if self.awardIndex == 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, self.showAwards, function()
				self.viewComponent:Show()

				return
			end)

			self.showAwards = {}
		end
	elseif var_15_0 == GAME.ACTIVITY_UPDATED then
		self.viewComponent:Show()
	end

	return
end

function SixYearUsTaskMediator:getSubmitDatas(arg_17_1)
	local var_17_0 = getProxy(TaskProxy)
	local var_17_1 = {}

	for iter_17_0 = 1, #arg_17_1 do
		local var_17_2 = var_17_0:getTaskById(arg_17_1[iter_17_0])

		if var_17_2 and var_17_2:getActId() then
			local var_17_3 = var_17_2:getActId()

			var_17_1[var_17_3] = var_17_1[var_17_3] or {}

			table.insert(var_17_1[var_17_3], arg_17_1[iter_17_0])
		end
	end

	return var_17_1
end

function SixYearUsTaskMediator.GetTaskRedTip()
	local var_18_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.SIX_YEAR_US_TASK_ACT_ID)
	local var_18_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.SIX_YEAR_US_TASK_2_ACT_ID)

	if var_18_0 and not var_18_0:isEnd() then
		for iter_18_0, iter_18_1 in pairs((var_18_0:getConfig("config_data"))) do
			local var_18_2 = getProxy(TaskProxy):getTaskVO(iter_18_1)

			if var_18_2 and var_18_2:getTaskStatus() == 1 then
				return true
			end
		end
	end

	if var_18_1 and not var_18_1:isEnd() then
		for iter_18_2, iter_18_3 in pairs((var_18_1:getConfig("config_data"))) do
			local var_18_3 = getProxy(TaskProxy):getTaskVO(iter_18_3)

			if var_18_3 and var_18_3:getTaskStatus() == 1 then
				return true
			end
		end
	end

	return false
end

return SixYearUsTaskMediator
