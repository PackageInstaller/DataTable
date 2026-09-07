local TaskMediator = class("TaskMediator", import("..base.ContextMediator"))

TaskMediator.ON_TASK_SUBMIT = "TaskMediator:ON_TASK_SUBMIT"
TaskMediator.ON_TASK_GO = "TaskMediator:ON_TASK_GO"
TaskMediator.TASK_FILTER = "TaskMediator:TASK_FILTER"
TaskMediator.ON_SUBMIT_AVATAR_TASK = "TaskMediator:ON_SUBMIT_AVATAR_TASK"
TaskMediator.ON_SUBMIT_WEEK_PROGREE = "TaskMediator:ON_SUBMIT_WEEK_PROGREE"
TaskMediator.ON_BATCH_SUBMIT_WEEK_TASK = "TaskMediator:ON_BATCH_SUBMIT_WEEK_TASK"
TaskMediator.ON_SUBMIT_WEEK_TASK = "TaskMediator:ON_SUBMIT_WEEK_TASK"
TaskMediator.CLICK_GET_ALL = "TaskMediator:CLICK_GET_ALL"
TaskMediator.ON_DROP = "TaskMediator:ON_DROP"
TaskMediator.STORE_ACTIVITY_AWARDS = "TaskMediator:STORE_ACTIVITY_AWARDS"

function TaskMediator:register()
	self:bind(TaskMediator.ON_SUBMIT_WEEK_TASK, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.SUBMIT_WEEK_TASK, {
			id = arg_2_1.id
		})

		return
	end)
	self:bind(TaskMediator.ON_SUBMIT_AVATAR_TASK, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_3_1:getActId(),
			task_ids = {
				arg_3_1.id
			}
		})

		return
	end)
	self:bind(TaskMediator.ON_SUBMIT_WEEK_PROGREE, function(arg_4_0)
		self:sendNotification(GAME.SUBMIT_WEEK_TASK_PROGRESS)

		return
	end)
	self:bind(TaskMediator.ON_BATCH_SUBMIT_WEEK_TASK, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.BATCH_SUBMIT_WEEK_TASK, {
			ids = arg_5_1,
			callback = arg_5_2
		})

		return
	end)
	self:bind(TaskMediator.ON_DROP, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_1.type == DROP_TYPE_EQUIP then
			self:addSubLayers(Context.New({
				mediator = EquipmentInfoMediator,
				viewComponent = EquipmentInfoLayer,
				data = {
					equipmentId = arg_6_1:getConfig("id"),
					type = EquipmentInfoMediator.TYPE_DISPLAY,
					onRemoved = arg_6_2
				}
			}))
		elseif arg_6_1.type == DROP_TYPE_SPWEAPON then
			self:addSubLayers(Context.New({
				mediator = SpWeaponInfoMediator,
				viewComponent = SpWeaponInfoLayer,
				data = {
					spWeaponConfigId = arg_6_1:getConfig("id"),
					type = SpWeaponInfoLayer.TYPE_DISPLAY,
					onRemoved = arg_6_2
				}
			}))
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_SINGLE_ITEM,
				drop = arg_6_1,
				onNo = arg_6_2,
				onYes = arg_6_2
			})
		end

		return
	end)
	self:bind(TaskMediator.ON_TASK_SUBMIT, function(arg_7_0, arg_7_1)
		local var_7_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.JYHZ_ACTIVITY_ID)

		if var_7_0 then
			local var_7_1 = _.flatten((var_7_0:getConfig("config_data")))

			if arg_7_1.id == var_7_1[#var_7_1] then
				pg.NewStoryMgr.GetInstance():Play("YIXIAN8", function()
					self:sendNotification(GAME.SUBMIT_TASK, arg_7_1.id)

					return
				end)

				return
			end
		end

		if arg_7_1.index then
			self:sendNotification(GAME.SUBMIT_TASK, {
				taskId = arg_7_1.id,
				index = arg_7_1.index
			})
		else
			self:sendNotification(GAME.SUBMIT_TASK, arg_7_1.id)
		end

		return
	end)
	self:bind(TaskMediator.ON_TASK_GO, function(arg_9_0, arg_9_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_9_1
		})

		return
	end)
	self:bind(TaskMediator.STORE_ACTIVITY_AWARDS, function(arg_10_0, arg_10_1)
		self.storeActivityAwardFlag = arg_10_1

		return
	end)
	self:SetTaskVOs()
	self.viewComponent:SetWeekTaskProgressInfo(getProxy(TaskProxy):GetWeekTaskProgressInfo())

	return
end

function TaskMediator:SetTaskVOs()
	local var_11_0 = getProxy(TaskProxy):getData()
	local var_11_1 = getProxy(BagProxy)

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		if iter_11_1:getConfig("sub_type") == TASK_SUB_TYPE_GIVE_ITEM then
			iter_11_1.progress = var_11_1:getItemCountById(tonumber((tonumber(iter_11_1:getConfig("target_id")))))
		elseif iter_11_1:getConfig("sub_type") == TASK_SUB_TYPE_GIVE_VIRTUAL_ITEM then
			iter_11_1.progress = getProxy(ActivityProxy):getVirtualItemNumber((tonumber(iter_11_1:getConfig("target_id"))))
		end
	end

	self.viewComponent:setTaskVOs(var_11_0)

	return
end

function TaskMediator:enterLevel(arg_12_1)
	local var_12_0 = getProxy(ChapterProxy):getChapterById(arg_12_1)

	if var_12_0 then
		local var_12_1 = {
			mapIdx = var_12_0:getConfig("map")
		}

		if var_12_0.active then
			var_12_1.chapterId = var_12_0.id
		else
			var_12_1.openChapterId = arg_12_1
		end

		self:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, var_12_1)
	end

	return
end

function TaskMediator:listNotificationInterests()
	return {
		TaskProxy.TASK_ADDED,
		TaskProxy.TASK_UPDATED,
		TaskProxy.TASK_REMOVED,
		TaskProxy.TASK_DELETE,
		GAME.SUBMIT_TASK_DONE,
		TaskMediator.TASK_FILTER,
		GAME.BEGIN_STAGE_DONE,
		GAME.CHAPTER_OP_DONE,
		TaskProxy.WEEK_TASK_UPDATED,
		TaskProxy.WEEK_TASKS_ADDED,
		TaskProxy.WEEK_TASKS_DELETED,
		GAME.SUBMIT_WEEK_TASK_DONE,
		GAME.SUBMIT_WEEK_TASK_PROGRESS_DONE,
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		GAME.SUBMIT_AVATAR_TASK_DONE,
		TaskProxy.WEEK_TASK_RESET,
		GAME.MERGE_TASK_ONE_STEP_AWARD_DONE,
		AvatarFrameProxy.FRAME_TASK_TIME_OUT
	}
end

function TaskMediator:handleNotification(arg_14_1)
	local var_14_0 = arg_14_1:getName()
	local var_14_1 = arg_14_1:getBody()

	if var_14_0 == TaskProxy.TASK_ADDED then
		if var_14_1:getConfig("sub_type") == TASK_SUB_TYPE_GIVE_ITEM then
			var_14_1.progress = getProxy(BagProxy):getItemCountById(tonumber((tonumber(var_14_1:getConfig("target_id")))))
		elseif var_14_1:getConfig("sub_type") == TASK_SUB_TYPE_GIVE_VIRTUAL_ITEM then
			var_14_1.progress = getProxy(ActivityProxy):getVirtualItemNumber((tonumber(var_14_1:getConfig("target_id"))))
		end

		self.viewComponent:addTask(var_14_1)
	elseif var_14_0 == GAME.CHAPTER_OP_DONE then
		if self.chapterId then
			self:enterLevel(self.chapterId)

			self.chapterId = nil
		end
	elseif var_14_0 == TaskProxy.TASK_UPDATED then
		if var_14_1:getConfig("sub_type") == TASK_SUB_TYPE_GIVE_ITEM then
			var_14_1.progress = getProxy(BagProxy):getItemCountById(tonumber((tonumber(var_14_1:getConfig("target_id")))))
		elseif var_14_1:getConfig("sub_type") == TASK_SUB_TYPE_GIVE_VIRTUAL_ITEM then
			var_14_1.progress = getProxy(ActivityProxy):getVirtualItemNumber((tonumber(var_14_1:getConfig("target_id"))))
		end

		self.viewComponent:updateTask(var_14_1)
	elseif var_14_0 == TaskProxy.TASK_REMOVED or var_14_0 == TaskProxy.TASK_DELETE then
		self.viewComponent:removeTask(var_14_1)
	elseif var_14_0 == TaskMediator.TASK_FILTER then
		self.viewComponent:GoToFilter(var_14_1)
	elseif var_14_0 == GAME.SUBMIT_TASK_DONE then
		local var_14_2 = arg_14_1:getType()
		local var_14_3 = getProxy(TaskProxy)

		self.viewComponent.onShowAwards = true

		if self.activityAwards and #self.activityAwards > 0 then
			for iter_14_0, iter_14_1 in ipairs(self.activityAwards) do
				table.insert(var_14_1, iter_14_1)
			end

			self.activityAwards = {}
		end

		self:addAwardShow(var_14_1, function()
			self.viewComponent.onShowAwards = nil

			self:accepetActivityTask()
			self.viewComponent:refreshPage()
			self.viewComponent:updateOneStepBtn()

			local var_15_0 = {}

			for iter_15_0, iter_15_1 in ipairs(var_14_2) do
				table.insert(var_15_0, function(arg_16_0)
					self:PlayStoryForTaskAct(iter_15_1, arg_16_0)

					return
				end)
			end

			if self.refreshWeekTaskPageFlag then
				self.viewComponent:RefreshWeekTaskPage()

				self.refreshWeekTaskPageFlag = nil
			end

			table.insert(var_15_0, function(arg_17_0)
				getProxy(FeastProxy):HandleTaskStories(var_14_2, arg_17_0)

				return
			end)

			if #var_15_0 > 0 then
				seriesAsync(var_15_0)
			end

			return
		end)
	elseif var_14_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_14_1)
	elseif var_14_0 == TaskProxy.WEEK_TASKS_ADDED or var_14_0 == TaskProxy.WEEK_TASKS_DELETED or var_14_0 == TaskProxy.WEEK_TASK_UPDATED then
		self.viewComponent:RefreshWeekTaskPage()
	elseif var_14_0 == GAME.SUBMIT_WEEK_TASK_DONE then
		self.viewComponent:RefreshWeekTaskPageBefore(var_14_1.id)

		local function var_14_4()
			self.viewComponent:RefreshWeekTaskPage()

			return
		end

		if #var_14_1.awards > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_14_1.awards, var_14_4)
		else
			var_14_4()
		end
	elseif var_14_0 == GAME.SUBMIT_WEEK_TASK_PROGRESS_DONE then
		local function var_14_5()
			self.viewComponent:RefreshWeekTaskProgress()

			return
		end

		if #var_14_1.awards > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_14_1.awards, var_14_5)
		else
			var_14_5()
		end
	elseif var_14_0 == GAME.SUBMIT_AVATAR_TASK_DONE or var_14_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		local function var_14_6()
			self.viewComponent:refreshPage()

			self.refreshWeekTaskPageFlag = true

			return
		end

		if #var_14_1.awards > 0 then
			if self.storeActivityAwardFlag then
				self.activityAwards = self.activityAwards or {}

				for iter_14_2, iter_14_3 in ipairs(var_14_1.awards) do
					table.insert(self.activityAwards, iter_14_3)
				end
			else
				self:addAwardShow(var_14_1.awards, var_14_6)
			end
		else
			var_14_6()
		end
	elseif var_14_0 == TaskProxy.WEEK_TASK_RESET then
		self:SetTaskVOs()
		self.viewComponent:ResetWeekTaskPage()
	elseif var_14_0 == GAME.MERGE_TASK_ONE_STEP_AWARD_DONE then
		self.refreshWeekTaskPageFlag = true

		self:sendNotification(GAME.SUBMIT_TASK_DONE, var_14_1.awards, var_14_1.taskIds)
	elseif var_14_0 == AvatarFrameProxy.FRAME_TASK_TIME_OUT then
		self.viewComponent:refreshPage()
	end

	return
end

function TaskMediator:addAwardShow(arg_21_1, arg_21_2)
	if not arg_21_1 or #arg_21_1 == 0 then
		return
	end

	self.awardsShowList = self.awardsShowList or {}

	table.insert(self.awardsShowList, {
		awards = arg_21_1,
		callback = arg_21_2
	})

	if self.isShowAwardFlag then
		return
	else
		self:showAwardList()
	end

	return
end

function TaskMediator:showAwardList()
	if self.isShowAwardFlag then
		return
	end

	if self.awardsShowList and #self.awardsShowList > 0 then
		self.isShowAwardFlag = true

		local var_22_0 = table.remove(self.awardsShowList, 1)

		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_22_0.awards, function()
			if var_22_0.callback then
				var_22_0.callback()
			end

			self.isShowAwardFlag = false

			self:showAwardList()

			return
		end)
	end

	return
end

function TaskMediator:accepetActivityTask()
	self:sendNotification(GAME.ACCEPT_ACTIVITY_TASK)

	return
end

function TaskMediator:PlayStoryForTaskAct(arg_25_1, arg_25_2)
	local var_25_0

	for iter_25_0, iter_25_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_TASK_LIST))) do
		if iter_25_1 and not iter_25_1:isEnd() then
			local var_25_1 = 0
			local var_25_2 = 0

			for iter_25_2, iter_25_3 in ipairs((iter_25_1:getConfig("config_data"))) do
				for iter_25_4, iter_25_5 in ipairs(iter_25_3) do
					if iter_25_5 == arg_25_1 then
						var_25_1 = iter_25_2
						var_25_2 = iter_25_4
					end
				end
			end

			local var_25_3 = iter_25_1:getConfig("config_client").story or {}

			if var_25_3[var_25_1] then
				if var_25_3[var_25_1][var_25_2] then
					if not pg.NewStoryMgr.GetInstance():IsPlayed(var_25_3[var_25_1][var_25_2]) then
						var_25_0 = var_25_3[var_25_1][var_25_2]
					end
				end
			end
		end
	end

	if var_25_0 then
		pg.NewStoryMgr.GetInstance():Play(var_25_0, arg_25_2)
	else
		arg_25_2()
	end

	return
end

return TaskMediator
