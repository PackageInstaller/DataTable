class = var_0_10000

local var_0_0 = "SecretShipyardScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.optionsPath = {
	"main/top/btn_home"
}
var_0_1.ACT_ID = 5625
var_0_1.GAME_ID = 59
var_0_1.ANIMATIONS = {
	"Phase_00",
	"Phase_01",
	"Phase_02",
	"Phase_03",
	"Phase_04",
	"Phase_05",
	"Phase_06",
	"Phase_07"
}
var_0_1.EFFECT_DELAY = 2
var_0_1.ANIMATION_DELAY = 1
var_0_1.STORY_DELAY = 3

function var_0_1.getUIName(arg_1_0)
	return "SecretShipyardUI"
end

function var_0_1.init(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)

	arg_2_0.activity = var_1.getActivityById(var_2_0, var_0_1.ACT_ID)
	arg_2_0.count = 0
	arg_2_0.bgId = 1
	getProxy = var_1
	TaskProxy = var_2_0
	arg_2_0.taskProxy = var_1(var_2_0)

	local var_2_1 = arg_2_0.activity

	arg_2_0.taskGroup = var_1.getConfig(var_2_1, "config_data")

	local var_2_2 = arg_2_0._tf

	arg_2_0.main = var_1.Find(var_2_2, "main")

	local var_2_3 = arg_2_0.main

	arg_2_0.bottom = var_1.Find(var_2_3, "bottom")

	local var_2_4 = arg_2_0.bottom

	arg_2_0.gameButton = var_1.Find(var_2_4, "btn_go_game")

	local var_2_5 = arg_2_0.gameButton

	arg_2_0.gameButtonLock = var_1.Find(var_2_5, "btn_go_game_lock")

	local var_2_6 = arg_2_0.bottom

	arg_2_0.items = var_1.Find(var_2_6, "items")

	local var_2_7 = arg_2_0.bottom

	arg_2_0.item = var_1.Find(var_2_7, "item")

	local var_2_8 = arg_2_0.bottom

	arg_2_0.dayText = var_1.Find(var_2_8, "day/nday")

	local var_2_9 = arg_2_0.bottom

	arg_2_0.description = var_1.Find(var_2_9, "description/Text")

	local var_2_10 = arg_2_0.main

	arg_2_0.top = var_1.Find(var_2_10, "top")

	local var_2_11 = arg_2_0.top

	arg_2_0.buttonBack = var_1.Find(var_2_11, "btn_back")

	local var_2_12 = arg_2_0.top

	arg_2_0.buttonHelp = var_1.Find(var_2_12, "btn_help")
	UIItemList = var_1
	arg_2_0.uilist = var_1.New(arg_2_0.items, arg_2_0.item)

	local var_2_13 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_13, "bg")

	local var_2_14 = arg_2_0.bg
	local var_2_15 = var_1.Find(var_2_14, "anim")
	local var_2_16 = var_1.GetComponent

	typeof = var_4
	Animator = var_1_10006
	arg_2_0.animator = var_2_16(var_2_15, var_4(var_1_10006))

	local var_2_17 = arg_2_0.bg

	arg_2_0.effect = var_1.Find(var_2_17, "effect")

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.buttonBack

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.buttonHelp

	local function var_3_5()
		i18n = var_2_10000

		local var_5_0 = var_2_10000("shipyard_phase_1" or "shipyard_phase_2")

		pg = var_2_10001

		local var_5_1 = var_2_10001.MsgboxMgr.GetInstance()
		local var_5_2 = var_1.ShowMsgBox
		local var_5_3 = {}

		MSGBOX_TYPE_HELP = var_2_10005
		var_5_3.type = var_2_10005
		var_5_3.helps = var_5_0

		var_5_2(var_5_1, var_5_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.gameButton

	local function var_3_8()
		local var_6_0 = arg_3_0

		if var_0.checkTaskFinish(var_6_0) then
			local var_6_1 = arg_3_0

			if not var_0.checkMinigame(var_6_1) then
				return
			end

			local var_6_2 = arg_3_0
			local var_6_3 = var_0.emit

			SecretShipyardMediator = var_2_10003

			var_6_3(var_6_2, var_2_10003.GO_MINI_GAME, var_0_1.GAME_ID)

			return
		end
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.gameButtonLock

	local function var_3_11()
		pg = var_2_10000

		local var_7_0 = var_2_10000.TipsMgr.GetInstance()
		local var_7_1 = var_0.ShowTips

		i18n = var_2_10003

		local var_7_2 = arg_3_0

		var_7_1(var_7_0, var_2_10003(var_5.checkTaskFinish(var_7_2) and "shipyard_button_1" or "shipyard_button_2"))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10006)

	local var_3_12 = arg_3_0.uilist

	var_1.make(var_3_12, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = arg_3_0

			var_3.UpdateTask(var_8_0, arg_8_1, arg_8_2)
		end

		return
	end)

	setText = var_1

	local var_3_13 = arg_3_0.description

	i18n = var_4

	var_1(var_3_13, var_4("shipyard_introduce"))

	setActive = var_1

	var_1(arg_3_0.effect, false)

	setActive = var_1

	var_1(arg_3_0.buttonHelp, arg_3_0:checkMinigame())

	arg_3_0.count = arg_3_0.activity.data3
	arg_3_0.bgId = arg_3_0:CheckBgId()

	local var_3_14 = arg_3_0.animator

	var_1.Play(var_3_14, var_0_1.ANIMATIONS[arg_3_0.bgId])
	arg_3_0:OnUpdateFlush()

	local var_3_15 = arg_3_0.activity

	if var_1.getConfig(var_3_15, "config_client").firstStory then
		playStory = var_1_10002

		var_1_10002(var_1)
	end

	arg_3_0:PlayStory()

	return
end

function var_0_1.UpdateTask(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_1 + 1
	local var_9_1 = arg_9_2:Find("item")
	local var_9_2 = arg_9_0.taskGroup[arg_9_0.count][var_9_0]
	local var_9_3 = arg_9_0.taskProxy
	local var_9_5

	if not var_6.getTaskById(var_9_3, var_9_2) then
		local var_9_4 = arg_9_0.taskProxy

		var_9_5 = var_6.getFinishTaskById(var_9_4, var_9_2)
	end

	assert = var_7

	var_7(var_9_5, "without this task by id: " .. var_9_2)

	local var_9_6 = var_9_5:getConfig("award_display")[1]
	local var_9_7 = {
		type = var_9_6[1],
		id = var_9_6[2],
		count = var_9_6[3]
	}

	updateDrop = var_9

	var_9(var_9_1, var_9_7)

	onButton = var_9

	local var_9_8 = arg_9_0
	local var_9_9 = var_9_1

	local function var_9_10()
		warning = var_2_10000

		var_2_10000("click")

		local var_10_0 = arg_9_0
		local var_10_1 = var_0.emit

		BaseUI = var_2_10003

		var_10_1(var_10_0, var_2_10003.ON_DROP, var_9_7)

		return
	end

	SFX_PANEL = var_1_10014

	var_9(var_9_8, var_9_9, var_9_10, var_1_10014)

	local var_9_11 = var_9_5
	local var_9_12 = var_9_5.getProgress(var_9_11)
	local var_9_13 = var_9_5:getConfig("target_num")

	setText = var_9_11

	var_9_11(arg_9_2:Find("description"), var_9_5:getConfig("desc"))

	local var_9_14 = var_9_12
	local var_9_15 = "/" .. var_9_13

	setText = var_13

	var_13(arg_9_2:Find("progress_text"), var_9_14 .. var_9_15)

	setSlider = var_13

	var_13(arg_9_2:Find("progress"), 0, var_9_13, var_9_12)

	local var_9_16 = arg_9_2:Find("go_btn")
	local var_9_17 = arg_9_2:Find("get_btn")
	local var_9_18 = arg_9_2
	local var_9_19 = arg_9_2.Find(var_9_18, "got_btn")
	local var_9_20 = var_9_5:getTaskStatus()

	setActive = var_9_18

	var_9_18(var_9_16, var_9_20 == 0)

	setActive = var_9_18

	var_9_18(var_9_17, var_9_20 == 1)

	setActive = var_9_18

	var_9_18(var_9_19, var_9_20 == 2)

	onButton = var_9_18

	local var_9_21 = arg_9_0
	local var_9_22 = var_9_16

	local function var_9_23()
		local var_11_0 = arg_9_0
		local var_11_1 = var_0.emit

		SecretShipyardMediator = var_2_10003

		var_11_1(var_11_0, var_2_10003.TASK_GO, var_9_5)

		return
	end

	SFX_PANEL = var_1_10022

	var_9_18(var_9_21, var_9_22, var_9_23, var_1_10022)

	onButton = var_9_18

	local var_9_24 = arg_9_0
	local var_9_25 = var_9_17

	local function var_9_26()
		local var_12_0 = arg_9_0
		local var_12_1 = var_0.emit

		SecretShipyardMediator = var_2_10003

		var_12_1(var_12_0, var_2_10003.SUBMIT_TASK, var_9_5.id)

		return
	end

	SFX_PANEL = var_1_10022

	var_9_18(var_9_24, var_9_25, var_9_26, var_1_10022)

	setActive = var_9_18

	local var_9_27 = arg_9_2:Find("mask")
	local var_9_28 = arg_9_0.taskProxy

	var_9_18(var_9_27, var_20.getFinishTaskById(var_9_28, var_9_2) ~= nil)

	return
end

function var_0_1.updateTaskLayers(arg_13_0)
	updateActivityTaskStatus = var_1_10001

	var_1_10001(arg_13_0.activity)

	getProxy = var_1_10001
	ActivityProxy = var_3

	local var_13_0 = var_1_10001(var_3)

	arg_13_0.activity = var_1.getActivityById(var_13_0, var_0_1.ACT_ID)

	arg_13_0:OnUpdateFlush()

	return
end

function var_0_1.CheckBgId(arg_14_0)
	local var_14_0 = arg_14_0.activity.data3
	local var_14_1 = arg_14_0.taskProxy

	if var_2.getFinishTaskById(var_14_1, arg_14_0.taskGroup[arg_14_0.count][1]) ~= nil then
		local var_14_2 = arg_14_0.taskProxy

		if var_2.getFinishTaskById(var_14_2, arg_14_0.taskGroup[arg_14_0.count][2]) ~= nil then
			var_14_0 = var_14_0 + 1
		end
	end

	return var_14_0
end

function var_0_1.OnUpdateFlush(arg_15_0)
	arg_15_0.count = arg_15_0.activity.data3

	local var_15_0 = arg_15_0.bgId
	local var_15_1 = arg_15_0

	if var_15_0 ~= arg_15_0.CheckBgId(var_15_1) then
		arg_15_0.bgId = arg_15_0:CheckBgId()

		arg_15_0:ChangeBackground()
	end

	if arg_15_0.dayText then
		setText = var_1

		local var_15_2 = arg_15_0.dayText

		tostring = var_15_1

		var_1(var_15_2, var_15_1(arg_15_0.count))
	end

	setActive = var_1

	var_1(arg_15_0.gameButtonLock, not arg_15_0:checkTaskFinish() or not arg_15_0:checkMinigame())

	setActive = var_1

	local var_15_3 = arg_15_0.gameButton
	local var_15_4

	if not arg_15_0:checkTaskFinish() then
		var_15_4 = arg_15_0:checkMinigame()
	end

	var_1(var_15_3, var_15_4)

	local var_15_5 = arg_15_0.uilist

	var_1.align(var_15_5, #arg_15_0.taskGroup[arg_15_0.count])

	return
end

function var_0_1.ChangeBackground(arg_16_0)
	LeanTween = var_1_10001

	local var_16_0 = var_1_10001.cancel

	go = var_1_10003

	var_16_0(var_1_10003(arg_16_0._tf))

	setActive = var_16_0

	var_16_0(arg_16_0.effect, true)

	LeanTween = var_16_0

	local var_16_1 = var_16_0.delayedCall

	go = var_3

	local var_16_2 = var_3(arg_16_0._tf)
	local var_16_3 = var_0_1.ANIMATION_DELAY

	System = var_5

	var_16_1(var_16_2, var_16_3, var_5.Action(function()
		local var_17_0 = arg_16_0.animator

		var_0.Play(var_17_0, var_0_1.ANIMATIONS[arg_16_0.bgId])

		return
	end))

	LeanTween = var_16_1

	local var_16_4 = var_16_1.delayedCall

	go = var_16_2

	local var_16_5 = var_16_2(arg_16_0._tf)
	local var_16_6 = var_0_1.EFFECT_DELAY

	System = var_5

	var_16_4(var_16_5, var_16_6, var_5.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_16_0.effect, false)

		return
	end))

	LeanTween = var_16_4

	local var_16_7 = var_16_4.delayedCall

	go = var_16_5

	local var_16_8 = var_16_5(arg_16_0._tf)
	local var_16_9 = var_0_1.STORY_DELAY

	System = var_5

	var_16_7(var_16_8, var_16_9, var_5.Action(function()
		local var_19_0 = arg_16_0

		var_0.PlayStory(var_19_0)

		return
	end))

	return
end

function var_0_1.PlayStory(arg_20_0)
	local var_20_0 = arg_20_0.activity
	local var_20_1 = var_1.getConfig(var_20_0, "config_client").story

	checkExist = var_1_10002

	if var_1_10002(var_20_1, {
		arg_20_0.bgId - 1
	}, {
		1
	}) then
		playStory = var_2

		var_2(var_20_1[arg_20_0.bgId - 1][1])
	end

	return
end

function var_0_1.checkTaskFinish(arg_21_0)
	if arg_21_0.count < #arg_21_0.taskGroup then
		return false
	end

	ipairs = var_1

	for iter_21_0, iter_21_1 in var_1(arg_21_0.taskGroup[arg_21_0.count]) do
		local var_21_0 = arg_21_0.taskProxy

		if not var_6.getFinishTaskById(var_21_0, iter_21_1) then
			return false
		end
	end

	return true
end

function var_0_1.checkMinigame(arg_22_0)
	pg = var_1_10001

	local var_22_0 = var_1_10001.mini_game[var_0_1.GAME_ID].simple_config_data.show_time

	pg = var_2

	local var_22_1 = var_2.TimeMgr.GetInstance()
	local var_22_2 = var_2.inTime(var_22_1, var_22_0)

	pg = var_1_10003

	return var_1_10003.mini_game[var_0_1.GAME_ID] ~= nil and var_22_2
end

function var_0_1.willExit(arg_23_0)
	LeanTween = var_1_10001

	local var_23_0 = var_1_10001.cancel

	go = var_1_10003

	var_23_0(var_1_10003(arg_23_0._tf))

	return
end

return var_0_1
