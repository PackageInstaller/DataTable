class = var_0_10000

local var_0_0 = "SenrankaguraTrainScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.optionsPath = {
	"top/btn_home"
}
ActivityConst = var_1
var_0_1.ACT_ID = var_1.SENRANKAGURA_TRAIN_ACT_ID
var_0_1.SCROLL_OFFSET = 4.13
var_0_1.DIALOG_TIME = 0.5
var_0_1.DEFAULT_DIALOG_TIME = 4

function var_0_1.getUIName(arg_1_0)
	return "SenrankaguraTrainUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:InitData()
	arg_2_0:InitTF()

	return
end

function var_0_1.InitTF(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.top = var_1.Find(var_3_0, "top")

	local var_3_1 = arg_3_0.top

	arg_3_0.buttonAward = var_1.Find(var_3_1, "btn_award")

	local var_3_2 = arg_3_0.top

	arg_3_0.buttonBack = var_1.Find(var_3_2, "btn_back")

	local var_3_3 = arg_3_0.top

	arg_3_0.buttonHelp = var_1.Find(var_3_3, "btn_help")

	local var_3_4 = arg_3_0.top

	arg_3_0.ptText = var_1.Find(var_3_4, "pt/Text")

	local var_3_5 = arg_3_0._tf

	arg_3_0.main = var_1.Find(var_3_5, "main")

	local var_3_6 = arg_3_0.main

	arg_3_0.tachie = var_1.Find(var_3_6, "group_left/group/tachie")

	local var_3_7 = arg_3_0.main

	arg_3_0.dialog = var_1.Find(var_3_7, "group_left/group/dialog")

	local var_3_8 = arg_3_0.main

	arg_3_0.attrGroup = var_1.Find(var_3_8, "attr")

	local var_3_9 = arg_3_0.main

	arg_3_0.scroll = var_1.Find(var_3_9, "scroll")

	local var_3_10 = arg_3_0._tf

	arg_3_0.window = var_1.Find(var_3_10, "window")

	local var_3_11 = arg_3_0.window

	arg_3_0.levelWindow = var_1.Find(var_3_11, "level_window")

	local var_3_12 = arg_3_0.levelWindow

	arg_3_0.levelPtText = var_1.Find(var_3_12, "pt/Text")

	local var_3_13 = arg_3_0.levelWindow

	arg_3_0.levelBg = var_1.Find(var_3_13, "bg")

	local var_3_14 = arg_3_0.levelBg

	arg_3_0.levelWindowConfirmButton = var_1.Find(var_3_14, "btn_confirm")

	local var_3_15 = arg_3_0.levelBg

	arg_3_0.levelWindowCancelButton = var_1.Find(var_3_15, "btn_cancel")

	local var_3_16 = arg_3_0.levelBg

	arg_3_0.levelTip = var_1.Find(var_3_16, "tip")

	local var_3_17 = arg_3_0.levelBg

	arg_3_0.levelAttrGroup = var_1.Find(var_3_17, "attr")

	local var_3_18 = arg_3_0.window

	arg_3_0.awardWindow = var_1.Find(var_3_18, "award_window")

	local var_3_19 = arg_3_0.awardWindow

	arg_3_0.awardContent = var_1.Find(var_3_19, "bg/mask/content")

	local var_3_20 = arg_3_0.awardWindow

	arg_3_0.awardItem = var_1.Find(var_3_20, "bg/mask/item")

	local var_3_21 = arg_3_0.window

	arg_3_0.showWindow = var_1.Find(var_3_21, "show_window")

	local var_3_22 = arg_3_0.showWindow

	arg_3_0.showSkipButton = var_1.Find(var_3_22, "bg/btn_skip")

	local var_3_23 = arg_3_0.showWindow

	arg_3_0.spine = var_1.Find(var_3_23, "bg/spine")

	local var_3_24 = arg_3_0.top

	arg_3_0.testLevel = var_1.Find(var_3_24, "testlevel")

	local var_3_25 = arg_3_0.top

	arg_3_0.testAward = var_1.Find(var_3_25, "testaward")

	return
end

function var_0_1.InitData(arg_4_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)

	arg_4_0.activity = var_1.getActivityById(var_4_0, var_0_1.ACT_ID)
	arg_4_0.ptCount = arg_4_0.activity.data1
	arg_4_0.attrLevel = arg_4_0.activity.data1_list
	arg_4_0.awardGotList = arg_4_0.activity.data2_list
	pg = var_1
	arg_4_0.ptDemand = var_1.activity_event_pt_consume[1].target
	pg = var_1
	arg_4_0.rewardList = var_1.activity_event_pt_consume[1].reward_display

	local var_4_1 = arg_4_0.activity

	arg_4_0.showList = var_1.getConfig(var_4_1, "config_client").show_list

	local var_4_2 = arg_4_0.activity

	arg_4_0.wordsKey = var_1.getConfig(var_4_2, "config_client").words_key

	local var_4_3 = arg_4_0.activity

	arg_4_0.standAnim = var_1.getConfig(var_4_3, "config_client").stand_anim

	return
end

function var_0_1.InitButton(arg_5_0)
	for iter_5_0 = 1, arg_5_0.attrGroup.childCount do
		onButton = var_1_10005

		local var_5_0 = arg_5_0
		local var_5_1 = arg_5_0.attrGroup
		local var_5_2 = var_8.GetChild(var_5_1, iter_5_0 - 1)

		local function var_5_3()
			if arg_5_0.attrLevel[iter_5_0] > 1 then
				return
			end

			local var_6_0 = arg_5_0

			var_6_0.currentAttr = iter_5_0
			setActive = var_6_0

			var_6_0(arg_5_0.levelWindow, true)

			eachChild = var_6_0

			var_6_0(arg_5_0.levelAttrGroup, function(arg_7_0)
				setActive = var_3_10001

				var_3_10001(arg_7_0, false)

				return
			end)

			setActive = var_6_0

			local var_6_1 = arg_5_0.levelAttrGroup

			var_6_0(var_2.GetChild(var_6_1, iter_5_0 - 1), true)

			local var_6_2 = arg_5_0.attrLevel[iter_5_0] + 1
			local var_6_3 = arg_5_0.ptDemand[iter_5_0][var_6_2]

			setText = var_2

			local var_6_4 = arg_5_0.levelTip

			i18n = var_5

			var_2(var_6_4, var_5("senran_pt_consume_tip", var_6_3, var_6_2))

			return
		end

		SFX_PANEL = var_5_1

		var_1_10005(var_5_0, var_5_2, var_5_3, var_5_1)
	end

	onButton = var_1

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.levelWindowConfirmButton

	local function var_5_6()
		local var_8_0 = arg_5_0.currentAttr
		local var_8_1 = arg_5_0.attrLevel[var_8_0]
		local var_8_2 = arg_5_0.ptDemand[var_8_0][var_8_1 + 1]

		if arg_5_0.ptCount < var_8_2 then
			pg = var_3

			local var_8_3 = var_3.TipsMgr.GetInstance()
			local var_8_4 = var_3.ShowTips

			i18n = var_2_10006

			var_8_4(var_8_3, var_2_10006("senran_pt_not_enough"))
		else
			local var_8_5 = arg_5_0
			local var_8_6 = var_3.emit

			SenrankaguraTrainMediator = var_2_10006

			var_8_6(var_8_5, var_2_10006.LEVEL_UP, {
				cmd = 2,
				id = var_0_1.ACT_ID,
				arg1 = var_8_0,
				cost = var_8_2,
				arg_list = {
					arg_5_0.lvTotal + 1
				}
			})
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_5_4, var_5_5, var_5_6, var_1_10006)

	onButton = var_1

	local var_5_7 = arg_5_0
	local var_5_8 = arg_5_0.levelWindowCancelButton

	local function var_5_9()
		setActive = var_2_10000

		var_2_10000(arg_5_0.levelWindow, false)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_5_7, var_5_8, var_5_9, var_1_10006)

	onButton = var_1

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0.buttonBack

	local function var_5_12()
		local var_10_0 = arg_5_0

		var_0.closeView(var_10_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_5_10, var_5_11, var_5_12, var_1_10006)

	onButton = var_1

	local var_5_13 = arg_5_0
	local var_5_14 = arg_5_0.buttonHelp

	local function var_5_15()
		i18n = var_2_10000

		local var_11_0 = var_2_10000("senran_pt_help")

		pg = var_2_10001

		local var_11_1 = var_2_10001.MsgboxMgr.GetInstance()
		local var_11_2 = var_1.ShowMsgBox
		local var_11_3 = {}

		MSGBOX_TYPE_HELP = var_2_10005
		var_11_3.type = var_2_10005
		var_11_3.helps = var_11_0

		var_11_2(var_11_1, var_11_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_5_13, var_5_14, var_5_15, var_1_10006)

	onButton = var_1

	local var_5_16 = arg_5_0
	local var_5_17 = arg_5_0.buttonAward

	local function var_5_18()
		local var_12_0 = 0

		for iter_12_0 = 1, #arg_5_0.rewardList do
			table = var_2_10005

			if not var_2_10005.contains(arg_5_0.awardGotList, iter_12_0) then
				var_12_0 = iter_12_0 - 1

				break
			end
		end

		if var_12_0 ~= 0 then
			scrollTo = var_1

			var_1(arg_5_0.awardContent, nil, 1 - var_12_0 / (#arg_5_0.rewardList - var_0_1.SCROLL_OFFSET))
		end

		setActive = var_1

		var_1(arg_5_0.awardWindow, true)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_5_16, var_5_17, var_5_18, var_1_10006)

	onButton = var_1

	local var_5_19 = arg_5_0

	findTF = var_5_17

	local var_5_20 = var_5_17(arg_5_0.awardWindow, "black")

	local function var_5_21()
		setActive = var_2_10000

		var_2_10000(arg_5_0.awardWindow, false)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_5_19, var_5_20, var_5_21, var_6)

	onButton = var_1

	local var_5_22 = arg_5_0

	findTF = var_5_20

	local var_5_23 = var_5_20(arg_5_0.levelWindow, "black")

	local function var_5_24()
		setActive = var_2_10000

		var_2_10000(arg_5_0.levelWindow, false)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_5_22, var_5_23, var_5_24, var_6)

	onButton = var_1

	local var_5_25 = arg_5_0
	local var_5_26 = arg_5_0.showSkipButton

	local function var_5_27()
		setActive = var_2_10000

		var_2_10000(arg_5_0.showWindow, false)

		local var_15_0 = arg_5_0

		var_0.GetAward(var_15_0, arg_5_0.awardList)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_5_25, var_5_26, var_5_27, var_6)

	for iter_5_1 = 1, arg_5_0.tachie.childCount do
		local var_5_28 = arg_5_0.tachie
		local var_5_29 = var_5.GetChild(var_5_28, iter_5_1 - 1)

		onButton = var_6

		local var_5_30 = arg_5_0
		local var_5_31 = var_5_29

		local function var_5_32()
			if not arg_5_0.tachieClickable then
				return
			end

			math = var_0

			local var_16_0 = var_0.random(2, 4)
			local var_16_1 = arg_5_0

			var_1.ShowDialog(var_16_1, var_16_0, function()
				arg_5_0.tachieClickable = false

				return
			end)

			return
		end

		SFX_PANEL = var_1_10011

		var_6(var_5_30, var_5_31, var_5_32, var_1_10011)

		setActive = var_6

		var_6(var_5_29, false)

		PLATFORM_CODE = var_6
		PLATFORM_CH = var_5_28

		if var_6 ~= var_5_28 then
			findTF = var_6

			if var_6(var_5_29, "Image") then
				setActive = var_5_28

				var_5_28(var_6, false)
			end
		end
	end

	return
end

function var_0_1.didEnter(arg_18_0)
	arg_18_0:InitButton()

	UIItemList = var_1
	arg_18_0.taskList = var_1.New(arg_18_0.awardContent, arg_18_0.awardItem)

	local var_18_0 = arg_18_0.taskList

	var_1.make(var_18_0, function(arg_19_0, arg_19_1, arg_19_2)
		UIItemList = var_2_10003

		if arg_19_0 == var_2_10003.EventUpdate then
			local var_19_0 = arg_18_0

			var_3.UpdateTask(var_19_0, arg_19_1, arg_19_2)
		end

		return
	end)

	math = var_1

	local var_18_1 = var_1.random(arg_18_0.tachie.childCount)

	setActive = var_1_10002

	local var_18_2 = arg_18_0.tachie

	var_1_10002(var_4.GetChild(var_18_2, var_18_1 - 1), true)

	pg = var_1_10002
	arg_18_0.wordsGroup = var_1_10002.gametip[arg_18_0.wordsKey[var_18_1]].tip

	local var_18_3 = {}

	for iter_18_0 = 1, #arg_18_0.standAnim do
		table = var_7

		var_7.insert(var_18_3, iter_18_0)
	end

	shuffle = var_3

	var_3(var_18_3)

	for iter_18_1 = 1, arg_18_0.scroll.childCount do
		PoolMgr = var_7

		local var_18_4 = var_7.GetInstance()

		var_7.GetSpineChar(var_18_4, arg_18_0.standAnim[var_18_3[iter_18_1]], false, function(arg_20_0)
			local var_20_0 = arg_20_0.transform

			Vector3 = var_2_10002
			var_20_0.localScale = var_2_10002.one

			local var_20_1 = arg_20_0.transform
			local var_20_2 = var_1.SetParent
			local var_20_3 = arg_18_0.scroll

			var_20_2(var_20_1, var_4.GetChild(var_20_3, iter_18_1 - 1), false)

			local var_20_4 = arg_20_0
			local var_20_5 = arg_20_0.GetComponent

			typeof = var_4
			SpineAnimUI = var_20_3

			local var_20_6 = var_20_5(var_20_4, var_4(var_20_3))

			var_1.SetAction(var_20_6, "stand2", 0)

			return
		end)
	end

	arg_18_0:ShowDialog(1, function()
		arg_18_0.tachieClickable = false

		return
	end)
	arg_18_0:UpdateFlush()

	return
end

function var_0_1.UpdateTask(arg_22_0, arg_22_1, arg_22_2)
	arg_22_1 = arg_22_1 + 1

	local var_22_0 = arg_22_2:Find("IconTpl")

	setText = var_1_10004
	findTF = var_6

	var_1_10004(var_6(arg_22_2, "title"), "PHASE" .. arg_22_1)

	local var_22_1 = arg_22_0.rewardList[arg_22_1]
	local var_22_2 = {
		type = var_22_1[1],
		id = var_22_1[2],
		count = var_22_1[3]
	}

	updateDrop = var_6

	var_6(var_22_0, var_22_2)

	onButton = var_6

	local var_22_3 = arg_22_0
	local var_22_4 = var_22_0

	local function var_22_5()
		local var_23_0 = arg_22_0
		local var_23_1 = var_0.emit

		BaseUI = var_2_10003

		var_23_1(var_23_0, var_2_10003.ON_DROP, var_22_2)

		return
	end

	SFX_PANEL = var_1_10011

	var_6(var_22_3, var_22_4, var_22_5, var_1_10011)

	setText = var_6

	local var_22_6 = arg_22_2:Find("progress")

	i18n = var_22_4

	var_6(var_22_6, var_22_4("senran_pt_rank", arg_22_1))

	table = var_6

	local var_22_7 = var_6.contains(arg_22_0.awardGotList, arg_22_1)

	setActive = var_7

	var_7(arg_22_2:Find("mask"), var_22_7)

	return
end

function var_0_1.ShowDialog(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0.LTList = {}

	if arg_24_2 then
		arg_24_2()
	end

	local var_24_0 = "event:/cv/" .. arg_24_0.wordsGroup[arg_24_1][1]
	local var_24_1 = arg_24_0.wordsGroup[arg_24_1][2]

	setText = var_1_10005
	findTF = var_1_10007

	var_1_10005(var_1_10007(arg_24_0.dialog, "Text"), var_24_1)

	setLocalScale = var_1_10005

	var_1_10005(arg_24_0.dialog, {
		z = 0,
		x = 0,
		y = 0
	})

	table = var_1_10005

	local var_24_2 = var_1_10005.insert
	local var_24_3 = arg_24_0.LTList

	LeanTween = var_8

	local var_24_4 = var_8.scale
	local var_24_5 = arg_24_0.dialog

	Vector3 = var_1_10011

	local var_24_6 = var_24_4(var_24_5, var_1_10011.New(1, 1, 1), var_0_1.DIALOG_TIME)
	local var_24_7 = var_8.setEase

	LeanTweenType = var_11

	var_24_2(var_24_3, var_24_7(var_24_6, var_11.easeOutSine).uniqueId)

	pg = var_24_2

	local var_24_8 = var_24_2.CriMgr.GetInstance()

	var_5.PlaySoundEffect_V3(var_24_8, var_24_0, function(arg_25_0)
		arg_24_0.playSoundInfo = arg_25_0

		local var_25_0 = var_0_1.DEFAULT_DIALOG_TIME

		if arg_25_0 then
			var_25_0 = arg_25_0:GetLength() * 0.001 - var_0_1.DIALOG_TIME
		end

		table = var_2_10002

		local var_25_1 = var_2_10002.insert
		local var_25_2 = arg_24_0.LTList

		LeanTween = var_2_10005

		local var_25_3 = var_2_10005.delayedCall

		go = var_2_10007

		local var_25_4 = var_2_10007(arg_24_0.dialog)
		local var_25_5 = var_25_0

		System = var_9

		var_25_1(var_25_2, var_25_3(var_25_4, var_25_5, var_9.Action(function()
			local var_26_0 = arg_24_0

			var_0.HideDialog(var_26_0)

			return
		end)).uniqueId)

		return
	end)

	return
end

function var_0_1.HideDialog(arg_27_0)
	table = var_1_10001

	local var_27_0 = var_1_10001.insert
	local var_27_1 = arg_27_0.LTList

	LeanTween = var_1_10004

	local var_27_2 = var_1_10004.scale
	local var_27_3 = arg_27_0.dialog

	Vector3 = var_1_10007

	local var_27_4 = var_27_2(var_27_3, var_1_10007.New(0, 0, 0), var_0_1.DIALOG_TIME)
	local var_27_5 = var_4.setEase

	LeanTweenType = var_7

	local var_27_6 = var_27_5(var_27_4, var_7.easeOutSine)
	local var_27_7 = var_4.setOnComplete

	System = var_7

	var_27_0(var_27_1, var_27_7(var_27_6, var_7.Action(function()
		arg_27_0.tachieClickable = true

		return
	end)).uniqueId)

	return
end

function var_0_1.LevelUp(arg_29_0, arg_29_1)
	arg_29_0.awardList = arg_29_1
	setActive = var_1_10002

	var_1_10002(arg_29_0.levelWindow, false)

	setActive = var_1_10002

	var_1_10002(arg_29_0.showWindow, true)
	arg_29_0:UpdateFlush()

	local var_29_0 = arg_29_0.showList[arg_29_0.currentAttr][arg_29_0.attrLevel[arg_29_0.currentAttr]]

	arg_29_0:SetAnim(arg_29_0.spine, var_29_0, function()
		setActive = var_2_10000

		var_2_10000(arg_29_0.showWindow, false)

		local var_30_0 = arg_29_0

		var_0.GetAward(var_30_0, arg_29_1)

		return
	end)

	return
end

function var_0_1.GetAward(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0
	local var_31_1 = arg_31_0.emit

	BaseUI = var_1_10005

	var_31_1(var_31_0, var_1_10005.ON_ACHIEVE, arg_31_1, function()
		arg_31_0.awardList = nil

		local var_32_0 = arg_31_0

		var_0.ShowDialog(var_32_0, 5, function()
			arg_31_0.tachieClickable = false

			if arg_31_0.playSoundInfo and arg_31_0.playSoundInfo.channelPlayer ~= nil then
				pg = var_0

				local var_33_0 = var_0.CriMgr.GetInstance()

				var_0.StopPlaybackInfoForce(var_33_0, arg_31_0.playSoundInfo)
			end

			pairs = var_0

			for iter_33_0, iter_33_1 in var_0(arg_31_0.LTList) do
				LeanTween = var_3_10005

				var_3_10005.cancel(iter_33_1)
			end

			return
		end)

		return
	end)
	arg_31_0:UpdateFlush()

	return
end

function var_0_1.UpdateFlush(arg_34_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_34_0 = var_1_10001(var_1_10003)

	arg_34_0.activity = var_1.getActivityById(var_34_0, var_0_1.ACT_ID)
	arg_34_0.ptCount = arg_34_0.activity.data1
	arg_34_0.attrLevel = arg_34_0.activity.data1_list
	arg_34_0.awardGotList = arg_34_0.activity.data2_list
	arg_34_0.lvTotal = 0
	pairs = var_1

	for iter_34_0, iter_34_1 in var_1(arg_34_0.attrLevel) do
		arg_34_0.lvTotal = arg_34_0.lvTotal + iter_34_1
	end

	setText = var_1

	var_1(arg_34_0.ptText, arg_34_0.ptCount)

	setText = var_1

	var_1(arg_34_0.levelPtText, arg_34_0.ptCount)
	;(function(arg_35_0, arg_35_1)
		for iter_35_0 = 1, arg_35_0.childCount do
			local var_35_0 = arg_35_0
			local var_35_1 = arg_35_0.GetChild(var_35_0, iter_35_0 - 1)

			eachChild = var_2_10007

			var_2_10007(var_35_1, function(arg_36_0)
				setActive = var_3_10001

				var_3_10001(arg_36_0, false)

				return
			end)

			var_2_10007 = arg_34_0.attrLevel[iter_35_0]
			setActive = var_35_0

			var_35_0(var_35_1:GetChild(var_2_10007), true)

			if arg_35_1 and var_2_10007 < 2 and arg_34_0.ptDemand[iter_35_0][var_2_10007 + 1] <= arg_34_0.ptCount then
				setActive = var_8
				findTF = var_10

				var_8(var_10(var_35_1, "red"), true)
			end
		end

		return
	end)(arg_34_0.attrGroup, true)
	var_1(arg_34_0.levelAttrGroup, false)

	local var_34_1 = arg_34_0.taskList

	var_2.align(var_34_1, #arg_34_0.rewardList)

	return
end

function var_0_1.SetAnim(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = arg_37_1
	local var_37_1 = arg_37_1.GetComponent

	typeof = var_1_10007
	SpineAnimUI = var_1_10009

	local var_37_2 = var_37_1(var_37_0, var_1_10007(var_1_10009))

	var_4.SetActionCallBack(var_37_2, nil)
	var_4:SetAction(arg_37_2, 0)
	var_4:SetActionCallBack(function(arg_38_0)
		if arg_38_0 == "finish" then
			local var_38_0 = var_0

			var_1.SetActionCallBack(var_38_0, nil)

			if arg_37_3 then
				arg_37_3()
			end
		end

		return
	end)

	return
end

function var_0_1.willExit(arg_39_0)
	pairs = var_1_10001

	for iter_39_0, iter_39_1 in var_1_10001(arg_39_0.LTList) do
		LeanTween = var_1_10006

		var_1_10006.cancel(iter_39_1)
	end

	return
end

function var_0_1.IsShowRed()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_40_0 = var_1_10000(var_1_10002)
	local var_40_1 = var_0.getActivityById(var_40_0, var_0_1.ACT_ID).data1_list

	pg = var_40_0

	local var_40_2 = var_40_0.activity_event_pt_consume[1].target
	local var_40_3 = var_0.data1

	pairs = var_1_10004

	for iter_40_0, iter_40_1 in var_1_10004(var_40_1) do
		if iter_40_1 < 2 and var_40_3 >= var_40_2[iter_40_0][iter_40_1 + 1] then
			return true
		end
	end

	return false
end

return var_0_1
