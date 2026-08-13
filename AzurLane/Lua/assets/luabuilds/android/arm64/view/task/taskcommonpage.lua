class = var_0_10000

local var_0_0 = "TaskCommonPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "TaskListPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0._scrllPanel = var_1.Find(var_2_0, "right_panel/content")

	local var_2_1 = arg_2_0._scrllPanel

	arg_2_0._scrollView = var_1.GetComponent(var_2_1, "LScrollRect")

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0.taskCards = {}

	function arg_3_0._scrollView.onInitItem(arg_4_0)
		local var_4_0 = arg_3_0

		var_1.onInitTask(var_4_0, arg_4_0)

		return
	end

	function arg_3_0._scrollView.onUpdateItem(arg_5_0, arg_5_1)
		local var_5_0 = arg_3_0

		var_2.onUpdateTask(var_5_0, arg_5_0, arg_5_1)

		return
	end

	return
end

function var_0_1.onInitTask(arg_6_0, arg_6_1)
	TaskCard = var_1_10002

	local var_6_0 = var_1_10002.New(arg_6_1, arg_6_0.contextData.viewComponent)

	arg_6_0.taskCards[arg_6_1] = var_6_0

	return
end

function var_0_1.onUpdateTask(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0

	if not arg_7_0.taskCards[arg_7_2] then
		arg_7_0:onInitTask(arg_7_2)

		var_7_0 = arg_7_0.taskCards[arg_7_2]
	end

	local var_7_1 = arg_7_0.taskVOs[arg_7_1 + 1]

	var_7_0:update(var_7_1)

	return
end

function var_0_1.Update(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0:Show()

	arg_8_0.taskVOs = {}

	local var_8_0 = arg_8_0.contextData.taskVOsById

	pairs = var_1_10005

	for iter_8_0, iter_8_1 in var_1_10005(var_8_0) do
		if iter_8_1:ShowOnTaskScene() and arg_8_2[iter_8_1:GetRealType()] then
			table = var_10

			var_10.insert(arg_8_0.taskVOs, iter_8_1)
		end
	end

	TaskScene = var_5

	if arg_8_1 ~= var_5.PAGE_TYPE_ALL then
		TaskScene = var_8_1

		local var_8_1

		if arg_8_1 == var_8_1.PAGE_TYPE_ROUTINE then
			TaskScene = var_8_1

			if var_8_1.IsPassScenario() then
				TaskScene = var_8_1

				if var_8_1.IsNewStyleTime() then
					pg = var_8_1
					var_8_1 = var_8_1.gameset.daily_task_new.description
					getProxy = var_6
					TaskProxy = iter_8_0

					local var_8_2 = var_6(iter_8_0)

					ipairs = var_7

					for iter_8_2, iter_8_3 in var_7(var_8_1) do
						local var_8_3

						if not var_8_2:getTaskById(iter_8_3) then
							var_8_3 = var_8_2:getFinishTaskById(iter_8_3)
						end

						if not var_8_3 then
							table = var_1_10013
							var_1_10013 = var_1_10013.insert

							local var_8_4 = arg_8_0.taskVOs

							Task = var_1_10016

							var_1_10013(var_8_4, var_1_10016.New({
								progress = 0,
								id = iter_8_3
							}))
						end
					end
				end
			end
		end

		TaskScene = var_8_1

		if arg_8_1 ~= var_8_1.PAGE_TYPE_ALL then
			TaskScene = var_5

			if arg_8_1 == var_5.PAGE_TYPE_ACT then
				getProxy = var_5
				AvatarFrameProxy = var_7

				local var_8_5 = var_5(var_7)
				local var_8_6 = var_5.getAllAvatarFrame(var_8_5)

				ipairs = var_7

				for iter_8_4, iter_8_5 in var_7(var_8_6) do
					local var_8_7 = iter_8_5.tasks

					ipairs = var_1_10013

					for iter_8_6, iter_8_7 in var_1_10013(var_8_7) do
						table = var_1_10018

						var_1_10018.insert(arg_8_0.taskVOs, iter_8_7)
					end
				end
			end

			arg_8_0:Sort()

			arg_8_0._scrollView.enabled = true

			local var_8_8 = arg_8_0._scrollView

			var_5.SetTotalCount(var_8_8, #arg_8_0.taskVOs, -1)

			if arg_8_0:GetSliderValue() > 0 then
				local var_8_9 = arg_8_0._scrollView

				var_6.ScrollTo(var_8_9, var_5)
			end

			if arg_8_3 then
				arg_8_3(arg_8_0.taskVOs)
			end

			return
		end
	end
end

function var_0_1.GetSliderValue(arg_9_0)
	local var_9_0 = -1

	if arg_9_0.contextData.targetId then
		local var_9_1

		ipairs = var_1_10003

		for iter_9_0, iter_9_1 in var_1_10003(arg_9_0.taskVOs) do
			if iter_9_1.id == arg_9_0.contextData.targetId then
				var_9_1 = iter_9_0 - 1

				break
			end
		end

		if var_9_1 then
			local var_9_2 = arg_9_0._scrollView

			var_9_0 = var_3.HeadIndexToValue(var_9_2, var_9_1)
		end
	end

	return var_9_0
end

function var_0_1.Sort(arg_10_0)
	local function var_10_0(arg_11_0, arg_11_1, arg_11_2)
		return (function(arg_12_0)
			ipairs = var_3_10001

			for iter_12_0, iter_12_1 in var_3_10001(arg_11_2) do
				if arg_12_0 == iter_12_1 then
					return iter_12_0
				end
			end

			return
		end)(arg_11_0) < var_3(arg_11_1)
	end

	local function var_10_1(arg_13_0)
		return arg_13_0:IsUrTask() and 1 or 0
	end

	local function var_10_2(arg_14_0)
		local var_14_0

		if not arg_14_0.configId then
			var_14_0 = 0
		end

		return var_14_0
	end

	local function var_10_3(arg_15_0, arg_15_1)
		if arg_15_0:GetRealType() == arg_15_1:GetRealType() then
			if arg_15_0:isAvatarTask() and arg_15_1:isAvatarTask() then
				if var_10_2(arg_15_0) == var_10_2(arg_15_1) then
					return arg_15_0.id < arg_15_1.id
				else
					return var_3 < var_2
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

	table = var_1_10005

	var_1_10005.sort(arg_10_0.taskVOs, function(arg_16_0, arg_16_1)
		if arg_16_0:getTaskStatus() == arg_16_1:getTaskStatus() then
			if (arg_16_0.id == 10302 and 1 or 0) == (arg_16_1.id == 10302 and 1 or 0) then
				if var_10_1(arg_16_0) == var_10_1(arg_16_1) then
					return var_10_3(arg_16_0, arg_16_1)
				else
					return var_5 < var_4
				end
			else
				return var_3 < var_2
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

function var_0_1.OnDestroy(arg_17_0)
	pairs = var_1_10001

	for iter_17_0, iter_17_1 in var_1_10001(arg_17_0.taskCards) do
		iter_17_1:dispose()
	end

	return
end

function var_0_1.GetWaitToCheckList(arg_18_0)
	local var_18_0

	if not arg_18_0.taskVOs then
		var_18_0 = {}
	end

	local var_18_1 = {}

	pairs = var_1_10003

	for iter_18_0, iter_18_1 in var_1_10003(var_18_0) do
		if iter_18_1:getTaskStatus() == 1 and iter_18_1:ShowOnTaskScene() then
			table = var_8

			var_8.insert(var_18_1, iter_18_1)
		end
	end

	return var_18_1
end

function var_0_1.ExecuteOneStepSubmit(arg_19_0)
	local var_19_0 = arg_19_0:GetWaitToCheckList()
	local var_19_1
	local var_19_2 = false
	local var_19_3

	local function var_19_4()
		local var_20_0 = arg_19_0

		var_19_1, var_19_2 = var_0.filterOverflowTaskVOList(var_20_0, var_19_0)

		local var_20_1 = arg_19_0

		var_19_1 = var_0.filterSubmitTaskVOList(var_20_1, var_19_1, var_19_3)

		local var_20_2 = arg_19_0

		var_19_1 = var_0.filterChoiceTaskVOList(var_20_2, var_19_1, var_19_3)

		local var_20_3 = {}
		local var_20_4 = {}

		for iter_20_0 = #var_19_1, 1, -1 do
			local var_20_5 = var_19_1[iter_20_0]

			if var_2_10006.isAvatarTask(var_20_5) then
				if not var_20_3[var_2_10006:getActId()] then
					var_20_3[var_2_10006:getActId()] = {}
				end

				table = var_7

				var_7.insert(var_20_3[var_2_10006:getActId()], var_2_10006.id)

				table = var_7

				var_7.remove(var_19_1, iter_20_0)
			elseif var_2_10006:isActivityTask() then
				if not var_20_4[var_2_10006:getActId()] then
					var_20_4[var_2_10006:getActId()] = {}
				end

				table = var_7

				var_7.insert(var_20_4[var_2_10006:getActId()], var_2_10006.id)

				table = var_7

				var_7.remove(var_19_1, iter_20_0)
			end
		end

		local function var_20_6(arg_21_0)
			pairs = var_3_10001

			for iter_21_0, iter_21_1 in var_3_10001(arg_21_0) do
				if #iter_21_1 > 0 then
					pg = var_6

					local var_21_0 = var_6.m02
					local var_21_1 = var_6.sendNotification

					GAME = var_3_10009

					var_21_1(var_21_0, var_3_10009.SUBMIT_ACTIVITY_TASK, {
						act_id = iter_21_0,
						task_ids = iter_21_1,
						callback = function(arg_22_0, arg_22_1, arg_22_2)
							var_19_3()

							return
						end
					})

					coroutine = var_21_1

					var_21_1.yield()
				end
			end

			return
		end

		if #var_19_1 > 0 then
			local var_20_7 = arg_19_0
			local var_20_8 = var_3.emit

			TaskMediator = var_2_10006

			var_20_8(var_20_7, var_2_10006.STORE_ACTIVITY_AWARDS, true)
		end

		var_20_6(var_20_3)
		var_20_6(var_20_4)

		local var_20_9 = arg_19_0
		local var_20_10 = var_3.emit

		TaskMediator = var_2_10006

		var_20_10(var_20_9, var_2_10006.STORE_ACTIVITY_AWARDS, false)

		if #var_19_1 > 0 then
			pg = var_3

			local var_20_11 = var_3.m02
			local var_20_12 = var_3.sendNotification

			GAME = var_6

			var_20_12(var_20_11, var_6.MERGE_TASK_ONE_STEP_AWARD, {
				resultList = var_19_1
			})
		end

		return
	end

	coroutine = var_1_10006

	var_1_10006.wrap(var_19_4)()

	if var_19_2 then
		pg = var_6

		local var_19_5 = var_6.TipsMgr.GetInstance()
		local var_19_6 = var_6.ShowTips

		i18n = var_1_10009

		var_19_6(var_19_5, var_1_10009("award_overflow_tip"))

		var_19_2 = false
	end

	return
end

function var_0_1.filterOverflowTaskVOList(arg_23_0, arg_23_1)
	local var_23_0 = {}

	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	local var_23_1 = var_1_10003(var_1_10005)
	local var_23_2 = var_3.getData(var_23_1)

	pg = var_1_10004

	local var_23_3 = var_1_10004.gameset.urpt_chapter_max.description[1]
	local var_23_4 = var_23_2.gold
	local var_23_5 = var_23_2.oil

	LOCK_UR_SHIP = var_1_10007

	if not var_1_10007 then
		getProxy = var_1_10007
		BagProxy = var_1_10009
		var_1_10009 = var_1_10007(var_1_10009)

		local var_23_6

		if not var_7.GetLimitCntById(var_1_10009, var_23_3) then
			var_23_6 = 0
		end

		pg = var_1_10008

		local var_23_7 = var_1_10008.gameset.max_gold.key_value

		pg = var_1_10009

		local var_23_8 = var_1_10009.gameset.max_oil.key_value

		LOCK_UR_SHIP = var_1_10010

		if not var_1_10010 then
			pg = var_1_10010

			if not var_1_10010.gameset.urpt_chapter_max.description[2] then
				local var_23_9 = 0
			end

			local var_23_10 = false

			pairs = var_1_10012

			for iter_23_0, iter_23_1 in var_1_10012(arg_23_1) do
				if not iter_23_1:judgeOverflow(var_23_4, var_23_5, var_23_6) then
					table = var_1_10018

					var_1_10018.insert(var_23_0, iter_23_1)
				end

				if var_17 then
					var_23_10 = true
				end
			end

			return var_23_0, var_23_10
		end
	end
end

function var_0_1.filterSubmitTaskVOList(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = {}
	local var_24_1 = arg_24_1

	ipairs = var_1_10005

	for iter_24_0, iter_24_1 in var_1_10005(var_24_1) do
		local var_24_2 = iter_24_1
		local var_24_3 = iter_24_1.getConfig(var_24_2, "sub_type")

		TASK_SUB_TYPE_GIVE_ITEM = var_1_10011

		if var_24_3 ~= var_1_10011 then
			var_24_2 = iter_24_1
			var_24_3 = iter_24_1.getConfig(var_24_2, "sub_type")
			TASK_SUB_TYPE_GIVE_VIRTUAL_ITEM = var_1_10011

			if var_24_3 ~= var_1_10011 then
				var_24_2 = iter_24_1
				var_24_3 = iter_24_1.getConfig(var_24_2, "sub_type")
				TASK_SUB_TYPE_PLAYER_RES = var_1_10011

				if var_24_3 == var_1_10011 then
					DROP_TYPE_ITEM = var_24_3
					var_1_10011 = iter_24_1:getConfig("sub_type")
					TASK_SUB_TYPE_PLAYER_RES = var_24_2

					if var_1_10011 == var_24_2 then
						DROP_TYPE_RESOURCE = var_24_3
					end

					var_1_10011 = {
						type = var_24_3
					}
					tonumber = var_24_2
					var_1_10011.id = var_24_2(iter_24_1:getConfig("target_id"))
					var_1_10011.count = iter_24_1:getConfig("target_num")

					local function var_24_4()
						table = var_2_10000

						var_2_10000.insert(var_24_0, iter_24_1)
						arg_24_2()

						return
					end

					local function var_24_5()
						arg_24_2()

						return
					end

					local var_24_6 = {}

					MSGBOX_TYPE_ITEM_BOX = var_15
					var_24_6.type = var_15
					i18n = var_15
					var_24_6.content = var_15("sub_item_warning")
					var_24_6.items = {
						var_1_10011
					}
					var_24_6.onYes = var_24_4
					var_24_6.onNo = var_24_5
					pg = var_15

					local var_24_7 = var_15.MsgboxMgr.GetInstance()

					var_15.ShowMsgBox(var_24_7, var_24_6)

					coroutine = var_15

					var_15.yield()
				else
					table = var_24_3

					var_24_3.insert(var_24_0, iter_24_1)
				end
			end
		end
	end

	return var_24_0
end

function var_0_1.filterChoiceTaskVOList(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = {}
	local var_27_1 = arg_27_1

	ipairs = var_1_10005

	for iter_27_0, iter_27_1 in var_1_10005(var_27_1) do
		local var_27_3

		if iter_27_1:isSelectable() then
			local var_27_2 = iter_27_1

			var_27_3 = iter_27_1.getConfig(var_27_2, "award_choice")

			local var_27_4 = {}

			ipairs = var_27_2

			for iter_27_2, iter_27_3 in var_27_2(var_27_3) do
				var_27_4[#var_27_4 + 1] = {
					type = iter_27_3[1],
					id = iter_27_3[2],
					count = iter_27_3[3],
					index = iter_27_2
				}
			end

			local var_27_5

			local function var_27_6(arg_28_0)
				var_27_5 = arg_28_0.index

				return
			end

			local function var_27_7()
				if not var_27_5 then
					pg = var_0

					local var_29_0 = var_0.TipsMgr.GetInstance()
					local var_29_1 = var_0.ShowTips

					i18n = var_2_10003

					var_29_1(var_29_0, var_2_10003("no_item_selected_tip"))
				else
					local var_29_2 = {}
					local var_29_3 = var_27_3[var_27_5]

					ipairs = var_2

					for iter_29_0, iter_29_1 in var_2(var_29_3) do
						table = var_2_10007

						var_2_10007.insert(var_29_2, {
							type = iter_29_1[1],
							id = iter_29_1[2],
							number = iter_29_1[3]
						})
					end

					local var_29_4 = iter_27_1

					var_29_4.choiceItemList = var_29_2
					table = var_29_4

					var_29_4.insert(var_27_0, iter_27_1)
					arg_27_2()
				end

				return
			end

			local function var_27_8()
				arg_27_2()

				return
			end

			local var_27_9 = {}

			MSGBOX_TYPE_ITEM_BOX = var_1_10017
			var_27_9.type = var_1_10017
			i18n = var_1_10017
			var_27_9.content = var_1_10017("select_award_warning")
			var_27_9.items = var_27_4
			var_27_9.itemFunc = var_27_6
			var_27_9.onYes = var_27_7
			var_27_9.onNo = var_27_8
			pg = var_1_10017

			local var_27_10 = var_1_10017.MsgboxMgr.GetInstance()

			var_1_10017.ShowMsgBox(var_27_10, var_27_9)

			coroutine = var_1_10017

			var_1_10017.yield()
		else
			table = var_27_3

			var_27_3.insert(var_27_0, iter_27_1)
		end
	end

	return var_27_0
end

return var_0_1
