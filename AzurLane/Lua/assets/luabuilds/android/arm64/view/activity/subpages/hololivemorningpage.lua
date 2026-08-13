class = var_0_10000

local var_0_0 = "HoloLivePtPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003
	arg_1_0.taskProxy = var_1_10001(var_1_10003)
	getProxy = var_1
	ActivityProxy = var_1_10003
	arg_1_0.activityProxy = var_1(var_1_10003)

	local var_1_0 = arg_1_0._tf

	arg_1_0.circleTF = var_1.Find(var_1_0, "CircleImg/Circle")

	local var_1_1 = arg_1_0._tf

	arg_1_0.startBtn = var_1.Find(var_1_1, "CircleImg/StartBtn")

	local var_1_2 = arg_1_0._tf

	arg_1_0.helpBtn1 = var_1.Find(var_1_2, "HelpBtn")

	local var_1_3 = arg_1_0._tf

	arg_1_0.taskPanel = var_1.Find(var_1_3, "AD")
	onButton = var_1

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.startBtn

	local function var_1_6()
		if arg_1_0.isTurning then
			return
		end

		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_2_1(var_2_0, var_2_10003.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_1_0.activity.id
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_4, var_1_5, var_1_6, var_1_10006)

	onButton = var_1

	local var_1_7 = arg_1_0
	local var_1_8 = arg_1_0.helpBtn1

	local function var_1_9()
		pg = var_2_10000

		local var_3_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_3_1 = var_0.ShowMsgBox
		local var_3_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_3_2.type = var_2_10004
		pg = var_2_10004
		var_3_2.helps = var_2_10004.gametip.hololive_goodmorning.tip

		var_3_1(var_3_0, var_3_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_7, var_1_8, var_1_9, var_1_10006)

	return
end

function var_0_1.OnDataSetting(arg_4_0)
	arg_4_0.activityStartTime = arg_4_0.activity.data1
	arg_4_0.isGotFinalAward = arg_4_0.activity.data2
	arg_4_0.progressStep = arg_4_0.activity.data3

	local var_4_0 = arg_4_0.activity

	arg_4_0.configID = var_1.getConfig(var_4_0, "config_id")
	pg = var_1
	arg_4_0.configData = var_1.activity_event_turning[arg_4_0.configID]
	arg_4_0.groupNum = arg_4_0.configData.total_num
	pg = var_1

	local var_4_1 = var_1.TimeMgr.GetInstance()
	local var_4_2 = var_1.DiffDay
	local var_4_3 = arg_4_0.activityStartTime

	pg = var_1_10005

	local var_4_4 = var_1_10005.TimeMgr.GetInstance()
	local var_4_5 = var_4_2(var_4_1, var_4_3, var_5.GetServerTime(var_4_4)) + 1

	math = var_2
	arg_4_0.maxday = var_2.clamp(var_4_5, 1, arg_4_0.configData.total_num)
	print = var_2

	local var_4_6 = "init data on setting:"

	tostring = var_5

	local var_4_7 = var_5(arg_4_0.maxday)

	tostring = var_6

	local var_4_8 = var_6(arg_4_0.isGotFinalAward)

	tostring = var_7

	local var_4_9 = var_7(arg_4_0.progressStep)

	tostring = var_8

	var_2(var_4_6, var_4_7, var_4_8, var_4_9, var_8(arg_4_0.activity.data4))

	return
end

function var_0_1.OnFirstFlush(arg_5_0)
	arg_5_0.curIndex = arg_5_0.activity.data4

	if arg_5_0.curIndex ~= 0 then
		arg_5_0.curShipGroupID = arg_5_0.configData.groupid_list[arg_5_0.curIndex]
		arg_5_0.curTaskIDList = arg_5_0.configData.task_table[arg_5_0.curIndex]
		arg_5_0.curStoryID = arg_5_0.configData.story_list[arg_5_0.curIndex]
	end

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	if arg_6_0.curIndex == 0 and arg_6_0.activity.data4 > 0 then
		arg_6_0.curIndex = arg_6_0.activity.data4
		arg_6_0.curShipGroupID = arg_6_0.configData.groupid_list[arg_6_0.curIndex]
		arg_6_0.curTaskIDList = arg_6_0.configData.task_table[arg_6_0.curIndex]
		arg_6_0.curStoryID = arg_6_0.configData.story_list[arg_6_0.curIndex]
		print = var_1

		local var_6_0 = "before rotate"

		tostring = var_1_10004
		var_1_10004 = var_1_10004(arg_6_0.curShipGroupID)
		tostring = var_1_10005
		var_1_10005 = var_1_10005(arg_6_0.curIndex)
		tostring = var_6

		var_1(var_6_0, var_1_10004, var_1_10005, var_6(arg_6_0.curStoryID))
		arg_6_0:rotate()
	elseif arg_6_0.activity.data4 > 0 then
		if arg_6_0.activity.data4 <= arg_6_0.groupNum then
			arg_6_0.curIndex = arg_6_0.activity.data4
			arg_6_0.curShipGroupID = arg_6_0.configData.groupid_list[arg_6_0.curIndex]
			arg_6_0.curTaskIDList = arg_6_0.configData.task_table[arg_6_0.curIndex]
			arg_6_0.curStoryID = arg_6_0.configData.story_list[arg_6_0.curIndex]
			print = var_1

			local var_6_1 = "direct update"

			tostring = var_1_10004

			local var_6_2 = var_1_10004(arg_6_0.curShipGroupID)

			tostring = var_1_10005

			local var_6_3 = var_1_10005(arg_6_0.curIndex)

			tostring = var_6

			var_1(var_6_1, var_6_2, var_6_3, var_6(arg_6_0.curStoryID))
			arg_6_0:updateTaskPanel()
		end
	elseif arg_6_0.activity.data4 == 0 then
		arg_6_0.curIndex = 0
		arg_6_0.curShipGroupID = nil
		arg_6_0.curTaskIDList = nil
		arg_6_0.curStoryID = nil
		setActive = var_1

		var_1(arg_6_0.taskPanel, false)

		if arg_6_0.progressStep > arg_6_0.groupNum then
			arg_6_0:lockTurnTable()
		end
	end

	arg_6_0:checkAward()

	return
end

function var_0_1.onDestroy(arg_7_0)
	LeanTween = var_1_10001

	local var_7_0 = var_1_10001.cancel

	go = var_1_10003

	var_7_0(var_1_10003(arg_7_0.circleTF))

	return
end

function var_0_1.rotate(arg_8_0)
	local var_8_0 = arg_8_0.activity
	local var_8_1 = var_1.getConfig(var_8_0, "config_id")

	pg = var_1_10002

	local var_8_2 = var_1_10002.activity_event_turning[var_8_1]
	local var_8_3 = {
		6,
		0,
		4,
		2,
		5,
		3,
		1
	}
	local var_8_4 = 4
	local var_8_5 = 8
	local var_8_6 = 360 - 360 / var_8_2.total_num * var_8_3[arg_8_0.curIndex] + var_8_5 * 360

	arg_8_0.isTurning = true
	LeanTween = var_9

	local var_8_7 = var_9.value

	go = var_1_10011

	local var_8_8 = var_8_7(var_1_10011(arg_8_0.circleTF), 0, var_8_6, var_8_4)
	local var_8_9 = var_9.setEase

	LeanTweenType = var_12

	local var_8_10 = var_8_9(var_8_8, var_12.easeInOutCirc)
	local var_8_11 = var_9.setOnUpdate

	System = var_12

	local var_8_12 = var_8_11(var_8_10, var_12.Action_float(function(arg_9_0)
		local var_9_0 = arg_8_0.circleTF

		Vector3 = var_2_10002
		var_9_0.localEulerAngles = var_2_10002(0, 0, -arg_9_0)

		return
	end))
	local var_8_13 = var_9.setOnComplete

	System = var_12

	var_8_13(var_8_12, var_12.Action(function()
		pg = var_2_10000

		local var_10_0 = var_2_10000.NewStoryMgr.GetInstance()

		var_0.Play(var_10_0, arg_8_0.curStoryID, function()
			local var_11_0 = arg_8_0

			var_0.updateTaskPanel(var_11_0)

			return
		end, true, true)

		arg_8_0.isTurning = false

		return
	end))

	return
end

function var_0_1.updateTaskPanel(arg_12_0)
	local var_12_0 = arg_12_0.taskPanel

	arg_12_0.charImg = var_1.Find(var_12_0, "CharImg")

	local var_12_1 = arg_12_0.charImg

	arg_12_0.nameImg = var_1.Find(var_12_1, "NameImg")

	local var_12_2 = arg_12_0.taskPanel

	arg_12_0.dayText = var_1.Find(var_12_2, "ProgressImg/day")

	local var_12_3 = arg_12_0.taskPanel

	arg_12_0.taskItemTpl = var_1.Find(var_12_3, "item")

	local var_12_4 = arg_12_0.taskPanel

	arg_12_0.taskItemContainer = var_1.Find(var_12_4, "items")

	local var_12_5 = arg_12_0.taskPanel

	arg_12_0.backBtn = var_1.Find(var_12_5, "BackBtn")

	local var_12_6 = arg_12_0.backBtn

	arg_12_0.countText = var_1.Find(var_12_6, "RedPoint/Text")

	local var_12_7 = arg_12_0.taskPanel

	arg_12_0.helpBtn2 = var_1.Find(var_12_7, "HelpBtn")

	local var_12_8 = "img_char_" .. arg_12_0.curShipGroupID

	LoadSpriteAtlasAsync = var_2

	var_2("ui/activityuipage/hololivemorningpage", var_12_8, function(arg_13_0)
		if arg_12_0.curShipGroupID == 17 then
			rtf = var_1

			local var_13_0 = var_1(arg_12_0.charImg)

			Vector2 = var_2_10002
			var_13_0.sizeDelta = var_2_10002(1058, 714)
			setImageSprite = var_13_0

			var_13_0(arg_12_0.charImg, arg_13_0)
		elseif arg_12_0.curShipGroupID == 19 then
			rtf = var_1

			local var_13_1 = var_1(arg_12_0.charImg)

			Vector2 = var_2_10002
			var_13_1.sizeDelta = var_2_10002(1122, 714)
			setImageSprite = var_13_1

			var_13_1(arg_12_0.charImg, arg_13_0)
		else
			local var_13_2

			if arg_12_0.curShipGroupID == 21 then
				rtf = var_13_2
				var_13_2 = var_13_2(arg_12_0.charImg)
				Vector2 = var_2_10002
				var_13_2.sizeDelta = var_2_10002(1044, 714)
				setImageSprite = var_13_2

				var_13_2(arg_12_0.charImg, arg_13_0)
			else
				setImageSprite = var_13_2

				var_13_2(arg_12_0.charImg, arg_13_0, true)
			end
		end

		return
	end)

	local var_12_9 = "img_name_" .. arg_12_0.curShipGroupID

	LoadSpriteAtlasAsync = var_3

	var_3("ui/activityuipage/hololivemorningpage", var_12_9, function(arg_14_0)
		setImageSprite = var_2_10001

		var_2_10001(arg_12_0.nameImg, arg_14_0, true)

		return
	end)

	setText = var_3

	var_3(arg_12_0.dayText, arg_12_0.progressStep .. "/" .. arg_12_0.configData.total_num)

	UIItemList = var_3
	arg_12_0.taskUIItemList = var_3.New(arg_12_0.taskItemContainer, arg_12_0.taskItemTpl)

	local var_12_10 = arg_12_0.taskUIItemList

	var_3.make(var_12_10, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			local var_15_0 = arg_15_1 + 1
			local var_15_1 = arg_15_2:Find("item")
			local var_15_2 = arg_12_0.curTaskIDList[var_15_0]
			local var_15_3 = arg_12_0.taskProxy
			local var_15_5

			if not var_6.getTaskById(var_15_3, var_15_2) then
				local var_15_4 = arg_12_0.taskProxy

				var_15_5 = var_6.getFinishTaskById(var_15_4, var_15_2)
			end

			assert = var_7

			var_7(var_15_5, "without this task by id: " .. var_15_2)

			local var_15_6 = var_15_5:getConfig("award_display")[1]
			local var_15_7 = {
				type = var_15_6[1],
				id = var_15_6[2],
				count = var_15_6[3]
			}

			updateDrop = var_9

			var_9(var_15_1, var_15_7)

			onButton = var_9

			local var_15_8 = arg_12_0
			local var_15_9 = var_15_1

			local function var_15_10()
				local var_16_0 = arg_12_0
				local var_16_1 = var_0.emit

				BaseUI = var_3_10003

				var_16_1(var_16_0, var_3_10003.ON_DROP, var_15_7)

				return
			end

			SFX_PANEL = var_2_10014

			var_9(var_15_8, var_15_9, var_15_10, var_2_10014)

			local var_15_11 = var_15_5
			local var_15_12 = var_15_5.getProgress(var_15_11)
			local var_15_13 = var_15_5:getConfig("target_num")

			setText = var_15_11

			var_15_11(arg_15_2:Find("description"), var_15_5:getConfig("desc") .. "(" .. var_15_12 .. "/" .. var_15_13 .. ")")

			setSlider = var_15_11

			var_15_11(arg_15_2:Find("progress"), 0, var_15_13, var_15_12)

			local var_15_14 = arg_15_2:Find("go_btn")
			local var_15_15 = arg_15_2:Find("get_btn")
			local var_15_16 = arg_15_2
			local var_15_17 = arg_15_2.Find(var_15_16, "got_btn")
			local var_15_18 = var_15_5:getTaskStatus()

			setActive = var_15_16

			var_15_16(var_15_14, var_15_18 == 0)

			setActive = var_15_16

			var_15_16(var_15_15, var_15_18 == 1)

			setActive = var_15_16

			var_15_16(var_15_17, var_15_18 == 2)

			onButton = var_15_16

			local var_15_19 = arg_12_0
			local var_15_20 = var_15_14

			local function var_15_21()
				local var_17_0 = arg_12_0
				local var_17_1 = var_0.emit

				ActivityMediator = var_3_10003

				var_17_1(var_17_0, var_3_10003.ON_TASK_GO, var_15_5)

				return
			end

			SFX_PANEL = var_2_10020

			var_15_16(var_15_19, var_15_20, var_15_21, var_2_10020)

			onButton = var_15_16

			local var_15_22 = arg_12_0
			local var_15_23 = var_15_15

			local function var_15_24()
				local var_18_0 = arg_12_0
				local var_18_1 = var_0.emit

				ActivityMediator = var_3_10003

				var_18_1(var_18_0, var_3_10003.ON_TASK_SUBMIT, var_15_5)

				return
			end

			SFX_PANEL = var_2_10020

			var_15_16(var_15_22, var_15_23, var_15_24, var_2_10020)
		end

		return
	end)

	local var_12_11 = arg_12_0.taskUIItemList

	var_3.align(var_12_11, #arg_12_0.curTaskIDList)

	local var_12_12 = true

	ipairs = var_4

	for iter_12_0, iter_12_1 in var_4(arg_12_0.curTaskIDList) do
		local var_12_13 = arg_12_0.taskProxy

		if not var_1_10009.getTaskById(var_12_13, iter_12_1) then
			local var_12_14 = arg_12_0.taskProxy

			var_1_10009 = var_1_10009.getFinishTaskById(var_12_14, iter_12_1)
		end

		if var_1_10009:getTaskStatus() ~= 2 then
			var_12_12 = false

			break
		end
	end

	if var_12_12 then
		local var_12_15 = arg_12_0.activity
		local var_12_16 = var_4.getConfig(var_12_15, "config_id")

		pg = var_5

		local var_12_17 = var_5.activity_event_turning[var_12_16].story_task[arg_12_0.progressStep][1]

		print = var_7
		var_1_10009 = "story"
		tostring = var_1_10010

		var_7(var_1_10009, var_1_10010(var_12_17))

		if var_12_17 then
			pg = var_7
			var_1_10009 = var_7.NewStoryMgr.GetInstance()

			var_7.Play(var_1_10009, var_12_17, nil)
		end
	end

	if arg_12_0.maxday <= arg_12_0.progressStep then
		var_12_12 = false
	end

	setActive = var_4

	var_4(arg_12_0.backBtn, var_12_12)

	if var_12_12 then
		setText = var_4

		local var_12_18 = arg_12_0.countText

		tostring = var_7

		var_4(var_12_18, var_7(arg_12_0.maxday - arg_12_0.progressStep))
	end

	setActive = var_4

	var_4(arg_12_0.taskPanel, true)

	onButton = var_4

	local var_12_19 = arg_12_0
	local var_12_20 = arg_12_0.backBtn

	local function var_12_21()
		local var_19_0 = arg_12_0

		var_0.resetIndex(var_19_0)

		return
	end

	SFX_CANCEL = var_1_10009

	var_4(var_12_19, var_12_20, var_12_21, var_1_10009)

	onButton = var_4

	local var_12_22 = arg_12_0
	local var_12_23 = arg_12_0.helpBtn2

	local function var_12_24()
		pg = var_2_10000

		local var_20_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_20_1 = var_0.ShowMsgBox
		local var_20_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_20_2.type = var_2_10004
		pg = var_2_10004
		var_20_2.helps = var_2_10004.gametip.hololive_goodmorning.tip

		var_20_1(var_20_0, var_20_2)

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_12_22, var_12_23, var_12_24, var_1_10009)

	return
end

function var_0_1.checkAward(arg_21_0)
	if arg_21_0.isGotFinalAward == 0 and arg_21_0.progressStep == arg_21_0.groupNum then
		if arg_21_0.curTaskIDList then
			local var_21_0 = true

			ipairs = var_2

			for iter_21_0, iter_21_1 in var_2(arg_21_0.curTaskIDList) do
				local var_21_1 = arg_21_0.taskProxy
				local var_21_3

				if not var_7.getTaskById(var_21_1, iter_21_1) then
					local var_21_2 = arg_21_0.taskProxy

					var_21_3 = var_7.getFinishTaskById(var_21_2, iter_21_1)
				end

				if var_21_3:getTaskStatus() ~= 2 then
					var_21_0 = false

					break
				end
			end

			if var_21_0 and arg_21_0.activity.data4 ~= 0 and arg_21_0.activity.data3 == arg_21_0.groupNum then
				var_1_10004 = arg_21_0

				local var_21_4 = arg_21_0.emit

				ActivityMediator = iter_21_0

				var_21_4(var_1_10004, iter_21_0.EVENT_OPERATION, {
					cmd = 2,
					activity_id = arg_21_0.activity.id
				})
			end
		else
			local var_21_5 = arg_21_0
			local var_21_6 = arg_21_0.emit

			ActivityMediator = var_1_10004

			var_21_6(var_21_5, var_1_10004.EVENT_OPERATION, {
				cmd = 1,
				activity_id = arg_21_0.activity.id
			})
		end
	end

	return
end

function var_0_1.resetIndex(arg_22_0)
	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.emit

	ActivityMediator = var_1_10004

	var_22_1(var_22_0, var_1_10004.EVENT_OPERATION, {
		cmd = 2,
		activity_id = arg_22_0.activity.id
	})

	return
end

function var_0_1.lockTurnTable(arg_23_0)
	local var_23_0 = arg_23_0._tf

	arg_23_0.finalTip = var_1.Find(var_23_0, "FinalTip")

	local var_23_1 = arg_23_0._tf

	arg_23_0.finalLock = var_1.Find(var_23_1, "CircleImg/FinalLock")
	setActive = var_1

	var_1(arg_23_0.finalTip, true)

	setActive = var_1

	var_1(arg_23_0.finalLock, true)

	local var_23_2 = arg_23_0._tf

	arg_23_0.tipImg = var_1.Find(var_23_2, "TipImg")
	setActive = var_1

	var_1(arg_23_0.tipImg, false)

	return
end

return var_0_1
