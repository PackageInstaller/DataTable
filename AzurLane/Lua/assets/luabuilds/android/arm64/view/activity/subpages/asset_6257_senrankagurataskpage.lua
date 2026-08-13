class = var_0_10000

local var_0_0 = "SenrankaguraTaskPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003
	arg_1_0.taskProxy = var_1_10001(var_1_10003)
	getProxy = var_1
	ActivityProxy = var_1_10003
	arg_1_0.activityProxy = var_1(var_1_10003)

	arg_1_0:findUI()

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity

	arg_2_0.configID = var_1.getConfig(var_2_0, "config_id")
	pg = var_1
	arg_2_0.configData = var_1.activity_event_turning[arg_2_0.configID]
	arg_2_0.groupNum = arg_2_0.configData.total_num

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	return
end

function var_0_1.OnUpdateFlush(arg_4_0)
	local var_4_0 = arg_4_0:getCurIndex()

	if arg_4_0.markClickPos and arg_4_0.markClickPos > 0 then
		print = var_2

		var_2("有操作再更新任务面板")
		arg_4_0:openTaskAni()
	elseif var_4_0 > 0 then
		if arg_4_0.activity.data4 <= arg_4_0.groupNum then
			print = var_2

			var_2("直接更新任务面板")
			arg_4_0:updateTaskPanel()

			setActive = var_2

			var_2(arg_4_0.posPanel, false)

			setActive = var_2

			var_2(arg_4_0.taskPanel, true)
		end
	elseif var_4_0 == 0 then
		arg_4_0:updatePosPanel()

		setActive = var_2

		var_2(arg_4_0.posPanel, true)

		setActive = var_2

		var_2(arg_4_0.taskPanel, false)

		if arg_4_0:getStep() > arg_4_0.groupNum then
			-- block empty
		end
	end

	arg_4_0:check()
	arg_4_0:updateLogText()

	return
end

function var_0_1.onDestroy(arg_5_0)
	return
end

function var_0_1.findUI(arg_6_0)
	local var_6_0 = arg_6_0._tf
	local var_6_1 = var_1.Find(var_6_0, "IconList")

	arg_6_0.nameList = {
		"feiniao",
		"banjiu",
		"yan",
		"xuequan",
		"xuebugui",
		"zi",
		"xishao"
	}
	arg_6_0.paintingList = {
		"asuka",
		"ikaruga",
		"homura",
		"yumi",
		"fubuki",
		"murasaki",
		"yuuyaki"
	}
	arg_6_0.iconSpriteDict = {}
	ipairs = var_2

	for iter_6_0, iter_6_1 in var_2(arg_6_0.nameList) do
		local var_6_2 = var_6_1:Find(iter_6_1)

		getImageSprite = var_1_10008
		var_1_10008 = var_1_10008(var_6_2)
		arg_6_0.iconSpriteDict[iter_6_0] = var_1_10008
		arg_6_0.iconSpriteDict[iter_6_1] = var_1_10008
	end

	local var_6_3 = arg_6_0._tf
	local var_6_4 = var_2.Find(var_6_3, "HXList")
	local var_6_5 = {
		"feiniao",
		"yan",
		"xuequan",
		"xuebugui",
		"xishao"
	}

	arg_6_0.hxSpriteDict = {}
	ipairs = var_4

	for iter_6_2, iter_6_3 in var_4(var_6_5) do
		local var_6_6 = var_6_4:Find(iter_6_3)

		getImageSprite = var_1_10010
		var_1_10010 = var_1_10010(var_6_6)
		arg_6_0.hxSpriteDict[iter_6_3] = var_1_10010
	end

	arg_6_0.hxPosDict = {
		feiniao = {
			x = -47,
			y = -7
		},
		yan = {
			x = 24,
			y = -176
		},
		xuequan = {
			x = -92,
			y = -126
		},
		xuebugui = {
			x = 5,
			y = 22
		},
		xishao = {
			x = -86,
			y = -21
		}
	}
	arg_6_0.paintingPosDict = {
		feiniao = {
			x = 42,
			y = -22
		},
		banjiu = {
			x = 23,
			y = -8
		},
		yan = {
			x = -11,
			y = 20
		},
		xuequan = {
			x = 39,
			y = 30
		},
		xuebugui = {
			x = 26,
			y = 12
		},
		zi = {
			x = 46,
			y = 36
		},
		xishao = {
			x = 20,
			y = -1
		}
	}

	local var_6_7 = arg_6_0._tf

	arg_6_0.posPanel = var_4.Find(var_6_7, "PosPanel")

	local var_6_8 = arg_6_0.posPanel

	arg_6_0.finalLockTF = var_4.Find(var_6_8, "FinalAward/Lock")

	local var_6_9 = arg_6_0.posPanel

	arg_6_0.finalGotTF = var_4.Find(var_6_9, "FinalAward/Got")
	arg_6_0.posTFList = {}

	local var_6_10 = arg_6_0.posPanel
	local var_6_11 = var_4.Find(var_6_10, "PosList")

	for iter_6_4 = 1, #arg_6_0.nameList do
		local var_6_12 = var_6_11
		local var_6_13 = var_6_11.Find(var_6_12, iter_6_4)

		table = var_1_10010

		var_1_10010.insert(arg_6_0.posTFList, var_6_13)

		var_1_10010 = var_6_13:Find("Get")
		onButton = var_6_12

		local var_6_14 = arg_6_0
		local var_6_15 = var_1_10010

		local function var_6_16()
			local var_7_0 = arg_6_0
			local var_7_1 = var_0.getStep(var_7_0)
			local var_7_2 = arg_6_0

			if var_7_1 < var_1.getCurDayCount(var_7_2) and var_7_1 < arg_6_0.groupNum then
				arg_6_0.markClickPos = iter_6_4

				local var_7_3 = arg_6_0

				var_2.selectPos(var_7_3, iter_6_4)
			end

			return
		end

		SFX_PANEL = var_1_10016

		var_6_12(var_6_14, var_6_15, var_6_16, var_1_10016)
	end

	local var_6_17 = arg_6_0._tf

	arg_6_0.taskPanel = var_5.Find(var_6_17, "TaskPanel")

	local var_6_18 = arg_6_0.taskPanel

	arg_6_0.paintingTF = var_5.Find(var_6_18, "PaintingPanel/Main/Painting")

	local var_6_19 = arg_6_0.taskPanel

	arg_6_0.paintingHXTF = var_5.Find(var_6_19, "PaintingPanel/Main/HX")
	arg_6_0.progressTFList = {}

	local var_6_20 = arg_6_0.taskPanel
	local var_6_21 = var_5.Find(var_6_20, "Progress")

	for iter_6_5 = 1, #arg_6_0.nameList do
		local var_6_22 = var_6_21:Find(iter_6_5)

		arg_6_0.progressTFList[iter_6_5] = var_6_22
	end

	arg_6_0.taskTFList = {}

	local var_6_23 = arg_6_0.taskTFList
	local var_6_24 = arg_6_0.taskPanel

	var_6_23[1] = var_7.Find(var_6_24, "Task1")

	local var_6_25 = arg_6_0.taskTFList
	local var_6_26 = arg_6_0.taskPanel

	var_6_25[2] = var_7.Find(var_6_26, "Task2")

	local var_6_27 = arg_6_0._tf

	arg_6_0.logText = var_6.Find(var_6_27, "LogText")

	return
end

function var_0_1.updatePosPanel(arg_8_0)
	local var_8_0 = arg_8_0.posTFList
	local var_8_1 = arg_8_0.activity.data1_list

	ipairs = var_1_10003

	for iter_8_0, iter_8_1 in var_1_10003(var_8_0) do
		local var_8_2 = var_8_1[iter_8_0] > 0
		local var_8_3 = iter_8_1:Find("Got")
		local var_8_4 = var_9.Find(var_8_3, "Icon")
		local var_8_5 = var_8_1[iter_8_0]
		local var_8_6 = arg_8_0.iconSpriteDict[var_8_5]

		setImageSprite = var_13

		var_13(var_8_4, var_8_6, true)

		setActive = var_13

		var_13(var_9, var_8_2)
	end

	local var_8_7 = arg_8_0:isGotFinalAward()

	setActive = var_4

	var_4(arg_8_0.finalGotTF, var_8_7)

	setActive = var_4

	var_4(arg_8_0.finalLockTF, not var_8_7)

	return
end

function var_0_1.updateTaskPanel(arg_9_0)
	arg_9_0:updateTaskList()
	arg_9_0:updateProgress()
	arg_9_0:updatePainting()

	return
end

function var_0_1.updateTaskList(arg_10_0)
	local var_10_0 = arg_10_0:getCurTaskIDList()

	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.taskTFList) do
		local var_10_1 = var_10_0[iter_10_0]
		local var_10_2 = arg_10_0.taskProxy
		local var_10_3 = var_8.getTaskVO(var_10_2, var_10_1)
		local var_10_4 = iter_10_1:Find("Desc")

		setText = var_10_2

		var_10_2(var_10_4, var_10_3:getConfig("desc"))

		local var_10_5 = var_10_3:getProgress()
		local var_10_6 = var_10_3:getConfig("target_num")
		local var_10_7 = iter_10_1
		local var_10_8 = iter_10_1.Find(var_10_7, "ProgressText")
		local var_10_9 = iter_10_1:Find("ProgressBar")

		setText = var_10_7

		var_10_7(var_10_8, var_10_5 .. "/" .. var_10_6)

		setSlider = var_10_7

		var_10_7(var_10_9, 0, var_10_6, var_10_5)

		local var_10_10 = var_10_3:getTaskStatus()
		local var_10_11 = iter_10_1:Find("GetBtn")
		local var_10_12 = iter_10_1
		local var_10_13 = iter_10_1.Find(var_10_12, "GotBtn")
		local var_10_14 = iter_10_1:Find("GoBtn")

		setActive = var_10_12

		var_10_12(var_10_14, var_10_10 == 0)

		setActive = var_10_12

		var_10_12(var_10_11, var_10_10 == 1)

		setActive = var_10_12

		var_10_12(var_10_13, var_10_10 == 2)

		onButton = var_10_12

		local var_10_15 = arg_10_0
		local var_10_16 = var_10_14

		local function var_10_17()
			local var_11_0 = arg_10_0
			local var_11_1 = var_0.emit

			ActivityMediator = var_2_10003

			var_11_1(var_11_0, var_2_10003.ON_TASK_GO, var_10_3)

			return
		end

		SFX_PANEL = var_1_10023

		var_10_12(var_10_15, var_10_16, var_10_17, var_1_10023)

		onButton = var_10_12

		local var_10_18 = arg_10_0
		local var_10_19 = var_10_11

		local function var_10_20()
			local var_12_0 = arg_10_0
			local var_12_1 = var_0.emit

			ActivityMediator = var_2_10003

			var_12_1(var_12_0, var_2_10003.ON_TASK_SUBMIT, var_10_3)

			return
		end

		SFX_PANEL = var_1_10023

		var_10_12(var_10_18, var_10_19, var_10_20, var_1_10023)

		local var_10_21 = var_10_3:getConfig("award_display")[1]
		local var_10_22 = {
			type = var_10_21[1],
			id = var_10_21[2],
			count = var_10_21[3]
		}
		local var_10_23 = iter_10_1:Find("Icon")

		updateDrop = var_21

		var_21(var_10_23, var_10_22)

		onButton = var_21
		var_1_10023 = arg_10_0

		local var_10_24 = var_10_23

		local function var_10_25()
			local var_13_0 = arg_10_0
			local var_13_1 = var_0.emit

			BaseUI = var_2_10003

			var_13_1(var_13_0, var_2_10003.ON_DROP, var_10_22)

			return
		end

		SFX_PANEL = var_1_10026

		var_21(var_1_10023, var_10_24, var_10_25, var_1_10026)

		var_1_10023 = arg_10_0

		if arg_10_0.isFinishedCurTaskList(var_1_10023) then
			local var_10_26 = arg_10_0
			local var_10_27 = arg_10_0.getStep(var_10_26)

			var_1_10023 = arg_10_0.configData.story_task[var_10_27][1]
			print = var_10_26
			var_1_10026 = "story"
			tostring = var_1_10027

			var_10_26(var_1_10026, var_1_10027(var_1_10023))

			if var_1_10023 then
				pg = var_10_26
				var_1_10026 = var_10_26.NewStoryMgr.GetInstance()

				var_24.Play(var_1_10026, var_1_10023, nil)
			end
		end
	end

	return
end

function var_0_1.updateProgress(arg_14_0)
	local var_14_0 = arg_14_0:getStep()

	ipairs = var_1_10002

	for iter_14_0, iter_14_1 in var_1_10002(arg_14_0.progressTFList) do
		local var_14_1 = iter_14_1:Find("Get")
		local var_14_2 = iter_14_1
		local var_14_3 = iter_14_1.Find(var_14_2, "Got")
		local var_14_4 = iter_14_1:Find("Doing")

		setActive = var_14_2

		var_14_2(var_14_3, iter_14_0 < var_14_0)

		setActive = var_14_2

		var_14_2(var_14_1, var_14_0 < iter_14_0)

		setActive = var_14_2

		var_14_2(var_14_4, iter_14_0 == var_14_0)
	end

	return
end

function var_0_1.updatePainting(arg_15_0)
	local var_15_0 = arg_15_0:getCurIndex()
	local var_15_1 = arg_15_0.nameList[var_15_0]
	local var_15_2 = arg_15_0.paintingList[var_15_0]

	LoadSprite = var_1_10004

	local var_15_3 = var_1_10004("activitypainting/" .. var_15_2, var_15_2)

	setImageSprite = var_1_10005

	var_1_10005(arg_15_0.paintingTF, var_15_3, true)

	local var_15_4 = arg_15_0.paintingPosDict[var_15_1]

	setLocalPosition = var_6

	var_6(arg_15_0.paintingTF, var_15_4)

	PLATFORM_CODE = var_6
	PLATFORM_CH = var_15_5

	if var_6 == var_15_5 then
		local var_15_5

		if arg_15_0.hxPosDict[var_15_1] then
			var_15_5 = arg_15_0.hxSpriteDict[var_15_1]
			setImageSprite = var_8

			var_8(arg_15_0.paintingHXTF, var_15_5, true)

			setLocalPosition = var_8

			var_8(arg_15_0.paintingHXTF, var_6)

			setActive = var_8

			var_8(arg_15_0.paintingHXTF, true)
		else
			setActive = var_15_5

			var_15_5(arg_15_0.paintingHXTF, false)
		end
	else
		setActive = var_6

		var_6(arg_15_0.paintingHXTF, false)
	end

	return
end

function var_0_1.openTaskAni(arg_16_0)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.getCurIndex(var_16_0)
	local var_16_2 = arg_16_0.activity.data1_list

	table = var_16_0

	local var_16_3 = var_16_0.indexof(var_16_2, var_16_1, 1)
	local var_16_4 = arg_16_0.posTFList[var_16_3]
	local var_16_5 = var_4.Find(var_16_4, "Get")
	local var_16_6 = var_4
	local var_16_7 = var_4.Find(var_16_6, "Got")

	setImageAlpha = var_16_4

	var_16_4(var_16_5, 1)

	setImageAlpha = var_16_4

	var_16_4(var_16_7, 0)

	setActive = var_16_4

	var_16_4(var_16_5, true)

	setActive = var_16_4

	var_16_4(var_16_7, true)

	local var_16_8 = var_16_7
	local var_16_9 = var_16_7.Find(var_16_8, "Icon")

	setActive = var_16_6

	var_16_6(var_16_9, false)

	System = var_16_6

	local var_16_10 = var_16_6.Action_float(function(arg_17_0)
		setImageAlpha = var_2_10001

		var_2_10001(var_16_5, 1 - arg_17_0)

		setImageAlpha = var_2_10001

		var_2_10001(var_16_7, arg_17_0)

		return
	end)

	System = var_16_8

	local var_16_11 = var_16_8.Action(function()
		local var_18_0 = arg_16_0
		local var_18_1 = var_0.getCurIndex(var_18_0)

		if arg_16_0.configData.story_list[var_18_1] then
			pg = var_18_0

			local var_18_2 = var_18_0.NewStoryMgr.GetInstance()

			var_2.Play(var_18_2, var_1, function()
				local var_19_0 = arg_16_0

				var_0.updateTaskPanel(var_19_0)

				setActive = var_0

				var_0(arg_16_0.posPanel, false)

				setActive = var_0

				var_0(arg_16_0.taskPanel, true)

				return
			end, true, true)
		else
			local var_18_3 = arg_16_0

			var_2.updateTaskPanel(var_18_3)

			setActive = var_2

			var_2(arg_16_0.posPanel, false)

			setActive = var_2

			var_2(arg_16_0.taskPanel, true)
		end

		arg_16_0.markClickPos = nil

		return
	end)

	var_4:SetAsLastSibling()

	local var_16_12 = arg_16_0
	local var_16_13 = arg_16_0.managedTween

	LeanTween = var_1_10013

	local var_16_14 = var_1_10013.value
	local var_16_15

	go = var_1_10015

	local var_16_16 = var_16_13(var_16_12, var_16_14, var_16_15, var_1_10015(var_4), var_16_10, 0, 1, 0.5)

	var_10.setOnComplete(var_16_16, var_16_11)

	arg_16_0.tweenTF = var_4

	return
end

function var_0_1.check(arg_20_0)
	if not arg_20_0:isGotFinalAward() then
		local var_20_0 = arg_20_0

		if arg_20_0.getStep(var_20_0) <= arg_20_0.groupNum then
			local var_20_1 = arg_20_0

			if arg_20_0.getCurTaskIDList(var_20_1) and arg_20_0:isFinishedCurTaskList() then
				print = var_20_1

				var_20_1("清除位置")
				arg_20_0:resetPos()
			end
		end

		if var_2 == arg_20_0.groupNum and not arg_20_0:getCurTaskIDList() then
			print = var_20_0

			var_20_0("领取最终奖励")
			arg_20_0:getFinalAward()
		end
	end

	return
end

function var_0_1.isGotFinalAward(arg_21_0)
	return arg_21_0.activity.data2 > 0
end

function var_0_1.getStep(arg_22_0)
	return arg_22_0.activity.data3
end

function var_0_1.getCurIndex(arg_23_0)
	return arg_23_0.activity.data4
end

function var_0_1.getCurTaskIDList(arg_24_0)
	local var_24_0 = arg_24_0:getCurIndex()

	return arg_24_0.configData.task_table[var_24_0]
end

function var_0_1.isFinishedCurTaskList(arg_25_0)
	local var_25_0 = arg_25_0:getCurTaskIDList()

	_ = var_1_10002

	return var_1_10002.all(var_25_0, function(arg_26_0)
		local var_26_0 = arg_25_0.taskProxy
		local var_26_1 = var_1.getTaskVO(var_26_0, arg_26_0)

		return var_1.getTaskStatus(var_26_1) == 2
	end)
end

function var_0_1.getCurDayCount(arg_27_0)
	local var_27_0 = arg_27_0.activity.data1

	pg = var_1_10002

	local var_27_1 = var_1_10002.TimeMgr.GetInstance()
	local var_27_2 = var_2.GetServerTime(var_27_1)

	pg = var_1_10003

	local var_27_3 = var_1_10003.TimeMgr.GetInstance()

	return var_3.DiffDay(var_27_3, var_27_0, var_27_2) + 1
end

function var_0_1.getMaxDayCount(arg_28_0)
	local var_28_0 = arg_28_0:getCurDayCount()

	math = var_1_10002

	return (var_1_10002.clamp(var_28_0, 1, arg_28_0.configData.total_num))
end

function var_0_1.resetPos(arg_29_0)
	local var_29_0 = arg_29_0
	local var_29_1 = arg_29_0.emit

	ActivityMediator = var_1_10004

	var_29_1(var_29_0, var_1_10004.EVENT_OPERATION, {
		cmd = 2,
		activity_id = arg_29_0.activity.id
	})

	return
end

function var_0_1.selectPos(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0
	local var_30_1 = arg_30_0.emit

	ActivityMediator = var_1_10005

	var_30_1(var_30_0, var_1_10005.EVENT_OPERATION, {
		cmd = 1,
		activity_id = arg_30_0.activity.id,
		arg1 = arg_30_1
	})

	return
end

function var_0_1.getFinalAward(arg_31_0)
	local var_31_0 = arg_31_0
	local var_31_1 = arg_31_0.emit

	ActivityMediator = var_1_10004

	var_31_1(var_31_0, var_1_10004.EVENT_OPERATION, {
		cmd = 1,
		activity_id = arg_31_0.activity.id
	})

	return
end

function var_0_1.updateLogText(arg_32_0)
	local var_32_0 = arg_32_0.activity.data1
	local var_32_1 = arg_32_0.activity.data2
	local var_32_2 = arg_32_0.activity.data3
	local var_32_3 = arg_32_0.activity.data4
	local var_32_4 = arg_32_0.activity.data1_list
	local var_32_5 = arg_32_0.activity
	local var_32_6 = var_6.getConfig(var_32_5, "config_id")

	pg = var_1_10007

	local var_32_7 = var_1_10007.activity_event_turning[var_32_6].total_num

	pg = var_32_5

	local var_32_8 = var_32_5.activity_event_turning[var_32_6].groupid_list

	pg = var_9

	local var_32_9 = var_9.TimeMgr.GetInstance()
	local var_32_10 = var_9.DiffDay
	local var_32_11 = var_32_0

	pg = var_1_10013

	local var_32_12 = var_1_10013.TimeMgr.GetInstance()
	local var_32_13 = var_32_10(var_32_9, var_32_11, var_13.GetServerTime(var_32_12)) + 1

	math = var_1_10010

	local var_32_14 = var_1_10010.clamp(var_32_13, 1, var_32_7)
	local var_32_15 = ""

	local function var_32_16(arg_33_0)
		var_32_15 = var_32_15 .. arg_33_0 .. "\n"

		return
	end

	local var_32_17 = "开始时间戳："

	tostring = var_1_10016

	var_32_16(var_32_17 .. var_1_10016(var_32_0))

	local var_32_18 = var_12
	local var_32_19 = "是否领取最终奖励："

	tostring = var_16

	var_32_18(var_32_19 .. var_16(var_32_1))

	local var_32_20 = var_12
	local var_32_21 = "当前进度："

	tostring = var_16

	var_32_20(var_32_21 .. var_16(var_32_2))

	local var_32_22 = var_12
	local var_32_23 = "抽到的索引："

	tostring = var_16

	var_32_22(var_32_23 .. var_16(var_32_3))

	local var_32_24 = var_12
	local var_32_25 = "抽到的位置-索引列表："

	table = var_16

	var_32_24(var_32_25 .. var_16.concat(var_32_4, "-"))

	local var_32_26 = var_12
	local var_32_27 = "活动开始到现在的天数："

	tostring = var_16

	var_32_26(var_32_27 .. var_16(var_32_13))

	local var_32_28 = var_12
	local var_32_29 = "活动的最大抽取次数："

	tostring = var_16

	var_32_28(var_32_29 .. var_16(var_32_14))

	local var_32_30 = var_12
	local var_32_31 = "配置的总段数："

	tostring = var_16

	var_32_30(var_32_31 .. var_16(var_32_7))

	local var_32_32 = var_12
	local var_32_33 = "配置的GroupID列表："

	table = var_16

	var_32_32(var_32_33 .. var_16.concat(var_32_8, "-"))

	local var_32_34

	if 0 < var_32_3 then
		pg = var_32_34
		var_32_34 = var_32_34.activity_event_turning[var_32_6][var_32_3]
		pg = var_14

		local var_32_35 = var_14.activity_event_turning[var_32_6].task_table[var_32_3]

		pg = var_15

		local var_32_36 = var_15.activity_event_turning[var_32_6].story_list[var_32_3]
		local var_32_37 = var_12
		local var_32_38 = "当前的GroupID："

		tostring = var_19

		var_32_37(var_32_38 .. var_19(var_32_34))

		local var_32_39 = var_12
		local var_32_40 = "当前的任务列表："

		table = var_19

		var_32_39(var_32_40 .. var_19.concat(var_32_35, "-"))

		local var_32_41 = var_12
		local var_32_42 = "当前的剧情ID："

		tostring = var_19

		var_32_41(var_32_42 .. var_19(var_32_36))
	end

	setText = var_32_34

	var_32_34(arg_32_0.logText, var_32_15)

	print = var_32_34

	var_32_34(var_32_15)

	return
end

return var_0_1
