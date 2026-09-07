local TaskCommonPage = class("TaskCommonPage", import("..base.BaseSubView"))

function TaskCommonPage:getUIName()
	return "TaskListPage"
end

function TaskCommonPage:OnLoaded()
	self._scrllPanel = self._tf:Find("right_panel/content")
	self._scrollView = self._scrllPanel:GetComponent("LScrollRect")

	return
end

function TaskCommonPage:OnInit()
	self.taskCards = {}

	function self._scrollView.onInitItem(arg_4_0)
		self:onInitTask(arg_4_0)

		return
	end

	function self._scrollView.onUpdateItem(arg_5_0, arg_5_1)
		self:onUpdateTask(arg_5_0, arg_5_1)

		return
	end

	return
end

function TaskCommonPage:onInitTask(arg_6_1)
	self.taskCards[arg_6_1] = TaskCard.New(arg_6_1, self.contextData.viewComponent)

	return
end

function TaskCommonPage:onUpdateTask(arg_7_1, arg_7_2)
	if not self.taskCards[arg_7_2] then
		self:onInitTask(arg_7_2)
	end

	self.taskCards[arg_7_2]:update(self.taskVOs[arg_7_1 + 1])

	return
end

function TaskCommonPage:Update(arg_8_1, arg_8_2, arg_8_3)
	self:Show()

	self.taskVOs = {}

	for iter_8_0, iter_8_1 in pairs(self.contextData.taskVOsById) do
		if iter_8_1:ShowOnTaskScene() and arg_8_2[iter_8_1:GetRealType()] then
			table.insert(self.taskVOs, iter_8_1)
		end
	end

	if (arg_8_1 == TaskScene.PAGE_TYPE_ALL or arg_8_1 == TaskScene.PAGE_TYPE_ROUTINE) and TaskScene.IsPassScenario() and TaskScene.IsNewStyleTime() then
		local var_8_0 = getProxy(TaskProxy)

		for iter_8_2, iter_8_3 in ipairs(pg.gameset.daily_task_new.description) do
			if not (var_8_0:getTaskById(iter_8_3) or var_8_0:getFinishTaskById(iter_8_3)) then
				table.insert(self.taskVOs, Task.New({
					progress = 0,
					id = iter_8_3
				}))
			end
		end
	end

	if arg_8_1 == TaskScene.PAGE_TYPE_ALL or arg_8_1 == TaskScene.PAGE_TYPE_ACT then
		for iter_8_4, iter_8_5 in ipairs((getProxy(AvatarFrameProxy):getAllAvatarFrame())) do
			for iter_8_6, iter_8_7 in ipairs(iter_8_5.tasks) do
				table.insert(self.taskVOs, iter_8_7)
			end
		end
	end

	self:Sort()

	self._scrollView.enabled = true

	self._scrollView:SetTotalCount(#self.taskVOs, -1)

	local var_8_1 = self:GetSliderValue()

	if var_8_1 > 0 then
		self._scrollView:ScrollTo(var_8_1)
	end

	if arg_8_3 then
		arg_8_3(self.taskVOs)
	end

	return
end

function TaskCommonPage:GetSliderValue()
	local var_9_0 = -1

	if self.contextData.targetId then
		local var_9_1

		for iter_9_0, iter_9_1 in ipairs(self.taskVOs) do
			if iter_9_1.id == self.contextData.targetId then
				var_9_1 = iter_9_0 - 1

				break
			end
		end

		if var_9_1 then
			var_9_0 = self._scrollView:HeadIndexToValue(var_9_1)
		end
	end

	return var_9_0
end

function TaskCommonPage:Sort()
	local function var_10_0(arg_11_0, arg_11_1, arg_11_2)
		local function var_11_0(arg_12_0)
			for iter_12_0, iter_12_1 in ipairs(arg_11_2) do
				if arg_12_0 == iter_12_1 then
					return iter_12_0
				end
			end

			return
		end

		return var_11_0(arg_11_0) < var_11_0(arg_11_1)
	end

	local function var_10_1(arg_13_0)
		return arg_13_0:IsUrTask() and 1 or 0
	end

	local function var_10_2(arg_14_0)
		return arg_14_0.configId or 0
	end

	local function var_10_3(arg_15_0, arg_15_1)
		if arg_15_0:GetRealType() == arg_15_1:GetRealType() then
			if arg_15_0:isAvatarTask() and arg_15_1:isAvatarTask() then
				local var_15_0 = var_10_2(arg_15_0)
				local var_15_1 = var_10_2(arg_15_1)

				if var_15_0 == var_15_1 then
					return arg_15_0.id < arg_15_1.id
				else
					return var_15_1 < var_15_0
				end
			else
				return arg_15_0.id < arg_15_1.id
			end
		elseif arg_15_0:getTaskStatus() == 0 then
			return var_10_0(arg_15_0:GetRealType(), arg_15_1:GetRealType(), {
				26,
				36,
				6,
				3,
				4,
				13,
				5,
				2,
				1,
				16
			})
		elseif arg_15_0:getTaskStatus() == 1 then
			return var_10_0(arg_15_0:GetRealType(), arg_15_1:GetRealType(), {
				26,
				36,
				6,
				1,
				4,
				13,
				2,
				5,
				3,
				16
			})
		end

		return
	end

	table.sort(self.taskVOs, function(arg_16_0, arg_16_1)
		if arg_16_0:getTaskStatus() == arg_16_1:getTaskStatus() then
			local var_16_0 = arg_16_0.id == 10302 and 1 or 0
			local var_16_1 = arg_16_1.id == 10302 and 1 or 0

			if (arg_16_0.id == 10302 and 1 or 0) == (arg_16_1.id == 10302 and 1 or 0) then
				local var_16_2 = var_10_1(arg_16_0)
				local var_16_3 = var_10_1(arg_16_1)

				if var_16_2 == var_16_3 then
					return var_10_3(arg_16_0, arg_16_1)
				else
					return var_16_3 < var_16_2
				end
			else
				return var_16_1 < var_16_0
			end
		else
			return var_10_0(arg_16_0:getTaskStatus(), arg_16_1:getTaskStatus(), {
				1,
				0,
				2,
				-1
			})
		end

		return
	end)

	return
end

function TaskCommonPage:OnDestroy()
	for iter_17_0, iter_17_1 in pairs(self.taskCards) do
		iter_17_1:dispose()
	end

	return
end

function TaskCommonPage:GetWaitToCheckList()
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in pairs(self.taskVOs or {}) do
		if iter_18_1:getTaskStatus() == 1 and iter_18_1:ShowOnTaskScene() then
			table.insert(var_18_1, iter_18_1)
		end
	end

	return var_18_1
end

function TaskCommonPage:ExecuteOneStepSubmit()
	local var_19_0 = self:GetWaitToCheckList()
	local var_19_1
	local var_19_2 = false
	local var_19_3

	var_19_3 = coroutine.wrap(function()
		var_19_1, var_19_2 = self:filterOverflowTaskVOList(var_19_0)
		var_19_1 = self:filterSubmitTaskVOList(var_19_1, var_19_3)
		var_19_1 = self:filterChoiceTaskVOList(var_19_1, var_19_3)

		local var_20_0 = {}
		local var_20_1 = {}

		for iter_20_0 = #var_19_1, 1, -1 do
			if var_19_1[iter_20_0]:isAvatarTask() then
				var_20_0[var_19_1[iter_20_0]:getActId()] = var_20_0[var_19_1[iter_20_0]:getActId()] or {}

				table.insert(var_20_0[var_19_1[iter_20_0]:getActId()], var_19_1[iter_20_0].id)
				table.remove(var_19_1, iter_20_0)
			elseif var_19_1[iter_20_0]:isActivityTask() then
				var_20_1[var_19_1[iter_20_0]:getActId()] = var_20_1[var_19_1[iter_20_0]:getActId()] or {}

				table.insert(var_20_1[var_19_1[iter_20_0]:getActId()], var_19_1[iter_20_0].id)
				table.remove(var_19_1, iter_20_0)
			end
		end

		local function var_20_2(arg_21_0)
			for iter_21_0, iter_21_1 in pairs(arg_21_0) do
				if #iter_21_1 > 0 then
					pg.m02:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
						act_id = iter_21_0,
						task_ids = iter_21_1,
						callback = function(arg_22_0, arg_22_1, arg_22_2)
							var_19_3()

							return
						end
					})
					coroutine.yield()
				end
			end

			return
		end

		if #var_19_1 > 0 then
			self:emit(TaskMediator.STORE_ACTIVITY_AWARDS, true)
		end

		var_20_2(var_20_0)
		var_20_2(var_20_1)
		self:emit(TaskMediator.STORE_ACTIVITY_AWARDS, false)

		if #var_19_1 > 0 then
			pg.m02:sendNotification(GAME.MERGE_TASK_ONE_STEP_AWARD, {
				resultList = var_19_1
			})
		end

		return
	end)

	;(nil)()

	if var_19_2 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("award_overflow_tip"))

		var_19_2 = false
	end

	return
end

function TaskCommonPage:filterOverflowTaskVOList(arg_23_1)
	local var_23_0 = {}
	local var_23_1 = getProxy(PlayerProxy):getData()
	local var_23_2 = var_23_1.gold
	local var_23_3 = var_23_1.oil
	local var_23_4

	if not LOCK_UR_SHIP then
		var_23_4 = getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]) or 0
	end

	if LOCK_UR_SHIP or not pg.gameset.urpt_chapter_max.description[2] then
		-- block empty
	end

	local var_23_8 = false

	for iter_23_0, iter_23_1 in pairs(arg_23_1) do
		local var_23_9 = iter_23_1:judgeOverflow(var_23_2, var_23_3, var_23_4)

		if not var_23_9 then
			table.insert(var_23_0, iter_23_1)
		end

		if var_23_9 then
			var_23_8 = true
		end
	end

	return var_23_0, var_23_8
end

function TaskCommonPage:filterSubmitTaskVOList(arg_24_1, arg_24_2)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
		if iter_24_1:getConfig("sub_type") == TASK_SUB_TYPE_GIVE_ITEM or iter_24_1:getConfig("sub_type") == TASK_SUB_TYPE_GIVE_VIRTUAL_ITEM or iter_24_1:getConfig("sub_type") == TASK_SUB_TYPE_PLAYER_RES then
			local var_24_1 = DROP_TYPE_ITEM
			local var_24_5
			local var_24_4
			local var_24_3
			local var_24_2

			if iter_24_1:getConfig("sub_type") == TASK_SUB_TYPE_PLAYER_RES then
				var_24_1 = DROP_TYPE_RESOURCE

				function var_24_2()
					table.insert(var_24_0, iter_24_1)
					arg_24_2()

					return
				end

				function var_24_3()
					arg_24_2()

					return
				end

				var_24_4 = {
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("sub_item_warning")
				}
				var_24_5 = {}
			end

			var_24_5[1] = {
				type = var_24_1,
				id = tonumber(iter_24_1:getConfig("target_id")),
				count = iter_24_1:getConfig("target_num")
			}
			var_24_4.items = var_24_5
			var_24_4.onYes = var_24_2
			var_24_4.onNo = var_24_3

			pg.MsgboxMgr.GetInstance():ShowMsgBox(var_24_4)
			coroutine.yield()
		else
			table.insert(var_24_0, iter_24_1)
		end
	end

	return var_24_0
end

function TaskCommonPage:filterChoiceTaskVOList(arg_27_1, arg_27_2)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
		if iter_27_1:isSelectable() then
			local var_27_1 = iter_27_1:getConfig("award_choice")
			local var_27_2 = {}

			for iter_27_2, iter_27_3 in ipairs(var_27_1) do
				var_27_2[#var_27_2 + 1] = {
					type = iter_27_3[1],
					id = iter_27_3[2],
					count = iter_27_3[3],
					index = iter_27_2
				}
			end

			local var_27_3

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_ITEM_BOX,
				content = i18n("select_award_warning"),
				items = var_27_2,
				itemFunc = function(self)
					var_27_3 = self.index

					return
				end,
				onYes = function()
					if not var_27_3 then
						pg.TipsMgr.GetInstance():ShowTips(i18n("no_item_selected_tip"))
					else
						local var_29_0 = {}

						for iter_29_0, iter_29_1 in ipairs(var_27_1[var_27_3]) do
							table.insert(var_29_0, {
								type = iter_29_1[1],
								id = iter_29_1[2],
								number = iter_29_1[3]
							})
						end

						iter_27_1.choiceItemList = var_29_0

						table.insert(var_27_0, iter_27_1)
						arg_27_2()
					end

					return
				end,
				onNo = function()
					arg_27_2()

					return
				end
			})
			coroutine.yield()
		else
			table.insert(var_27_0, iter_27_1)
		end
	end

	return var_27_0
end

return TaskCommonPage
