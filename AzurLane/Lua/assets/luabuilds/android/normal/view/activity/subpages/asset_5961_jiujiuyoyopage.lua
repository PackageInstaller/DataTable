class = var_0_10000

local var_0_0 = "JiujiuYoyoPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

PLATFORM_CODE = var_0_0
PLATFORM_JP = var_2

local var_0_2

if var_0_0 ~= var_2 then
	PLATFORM_CODE = var_0_0
	PLATFORM_CHT = var_2

	if var_0_0 ~= var_2 then
		var_0_2 = false

		goto label_0_0
	end
end

var_0_2 = true

::label_0_0::

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.helpBtn = var_1.Find(var_1_1, "help_btn")

	local var_1_2 = arg_1_0.bg

	arg_1_0.taskBtn = var_1.Find(var_1_2, "task_btn")

	local var_1_3 = arg_1_0.taskBtn

	arg_1_0.taskRedDot = var_1.Find(var_1_3, "red_dot")

	local var_1_4 = arg_1_0.bg

	arg_1_0.ticketNumTF = var_1.Find(var_1_4, "ticket_num")

	local var_1_5 = arg_1_0.bg

	arg_1_0.rollingCountTF = var_1.Find(var_1_5, "rolling_count")

	local var_1_6 = arg_1_0.bg

	arg_1_0.rollingBlink = var_1.Find(var_1_6, "blink")

	if var_0_2 then
		local var_1_7 = arg_1_0.bg

		arg_1_0.awardTpl = var_1.Find(var_1_7, "item_jp")

		local var_1_8 = arg_1_0.bg

		arg_1_0.awardContainter = var_1.Find(var_1_8, "award_list_jp")
	else
		local var_1_9 = arg_1_0.bg

		arg_1_0.awardTpl = var_1.Find(var_1_9, "item")

		local var_1_10 = arg_1_0.bg

		arg_1_0.awardContainter = var_1.Find(var_1_10, "award_list")
	end

	UIItemList = var_1
	arg_1_0.awardUIList = var_1.New(arg_1_0.awardContainter, arg_1_0.awardTpl)

	local var_1_11 = arg_1_0.bg

	arg_1_0.finalGot = var_1.Find(var_1_11, "final_got_jp")

	local var_1_12 = arg_1_0.bg

	arg_1_0.rollingAni = var_1.Find(var_1_12, "rolling_mask")

	local var_1_13 = arg_1_0.rollingAni
	local var_1_14 = var_1.Find(var_1_13, "rolling")

	arg_1_0.rollingSpine = var_1.GetComponent(var_1_14, "SpineAnimUI")

	local var_1_15 = arg_1_0.rollingAni
	local var_1_16 = var_1.Find(var_1_15, "rolling")

	arg_1_0.rollingGraphic = var_1.GetComponent(var_1_16, "SkeletonGraphic")

	local var_1_17 = arg_1_0.bg

	arg_1_0.forbidMask = var_1.Find(var_1_17, "forbid_mask")

	local var_1_18 = arg_1_0._tf

	arg_1_0.taskWindow = var_1.Find(var_1_18, "TaskWindow")

	local var_1_19 = arg_1_0.taskWindow

	arg_1_0.closeBtn = var_1.Find(var_1_19, "panel/close_btn")

	local var_1_20 = arg_1_0.taskWindow

	arg_1_0.taskTpl = var_1.Find(var_1_20, "panel/scrollview/item")

	local var_1_21 = arg_1_0.taskWindow

	arg_1_0.taskContainter = var_1.Find(var_1_21, "panel/scrollview/items")
	UIItemList = var_1
	arg_1_0.taskUIList = var_1.New(arg_1_0.taskContainter, arg_1_0.taskTpl)

	arg_1_0:register()

	return
end

function var_0_1.register(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.bind

	ActivityMediator = var_1_10003

	var_2_1(var_2_0, var_1_10003.ON_SHAKE_BEADS_RESULT, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.displayResult(var_3_0, arg_3_1.awards, arg_3_1.number, function()
			arg_3_1.callback()

			return
		end)

		return
	end)

	return
end

function var_0_1.OnDataSetting(arg_5_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002
	arg_5_0.taskProxy = var_1_10001(var_1_10002)

	local var_5_0 = arg_5_0.activity
	local var_5_1 = var_1.getConfig(var_5_0, "config_client").taskActID

	pg = var_5_0
	arg_5_0.taskList = var_5_0.activity_template[var_5_1].config_data

	local var_5_2 = arg_5_0.activity

	arg_5_0.startTime = var_2.getStartTime(var_5_2)
	arg_5_0.totalNumList = {}
	arg_5_0.remainNumList = {}
	arg_5_0.remainTotalNum = 0
	arg_5_0.awardList = {}

	local var_5_3 = arg_5_0.activity

	arg_5_0.finalAward = var_2.getConfig(var_5_3, "config_client").finalAward

	local var_5_4 = arg_5_0.activity

	arg_5_0.awardConifg = var_2.getConfig(var_5_4, "config_client").award

	local var_5_5 = arg_5_0.activity

	arg_5_0.beadsConfig = var_2.getConfig(var_5_5, "config_data")[1]
	ipairs = var_2

	for iter_5_0, iter_5_1 in var_2(arg_5_0.beadsConfig) do
		local var_5_6 = iter_5_1[1]

		arg_5_0.awardList[var_5_6] = arg_5_0.awardConifg[var_5_6]
		arg_5_0.totalNumList[var_5_6] = iter_5_1[2]
	end

	return
end

function var_0_1.OnFirstFlush(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.helpBtn

	local function var_6_2()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_7_2.type = var_2_10003
		i18n = var_2_10003
		var_7_2.helps = var_2_10003("tips_shakebeads")

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10005)

	onButton = var_1_10001

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.taskBtn

	local function var_6_5()
		local var_8_0 = arg_6_0

		var_0.openTask(var_8_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_3, var_6_4, var_6_5, var_1_10005)

	onButton = var_1_10001

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.closeBtn

	local function var_6_8()
		local var_9_0 = arg_6_0

		var_0.closeTask(var_9_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_6, var_6_7, var_6_8, var_1_10005)

	onButton = var_1_10001

	local var_6_9 = arg_6_0
	local var_6_10 = arg_6_0.taskWindow
	local var_6_11 = var_3.Find(var_6_10, "mask")

	local function var_6_12()
		local var_10_0 = arg_6_0

		var_0.closeTask(var_10_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_6_9, var_6_11, var_6_12, var_5)

	onButton = var_1_10001

	local var_6_13 = arg_6_0
	local var_6_14 = arg_6_0.rollingBlink

	local function var_6_15()
		if arg_6_0.ticketNum <= 0 then
			return
		end

		local var_11_0 = arg_6_0
		local var_11_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_11_1(var_11_0, var_2_10002.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_6_0.activity.id
		})

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_6_13, var_6_14, var_6_15, var_5)

	setActive = var_1_10001

	var_1_10001(arg_6_0.taskRedDot, false)

	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_6_0.rollingBlink) then
		LeanTween = var_1

		var_1.cancel(arg_6_0.rollingBlink)
	end

	setImageAlpha = var_1

	var_1(arg_6_0.rollingBlink, 1)

	blinkAni = var_1

	var_1(arg_6_0.rollingBlink, 0.5)

	return
end

function var_0_1.OnUpdateFlush(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.TimeMgr.GetInstance()
	local var_12_1 = var_1.DiffDay
	local var_12_2 = arg_12_0.startTime

	pg = var_1_10004

	local var_12_3 = var_1_10004.TimeMgr.GetInstance()

	arg_12_0.curDay = var_12_1(var_12_0, var_12_2, var_4.GetServerTime(var_12_3)) + 1
	arg_12_0.ticketNum = arg_12_0.activity.data1
	arg_12_0.hasNumList = arg_12_0.activity.data1KeyValueList[1]
	arg_12_0.remainTotalNum = 0
	ipairs = var_1

	for iter_12_0, iter_12_1 in var_1(arg_12_0.beadsConfig) do
		local var_12_4 = iter_12_1[1]

		if not arg_12_0.hasNumList[var_12_4] then
			arg_12_0.hasNumList[var_12_4] = 0
		end

		arg_12_0.remainNumList[var_12_4] = arg_12_0.totalNumList[var_12_4] - arg_12_0.hasNumList[var_12_4]
		arg_12_0.remainTotalNum = arg_12_0.remainTotalNum + arg_12_0.remainNumList[var_12_4]
	end

	setText = var_1

	var_1(arg_12_0.ticketNumTF, arg_12_0.ticketNum)

	setText = var_1

	var_1(arg_12_0.rollingCountTF, arg_12_0.remainTotalNum)

	setActive = var_1

	local var_12_5 = arg_12_0.rollingBlink
	local var_12_6 = arg_12_0.ticketNum

	var_1(var_12_5, 0 < var_12_6)
	arg_12_0:initAwardList()
	arg_12_0:initTaskWindow()

	PlayerPrefs = var_1

	local var_12_7 = var_1.GetInt
	local var_12_8 = "jiujiuyoyo_first_"

	getProxy = var_3
	PlayerProxy = var_4

	local var_12_9 = var_3(var_4)

	arg_12_0.isFirst = var_12_7(var_12_8 .. var_3.getData(var_12_9).id)

	if arg_12_0.isFirst == 0 then
		setActive = var_1

		var_1(arg_12_0.taskRedDot, true)
	end

	if #arg_12_0.finishItemList > 0 then
		arg_12_0:openTask()
	end

	setActive = var_1

	local var_12_10 = arg_12_0.finalGot
	local var_12_11

	if var_0_2 then
		var_12_11 = arg_12_0.activity.data2 == 1
	end

	var_1(var_12_10, var_12_11)
	arg_12_0:CheckFinalAward()

	return
end

function var_0_1.initAwardList(arg_13_0)
	local var_13_0 = arg_13_0.awardUIList

	var_1.make(var_13_0, function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			local var_14_0 = arg_14_1 + 1
			local var_14_1 = arg_13_0.totalNumList[var_14_0]

			if arg_13_0.remainNumList[var_14_0] == 0 then
				setTextColor = var_2_10006

				local var_14_2 = arg_14_2
				local var_14_3 = arg_14_2.Find(var_14_2, "num")

				Color = var_14_2

				var_2_10006(var_14_3, var_14_2.New(0.55, 0.55, 0.55, 1))

				setOutlineColor = var_2_10006

				local var_14_4 = arg_14_2
				local var_14_5 = arg_14_2.Find(var_14_4, "num")

				Color = var_14_4

				var_2_10006(var_14_5, var_14_4.New(0.26, 0.26, 0.26, 1))
			end

			setText = var_2_10006

			var_2_10006(arg_14_2:Find("num"), var_5 .. "/" .. var_14_1)

			setActive = var_2_10006

			var_2_10006(arg_14_2:Find("got"), var_5 == 0)

			local var_14_6 = arg_14_2:Find("award_mask/award")
			local var_14_7 = arg_13_0.awardList[var_14_0]
			local var_14_8 = {
				type = var_14_7[1],
				id = var_14_7[2],
				count = var_14_7[3] * var_5
			}

			updateDrop = var_9

			var_9(var_14_6, var_14_8)

			onButton = var_9

			local var_14_9 = arg_13_0
			local var_14_10 = var_14_6

			local function var_14_11()
				local var_15_0 = arg_13_0
				local var_15_1 = var_0.emit

				BaseUI = var_3_10002

				var_15_1(var_15_0, var_3_10002.ON_DROP, var_14_8)

				return
			end

			SFX_PANEL = var_2_10013

			var_9(var_14_9, var_14_10, var_14_11, var_2_10013)
		end

		return
	end)

	local var_13_1 = arg_13_0.awardUIList

	var_1.align(var_13_1, #arg_13_0.awardList)

	return
end

function var_0_1.initTaskWindow(arg_16_0)
	arg_16_0.finishItemList = {}
	arg_16_0.finishTaskVOList = {}

	local var_16_0 = arg_16_0.taskUIList

	var_1.make(var_16_0, function(arg_17_0, arg_17_1, arg_17_2)
		UIItemList = var_2_10003

		if arg_17_0 == var_2_10003.EventUpdate then
			local var_17_0 = arg_17_1 + 1
			local var_17_1 = arg_17_2:Find("award/award")
			local var_17_2 = arg_16_0.taskList[var_17_0]
			local var_17_3 = arg_16_0.taskProxy
			local var_17_4

			if not var_6.getTaskById(var_17_3, var_17_2) then
				var_17_3 = arg_16_0.taskProxy
				var_17_4 = var_6.getFinishTaskById(var_17_3, var_17_2)
			end

			assert = var_17_3

			var_17_3(var_17_4, "without this task by id: " .. var_17_2)

			local var_17_5 = var_17_4:getProgress()
			local var_17_6 = var_17_4:getConfig("target_num")
			local var_17_7 = var_17_4:getTaskStatus()
			local var_17_8 = var_17_4:getConfig("desc")
			local var_17_9 = var_17_4:getConfig("award_display")[1]
			local var_17_10 = var_17_0 > arg_16_0.curDay

			setText = var_13

			var_13(arg_17_2:Find("description"), var_17_8)

			setText = var_13

			var_13(arg_17_2:Find("progress/progressText"), var_17_5 .. "/" .. var_17_6)

			setSlider = var_13

			var_13(arg_17_2:Find("progress"), 0, var_17_6, var_17_5)

			local var_17_11 = {
				type = var_17_9[1],
				id = var_17_9[2],
				count = var_17_9[3]
			}

			updateDrop = var_14

			var_14(var_17_1, var_17_11)

			onButton = var_14

			local var_17_12 = arg_16_0
			local var_17_13 = arg_17_2:Find("award/Image")

			local function var_17_14()
				local var_18_0 = arg_16_0
				local var_18_1 = var_0.emit

				BaseUI = var_3_10002

				var_18_1(var_18_0, var_3_10002.ON_DROP, var_17_11)

				return
			end

			SFX_PANEL = var_18

			var_14(var_17_12, var_17_13, var_17_14, var_18)

			local var_17_15 = arg_17_2:Find("go_btn")
			local var_17_16 = arg_17_2
			local var_17_17 = arg_17_2.Find(var_17_16, "get_btn")

			setActive = var_17_16

			var_17_16(var_17_15, var_17_7 == 0)

			setActive = var_17_16

			var_17_16(var_17_17, var_17_7 == 1)

			onButton = var_17_16

			local var_17_18 = arg_16_0
			local var_17_19 = var_17_15

			local function var_17_20()
				local var_19_0 = arg_16_0
				local var_19_1 = var_0.emit

				ActivityMediator = var_3_10002

				var_19_1(var_19_0, var_3_10002.ON_TASK_GO, var_17_4)

				return
			end

			SFX_PANEL = var_2_10020

			var_17_16(var_17_18, var_17_19, var_17_20, var_2_10020)

			onButton = var_17_16

			local var_17_21 = arg_16_0
			local var_17_22 = var_17_17

			local function var_17_23()
				local var_20_0 = arg_16_0
				local var_20_1 = var_0.emit

				ActivityMediator = var_3_10002

				var_20_1(var_20_0, var_3_10002.ON_TASK_SUBMIT, var_17_4)

				return
			end

			SFX_PANEL = var_2_10020

			var_17_16(var_17_21, var_17_22, var_17_23, var_2_10020)

			setActive = var_17_16

			var_17_16(arg_17_2:Find("finnal"), var_17_7 == 2 and not var_17_10)

			setText = var_17_16

			local var_17_24 = arg_17_2
			local var_17_25 = arg_17_2.Find(var_17_24, "lock/tip")

			i18n = var_17_24

			var_17_16(var_17_25, var_17_24("unlock_tips", var_17_0))

			setActive = var_17_16

			var_17_16(arg_17_2:Find("lock"), var_17_10)

			if var_17_7 == 1 and not var_17_10 then
				table = var_17_16

				var_17_16.insert(arg_16_0.finishItemList, arg_17_2)

				table = var_16

				var_16.insert(arg_16_0.finishTaskVOList, var_17_4)
			end
		end

		return
	end)

	local var_16_1 = arg_16_0.taskUIList

	var_1.align(var_16_1, #arg_16_0.taskList)

	return
end

function var_0_1.closeTask(arg_21_0)
	setActive = var_1_10001

	var_1_10001(arg_21_0.taskWindow, false)

	return
end

function var_0_1.openTask(arg_22_0)
	setActive = var_1_10001

	var_1_10001(arg_22_0.taskWindow, true)

	if arg_22_0.isFirst == 0 then
		PlayerPrefs = var_1

		local var_22_0 = var_1.SetInt
		local var_22_1 = "jiujiuyoyo_first_"

		getProxy = var_3
		PlayerProxy = var_1_10004

		local var_22_2 = var_3(var_1_10004)

		var_22_0(var_22_1 .. var_3.getData(var_22_2).id, 1)

		setActive = var_22_0

		var_22_0(arg_22_0.taskRedDot, false)
	end

	arg_22_0.hasClickTask = true
	eachChild = var_1

	var_1(arg_22_0.taskContainter, function(arg_23_0)
		isActive = var_2_10001

		if var_2_10001(arg_23_0:Find("finnal")) then
			arg_23_0:SetAsLastSibling()
		end

		return
	end)

	if #arg_22_0.finishItemList > 0 then
		arg_22_0:autoFinishTask()
	end

	return
end

function var_0_1.autoFinishTask(arg_24_0)
	local var_24_0 = 0.01
	local var_24_1 = 0.5

	ipairs = var_1_10003

	for iter_24_0, iter_24_1 in var_1_10003(arg_24_0.finishItemList) do
		GetOrAddComponent = var_1_10008

		local var_24_2 = iter_24_1

		typeof = var_1_10010
		CanvasGroup = var_1_10011
		var_1_10008 = var_1_10008(var_24_2, var_1_10010(var_1_10011))
		var_1_10010 = arg_24_0

		local var_24_3 = arg_24_0.managedTween

		LeanTween = var_1_10011

		var_24_3(var_1_10010, var_1_10011.delayedCall, function()
			local var_25_0 = iter_24_1

			var_0.SetAsFirstSibling(var_25_0)

			LeanTween = var_0

			local var_25_1 = var_0.value

			go = var_25_0

			local var_25_2 = var_25_1(var_25_0(iter_24_1), 1, 0, var_24_1)
			local var_25_3 = var_0.setOnUpdate

			System = var_2

			local var_25_4 = var_25_3(var_25_2, var_2.Action_float(function(arg_26_0)
				var_1_10008.alpha = arg_26_0

				return
			end))
			local var_25_5 = var_0.setOnComplete

			System = var_2

			var_25_5(var_25_4, var_2.Action(function()
				local var_27_0 = var_1_10008

				var_27_0.alpha = 1
				setActive = var_27_0

				local var_27_1 = iter_24_1

				var_27_0(var_1.Find(var_27_1, "finnal"), true)

				local var_27_2 = iter_24_1

				var_0.SetAsLastSibling(var_27_2)

				return
			end))

			return
		end, var_24_0, nil)

		var_24_0 = var_24_0 + var_24_1 + 0.1
	end

	local var_24_4 = arg_24_0
	local var_24_5 = arg_24_0.managedTween

	LeanTween = var_5

	var_24_5(var_24_4, var_5.delayedCall, function()
		pg = var_2_10000

		local var_28_0 = var_2_10000.m02
		local var_28_1 = var_0.sendNotification

		GAME = var_2_10002

		var_28_1(var_28_0, var_2_10002.SUBMIT_TASK_ONESTEP, {
			resultList = arg_24_0.finishTaskVOList
		})

		return
	end, var_24_0, nil)

	return
end

function var_0_1.CheckFinalAward(arg_29_0)
	if var_0_2 and arg_29_0.activity.data2 == 0 and arg_29_0.remainTotalNum == 0 then
		local var_29_0 = arg_29_0
		local var_29_1 = arg_29_0.emit

		ActivityMediator = var_1_10003

		var_29_1(var_29_0, var_1_10003.EVENT_OPERATION, {
			cmd = 2,
			activity_id = arg_29_0.activity.id
		})
	end

	return
end

function var_0_1.displayResult(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	arg_30_0:setForbidMaskStatus(true)

	setActive = var_4

	var_4(arg_30_0.rollingAni, true)

	function arg_30_0.aniCallback()
		arg_30_3()

		return
	end

	local var_30_0 = arg_30_0.rollingSpine

	var_4.SetActionCallBack(var_30_0, function(arg_32_0)
		if arg_32_0 == "finish" then
			setActive = var_2_10001

			var_2_10001(arg_30_0.rollingAni, false)
			arg_30_3()

			arg_30_0.aniCallback = nil

			local var_32_0 = arg_30_0

			var_1.setForbidMaskStatus(var_32_0, false)
		end

		return
	end)

	local var_30_1 = arg_30_0.rollingSpine
	local var_30_2 = var_4.SetAction

	tostring = var_6

	var_30_2(var_30_1, var_6(arg_30_2), 0)

	pg = var_30_2

	local var_30_3 = var_30_2.CriMgr.GetInstance()

	var_4.PlaySoundEffect_V3(var_30_3, "event:/ui/zhuanzhu")

	local var_30_4 = arg_30_0
	local var_30_5 = arg_30_0.managedTween

	LeanTween = var_6

	var_30_5(var_30_4, var_6.delayedCall, function()
		pg = var_2_10000

		local var_33_0 = var_2_10000.CriMgr.GetInstance()

		var_0.PlaySoundEffect_V3(var_33_0, "event:/ui/zhengque")

		return
	end, 4, nil)

	return
end

function var_0_1.setForbidMaskStatus(arg_34_0, arg_34_1)
	if arg_34_1 then
		setActive = var_1_10002

		var_1_10002(arg_34_0.forbidMask, true)

		pg = var_1_10002

		local var_34_0 = var_1_10002.UIMgr.GetInstance()

		var_1_10002.OverlayPanel(var_34_0, arg_34_0.forbidMask)
	else
		setActive = var_1_10002

		var_1_10002(arg_34_0.forbidMask, false)

		pg = var_1_10002

		local var_34_1 = var_1_10002.UIMgr.GetInstance()

		var_2.UnOverlayPanel(var_34_1, arg_34_0.forbidMask, arg_34_0.bg)
	end

	return
end

function var_0_1.canFinishTask()
	pg = var_1_10000

	local var_35_0 = var_1_10000.activity_template

	ActivityConst = var_1_10001

	local var_35_1 = var_35_0[var_1_10001.JIUJIU_YOYO_ID].config_client.taskActID

	pg = var_1_10002

	local var_35_2 = var_1_10002.activity_template[var_35_1].config_data

	pg = var_1_10003

	local var_35_3 = var_1_10003.TimeMgr.GetInstance()
	local var_35_4 = var_3.parseTimeFromConfig(var_35_3, var_0.time[2])

	pg = var_35_3

	local var_35_5 = var_35_3.TimeMgr.GetInstance()
	local var_35_6 = var_4.DiffDay
	local var_35_7 = var_35_4

	pg = var_1_10007

	local var_35_8 = var_1_10007.TimeMgr.GetInstance()
	local var_35_9 = var_35_6(var_35_5, var_35_7, var_7.GetServerTime(var_35_8)) + 1
	local var_35_10 = false

	getProxy = var_35_7
	TaskProxy = var_7

	local var_35_11 = var_35_7(var_7)

	pairs = var_7

	for iter_35_0, iter_35_1 in var_7(var_35_2) do
		local var_35_12 = var_35_9 < iter_35_0
		local var_35_13 = var_35_11
		local var_35_14

		if not var_35_11.getTaskById(var_35_13, iter_35_1) then
			var_35_13 = var_35_11
			var_35_14 = var_35_11.getFinishTaskById(var_35_13, iter_35_1)
		end

		assert = var_35_13

		var_35_13(var_35_14, "without this task by id: " .. iter_35_1)

		if var_35_14:getTaskStatus() == 1 and not var_35_12 then
			var_35_10 = true

			break
		end
	end

	return var_35_10
end

function var_0_1.IsShowRed()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_36_0 = var_1_10000(var_1_10001)
	local var_36_1 = var_0.getActivityById

	ActivityConst = var_1_10002

	return var_36_1(var_36_0, var_1_10002.JIUJIU_YOYO_ID).data1 > 0 or var_0_1.canFinishTask()
end

return var_0_1
