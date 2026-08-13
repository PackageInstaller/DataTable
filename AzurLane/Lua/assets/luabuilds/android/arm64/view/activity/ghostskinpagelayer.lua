class = var_0_10000

local var_0_0 = "GhostSkinPageLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))
local var_0_2

function var_0_1.getUIName(arg_1_0)
	return "GhostSkinPageUI"
end

function var_0_1.init(arg_2_0)
	ActivityConst = var_1_10001
	var_0_2 = var_1_10001.GOASTSTORYACTIVITY_ID
	getProxy = var_1
	ActivityProxy = var_1_10003

	local var_2_0 = var_1(var_1_10003)

	arg_2_0.activity = var_1.getActivityById(var_2_0, var_0_2)

	local var_2_1 = arg_2_0.activity

	arg_2_0.story = var_1.getConfig(var_2_1, "config_client").story
	arg_2_0.storyStateDic = {}

	local var_2_2 = arg_2_0.bg

	arg_2_0.item = var_1.Find(var_2_2, "task/item")

	local var_2_3 = arg_2_0.bg

	arg_2_0.items = var_1.Find(var_2_3, "task/items")
	UIItemList = var_1
	arg_2_0.uilist = var_1.New(arg_2_0.items, arg_2_0.item)
	setActive = var_1

	var_1(arg_2_0.item, false)

	onButton = var_1

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0._tf

	var_1(var_2_4, var_4.Find(var_2_5, "des/itemDes"), function()
		getProxy = var_2_10000
		ActivityProxy = var_2_10002

		local var_3_0 = var_2_10000(var_2_10002)
		local var_3_1 = var_0.getActivityById(var_3_0, var_0_2).data1
		local var_3_2 = {}

		DROP_TYPE_VITEM = var_3_0
		var_3_2.type = var_3_0

		local var_3_3 = arg_2_0.activity

		var_3_2.id = var_2.getConfig(var_3_3, "config_id")
		var_3_2.count = var_3_1

		local var_3_4 = arg_2_0
		local var_3_5 = var_2.emit

		BaseUI = var_5

		var_3_5(var_3_4, var_5.ON_DROP, var_3_2)

		return
	end)

	local var_2_6 = arg_2_0.uilist

	var_1.make(var_2_6, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_2_0

			var_3.UpdateTask(var_4_0, arg_4_1, arg_4_2)
		end

		return
	end)

	getProxy = var_1
	TaskProxy = var_2_6
	arg_2_0.taskProxy = var_1(var_2_6)

	arg_2_0:OnUpdateFlush()
	arg_2_0:UpdateItemView(arg_2_0.activity)
	arg_2_0:ShowMask(false)

	arg_2_0.isPlaying = false

	arg_2_0:InitStoryState()
	arg_2_0:UpdateStoryView()
	arg_2_0:DisplayBigTask()

	setText = var_1

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_3.Find(var_2_7, "task/taskAll/taskallReward/hasRewardText")

	i18n = var_4

	var_1(var_2_8, var_4("activity_1024_memory_get"))

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	arg_5_0:UpdataTaskData()

	local var_5_0 = arg_5_0.uilist

	var_1.align(var_5_0, #arg_5_0.taskGroup)

	return
end

function var_0_1.UpdataTaskData(arg_6_0)
	arg_6_0.taskGroup = {}

	local var_6_0 = arg_6_0.activity
	local var_6_1 = #var_1.getConfig(var_6_0, "config_client").group_1

	arg_6_0.allCompleteCount = 0
	ipairs = var_3

	for iter_6_0, iter_6_1 in var_3(var_1.group_1) do
		local var_6_2 = arg_6_0.taskProxy
		local var_6_3

		if not var_8.getTaskById(var_6_2, iter_6_1) then
			var_6_2 = arg_6_0.taskProxy
			var_6_3 = var_8.getFinishTaskById(var_6_2, iter_6_1)
		end

		if var_6_3:getTaskStatus() == 0 or var_9 == 1 or iter_6_0 == var_6_1 then
			table = var_6_2

			var_6_2.insert(arg_6_0.taskGroup, iter_6_1)

			local var_6_4

			if iter_6_0 == var_6_1 and var_9 == 2 then
				var_6_4 = iter_6_0
			else
				var_6_4 = iter_6_0 - 1
			end

			arg_6_0.allCompleteCount = arg_6_0.allCompleteCount + var_6_4

			break
		end
	end

	local var_6_5 = #var_1.group_2

	ipairs = var_4

	for iter_6_2, iter_6_3 in var_4(var_1.group_2) do
		local var_6_6 = arg_6_0.taskProxy
		local var_6_7

		if not var_9.getTaskById(var_6_6, iter_6_3) then
			var_6_6 = arg_6_0.taskProxy
			var_6_7 = var_9.getFinishTaskById(var_6_6, iter_6_3)
		end

		if var_6_7:getTaskStatus() == 0 or var_10 == 1 or iter_6_2 == var_6_5 then
			table = var_6_6

			var_6_6.insert(arg_6_0.taskGroup, iter_6_3)

			local var_6_8

			if iter_6_2 == var_6_5 and var_10 == 2 then
				var_6_8 = iter_6_2
			else
				var_6_8 = iter_6_2 - 1
			end

			arg_6_0.allCompleteCount = arg_6_0.allCompleteCount + var_6_8

			break
		end
	end

	return
end

function var_0_1.UpdateTask(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1 + 1
	local var_7_1 = arg_7_2:Find("item")
	local var_7_2 = arg_7_0.taskGroup[var_7_0]
	local var_7_3 = arg_7_0.taskProxy
	local var_7_4

	if not var_6.getTaskById(var_7_3, var_7_2) then
		var_7_3 = arg_7_0.taskProxy
		var_7_4 = var_6.getFinishTaskById(var_7_3, var_7_2)
	end

	assert = var_7

	var_7(var_7_4, "without this task by id: " .. var_7_2)

	Drop = var_7

	local var_7_5 = var_7.Create(var_7_4:getConfig("award_display")[1])

	updateDrop = var_7_3

	var_7_3(var_7_1, var_7_5)

	onButton = var_7_3

	local var_7_6 = arg_7_0
	local var_7_7 = var_7_1

	local function var_7_8()
		local var_8_0 = arg_7_0
		local var_8_1 = var_0.emit

		BaseUI = var_2_10003

		var_8_1(var_8_0, var_2_10003.ON_DROP, var_7_5)

		return
	end

	SFX_PANEL = var_1_10013

	var_7_3(var_7_6, var_7_7, var_7_8, var_1_10013)

	local var_7_9 = var_7_4:getProgress()
	local var_7_10 = var_7_4:getConfig("target_num")

	if arg_7_0.allCompleteCount == 8 then
		var_7_9 = var_7_10
	end

	local var_7_11 = arg_7_0
	local var_7_12, var_7_13 = arg_7_0.GetProgressColor(var_7_11)

	if var_7_12 then
		setColorStr = var_7_11

		local var_7_14

		if not var_7_11(var_7_9, var_7_12) then
			::label_7_0::

			var_7_14 = var_7_9
		end

		if var_7_13 then
			setColorStr = var_7_11

			local var_7_15

			if not var_7_11("/" .. var_7_10, var_7_13) then
				::label_7_1::

				var_7_15 = "/" .. var_7_10
			end

			setActive = var_7_11

			var_7_11(arg_7_2:Find("progressText"), false)

			local var_7_16 = var_7_4:getConfig("desc") .. " (" .. var_7_14 .. var_7_15 .. ")"

			setText = var_13

			var_13(arg_7_2:Find("description"), var_7_16)

			setSlider = var_13

			var_13(arg_7_2:Find("progress"), 0, var_7_10, var_7_9)

			local var_7_17 = arg_7_2:Find("go_btn")
			local var_7_18 = arg_7_2:Find("get_btn")
			local var_7_19 = arg_7_2:Find("got_btn")
			local var_7_20 = var_7_4:getTaskStatus()

			if arg_7_0.allCompleteCount == 8 then
				var_7_20 = 2
			end

			setActive = var_17

			var_17(var_7_17, var_7_20 == 0)

			setActive = var_17

			var_17(var_7_18, var_7_20 == 1)

			setActive = var_17

			var_17(var_7_19, var_7_20 == 2)

			onButton = var_17

			local var_7_21 = arg_7_0
			local var_7_22 = var_7_17

			local function var_7_23()
				local var_9_0 = arg_7_0
				local var_9_1 = var_0.emit

				ActivityMediator = var_2_10003

				var_9_1(var_9_0, var_2_10003.ON_TASK_GO, var_7_4)

				return
			end

			SFX_PANEL = var_1_10022

			var_17(var_7_21, var_7_22, var_7_23, var_1_10022)

			onButton = var_17

			local var_7_24 = arg_7_0
			local var_7_25 = var_7_18

			local function var_7_26()
				local var_10_0 = {}
				local var_10_1 = var_7_4
				local var_10_2 = var_1.getConfig(var_10_1, "award_display")

				getProxy = var_2_10002
				PlayerProxy = var_4

				local var_10_3 = var_2_10002(var_4)
				local var_10_4 = var_2.getRawData(var_10_3)

				pg = var_4

				local var_10_5 = var_4.gameset.urpt_chapter_max.description[1]

				LOCK_UR_SHIP = var_10_3

				if var_10_3 then
					var_10_3 = 0
				else
					getProxy = var_10_3
					BagProxy = var_2_10007

					local var_10_6 = var_10_3(var_2_10007)

					var_10_3 = var_10_3.GetLimitCntById(var_10_6, var_10_5)
				end

				Task = var_2_10006

				local var_10_7, var_10_8 = var_2_10006.StaticJudgeOverflow(var_10_4.gold, var_10_4.oil, var_10_3, true, true, var_10_2)

				if var_10_7 then
					table = var_8

					var_8.insert(var_10_0, function(arg_11_0)
						pg = var_3_10001

						local var_11_0 = var_3_10001.MsgboxMgr.GetInstance()
						local var_11_1 = var_1.ShowMsgBox
						local var_11_2 = {}

						MSGBOX_TYPE_ITEM_BOX = var_3_10005
						var_11_2.type = var_3_10005
						i18n = var_3_10005
						var_11_2.content = var_3_10005("award_max_warning")
						var_11_2.items = var_10_8
						var_11_2.onYes = arg_11_0

						var_11_1(var_11_0, var_11_2)

						return
					end)
				end

				seriesAsync = var_8

				var_8(var_10_0, function()
					local var_12_0 = arg_7_0
					local var_12_1 = var_0.emit

					GhostSkinMediator = var_3_10003

					var_12_1(var_12_0, var_3_10003.ON_TASK_SUBMIT, var_7_4)

					return
				end)

				return
			end

			SFX_PANEL = var_1_10022

			var_17(var_7_24, var_7_25, var_7_26, var_1_10022)

			local var_7_27 = arg_7_0.allCompleteCount < 8 and var_7_20 == 1
			local var_7_28 = arg_7_2:Find("reddot")

			setActive = var_7_24

			var_7_24(var_7_28, var_7_27)

			return
		end
	end
end

function var_0_1.DisplayBigTask(arg_13_0)
	local var_13_0 = arg_13_0.activity
	local var_13_1 = var_1.getConfig(var_13_0, "config_client").group_3[1]
	local var_13_2 = arg_13_0.taskProxy
	local var_13_3

	if not var_2.getTaskById(var_13_2, var_13_1) then
		var_13_2 = arg_13_0.taskProxy
		var_13_3 = var_2.getFinishTaskById(var_13_2, var_13_1)
	end

	assert = var_13_0

	var_13_0(var_13_3, "without this task by id: " .. var_13_1)

	local var_13_4 = arg_13_0._tf
	local var_13_5 = var_3.Find(var_13_4, "task/allTaskItem")

	Drop = var_13_2

	local var_13_6 = var_13_2.Create(var_13_3:getConfig("award_display")[1])

	updateDrop = var_13_4

	var_13_4(var_13_5, var_13_6)

	onButton = var_13_4

	local var_13_7 = arg_13_0
	local var_13_8 = var_13_5

	local function var_13_9()
		local var_14_0 = arg_13_0
		local var_14_1 = var_0.emit

		BaseUI = var_2_10003

		var_14_1(var_14_0, var_2_10003.ON_DROP, var_13_6)

		return
	end

	SFX_PANEL = var_1_10010

	var_13_4(var_13_7, var_13_8, var_13_9, var_1_10010)

	local var_13_10 = var_13_3:getTaskStatus()

	setActive = var_6

	local var_13_11 = arg_13_0._tf

	var_6(var_8.Find(var_13_11, "task/taskAll/taskallReward"), var_13_10 == 2)

	return
end

function var_0_1.GetProgressColor(arg_15_0)
	return nil
end

function var_0_1.InitStoryState(arg_16_0)
	ipairs = var_1_10001

	for iter_16_0, iter_16_1 in var_1_10001(arg_16_0.story) do
		checkExist = var_1_10006

		if var_1_10006(arg_16_0.story, {
			iter_16_0
		}, {
			1
		}) then
			var_1_10006 = false

			local var_16_0 = iter_16_1[1]

			pg = var_8

			local var_16_1 = var_8.NewStoryMgr.GetInstance()

			if var_8.IsPlayed(var_16_1, var_16_0) then
				var_1_10006 = true
			end

			pg = var_8

			local var_16_2 = var_8.NewStoryMgr.GetInstance()
			local var_16_3 = var_8.StoryName2StoryId(var_16_2, var_16_0)

			arg_16_0.storyStateDic[var_16_3] = var_1_10006
		end
	end

	return
end

function var_0_1.UpdateStoryView(arg_17_0)
	local var_17_0 = {
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8"
	}

	ipairs = var_1_10002

	for iter_17_0, iter_17_1 in var_1_10002(var_17_0) do
		local var_17_1 = arg_17_0.story[iter_17_0][1]

		pg = var_1_10008

		local var_17_2 = var_1_10008.NewStoryMgr.GetInstance()

		var_1_10008 = var_1_10008.StoryName2StoryId(var_17_2, var_17_1)

		local var_17_3 = arg_17_0.storyStateDic[var_1_10008]
		local var_17_4 = arg_17_0._tf
		local var_17_5 = var_10.Find(var_17_4, "frame/" .. iter_17_1 .. "/locked")
		local var_17_6 = arg_17_0._tf
		local var_17_7 = var_11.Find(var_17_6, "frame/" .. iter_17_1)

		setActive = var_17_4

		var_17_4(var_17_5, not var_17_3)

		if var_17_3 then
			onButton = var_17_4

			var_17_4(arg_17_0, var_17_7, function()
				pg = var_2_10000

				local var_18_0 = var_2_10000.NewStoryMgr.GetInstance()
				local var_18_1 = var_0.Play

				pg = var_2_10003

				local var_18_2 = var_2_10003.NewStoryMgr.GetInstance()

				var_18_1(var_18_0, var_3.StoryId2StoryName(var_18_2, var_1_10008), nil, true)

				return
			end)
		else
			onButton = var_17_4

			var_17_4(arg_17_0, var_17_5, function()
				getProxy = var_2_10000
				ActivityProxy = var_2_10002

				local var_19_0 = var_2_10000(var_2_10002)
				local var_19_2

				if var_0.getActivityById(var_19_0, var_0_2).data1 <= 0 then
					pg = var_19_2

					local var_19_1 = var_19_2.TipsMgr.GetInstance()

					var_19_2 = var_19_2.ShowTips
					i18n = var_2_10004

					var_19_2(var_19_1, var_2_10004("activity_1024_memory"))

					return
				end

				pg = var_19_2

				local var_19_3 = var_19_2.m02
				local var_19_4 = var_1.sendNotification

				GAME = var_2_10004

				var_19_4(var_19_3, var_2_10004.ACTIVITY_UNLOCKSTORY, {
					cmd = 1,
					activity_id = arg_17_0.activity.id,
					arg1 = var_1_10008
				})

				return
			end)
		end
	end

	return
end

function var_0_1.UpdateItemView(arg_20_0, arg_20_1)
	setText = var_1_10002

	local var_20_0 = arg_20_0._tf
	local var_20_1 = var_4.Find(var_20_0, "des/count")

	tostring = var_1_10005

	var_1_10002(var_20_1, var_1_10005(arg_20_1.data1))

	return
end

function var_0_1.UpdataStoryState(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1.storyId

	arg_21_0.storyStateDic[var_21_0] = true

	local var_21_1 = 0

	ipairs = var_4

	for iter_21_0, iter_21_1 in var_4(arg_21_0.story) do
		local var_21_2 = iter_21_1[1]

		pg = var_1_10010

		local var_21_3 = var_1_10010.NewStoryMgr.GetInstance()

		if var_1_10010.StoryName2StoryId(var_21_3, var_21_2) == var_21_0 then
			var_21_1 = iter_21_0
		end
	end

	local var_21_4 = {
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8"
	}

	ipairs = var_5

	for iter_21_2, iter_21_3 in var_5(var_21_4) do
		if iter_21_2 == var_21_1 then
			local var_21_5 = arg_21_0.storyStateDic[var_21_0]
			local var_21_6 = arg_21_0._tf
			local var_21_7 = var_11.Find(var_21_6, "frame/" .. iter_21_3 .. "/locked")
			local var_21_8 = arg_21_0._tf
			local var_21_9 = var_12.Find(var_21_8, "frame/" .. iter_21_3)
			local var_21_10 = var_21_7
			local var_21_11 = var_21_7.GetComponent

			typeof = var_16
			Animation = var_1_10018

			local var_21_12 = var_21_11(var_21_10, var_16(var_1_10018))
			local var_21_13 = var_13.GetClip(var_21_12, "anim_GhostSkin_unlock_1").length

			var_13:Play("anim_GhostSkin_unlock_1")
			arg_21_0:ShowMask(true)

			arg_21_0.isPlaying = true
			onDelayTick = var_15

			var_15(function()
				local var_22_0 = arg_21_0

				var_22_0.isPlaying = false
				setActive = var_22_0

				var_22_0(var_21_7, not var_21_5)

				local var_22_1 = arg_21_0

				var_0.ShowMask(var_22_1, false)

				pg = var_0

				local var_22_2 = var_0.NewStoryMgr.GetInstance()
				local var_22_3 = var_0.Play

				pg = var_3

				local var_22_4 = var_3.NewStoryMgr.GetInstance()

				var_22_3(var_22_2, var_3.StoryId2StoryName(var_22_4, var_21_0), function()
					local var_23_0 = arg_21_0

					var_0.ShouldRewardAll(var_23_0, false)

					return
				end)

				return
			end, var_21_13)

			onButton = var_15

			var_15(arg_21_0, var_21_9, function()
				pg = var_2_10000

				local var_24_0 = var_2_10000.NewStoryMgr.GetInstance()
				local var_24_1 = var_0.Play

				pg = var_2_10003

				local var_24_2 = var_2_10003.NewStoryMgr.GetInstance()

				var_24_1(var_24_0, var_3.StoryId2StoryName(var_24_2, var_21_0), nil, true)

				return
			end)
		end
	end

	return
end

function var_0_1.ShouldRewardAll(arg_25_0, arg_25_1)
	local function var_25_0()
		pairs = var_2_10000

		for iter_26_0, iter_26_1 in var_2_10000(arg_25_0.storyStateDic) do
			if iter_26_1 == false then
				return false
			end
		end

		return true
	end

	local function var_25_1()
		if not arg_25_1 then
			return true
		end

		local var_27_0 = arg_25_0.activity
		local var_27_1 = var_0.getConfig(var_27_0, "config_client").group_3[1]
		local var_27_2 = arg_25_0.taskProxy
		local var_27_4

		if not var_1.getTaskById(var_27_2, var_27_1) then
			local var_27_3 = arg_25_0.taskProxy

			var_27_4 = var_1.getFinishTaskById(var_27_3, var_27_1)
		end

		assert = var_27_0

		var_27_0(var_27_4, "without this task by id: " .. var_27_1)

		if var_27_4:getTaskStatus() == 1 then
			return true
		end

		return false
	end

	if var_25_0() and var_25_1() then
		local var_25_2 = {}
		local var_25_3 = arg_25_0.activity
		local var_25_4 = var_5.getConfig(var_25_3, "config_client").group_3[1]
		local var_25_5 = arg_25_0.taskProxy
		local var_25_6

		if not var_6.getTaskById(var_25_5, var_25_4) then
			var_25_5 = arg_25_0.taskProxy
			var_25_6 = var_6.getFinishTaskById(var_25_5, var_25_4)
		end

		local var_25_7 = var_25_6:getConfig("award_display")

		getProxy = var_25_5
		PlayerProxy = var_10

		local var_25_8 = var_25_5(var_10)
		local var_25_9 = var_8.getRawData(var_25_8)

		pg = var_10

		local var_25_10 = var_10.gameset.urpt_chapter_max.description[1]

		LOCK_UR_SHIP = var_25_8

		if var_25_8 then
			var_25_8 = 0
		else
			getProxy = var_25_8
			BagProxy = var_1_10013

			local var_25_11 = var_25_8(var_1_10013)

			var_25_8 = var_25_8.GetLimitCntById(var_25_11, var_25_10)
		end

		Task = var_1_10012

		local var_25_12, var_25_13 = var_1_10012.StaticJudgeOverflow(var_25_9.gold, var_25_9.oil, var_25_8, true, true, var_25_7)

		if var_25_12 then
			table = var_14

			var_14.insert(var_25_2, function(arg_28_0)
				pg = var_2_10001

				local var_28_0 = var_2_10001.MsgboxMgr.GetInstance()
				local var_28_1 = var_1.ShowMsgBox
				local var_28_2 = {}

				MSGBOX_TYPE_ITEM_BOX = var_2_10005
				var_28_2.type = var_2_10005
				i18n = var_2_10005
				var_28_2.content = var_2_10005("award_max_warning")
				var_28_2.items = var_25_13
				var_28_2.onYes = arg_28_0

				var_28_1(var_28_0, var_28_2)

				return
			end)
		end

		seriesAsync = var_14

		var_14(var_25_2, function()
			local var_29_0 = arg_25_0
			local var_29_1 = var_0.emit

			GhostSkinMediator = var_2_10003

			var_29_1(var_29_0, var_2_10003.ON_TASK_SUBMIT, var_25_6)

			return
		end)
	end

	return
end

function var_0_1.didEnter(arg_30_0)
	onButton = var_1_10001

	local var_30_0 = arg_30_0
	local var_30_1 = arg_30_0._tf
	local var_30_2 = var_4.Find(var_30_1, "title/back")

	local function var_30_3()
		local var_31_0 = arg_30_0

		var_0.onBackPressed(var_31_0)

		return
	end

	SFX_PANEL = var_30_1

	var_1_10001(var_30_0, var_30_2, var_30_3, var_30_1)
	arg_30_0:ShouldRewardAll(true)

	return
end

function var_0_1.ShowMask(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0._tf
	local var_32_1

	var_32_1, GetOrAddComponent = var_2.Find(var_32_0, "mask"), var_1_10003
	typeof = var_1_10006
	CanvasGroup = var_1_10008
	var_1_10003(var_32_1, var_1_10006(var_1_10008)).blocksRaycasts = arg_32_1

	return
end

function var_0_1.onBackPressed(arg_33_0)
	if arg_33_0.isPlaying then
		return
	end

	arg_33_0.super.onBackPressed(arg_33_0)

	return
end

function var_0_1.IsShowRed()
	getProxy = var_1_10000
	TaskProxy = var_1_10002

	local var_34_0 = var_1_10000(var_1_10002)

	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_34_1 = var_1_10001(var_1_10003)
	local var_34_2 = var_1.getActivityById

	ActivityConst = var_1_10004

	local var_34_3 = var_34_2(var_34_1, var_1_10004.GOASTSTORYACTIVITY_ID)
	local var_34_4 = var_1.getConfig(var_34_3, "config_client")
	local var_34_5 = 0
	local var_34_6 = false

	ipairs = var_5

	for iter_34_0, iter_34_1 in var_5(var_34_4.group_1) do
		local var_34_7

		if not var_34_0:getTaskById(iter_34_1) then
			var_34_7 = var_34_0:getFinishTaskById(iter_34_1)
		end

		if var_34_7 then
			if var_34_7:getTaskStatus() == 2 then
				var_34_5 = var_34_5 + 1
			elseif var_11 == 1 then
				var_34_6 = true
			end
		end
	end

	ipairs = var_5

	for iter_34_2, iter_34_3 in var_5(var_34_4.group_2) do
		local var_34_8

		if not var_34_0:getTaskById(iter_34_3) then
			var_34_8 = var_34_0:getFinishTaskById(iter_34_3)
		end

		if var_34_8 then
			if var_34_8:getTaskStatus() == 2 then
				var_34_5 = var_34_5 + 1
			elseif var_11 == 1 then
				var_34_6 = true
			end
		end
	end

	return var_34_5 < 8 and var_34_6
end

return var_0_1
