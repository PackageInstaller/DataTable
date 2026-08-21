local var_0_0 = class("TaskCommonPage", import("..base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "TaskListPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0._scrllPanel = arg_2_0._tf:Find("right_panel/content")
	arg_2_0._scrollView = arg_2_0._scrllPanel:GetComponent("LScrollRect")

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.taskCards = {}

	function arg_3_0._scrollView.onInitItem(arg_4_0)
		arg_3_0:onInitTask(arg_4_0)

		return
	end

	function arg_3_0._scrollView.onUpdateItem(arg_5_0, arg_5_1)
		arg_3_0:onUpdateTask(arg_5_0, arg_5_1)

		return
	end

	return
end

function var_0_0.onInitTask(arg_6_0, arg_6_1)
	arg_6_0.taskCards[arg_6_1] = TaskCard.New(arg_6_1, arg_6_0.contextData.viewComponent)

	return
end

function var_0_0.onUpdateTask(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0.taskCards[arg_7_2] then
		arg_7_0:onInitTask(arg_7_2)
	end

	arg_7_0.taskCards[arg_7_2]:update(arg_7_0.taskVOs[arg_7_1 + 1])

	return
end

function var_0_0.Update(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0:Show()

	arg_8_0.taskVOs = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_0.contextData.taskVOsById) do
		if iter_8_1:ShowOnTaskScene() and arg_8_2[iter_8_1:GetRealType()] then
			table.insert(arg_8_0.taskVOs, iter_8_1)
		end
	end

	if (arg_8_1 == TaskScene.PAGE_TYPE_ALL or arg_8_1 == TaskScene.PAGE_TYPE_ROUTINE) and TaskScene.IsPassScenario() and TaskScene.IsNewStyleTime() then
		local var_8_0 = getProxy(TaskProxy)

		for iter_8_2, iter_8_3 in ipairs(pg.gameset.daily_task_new.description) do
			local var_8_1 = var_8_0:getTaskById(iter_8_3) or var_8_0:getFinishTaskById(iter_8_3)

			if not var_8_1 then
				table.insert(arg_8_0.taskVOs, Task.New({
					progress = 0,
					id = iter_8_3
				}))
			end
		end
	end

	if arg_8_1 == TaskScene.PAGE_TYPE_ALL or arg_8_1 == TaskScene.PAGE_TYPE_ACT then
		local var_8_2 = getProxy(AvatarFrameProxy)

		for iter_8_4, iter_8_5 in ipairs((var_8_2:getAllAvatarFrame())) do
			for iter_8_6, iter_8_7 in ipairs(iter_8_5.tasks) do
				table.insert(arg_8_0.taskVOs, iter_8_7)
			end
		end
	end

	arg_8_0:Sort()

	arg_8_0._scrollView.enabled = true

	arg_8_0._scrollView:SetTotalCount(#arg_8_0.taskVOs, -1)

	local var_8_3 = arg_8_0:GetSliderValue()

	if var_8_3 > 0 then
		arg_8_0._scrollView:ScrollTo(var_8_3)
	end

	if arg_8_3 then
		arg_8_3(arg_8_0.taskVOs)
	end

	return
end

function var_0_0.GetSliderValue(arg_9_0)
	local var_9_0 = -1

	if arg_9_0.contextData.targetId then
		local var_9_1

		for iter_9_0, iter_9_1 in ipairs(arg_9_0.taskVOs) do
			if iter_9_1.id == arg_9_0.contextData.targetId then
				var_9_1 = iter_9_0 - 1

				break
			end
		end

		if var_9_1 then
			var_9_0 = arg_9_0._scrollView:HeadIndexToValue(var_9_1)
		end
	end

	return var_9_0
end

function var_0_0.Sort(arg_10_0)
	local function var_10_0(arg_11_0, arg_11_1, arg_11_2)
		return (function(arg_12_0)
			for iter_12_0, iter_12_1 in ipairs(arg_11_2) do
				if arg_12_0 == iter_12_1 then
					return iter_12_0
				end
			end

			return
		end)(arg_11_0) < (function(arg_12_0)
			for iter_12_0, iter_12_1 in ipairs(arg_11_2) do
				if arg_12_0 == iter_12_1 then
					return iter_12_0
				end
			end

			return
		end)(arg_11_1)
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

	table.sort(arg_10_0.taskVOs, function(arg_16_0, arg_16_1)
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

function var_0_0.OnDestroy(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.taskCards) do
		iter_17_1:dispose()
	end

	return
end

function var_0_0.GetWaitToCheckList(arg_18_0)
	local var_18_0 = arg_18_0.taskVOs or {}
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in pairs(var_18_0) do
		if iter_18_1:getTaskStatus() == 1 and iter_18_1:ShowOnTaskScene() then
			table.insert(var_18_1, iter_18_1)
		end
	end

	return var_18_1
end

function var_0_0.ExecuteOneStepSubmit(arg_19_0)
	local var_19_0 = arg_19_0:GetWaitToCheckList()
	local var_19_1
	local var_19_2 = false
	local var_19_3

	coroutine.wrap(function()
		var_19_1, var_19_2 = arg_19_0:filterOverflowTaskVOList(var_19_0)
		var_19_1 = arg_19_0:filterSubmitTaskVOList(var_19_1, var_19_3)
		var_19_1 = arg_19_0:filterChoiceTaskVOList(var_19_1, var_19_3)

		for iter_20_0 = #var_19_1, 1, -1 do
			if var_19_1[iter_20_0]:isAvatarTask() then
				if not ({})[var_19_1[iter_20_0]:getActId()] then
					({})[var_19_1[iter_20_0]:getActId()] = {}
				end

				table.insert(({})[var_19_1[iter_20_0]:getActId()], var_19_1[iter_20_0].id)
				table.remove(var_19_1, iter_20_0)
			elseif var_19_1[iter_20_0]:isActivityTask() then
				if not ({})[var_19_1[iter_20_0]:getActId()] then
					({})[var_19_1[iter_20_0]:getActId()] = {}
				end

				table.insert(({})[var_19_1[iter_20_0]:getActId()], var_19_1[iter_20_0].id)
				table.remove(var_19_1, iter_20_0)
			end
		end

		if #var_19_1 > 0 then
			arg_19_0:emit(TaskMediator.STORE_ACTIVITY_AWARDS, true)
		end

		;(function(arg_21_0)
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
		end)({})
		;(function(arg_21_0)
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
		end)({})
		arg_19_0:emit(TaskMediator.STORE_ACTIVITY_AWARDS, false)

		if #var_19_1 > 0 then
			pg.m02:sendNotification(GAME.MERGE_TASK_ONE_STEP_AWARD, {
				resultList = var_19_1
			})
		end

		return
	end)()

	if false then
		pg.TipsMgr.GetInstance():ShowTips(i18n("award_overflow_tip"))

		var_19_2 = false
	end

	return
end

function var_0_0.filterOverflowTaskVOList(arg_23_0, arg_23_1)
	local var_23_0 = getProxy(PlayerProxy):getData()
	local var_23_1 = var_23_0.gold
	local var_23_2 = var_23_0.oil

	if not LOCK_UR_SHIP then
		local var_23_3 = getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]) or 0

		if LOCK_UR_SHIP or not pg.gameset.urpt_chapter_max.description[2] then
			-- block empty
		end

		local var_23_7 = false

		for iter_23_0, iter_23_1 in pairs(arg_23_1) do
			local var_23_8 = iter_23_1:judgeOverflow(var_23_1, var_23_2, var_23_3)

			if not var_23_8 then
				table.insert({}, iter_23_1)
			end

			if var_23_8 then
				var_23_7 = true
			end
		end

		return {}, var_23_7
	end
end

function var_0_0.filterSubmitTaskVOList(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
		if iter_24_1:getConfig("sub_type") == TASK_SUB_TYPE_GIVE_ITEM or iter_24_1:getConfig("sub_type") == TASK_SUB_TYPE_GIVE_VIRTUAL_ITEM or iter_24_1:getConfig("sub_type") == TASK_SUB_TYPE_PLAYER_RES then
			local var_24_1 = DROP_TYPE_ITEM
			local var_24_2

			if iter_24_1:getConfig("sub_type") == TASK_SUB_TYPE_PLAYER_RES then
				var_24_1 = DROP_TYPE_RESOURCE
				var_24_2 = {
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("sub_item_warning")
				}
			end

			;({})[1] = {
				type = var_24_1,
				id = tonumber(iter_24_1:getConfig("target_id")),
				count = iter_24_1:getConfig("target_num")
			}
			var_24_2.items = {}

			function var_24_2.onYes()
				table.insert(var_24_0, iter_24_1)
				arg_24_2()

				return
			end

			function var_24_2.onNo()
				arg_24_2()

				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox(var_24_2)
			coroutine.yield()
		else
			table.insert({}, iter_24_1)
		end
	end

	return {}
end

function var_0_0.filterChoiceTaskVOList(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
		if iter_27_1:isSelectable() then
			for iter_27_2, iter_27_3 in ipairs((iter_27_1:getConfig("award_choice"))) do
				({})[#{} + 1] = {
					type = iter_27_3[1],
					id = iter_27_3[2],
					count = iter_27_3[3],
					index = iter_27_2
				}
			end

			local var_27_1

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_ITEM_BOX,
				content = i18n("select_award_warning"),
				items = {},
				itemFunc = function(arg_28_0)
					var_27_1 = arg_28_0.index

					return
				end,
				onYes = function()
					if not var_27_1 then
						pg.TipsMgr.GetInstance():ShowTips(i18n("no_item_selected_tip"))
					else
						local var_29_0 = {}

						for iter_29_0, iter_29_1 in ipairs(var_0[var_27_1]) do
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
			table.insert({}, iter_27_1)
		end
	end

	return {}
end

return var_0_0
