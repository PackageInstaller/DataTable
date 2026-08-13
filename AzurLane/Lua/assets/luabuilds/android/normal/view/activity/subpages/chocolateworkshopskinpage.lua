class = var_0_10000

local var_0_0 = "ChocolateWorkshopSkinPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))

var_0_1.FADE_TIME = 0.5
var_0_1.SHOW_TIME = 2
var_0_1.FADE_OUT_TIME = 0.5

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.finishContainer = var_1.Find(var_1_0, "FinishContainer")

	local var_1_1 = arg_1_0.bg

	arg_1_0.bubbleTF = var_1.Find(var_1_1, "Bubble")

	local var_1_2 = arg_1_0.bubbleTF

	arg_1_0.bubbleText = var_1.Find(var_1_2, "Text")
	GetComponent = var_1
	arg_1_0.bubbleCG = var_1(arg_1_0.bubbleTF, "CanvasGroup")

	local var_1_3 = arg_1_0.bg

	arg_1_0.sdContainer = var_1.Find(var_1_3, "SDcontainer")

	local var_1_4 = arg_1_0.bg

	arg_1_0.sdBtn = var_1.Find(var_1_4, "SDBtn")
	onButton = var_1

	local var_1_5 = arg_1_0
	local var_1_6 = arg_1_0.sdBtn

	local function var_1_7()
		local var_2_0 = {
			{
				{
					2022,
					2,
					14
				},
				{
					0,
					0,
					0
				}
			},
			{
				{
					2022,
					2,
					23
				},
				{
					23,
					59,
					59
				}
			}
		}

		type = var_1

		if var_1(var_2_0) == "table" then
			pg = var_1

			local var_2_1 = var_1.TimeMgr.GetInstance()

			if var_1.inTime(var_2_1, var_2_0) then
				setActive = var_1

				var_1(arg_1_0.boxTF, true)
			end
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_5, var_1_6, var_1_7, var_1_10005)

	local var_1_8 = arg_1_0._tf

	arg_1_0.boxTF = var_1.Find(var_1_8, "Box")

	local var_1_9 = arg_1_0.boxTF

	arg_1_0.boxBG = var_1.Find(var_1_9, "BG")

	local var_1_10 = arg_1_0.boxTF

	arg_1_0.boxText = var_1.Find(var_1_10, "Content/Text")
	setText = var_1

	local var_1_11 = arg_1_0.boxText

	i18n = var_3

	var_1(var_1_11, var_3("valentinesday__shop_tip"))

	local var_1_12 = arg_1_0.boxTF

	arg_1_0.confirmBtn = var_1.Find(var_1_12, "Content/Confirm")

	local var_1_13 = arg_1_0.boxTF

	arg_1_0.cancelBtn = var_1.Find(var_1_13, "Content/Cancel")
	onButton = var_1

	local var_1_14 = arg_1_0
	local var_1_15 = arg_1_0.boxBG

	local function var_1_16()
		setActive = var_2_10000

		var_2_10000(arg_1_0.boxTF, false)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_1_14, var_1_15, var_1_16, var_1_10005)

	onButton = var_1

	local var_1_17 = arg_1_0
	local var_1_18 = arg_1_0.cancelBtn

	local function var_1_19()
		setActive = var_2_10000

		var_2_10000(arg_1_0.boxTF, false)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_1_17, var_1_18, var_1_19, var_1_10005)

	onButton = var_1

	local var_1_20 = arg_1_0
	local var_1_21 = arg_1_0.confirmBtn

	local function var_1_22()
		pg = var_2_10000

		local var_5_0 = var_2_10000.m02
		local var_5_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_5_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_5_1(var_5_0, var_5_2, var_2_10003.SKINSHOP)

		setActive = var_5_1

		var_5_1(arg_1_0.boxTF, false)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_20, var_1_21, var_1_22, var_1_10005)

	arg_1_0.sdNameList = {
		"anshan_3",
		"shiyu_4"
	}
	arg_1_0.bubbleTextTable = {
		anshan_3 = {
			"valentinesday__txt1_tip",
			"valentinesday__txt2_tip",
			"valentinesday__txt3_tip"
		},
		shiyu_4 = {
			"valentinesday__txt4_tip",
			"valentinesday__txt5_tip",
			"valentinesday__txt6_tip"
		}
	}

	local var_1_23 = arg_1_0.bg

	arg_1_0.aniContainerTF = var_1.Find(var_1_23, "AniContainer")

	local var_1_24 = arg_1_0.sdNameList

	math = var_1_23
	arg_1_0.sdName = var_1_24[var_1_23.random(#arg_1_0.sdNameList)]
	arg_1_0.animChar = nil
	GetSpineRequestPackage = var_1

	local var_1_25 = var_1.New(arg_1_0.sdName, function(arg_6_0)
		arg_1_0.animChar = arg_6_0

		local var_6_0 = arg_1_0.animChar

		var_1.SetParent(var_6_0, arg_1_0.sdContainer)

		local var_6_1 = arg_1_0.animChar
		local var_6_2 = var_1.SetLocalScale

		Vector3 = var_3

		var_6_2(var_6_1, var_3.one)

		local var_6_3 = arg_1_0.animChar

		var_1.SetAction(var_6_3, "stand2", 0)

		return
	end)

	var_1.Start(var_1_25)

	return
end

function var_0_1.OnFirstFlush(arg_7_0)
	local var_7_0 = arg_7_0.uilist

	var_1.make(var_7_0, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = arg_8_1 + 1
			local var_8_1 = arg_8_2:Find("item")
			local var_8_2 = arg_7_0.taskGroup[arg_7_0.nday][var_8_0]
			local var_8_3 = arg_7_0.taskProxy
			local var_8_4

			if not var_6.getTaskById(var_8_3, var_8_2) then
				var_8_3 = arg_7_0.taskProxy
				var_8_4 = var_6.getFinishTaskById(var_8_3, var_8_2)
			end

			assert = var_8_3

			var_8_3(var_8_4, "without this task by id: " .. var_8_2)

			local var_8_5 = var_8_4:getConfig("award_display")[1]
			local var_8_6 = {
				type = var_8_5[1],
				id = var_8_5[2],
				count = var_8_5[3]
			}

			updateDrop = var_9

			var_9(var_8_1, var_8_6)

			onButton = var_9

			local var_8_7 = arg_7_0
			local var_8_8 = var_8_1

			local function var_8_9()
				local var_9_0 = arg_7_0
				local var_9_1 = var_0.emit

				BaseUI = var_3_10002

				var_9_1(var_9_0, var_3_10002.ON_DROP, var_8_6)

				return
			end

			SFX_PANEL = var_2_10013

			var_9(var_8_7, var_8_8, var_8_9, var_2_10013)

			local var_8_10 = var_8_4:getProgress()
			local var_8_11 = var_8_4
			local var_8_12 = var_8_4.getConfig(var_8_11, "target_num")

			setText = var_8_11

			var_8_11(arg_8_2:Find("description"), var_8_4:getConfig("desc"))

			setText = var_8_11

			local var_8_13 = arg_8_2
			local var_8_14 = arg_8_2.Find(var_8_13, "progressText")

			setColorStr = var_8_13

			var_8_11(var_8_14, var_8_13(var_8_10, "#BBCF2EFF") .. "/" .. var_8_12)

			setSlider = var_8_11

			var_8_11(arg_8_2:Find("progress"), 0, var_8_12, var_8_10)

			local var_8_15 = arg_8_2:Find("go_btn")
			local var_8_16 = arg_8_2:Find("get_btn")
			local var_8_17 = arg_8_2:Find("got_btn")
			local var_8_18 = var_8_4
			local var_8_19 = var_8_4.getTaskStatus(var_8_18)

			setActive = var_8_18

			var_8_18(var_8_15, var_8_19 == 0)

			setActive = var_8_18

			var_8_18(var_8_16, var_8_19 == 1)

			setActive = var_8_18

			var_8_18(var_8_17, var_8_19 == 2)

			onButton = var_8_18

			local var_8_20 = arg_7_0
			local var_8_21 = var_8_15

			local function var_8_22()
				local var_10_0 = arg_7_0
				local var_10_1 = var_0.emit

				ActivityMediator = var_3_10002

				var_10_1(var_10_0, var_3_10002.ON_TASK_GO, var_8_4)

				return
			end

			SFX_PANEL = var_2_10019

			var_8_18(var_8_20, var_8_21, var_8_22, var_2_10019)

			onButton = var_8_18

			local var_8_23 = arg_7_0
			local var_8_24 = var_8_16

			local function var_8_25()
				local var_11_0 = arg_7_0
				local var_11_1 = var_0.emit

				ActivityMediator = var_3_10002

				var_11_1(var_11_0, var_3_10002.ON_TASK_SUBMIT, var_8_4)

				return
			end

			SFX_PANEL = var_2_10019

			var_8_18(var_8_23, var_8_24, var_8_25, var_2_10019)
		end

		return
	end)

	arg_7_0.showBubbleTag = false

	return
end

function var_0_1.OnUpdateFlush(arg_12_0)
	var_0_1.super.OnUpdateFlush(arg_12_0)

	setActive = var_1

	var_1(arg_12_0.boxTF, false)

	for iter_12_0 = 1, arg_12_0.finishContainer.childCount do
		var_1_10006 = arg_12_0.finishContainer

		local var_12_0 = var_5.GetChild(var_1_10006, iter_12_0 - 1)

		setActive = var_1_10006

		var_1_10006(var_12_0, iter_12_0 <= arg_12_0.nday)
	end

	local var_12_1 = arg_12_0.taskGroup[arg_12_0.nday][1]
	local var_12_2 = arg_12_0.taskProxy
	local var_12_3 = var_2.getTaskVO(var_12_2, var_12_1)
	local var_12_4 = var_2.getTaskStatus(var_12_3)
	local var_12_6

	if not arg_12_0.showBubbleTag then
		if var_12_4 == 0 then
			local var_12_5 = arg_12_0

			var_12_6 = arg_12_0.showBubble
			i18n = var_1_10006

			var_12_6(var_12_5, var_1_10006(arg_12_0.bubbleTextTable[arg_12_0.sdName][1]))

			arg_12_0.showBubbleTag = true
		elseif var_12_4 == 1 then
			local var_12_7 = arg_12_0

			var_12_6 = arg_12_0.showBubble
			i18n = var_1_10006

			var_12_6(var_12_7, var_1_10006(arg_12_0.bubbleTextTable[arg_12_0.sdName][2]))

			arg_12_0.showBubbleTag = true
		end
	end

	eachChild = var_12_6

	var_12_6(arg_12_0.aniContainerTF, function(arg_13_0)
		setActive = var_2_10001

		var_2_10001(arg_13_0, false)

		return
	end)

	if var_12_4 == 0 then
		setActive = var_12_6

		local var_12_8 = arg_12_0.aniContainerTF

		var_12_6(var_5.Find(var_12_8, "choco_factory_rest"), true)
	else
		setActive = var_12_6

		local var_12_9 = arg_12_0.aniContainerTF

		var_12_6(var_5.Find(var_12_9, "choco_factory_working"), true)
	end

	return
end

function var_0_1.OnDestroy(arg_14_0)
	var_0_1.super.OnDestroy(arg_14_0)

	if arg_14_0.animChar then
		local var_14_0 = arg_14_0.animChar

		var_1.Dispose(var_14_0)

		arg_14_0.animChar = nil
	end

	return
end

function var_0_1.showBubble(arg_15_0, arg_15_1)
	local var_15_0

	if not arg_15_1 then
		i18n = var_1_10003

		local var_15_1 = arg_15_0.bubbleTextList

		math = var_1_10005
		var_15_0 = var_1_10003(var_15_1[var_1_10005.random(#arg_15_0.bubbleTextList)])
	else
		var_15_0 = arg_15_1
	end

	setText = var_1_10003

	var_1_10003(arg_15_0.bubbleText, var_15_0)

	local function var_15_2(arg_16_0)
		local var_16_0 = arg_15_0.bubbleCG

		var_16_0.alpha = arg_16_0
		setLocalScale = var_16_0

		local var_16_1 = arg_15_0.bubbleTF

		Vector3 = var_2_10003

		var_16_0(var_16_1, var_2_10003.one * arg_16_0)

		return
	end

	local function var_15_3()
		LeanTween = var_2_10000

		local var_17_0 = var_2_10000.value

		go = var_2_10001

		local var_17_1 = var_17_0(var_2_10001(arg_15_0.bubbleTF), 1, 0, var_0_1.FADE_OUT_TIME)
		local var_17_2 = var_0.setOnUpdate

		System = var_2

		local var_17_3 = var_17_2(var_17_1, var_2.Action_float(var_15_2))
		local var_17_4 = var_0.setOnComplete

		System = var_2

		var_17_4(var_17_3, var_2.Action(function()
			setActive = var_3_10000

			var_3_10000(arg_15_0.bubbleTF, false)

			return
		end))

		return
	end

	LeanTween = var_5

	local var_15_4 = var_5.cancel

	go = var_1_10006

	var_15_4(var_1_10006(arg_15_0.bubbleTF))

	setActive = var_15_4

	var_15_4(arg_15_0.bubbleTF, true)

	LeanTween = var_15_4

	local var_15_5 = var_15_4.value

	go = var_6

	local var_15_6 = var_15_5(var_6(arg_15_0.bubbleTF), 0, 1, var_0_1.FADE_TIME)
	local var_15_7 = var_5.setOnUpdate

	System = var_7

	local var_15_8 = var_15_7(var_15_6, var_7.Action_float(var_15_2))
	local var_15_9 = var_5.setOnComplete

	System = var_7

	var_15_9(var_15_8, var_7.Action(function()
		LeanTween = var_2_10000

		local var_19_0 = var_2_10000.delayedCall

		go = var_2_10001

		local var_19_1 = var_2_10001(arg_15_0.bubbleTF)
		local var_19_2 = var_0_1.SHOW_TIME

		System = var_2_10003

		var_19_0(var_19_1, var_19_2, var_2_10003.Action(var_15_3))

		return
	end))

	return
end

return var_0_1
