class = var_0_10000

local var_0_0 = "NieRAutomataOmenPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreLoginTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "bg")

	local var_1_1 = arg_1_0.bg

	arg_1_0.introduction = var_1.Find(var_1_1, "Introduction")

	local var_1_2 = arg_1_0.introduction

	arg_1_0.desc1 = var_1.Find(var_1_2, "desc1")

	local var_1_3 = arg_1_0.introduction

	arg_1_0.desc2 = var_1.Find(var_1_3, "desc2")

	local var_1_4 = arg_1_0.bg

	arg_1_0.total = var_1.Find(var_1_4, "total_progress")

	local var_1_5 = arg_1_0.total

	arg_1_0.dayTF = var_1.Find(var_1_5, "day")

	local var_1_6 = arg_1_0.total

	arg_1_0.maxDayTF = var_1.Find(var_1_6, "max_day")

	local var_1_7 = arg_1_0.total

	arg_1_0.btnDetail = var_1.Find(var_1_7, "btn_detail")

	local var_1_8 = arg_1_0.btnDetail

	arg_1_0.btnDetailText = var_1.Find(var_1_8, "detail")

	local var_1_9 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_9, "item")

	local var_1_10 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_10, "items")
	UIItemList = var_1
	arg_1_0.uilist = var_1.New(arg_1_0.items, arg_1_0.item)
	NieRAutomataOmenTaskWindow = var_1
	arg_1_0.taskWindow = var_1.New(arg_1_0._tf, arg_1_0.event)
	arg_1_0.finishAll = false
	setActive = var_1

	var_1(arg_1_0.item, false)

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003
	arg_2_0.taskProxy = var_1_10001(var_1_10003)

	local var_2_0 = arg_2_0.activity

	arg_2_0.taskGroup = var_1.getConfig(var_2_0, "config_client").unlock_task
	updateActivityTaskStatus = var_1

	return var_1(arg_2_0.activity)
end

function var_0_1.OnFirstFlush(arg_3_0)
	var_0_1.super.OnFirstFlush(arg_3_0)

	setActive = var_1

	var_1(arg_3_0.maxTF, #arg_3_0.taskGroup)

	setText = var_1

	local var_3_0 = arg_3_0.btnDetailText

	i18n = var_4

	var_1(var_3_0, var_4("nier_a2_mission_detail"))

	onButton = var_1

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.btnDetail

	local function var_3_3()
		local var_4_0 = arg_3_0.taskWindow

		var_0.ExecuteAction(var_4_0, "Show", arg_3_0.activity)

		return
	end

	SFX_PANEL = var_6

	var_1(var_3_1, var_3_2, var_3_3, var_6)

	return
end

function var_0_1.OnShowFlush(arg_5_0)
	var_0_1.super.OnShowFlush(arg_5_0)

	return
end

function var_0_1.GetTypewriterSpeed(arg_6_0)
	local var_6_0 = arg_6_0.activity

	return var_1.getConfig(var_6_0, "config_client").typewriterSpeed and var_2 or 0.1
end

function var_0_1.InvalidateWriter(arg_7_0)
	local var_7_0

	if not arg_7_0.writerToken then
		var_7_0 = 0
	end

	arg_7_0.writerToken = var_7_0 + 1

	if arg_7_0.desc1 then
		GetOrAddComponent = var_1

		local var_7_1 = arg_7_0.desc1

		typeof = var_1_10004
		Typewriter = var_1_10006
		var_1(var_7_1, var_1_10004(var_1_10006)).endFunc = nil
	end

	if arg_7_0.desc2 then
		GetOrAddComponent = var_1

		local var_7_2 = arg_7_0.desc2

		typeof = var_1_10004
		Typewriter = var_1_10006
		var_1(var_7_2, var_1_10004(var_1_10006)).endFunc = nil
	end

	return
end

function var_0_1.Playwriter(arg_8_0)
	arg_8_0:InvalidateWriter()

	local var_8_0 = arg_8_0.writerToken

	local function var_8_1()
		local var_9_0

		if arg_8_0.writerToken == var_8_0 then
			if arg_8_0._go then
				isActive = var_9_0
				var_9_0 = var_9_0(arg_8_0._go)
			end
		else
			var_9_0 = false
		end

		if false then
			var_9_0 = true
		end

		return var_9_0
	end

	local var_8_2 = {}

	if not arg_8_0.finishAll then
		table = var_4

		var_4.insert(var_8_2, function(arg_10_0)
			if not var_8_1() then
				return
			end

			local var_10_0

			var_10_0, GetOrAddComponent = arg_8_0.desc1, var_2_10002
			typeof = var_2_10005
			Typewriter = var_2_10007

			local var_10_1 = var_2_10002(var_10_0, var_2_10005(var_2_10007))

			function var_10_1.endFunc()
				if not var_8_1() then
					return
				end

				arg_10_0()

				return
			end

			local var_10_2 = var_10_1
			local var_10_3 = var_10_1.setSpeed
			local var_10_4 = arg_8_0

			var_10_3(var_10_2, var_6.GetTypewriterSpeed(var_10_4))
			var_10_1:Play()

			return
		end)
	else
		table = var_4

		var_4.insert(var_8_2, function(arg_12_0)
			if not var_8_1() then
				return
			end

			local var_12_0 = arg_8_0.activity
			local var_12_1 = var_1.getConfig(var_12_0, "config_client").story

			checkExist = var_2_10002

			if var_2_10002(var_12_1, {
				arg_8_0.nday
			}, {
				1
			}) then
				pg = var_12_0

				local var_12_2 = var_12_0.NewStoryMgr.GetInstance()

				if not var_3.IsPlayed(var_12_2, var_2) then
					pg = var_3

					local var_12_3 = var_3.NewStoryMgr.GetInstance()

					var_3.Play(var_12_3, var_2, function()
						if not var_8_1() then
							return
						end

						arg_12_0()

						return
					end)

					goto label_12_0
				end
			end

			arg_12_0()

			::label_12_0::

			return
		end)
	end

	table = var_4

	var_4.insert(var_8_2, function(arg_14_0)
		if not var_8_1() then
			return
		end

		local var_14_0 = arg_8_0.desc2

		setActive = var_2_10002

		var_2_10002(arg_8_0.desc2, true)

		GetOrAddComponent = var_2_10002

		local var_14_1 = var_14_0

		typeof = var_5
		Typewriter = var_2_10007

		local var_14_2 = var_2_10002(var_14_1, var_5(var_2_10007))

		function var_14_2.endFunc()
			if not var_8_1() then
				return
			end

			arg_14_0()

			return
		end

		local var_14_3 = var_14_2
		local var_14_4 = var_14_2.setSpeed
		local var_14_5 = arg_8_0

		var_14_4(var_14_3, var_6.GetTypewriterSpeed(var_14_5))
		var_14_2:Play()

		return
	end)

	seriesAsync = var_4

	var_4(var_8_2)

	return
end

function var_0_1.LocalFresh(arg_16_0, arg_16_1)
	local var_16_0 = "nier_a2_text_block_day"
	local var_16_1

	arg_16_0.finishAll = arg_16_1 >= 7 and arg_16_0:lastFinish()

	if arg_16_0.finishAll then
		i18n = var_4
		var_16_1 = var_4(var_16_0 .. "_fin")
		setActive = var_4

		var_4(arg_16_0.desc1, false)
	else
		i18n = var_4
		var_16_1 = var_4(var_16_0 .. arg_16_1)
		setText = var_4

		var_4(arg_16_0.desc1, var_16_1[1].info)
	end

	setText = var_4

	var_4(arg_16_0.desc2, var_16_1[2].info)

	setActive = var_4

	var_4(arg_16_0.desc2, false)
	arg_16_0:Playwriter()

	return
end

function var_0_1.lastFinish(arg_17_0)
	local var_17_0 = arg_17_0.taskGroup[#arg_17_0.taskGroup]

	getProxy = var_2
	TaskProxy = var_1_10004

	local var_17_1 = var_2(var_1_10004)
	local var_17_2 = var_2.getTaskVO(var_17_1, var_17_0[1])

	getProxy = var_1_10003
	TaskProxy = var_5

	local var_17_3 = var_1_10003(var_5)
	local var_17_4 = var_3.getTaskVO(var_17_3, var_17_0[2])

	return var_17_2:getTaskStatus() == 2 and var_17_4:getTaskStatus() == 2
end

function var_0_1.UpdateTask(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_1 + 1
	local var_18_1 = arg_18_2:Find("item")
	local var_18_2 = arg_18_0.taskGroup[arg_18_0.nday][var_18_0]
	local var_18_3 = arg_18_0.taskProxy
	local var_18_4

	if not var_6.getTaskById(var_18_3, var_18_2) then
		var_18_3 = arg_18_0.taskProxy
		var_18_4 = var_6.getFinishTaskById(var_18_3, var_18_2)
	end

	assert = var_7

	var_7(var_18_4, "without this task by id: " .. var_18_2)

	Drop = var_7

	local var_18_5 = var_7.Create(var_18_4:getConfig("award_display")[1])

	updateDrop = var_18_3

	var_18_3(var_18_1, var_18_5)

	onButton = var_18_3

	local var_18_6 = arg_18_0
	local var_18_7 = var_18_1

	local function var_18_8()
		local var_19_0 = arg_18_0
		local var_19_1 = var_0.emit

		BaseUI = var_2_10003

		var_19_1(var_19_0, var_2_10003.ON_DROP, var_18_5)

		return
	end

	SFX_PANEL = var_1_10013

	var_18_3(var_18_6, var_18_7, var_18_8, var_1_10013)

	local var_18_9 = var_18_4:getProgress()
	local var_18_10 = var_18_4
	local var_18_11 = var_18_4.getConfig(var_18_10, "target_num")
	local var_18_12 = var_18_4:getConfig("desc")

	utf8 = var_18_10

	if var_18_10.len(var_18_12) >= 11 then
		setScrollText = var_11

		var_11(arg_18_2:Find("mask/description"), var_18_12)
	else
		setText = var_11

		var_11(arg_18_2:Find("mask/description"), var_18_12)
	end

	local var_18_13 = arg_18_0
	local var_18_14, var_18_15 = arg_18_0.GetProgressColor(var_18_13)

	if var_18_14 then
		setColorStr = var_18_13

		local var_18_16

		if not var_18_13(var_18_9, var_18_14) then
			::label_18_0::

			var_18_16 = var_18_9
		end

		if var_18_15 then
			setColorStr = var_18_13

			local var_18_17

			if not var_18_13("/" .. var_18_11, var_18_15) then
				::label_18_1::

				var_18_17 = "/" .. var_18_11
			end

			setText = var_18_13

			var_18_13(arg_18_2:Find("progressText"), var_18_16 .. var_18_17)

			setSlider = var_18_13

			var_18_13(arg_18_2:Find("progress"), 0, var_18_11, var_18_9)

			local var_18_18 = arg_18_2:Find("go_btn")
			local var_18_19 = arg_18_2:Find("get_btn")
			local var_18_20 = arg_18_2
			local var_18_21 = arg_18_2.Find(var_18_20, "got_btn")
			local var_18_22 = var_18_4:getTaskStatus()

			setActive = var_18_20

			var_18_20(var_18_18, var_18_22 == 0)

			setActive = var_18_20

			var_18_20(var_18_19, var_18_22 == 1)

			setActive = var_18_20

			var_18_20(var_18_21, var_18_22 == 2)

			onButton = var_18_20

			local var_18_23 = arg_18_0
			local var_18_24 = var_18_18

			local function var_18_25()
				local var_20_0 = arg_18_0
				local var_20_1 = var_0.emit

				ActivityMediator = var_2_10003

				var_20_1(var_20_0, var_2_10003.ON_TASK_GO, var_18_4)

				return
			end

			SFX_PANEL = var_1_10022

			var_18_20(var_18_23, var_18_24, var_18_25, var_1_10022)

			onButton = var_18_20

			local var_18_26 = arg_18_0
			local var_18_27 = var_18_19

			local function var_18_28()
				local var_21_0 = {}
				local var_21_1 = var_18_4
				local var_21_2 = var_1.getConfig(var_21_1, "award_display")

				getProxy = var_2_10002
				PlayerProxy = var_4

				local var_21_3 = var_2_10002(var_4)
				local var_21_4 = var_2.getRawData(var_21_3)

				pg = var_4

				local var_21_5 = var_4.gameset.urpt_chapter_max.description[1]

				LOCK_UR_SHIP = var_21_3

				if var_21_3 then
					var_21_3 = 0
				else
					getProxy = var_21_3
					BagProxy = var_2_10007

					local var_21_6 = var_21_3(var_2_10007)

					var_21_3 = var_21_3.GetLimitCntById(var_21_6, var_21_5)
				end

				Task = var_2_10006

				local var_21_7, var_21_8 = var_2_10006.StaticJudgeOverflow(var_21_4.gold, var_21_4.oil, var_21_3, true, true, var_21_2)

				if var_21_7 then
					table = var_8

					var_8.insert(var_21_0, function(arg_22_0)
						pg = var_3_10001

						local var_22_0 = var_3_10001.MsgboxMgr.GetInstance()
						local var_22_1 = var_1.ShowMsgBox
						local var_22_2 = {}

						MSGBOX_TYPE_ITEM_BOX = var_3_10005
						var_22_2.type = var_3_10005
						i18n = var_3_10005
						var_22_2.content = var_3_10005("award_max_warning")
						var_22_2.items = var_21_8
						var_22_2.onYes = arg_22_0

						var_22_1(var_22_0, var_22_2)

						return
					end)
				end

				seriesAsync = var_8

				var_8(var_21_0, function()
					local var_23_0 = arg_18_0
					local var_23_1 = var_0.emit

					ActivityMediator = var_3_10003

					var_23_1(var_23_0, var_3_10003.ON_TASK_SUBMIT, var_18_4)

					return
				end)

				return
			end

			SFX_PANEL = var_1_10022

			var_18_20(var_18_26, var_18_27, var_18_28, var_1_10022)

			return
		end
	end
end

function var_0_1.OnUpdateFlush(arg_24_0)
	arg_24_0.nday = arg_24_0:getTaskIdx(arg_24_0.activity)

	if arg_24_0.dayTF then
		setText = var_1

		var_1(arg_24_0.dayTF, arg_24_0.nday)

		setText = var_1

		var_1(arg_24_0.maxDayTF, "/" .. #arg_24_0.taskGroup)
	end

	arg_24_0:LocalFresh(arg_24_0.nday)

	local var_24_0 = arg_24_0.uilist

	var_1.align(var_24_0, #arg_24_0.taskGroup[arg_24_0.nday])

	local var_24_1 = arg_24_0.taskWindow

	if var_1.isShowing(var_24_1) then
		local var_24_2 = arg_24_0.taskWindow

		var_1.ExecuteAction(var_24_2, "Show", arg_24_0.activity)
	end

	return
end

function var_0_1.getTaskIdx(arg_25_0, arg_25_1)
	local var_25_0 = 1
	local var_25_1 = arg_25_1
	local var_25_2 = arg_25_1.getNDay(var_25_1)
	local var_25_3 = #arg_25_0.taskGroup

	math = var_25_1

	local var_25_4 = var_25_1.min(var_25_2, var_25_3)
	local var_25_5 = true

	for iter_25_0 = 1, var_25_4 do
		if not var_25_5 then
			break
		end

		var_25_0 = iter_25_0

		if iter_25_0 < var_25_4 then
			ipairs = var_1_10011

			for iter_25_1, iter_25_2 in var_1_10011(arg_25_0.taskGroup[iter_25_0]) do
				if not arg_25_0:isTaskFinished(iter_25_2) then
					var_25_5 = false

					break
				end
			end
		end
	end

	math = var_7

	return var_7.min(var_25_0, var_25_3)
end

function var_0_1.isTaskFinished(arg_26_0, arg_26_1)
	if not arg_26_0.taskProxy then
		getProxy = var_2
		TaskProxy = var_1_10004
		arg_26_0.taskProxy = var_2(var_1_10004)
	end

	local var_26_0 = arg_26_0.taskProxy
	local var_26_2

	if not var_2.getTaskById(var_26_0, arg_26_1) then
		local var_26_1 = arg_26_0.taskProxy

		var_26_2 = var_2.getFinishTaskById(var_26_1, arg_26_1)
	end

	return var_26_2 and var_26_2:getTaskStatus() == 2
end

function var_0_1.GetProgressColor(arg_27_0)
	return "#ffbc46", "#52514a"
end

function var_0_1.OnHideFlush(arg_28_0)
	arg_28_0:InvalidateWriter()

	local var_28_0 = arg_28_0.taskWindow

	if var_1.isShowing(var_28_0) then
		local var_28_1 = arg_28_0.taskWindow

		var_1.Hide(var_28_1)
	end

	return
end

function var_0_1.OnDestroy(arg_29_0)
	arg_29_0:InvalidateWriter()

	if arg_29_0.taskWindow then
		local var_29_0 = arg_29_0.taskWindow

		var_1.Hide(var_29_0)

		local var_29_1 = arg_29_0.taskWindow

		var_1.Destroy(var_29_1)

		arg_29_0.taskWindow = nil
	end

	return
end

return var_0_1
