class = var_0_10000

local var_0_0 = "IceCreamGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))
local var_0_2 = "EVENT_ICE_FINISH"
local var_0_3 = "EVENT_UPDATE_WAIT_TIME"
local var_0_4 = 0.05
local var_0_5 = 2
local var_0_6 = {
	{
		6,
		10
	},
	{
		8,
		12
	},
	{
		10,
		14
	}
}
local var_0_7 = 60
local var_0_8 = {
	750,
	250,
	300
}
local var_0_9 = {
	200,
	100
}
local var_0_10 = {
	100,
	50,
	20
}
local var_0_11 = 20
local var_0_12 = {
	point_boost = 100,
	wait_time_boost = 2,
	bullet_time = {
		0.1,
		4,
		0.8,
		5
	}
}
local var_0_13 = {
	{
		1
	},
	{
		0,
		1
	},
	{
		1,
		0,
		2
	}
}
local var_0_14 = {
	{
		1
	},
	{
		2
	},
	{
		1,
		3
	}
}
local var_0_15 = {
	"A",
	"B",
	"C",
	"D"
}
local var_0_16 = {
	"H",
	"J",
	"K",
	"I"
}
local var_0_17

local function var_0_18(arg_1_0)
	if var_0_17 then
		local var_1_0 = var_0_17

		var_1.Pause(var_1_0, not arg_1_0)
	elseif arg_1_0 then
		pg = var_1

		local var_1_1 = var_1.CriMgr.GetInstance()

		var_1.PlaySoundEffect_V3(var_1_1, "ui-icecream_topping", function(arg_2_0)
			assert = var_2_10001

			var_2_10001(arg_2_0)

			var_0_17 = arg_2_0.playback

			return
		end)
	end

	return
end

function var_0_1.getUIName(arg_3_0)
	return "IceCreamGameUI"
end

function var_0_1.initTimer(arg_4_0)
	Timer = var_1_10001
	arg_4_0.timer = var_1_10001.New(function()
		local var_5_0 = arg_4_0

		var_0.onTimer(var_5_0)

		return
	end, var_0_4, -1)

	return
end

function var_0_1.didEnter(arg_6_0)
	arg_6_0:initTimer()
	arg_6_0:initUI()
	arg_6_0:initGameUI()
	arg_6_0:openMainUI()

	return
end

function var_0_1.initUI(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.clickMask = var_1.Find(var_7_0, "ui/click_mask")

	local var_7_1 = arg_7_0._tf

	arg_7_0.rtResource = var_1.Find(var_7_1, "Resource")

	local var_7_2 = arg_7_0._tf

	arg_7_0.mainUI = var_1.Find(var_7_2, "ui/main_ui")
	GetComponent = var_1

	local var_7_3 = arg_7_0.mainUI
	local var_7_4 = var_2.Find(var_7_3, "right_panel/item_list/content")

	typeof = var_7_3
	ScrollRect = var_4
	arg_7_0.listScrollRect = var_1(var_7_4, var_7_3(var_4))
	onButton = var_1

	local var_7_5 = arg_7_0
	local var_7_6 = arg_7_0.mainUI
	local var_7_7 = var_3.Find(var_7_6, "btn_back")

	local function var_7_8()
		local var_8_0 = arg_7_0

		var_0.emit(var_8_0, var_0_1.ON_BACK_PRESSED)

		return
	end

	SFX_PANEL = var_5

	var_1(var_7_5, var_7_7, var_7_8, var_5)

	onButton = var_1

	local var_7_9 = arg_7_0
	local var_7_10 = arg_7_0.mainUI
	local var_7_11 = var_3.Find(var_7_10, "bg/btn_help")

	local function var_7_12()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_9_2.type = var_2_10003
		pg = var_2_10003
		var_9_2.helps = var_2_10003.gametip.icecreamgame_tip.tip

		var_9_1(var_9_0, var_9_2)

		return
	end

	SFX_PANEL = var_5

	var_1(var_7_9, var_7_11, var_7_12, var_5)

	onButton = var_1

	local var_7_13 = arg_7_0
	local var_7_14 = arg_7_0.mainUI
	local var_7_15 = var_3.Find(var_7_14, "bg/btn_start")

	local function var_7_16()
		local var_10_0 = arg_7_0

		var_0.readyStart(var_10_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_7_13, var_7_15, var_7_16, var_5)

	arg_7_0.totalTimes = arg_7_0:getGameTotalTime()

	local var_7_17, var_7_18

	if arg_7_0:getGameUsedTimes() - 4 < 0 then
		var_7_17 = 0
	else
		var_7_18 = arg_7_0
		var_7_17 = arg_7_0.getGameUsedTimes(var_7_18) - 4
	end

	scrollTo = var_7_18

	var_7_18(arg_7_0.listScrollRect, 0, 1 - var_7_17 / (arg_7_0.totalTimes - 4))

	onButton = var_7_18

	local var_7_19 = arg_7_0
	local var_7_20 = arg_7_0.mainUI
	local var_7_21 = var_4.Find(var_7_20, "right_panel/arrows_up")

	local function var_7_22()
		local var_11_0 = arg_7_0.listScrollRect.normalizedPosition.y + 1 / (arg_7_0.totalTimes - 4)

		if 1 < var_11_0 then
			var_11_0 = 1
		end

		scrollTo = var_1

		var_1(arg_7_0.listScrollRect, 0, var_11_0)

		return
	end

	SFX_PANEL = var_6

	var_7_18(var_7_19, var_7_21, var_7_22, var_6)

	onButton = var_7_18

	local var_7_23 = arg_7_0
	local var_7_24 = arg_7_0.mainUI
	local var_7_25 = var_4.Find(var_7_24, "right_panel/arrows_down")

	local function var_7_26()
		local var_12_0

		if arg_7_0.listScrollRect.normalizedPosition.y - 1 / (arg_7_0.totalTimes - 4) < 0 then
			var_12_0 = 0
		end

		scrollTo = var_1

		var_1(arg_7_0.listScrollRect, 0, var_12_0)

		return
	end

	SFX_PANEL = var_6

	var_7_18(var_7_23, var_7_25, var_7_26, var_6)

	pg = var_7_18

	local var_7_27 = var_7_18.mini_game[arg_7_0:GetMGData().id].simple_config_data.drop_ids
	local var_7_28 = arg_7_0.mainUI
	local var_7_29 = var_3.Find(var_7_28, "right_panel/item_list/content")

	UIItemList = var_7_28
	arg_7_0.itemList = var_7_28.New(var_7_29, var_7_29:GetChild(0))

	local var_7_30 = arg_7_0.itemList

	var_4.make(var_7_30, function(arg_13_0, arg_13_1, arg_13_2)
		arg_13_1 = arg_13_1 + 1
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventUpdate then
			arg_13_2.name = arg_13_1
			GetImageSpriteFromAtlasAsync = var_3

			var_3("ui/minigameui/icecreamgameui_atlas", "day_" .. arg_13_1, arg_13_2:Find("text"))

			local var_13_0 = arg_13_2:Find("IconTpl")
			local var_13_1 = {}

			unpack = var_5

			local var_13_2, var_13_3, var_13_4 = var_5(var_7_27[arg_13_1])

			var_13_1.count = var_13_4
			var_13_1.id = var_13_3
			var_13_1.type = var_13_2
			updateDrop = var_13_2

			var_13_2(var_13_0, var_13_1)

			onButton = var_13_2

			local var_13_5 = arg_7_0
			local var_13_6 = var_13_0

			local function var_13_7()
				local var_14_0 = arg_7_0

				var_0.emit(var_14_0, var_0_1.ON_DROP, var_13_1)

				return
			end

			SFX_PANEL = var_2_10009

			var_13_2(var_13_5, var_13_6, var_13_7, var_2_10009)
		end

		return
	end)

	local var_7_31 = arg_7_0.itemList

	var_4.align(var_7_31, #var_7_27)

	local var_7_32 = arg_7_0._tf

	arg_7_0.countUI = var_4.Find(var_7_32, "ui/count_ui")
	GetComponent = var_4

	local var_7_33 = arg_7_0.countUI
	local var_7_34 = var_5.Find(var_7_33, "count")

	typeof = var_7_33
	Animator = var_7
	arg_7_0.countAnimator = var_4(var_7_34, var_7_33(var_7))
	GetOrAddComponent = var_4

	local var_7_35 = arg_7_0.countUI
	local var_7_36 = var_5.Find(var_7_35, "count")

	typeof = var_7_35
	DftAniEvent = var_7
	arg_7_0.countDft = var_4(var_7_36, var_7_35(var_7))

	local var_7_37 = arg_7_0.countDft

	var_4.SetTriggerEvent(var_7_37, function()
		return
	end)

	local var_7_38 = arg_7_0.countDft

	var_4.SetEndEvent(var_7_38, function()
		setActive = var_2_10000

		var_2_10000(arg_7_0.countUI, false)

		local var_16_0 = arg_7_0

		var_0.startGame(var_16_0)

		return
	end)

	local var_7_39 = arg_7_0._tf

	arg_7_0.pauseUI = var_4.Find(var_7_39, "ui/pause_ui")
	onButton = var_4

	local var_7_40 = arg_7_0
	local var_7_41 = arg_7_0.pauseUI
	local var_7_42 = var_6.Find(var_7_41, "panel/btn_confirm")

	local function var_7_43()
		pg = var_2_10000

		local var_17_0 = var_2_10000.UIMgr.GetInstance()
		local var_17_1 = var_0.UnOverlayPanel
		local var_17_2 = arg_7_0.pauseUI
		local var_17_3 = arg_7_0._tf

		var_17_1(var_17_0, var_17_2, var_3.Find(var_17_3, "ui"))

		setActive = var_17_1

		var_17_1(arg_7_0.pauseUI, false)

		local var_17_4 = arg_7_0

		var_0.resumeGame(var_17_4)

		return
	end

	SFX_PANEL = var_8

	var_4(var_7_40, var_7_42, var_7_43, var_8)

	local var_7_44 = arg_7_0._tf

	arg_7_0.returnUI = var_4.Find(var_7_44, "ui/return_ui")
	onButton = var_4

	local var_7_45 = arg_7_0
	local var_7_46 = arg_7_0.returnUI
	local var_7_47 = var_6.Find(var_7_46, "panel/btn_confirm")

	local function var_7_48()
		pg = var_2_10000

		local var_18_0 = var_2_10000.UIMgr.GetInstance()
		local var_18_1 = var_0.UnOverlayPanel
		local var_18_2 = arg_7_0.returnUI
		local var_18_3 = arg_7_0._tf

		var_18_1(var_18_0, var_18_2, var_3.Find(var_18_3, "ui"))

		setActive = var_18_1

		var_18_1(arg_7_0.returnUI, false)

		local var_18_4 = arg_7_0

		var_0.resumeGame(var_18_4)

		local var_18_5 = arg_7_0

		var_0.endGame(var_18_5)

		return
	end

	SFX_PANEL = var_8

	var_4(var_7_45, var_7_47, var_7_48, var_8)

	onButton = var_4

	local var_7_49 = arg_7_0
	local var_7_50 = arg_7_0.returnUI
	local var_7_51 = var_6.Find(var_7_50, "panel/btn_cancel")

	local function var_7_52()
		pg = var_2_10000

		local var_19_0 = var_2_10000.UIMgr.GetInstance()
		local var_19_1 = var_0.UnOverlayPanel
		local var_19_2 = arg_7_0.returnUI
		local var_19_3 = arg_7_0._tf

		var_19_1(var_19_0, var_19_2, var_3.Find(var_19_3, "ui"))

		setActive = var_19_1

		var_19_1(arg_7_0.returnUI, false)

		local var_19_4 = arg_7_0

		var_0.resumeGame(var_19_4)

		return
	end

	SFX_PANEL = var_8

	var_4(var_7_49, var_7_51, var_7_52, var_8)

	local var_7_53 = arg_7_0._tf

	arg_7_0.endUI = var_4.Find(var_7_53, "ui/end_ui")
	onButton = var_4

	local var_7_54 = arg_7_0
	local var_7_55 = arg_7_0.endUI
	local var_7_56 = var_6.Find(var_7_55, "panel/btn_finish")

	local function var_7_57()
		pg = var_2_10000

		local var_20_0 = var_2_10000.UIMgr.GetInstance()
		local var_20_1 = var_0.UnOverlayPanel
		local var_20_2 = arg_7_0.endUI
		local var_20_3 = arg_7_0._tf

		var_20_1(var_20_0, var_20_2, var_3.Find(var_20_3, "ui"))

		setActive = var_20_1

		var_20_1(arg_7_0.endUI, false)

		local var_20_4 = arg_7_0

		var_0.openMainUI(var_20_4)

		return
	end

	SFX_PANEL = var_8

	var_4(var_7_54, var_7_56, var_7_57, var_8)

	if not arg_7_0.handle then
		UpdateBeat = var_4
		arg_7_0.handle = var_4:CreateListener(arg_7_0.Update, arg_7_0)
	end

	UpdateBeat = var_4

	var_4:AddListener(arg_7_0.handle)

	return
end

function var_0_1.Update(arg_21_0)
	return
end

function var_0_1.initGameUI(arg_22_0)
	local var_22_0 = arg_22_0._tf

	arg_22_0.gameUI = var_1.Find(var_22_0, "ui/game_ui")

	local var_22_1 = arg_22_0.gameUI

	arg_22_0.timeTF = var_1.Find(var_22_1, "Score/time/Text")

	local var_22_2 = arg_22_0.gameUI

	arg_22_0.scoreTF = var_1.Find(var_22_2, "Score/point/Text")

	local var_22_3 = arg_22_0.gameUI

	arg_22_0.addScoreTF = var_1.Find(var_22_3, "Score/add_score")
	onButton = var_1

	local var_22_4 = arg_22_0
	local var_22_5 = arg_22_0.gameUI

	var_1(var_22_4, var_3.Find(var_22_5, "Button/btn_pause"), function()
		local var_23_0 = arg_22_0

		var_0.pauseGame(var_23_0)

		pg = var_0

		local var_23_1 = var_0.UIMgr.GetInstance()

		var_0.OverlayPanel(var_23_1, arg_22_0.pauseUI)

		setActive = var_0

		var_0(arg_22_0.pauseUI, true)

		return
	end)

	onButton = var_1

	local var_22_6 = arg_22_0
	local var_22_7 = arg_22_0.gameUI

	var_1(var_22_6, var_3.Find(var_22_7, "Button/btn_back"), function()
		local var_24_0 = arg_22_0

		var_0.pauseGame(var_24_0)

		pg = var_0

		local var_24_1 = var_0.UIMgr.GetInstance()

		var_0.OverlayPanel(var_24_1, arg_22_0.returnUI)

		setActive = var_0

		var_0(arg_22_0.returnUI, true)

		return
	end)

	local var_22_8 = arg_22_0.gameUI

	arg_22_0.rtWalk = var_1.Find(var_22_8, "Walk")

	local var_22_9 = arg_22_0.gameUI

	arg_22_0.rtMake = var_1.Find(var_22_9, "Make")

	local var_22_10 = arg_22_0.gameUI

	arg_22_0.rtTime = var_1.Find(var_22_10, "Time")

	local var_22_11 = arg_22_0.gameUI

	arg_22_0.rtButton = var_1.Find(var_22_11, "Button")

	for iter_22_0 = 1, 4 do
		onButton = var_5

		local var_22_12 = arg_22_0
		local var_22_13 = arg_22_0.rtButton

		var_5(var_22_12, var_7.Find(var_22_13, "L" .. iter_22_0), function()
			if not arg_22_0.iceBuild or arg_22_0.iceBuild.isLeftLock then
				return
			end

			local var_25_0 = arg_22_0.targetList[arg_22_0.targetIndex]._info

			if #arg_22_0.iceBuild._info[1] == #var_25_0[1] then
				return
			end

			local var_25_1 = arg_22_0.iceBuild

			var_1.MakeBall(var_25_1, iter_22_0)

			return
		end)

		onButton = var_5

		local var_22_14 = arg_22_0
		local var_22_15 = arg_22_0.rtButton

		var_5(var_22_14, var_7.Find(var_22_15, "R" .. iter_22_0), function()
			if not arg_22_0.iceBuild or arg_22_0.iceBuild.isRightLock then
				return
			end

			local var_26_0 = arg_22_0.targetList[arg_22_0.targetIndex]._info

			if #arg_22_0.iceBuild._info[2] == #var_26_0[2] then
				return
			end

			if not arg_22_0.iceBuild._info[1][var_0_14[#var_26_0[1]][#arg_22_0.iceBuild._info[2] + 1]] then
				local var_26_1 = arg_22_0.iceBuild

				var_1.MakeMissTopping(var_26_1, iter_22_0)
			else
				local var_26_2 = arg_22_0.iceBuild

				var_1.MakeTopping(var_26_2, iter_22_0)
			end

			return
		end)
	end

	arg_22_0:bind(var_0_2, function(arg_27_0, ...)
		local var_27_0 = arg_22_0

		var_1.ResultTarget(var_27_0, ...)

		return
	end)
	arg_22_0:bind(var_0_3, function(arg_28_0, arg_28_1, ...)
		eachChild = var_2_10002

		var_2_10002(arg_22_0.rtTime, function(arg_29_0)
			setActive = var_3_10001

			var_3_10001(arg_29_0, arg_29_0.name == arg_28_1)

			return
		end)

		setSlider = var_2_10002

		local var_28_0 = arg_22_0.rtTime

		var_2_10002(var_3.Find(var_28_0, arg_28_1), ...)

		return
	end)

	return
end

function var_0_1.updateMainUI(arg_30_0)
	local var_30_0 = arg_30_0:getGameUsedTimes()
	local var_30_1 = arg_30_0:getGameTimes()
	local var_30_2 = arg_30_0.itemList.container.childCount

	for iter_30_0 = 1, var_30_2 do
		local var_30_3 = {
			award = true
		}

		if iter_30_0 <= var_30_0 then
			var_30_3.finish = true
		elseif iter_30_0 == var_30_0 + 1 and var_30_1 >= 1 then
			-- block empty
		elseif var_30_0 < iter_30_0 and iter_30_0 <= var_30_0 + var_30_1 then
			-- block empty
		else
			var_30_3.lock = true
			var_30_3.award = false
		end

		local var_30_4 = var_3
		local var_30_5 = var_3.GetChild(var_30_4, iter_30_0 - 1)

		setActive = var_30_4

		var_30_4(var_30_5:Find("finish"), var_30_3.finish)

		setActive = var_30_4

		var_30_4(var_30_5:Find("lock"), var_30_3.lock)

		setActive = var_30_4

		var_30_4(var_30_5:Find("IconTpl"), var_30_3.award)
	end

	arg_30_0.totalTimes = arg_30_0:getGameTotalTime()

	local var_30_6 = 1 - (arg_30_0:getGameUsedTimes() - 3 < 0 and 0 or arg_30_0:getGameUsedTimes() - 3) / (arg_30_0.totalTimes - 4)

	if 1 < var_30_6 then
		var_30_6 = 1
	end

	scrollTo = var_7

	var_7(arg_30_0.listScrollRect, 0, var_30_6)
	arg_30_0:checkGet()

	return
end

function var_0_1.checkGet(arg_31_0)
	if arg_31_0:getUltimate() == 0 then
		local var_31_0 = arg_31_0:getGameTotalTime()
		local var_31_1 = arg_31_0

		if var_31_0 > arg_31_0.getGameUsedTimes(var_31_1) then
			return
		end

		pg = var_31_1

		local var_31_2 = var_31_1.m02
		local var_31_3 = var_3.sendNotification

		GAME = var_1_10005

		local var_31_4 = var_1_10005.SEND_MINI_GAME_OP
		local var_31_5 = {
			hubid = arg_31_0:GetMGHubData().id
		}

		MiniGameOPCommand = var_7
		var_31_5.cmd = var_7.CMD_ULTIMATE
		var_31_5.args1 = {}

		var_31_3(var_31_2, var_31_4, var_31_5)
	end

	return
end

function var_0_1.openMainUI(arg_32_0)
	setActive = var_1_10001

	var_1_10001(arg_32_0.gameUI, false)

	setActive = var_1_10001

	var_1_10001(arg_32_0.mainUI, true)
	arg_32_0:updateMainUI()

	return
end

function var_0_1.readyStart(arg_33_0)
	setActive = var_1_10001

	var_1_10001(arg_33_0.mainUI, false)

	setActive = var_1_10001

	var_1_10001(arg_33_0.countUI, true)

	local var_33_0 = arg_33_0.countAnimator

	var_1.Play(var_33_0, "count")

	pg = var_1

	local var_33_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_33_1, "event:/ui/ddldaoshu2")
	arg_33_0:resetGame()

	return
end

function var_0_1.resetGame(arg_34_0)
	arg_34_0.gameStartFlag = false
	arg_34_0.gamePause = false
	arg_34_0.gameEndFlag = false
	arg_34_0.scoreNum = 0
	arg_34_0.lastTime = var_0_7
	arg_34_0.targetNameList = {}
	arg_34_0.targetList = {}
	arg_34_0.iceBuild = nil
	arg_34_0.countList = {
		0,
		0,
		0
	}
	arg_34_0.effectTrigger = {
		bullet_time = {
			doingTime = 0,
			waitTime = 0
		},
		wait_time_boost = {
			count = 0
		},
		point_boost = {}
	}
	eachChild = var_1

	local var_34_0 = arg_34_0.rtResource

	var_1(var_2.Find(var_34_0, "Character"), function(arg_35_0)
		table = var_2_10001

		var_2_10001.insert(arg_34_0.targetNameList, arg_35_0.name)

		return
	end)

	removeAllChildren = var_1

	var_1(arg_34_0.rtWalk)

	setActive = var_1

	local var_34_1 = arg_34_0.gameUI

	var_1(var_2.Find(var_34_1, "BulletTimeMask"), false)

	setActive = var_1

	var_1(arg_34_0.rtMake, false)

	setActive = var_1

	var_1(arg_34_0.rtTime, false)

	setText = var_1

	var_1(arg_34_0.scoreTF, arg_34_0.scoreNum)

	setActive = var_1

	var_1(arg_34_0.addScoreTF, false)
	arg_34_0:setAnimatorSpeed(arg_34_0._tf, 1)

	return
end

local function var_0_19(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = {}

	local function var_36_1(arg_37_0, arg_37_1)
		math = var_2_10002

		for iter_37_0 = var_2_10002.max(#arg_37_1[1], 2), 1, -1 do
			setActive = var_2_10006

			var_2_10006(arg_37_0:Find(iter_37_0), arg_37_1[1][iter_37_0])

			if arg_37_1[1][iter_37_0] then
				local var_37_0 = arg_37_0

				var_2_10006 = arg_37_0.Find(var_37_0, iter_37_0)
				GetImageSpriteFromAtlasAsync = var_37_0

				var_37_0("ui/minigameui/icecreamgameui_atlas", "Assets/ArtResource/UI/MiniGameUI/IceCreamGameUI/ICE_S/" .. var_0_15[arg_37_1[1][iter_37_0]] .. ".png", var_2_10006:Find("Scoop"), true)

				local var_37_1 = arg_37_1[2][var_0_13[#arg_37_1[1]][iter_37_0]]

				setActive = var_8

				var_8(var_2_10006:Find("Topping"), var_37_1)

				if var_37_1 then
					GetImageSpriteFromAtlasAsync = var_8

					var_8("ui/minigameui/icecreamgameui_atlas", "Assets/ArtResource/UI/MiniGameUI/IceCreamGameUI/ICE_S/" .. var_0_16[var_37_1] .. ".png", var_2_10006:Find("Topping"), true)
				end
			end
		end

		return
	end

	function var_36_0.Ctor(arg_38_0)
		arg_38_0._tf = arg_36_0
		arg_38_0._event = arg_36_1
		arg_38_0._info = arg_36_2
		arg_38_0.time = arg_36_3
		arg_38_0.pointBoost = 100
		arg_38_0.result = nil

		local var_38_0 = #arg_36_2[1] < 3 and "Cone" or "Bowl"

		ipairs = var_2

		for iter_38_0, iter_38_1 in var_2({
			"IceCream",
			"Bubble",
			"BadCream"
		}) do
			eachChild = var_2_10007

			local var_38_1 = arg_36_0

			var_2_10007(var_8.Find(var_38_1, iter_38_1), function(arg_39_0)
				setActive = var_3_10001

				var_3_10001(arg_39_0, arg_39_0.name == var_38_0)

				return
			end)
		end

		local var_38_2 = var_36_1
		local var_38_3 = arg_36_0

		var_38_2(var_3.Find(var_38_3, "Bubble/" .. var_38_0), arg_36_2)

		GetImageSpriteFromAtlasAsync = var_38_2

		local var_38_4 = "ui/minigameui/icecreamgameui_atlas"
		local var_38_5 = "Assets/ArtResource/UI/MiniGameUI/IceCreamGameUI/ICE_S/bubble_" .. #arg_36_2[1] .. ".png"
		local var_38_6 = arg_36_0

		var_38_2(var_38_4, var_38_5, var_5.Find(var_38_6, "Bubble"), true)

		setActive = var_38_2

		local var_38_7 = arg_36_0

		var_38_2(var_3.Find(var_38_7, "Bubble/Boost"), false)

		GetComponent = var_38_2

		local var_38_8 = arg_38_0._tf

		typeof = var_4
		Animator = var_5
		arg_38_0.animator = var_38_2(var_38_8, var_4(var_5))

		local var_38_9 = arg_38_0._tf
		local var_38_10 = var_2.GetComponent

		typeof = var_4
		DftAniEvent = var_5

		local var_38_11 = var_38_10(var_38_9, var_4(var_5))

		var_2.SetTriggerEvent(var_38_11, function()
			arg_38_0.isLeave = true

			return
		end)

		return
	end

	function var_36_0.Result(arg_41_0, arg_41_1, arg_41_2)
		arg_41_0.result = arg_41_1

		local var_41_0 = #arg_41_2[1] < 3 and "Cone" or "Bowl"

		if arg_41_1 == 0 then
			local var_41_1 = arg_41_0.animator

			var_4.Play(var_41_1, "Bad")
		elseif arg_41_1 == 1 then
			local var_41_2 = var_36_1
			local var_41_3 = arg_41_0._tf

			var_41_2(var_5.Find(var_41_3, "IceCream/" .. var_41_0), arg_41_2)

			local var_41_4 = arg_41_0.animator

			var_4.Play(var_41_4, "Hmm")
		else
			local var_41_5

			if 2 <= arg_41_1 then
				var_41_5 = var_36_1

				local var_41_6 = arg_41_0._tf

				var_41_5(var_5.Find(var_41_6, "IceCream/" .. var_41_0), arg_41_2)

				local var_41_7 = arg_41_0.animator

				var_41_5.Play(var_41_7, "Great")
			else
				assert = var_41_5

				var_41_5(false)
			end
		end

		return
	end

	var_36_0:Ctor()

	return var_36_0
end

function var_0_1.CreateTarget(arg_42_0, arg_42_1)
	table = var_1_10002

	local var_42_0 = var_1_10002.remove
	local var_42_1 = arg_42_0.targetNameList

	math = var_1_10004

	local var_42_2 = var_42_0(var_42_1, var_1_10004.random(#arg_42_0.targetNameList))

	cloneTplTo = var_42_1

	local var_42_3 = arg_42_0.rtResource
	local var_42_4 = var_42_1(var_4.Find(var_42_3, "Character/" .. var_42_2), arg_42_0.rtWalk, var_42_2)

	setAnchoredPosition = var_4

	var_4(var_42_4, {
		x = arg_42_1 or -var_0_8[1]
	})

	local var_42_5 = {
		{},
		{}
	}
	local var_42_6

	if var_42_2 ~= "Agir" or not {
		1,
		2
	} then
		var_42_6 = {
			1,
			2,
			3
		}
	end

	if #arg_42_0.targetList > 0 then
		table = var_6

		var_6.removebyvalue(var_42_6, #arg_42_0.targetList[#arg_42_0.targetList]._info[1])
	end

	math = var_6

	for iter_42_0 = var_42_6[var_6.random(#var_42_6)], 1, -1 do
		table = var_1_10010
		var_1_10010 = var_1_10010.insert
		var_1_10011 = var_42_5[1]
		math = var_1_10012

		var_1_10010(var_1_10011, var_1_10012.random(4))
	end

	local var_42_7 = {
		1,
		2,
		3,
		4
	}

	math = var_7

	for iter_42_1 = var_7.max(1, #var_42_5[1] - 1), 1, -1 do
		table = var_1_10011
		var_1_10011 = var_1_10011.insert

		local var_42_8 = var_42_5[2]

		table = var_1_10013
		var_1_10013 = var_1_10013.remove

		local var_42_9 = var_42_7

		math = var_1_10015

		var_1_10011(var_42_8, var_1_10013(var_42_9, var_1_10015.random(#var_42_7)))
	end

	math = var_7

	local var_42_10 = var_7.clamp
	local var_42_11 = var_0_6[#var_42_5[1]][2] - arg_42_0.countList[#var_42_5[1]]

	unpack = var_9

	local var_42_12 = var_42_10(var_42_11, var_9(var_0_6[#var_42_5[1]]))
	local var_42_13 = arg_42_0.countList

	var_42_13[#var_42_5[1]] = arg_42_0.countList[#var_42_5[1]] + 1
	table = var_42_13

	var_42_13.insert(arg_42_0.targetList, var_0_19(var_42_4, arg_42_0, var_42_5, var_42_12))

	return
end

function var_0_1.RemoveTarget(arg_43_0)
	assert = var_1_10001

	var_1_10001(#arg_43_0.targetList > 0)

	table = var_1_10001

	local var_43_0 = var_1_10001.remove(arg_43_0.targetList, 1)

	arg_43_0.targetIndex = arg_43_0.targetIndex - 1
	table = var_2

	var_2.insert(arg_43_0.targetNameList, var_43_0._tf.name)

	Destroy = var_2

	var_2(var_43_0._tf)

	return
end

function var_0_1.ResultTarget(arg_44_0, arg_44_1, arg_44_2, ...)
	assert = var_1_10003

	var_1_10003(#arg_44_0.targetList > 0)

	math = var_1_10003
	arg_44_1 = var_1_10003.ceil(arg_44_1 * arg_44_0.targetList[arg_44_0.targetIndex].pointBoost / 100)

	arg_44_0:addScore(arg_44_1, arg_44_2)

	local var_44_0 = arg_44_0.targetList[arg_44_0.targetIndex]

	var_3.Result(var_44_0, arg_44_2, ...)
	arg_44_0:TriggerSpecialEffect(arg_44_2, ...)

	arg_44_0.targetIndex = arg_44_0.targetIndex + 1
	arg_44_0.iceBuild = nil
	onNextTick = var_3

	var_3(function()
		setActive = var_2_10000

		var_2_10000(arg_44_0.rtMake, false)

		setActive = var_2_10000

		var_2_10000(arg_44_0.rtTime, false)

		return
	end)

	if arg_44_0.effectTrigger.bullet_time.doingTime > 0 then
		var_3.doingTime = 0

		arg_44_0:setAnimatorSpeed(arg_44_0._tf, 1)

		setActive = var_4

		local var_44_1 = arg_44_0.gameUI

		var_4(var_5.Find(var_44_1, "BulletTimeMask"), false)
	end

	return
end

function var_0_1.TriggerSpecialEffect(arg_46_0, arg_46_1, arg_46_2)
	if arg_46_1 == 3 then
		local var_46_0 = arg_46_0.targetList[arg_46_0.targetIndex + 1]
		local var_46_1 = arg_46_0.effectTrigger.bullet_time

		if #arg_46_0.targetList[arg_46_0.targetIndex]._info[1] == 3 and var_46_1.waitTime <= 0 then
			math = var_5

			if var_5.random() < var_0_12.bullet_time[3] then
				var_46_0.timeBoost = true
			end
		end

		var_5.count = arg_46_0.effectTrigger.wait_time_boost.count + 1

		if var_5.count == 2 then
			var_5.count = 0
			var_46_0.time = var_46_0.time + var_0_12.wait_time_boost
			var_46_0.isWaitTimeBoost = true
		end

		if arg_46_0.effectTrigger.point_boost[arg_46_0.targetList[arg_46_0.targetIndex]._tf.name] == "finish" then
			-- block empty
		elseif var_6[var_7] == "count" then
			var_46_0.pointBoost = var_46_0.pointBoost + var_0_12.point_boost
			setActive = var_8

			local var_46_2 = var_46_0._tf

			var_8(var_9.Find(var_46_2, "Bubble/Boost"), true)

			var_6[var_7] = "finish"
		else
			var_6[var_7] = "count"
		end
	elseif arg_46_0.effectTrigger.point_boost[arg_46_0.targetList[arg_46_0.targetIndex]._tf.name] == "finish" then
		-- block empty
	else
		var_3[var_4] = nil
	end

	return
end

local function var_0_20(arg_47_0, arg_47_1, arg_47_2, arg_47_3, arg_47_4)
	local var_47_0 = {
		Ctor = function(arg_48_0)
			arg_48_0._tf = arg_47_0
			arg_48_0._event = arg_47_1
			arg_48_0._info = {
				{},
				{}
			}
			arg_48_0.isLeftLock = false
			arg_48_0.isRightLock = false
			arg_48_0.missToppingMark = {}
			arg_48_0.waitTime = arg_47_3
			arg_48_0.isWaitTimeBoost = arg_47_4

			arg_48_0:Reset()
			arg_48_0:NextDeal()

			return
		end,
		NextDeal = function(arg_49_0)
			if arg_49_0.isLeftLock or arg_49_0.isRightLock then
				return
			end

			if #arg_49_0._info[1] < #arg_47_2[1] then
				arg_49_0:ReadyBall()
			elseif #arg_49_0._info[2] < #arg_47_2[2] then
				arg_49_0:ReadyTopping()
			else
				arg_49_0:Result()
			end

			return
		end,
		Result = function(arg_50_0, arg_50_1)
			arg_50_0.isResulted = true

			var_0_18(false)

			local var_50_0 = 0
			local var_50_1 = {
				{
					0,
					0,
					0,
					0
				},
				{
					0,
					0,
					0,
					0
				}
			}

			local function var_50_2(arg_51_0, arg_51_1, arg_51_2)
				local var_51_0 = arg_51_0[arg_51_1]

				arg_51_0[arg_51_1] = arg_51_0[arg_51_1] + arg_51_2
				math = var_4

				local var_51_1 = var_4.abs(arg_51_0[arg_51_1])

				math = var_5

				return var_51_1 - var_5.abs(var_51_0)
			end

			ipairs = var_2_10005

			for iter_50_0, iter_50_1 in var_2_10005(arg_50_0._info) do
				ipairs = var_2_10010

				for iter_50_2, iter_50_3 in var_2_10010(iter_50_1) do
					if var_50_2(var_50_1[iter_50_0], arg_47_2[iter_50_0][iter_50_2], -1) < 0 then
						var_50_0 = var_50_0 + var_0_10[iter_50_0]
					end

					if var_50_2(var_50_1[iter_50_0], iter_50_3, 1) < 0 then
						var_50_0 = var_50_0 + var_0_10[iter_50_0]
					end

					if arg_47_2[iter_50_0][iter_50_2] == iter_50_3 and (iter_50_0 == 1 or not arg_50_0.missToppingMark[iter_50_2]) then
						var_50_0 = var_50_0 + var_0_10[3]
					end
				end
			end

			if arg_50_1 then
				arg_50_0.result = arg_50_1
			elseif var_50_0 == #arg_50_0._info[1] * var_0_10[1] + #arg_50_0._info[2] * var_0_10[2] + (#arg_50_0._info[1] + #arg_50_0._info[2]) * var_0_10[3] then
				arg_50_0.result = 3
			else
				table = var_6

				if var_6.equal(arg_50_0._info, arg_47_2) then
					arg_50_0.result = 2
				elseif var_50_0 >= var_5 / 2 then
					arg_50_0.result = 1
				else
					arg_50_0.result = 0
				end
			end

			local var_50_3 = arg_50_0._tf
			local var_50_4 = var_5.GetComponent

			typeof = var_7
			Animator = iter_50_0

			local var_50_5 = var_50_4(var_50_3, var_7(iter_50_0))

			if arg_50_0.result == 3 then
				arg_50_0.point = var_50_0 * (1 + var_0_11 / 100 + arg_50_0.waitTime / arg_47_3)

				var_50_5:Play("Perfect")

				pg = var_6

				local var_50_6 = var_6.CriMgr.GetInstance()

				var_6.PlaySoundEffect_V3(var_50_6, "ui-icecream_great")
			elseif arg_50_0.result == 2 then
				arg_50_0.point = var_50_0 * (1 + arg_50_0.waitTime / arg_47_3)

				var_50_5:Play("Pass")
			elseif arg_50_0.result == 1 then
				arg_50_0.point = var_50_0 * (1 + arg_50_0.waitTime / arg_47_3)

				var_50_5:Play("Pass")
			elseif arg_50_0.result == 0 then
				arg_50_0.point = 0

				var_50_5:Play("Fail")

				pg = var_6

				local var_50_7 = var_6.CriMgr.GetInstance()

				var_6.PlaySoundEffect_V3(var_50_7, "ui-icecream_fail")
			else
				assert = var_6

				var_6(false)
			end

			return
		end,
		CountDown = function(arg_52_0, arg_52_1, arg_52_2)
			if arg_52_0.isResulted then
				return
			end

			if arg_52_0.waitTime > 0 then
				arg_52_0.waitTime = arg_52_0.waitTime - arg_52_1

				local var_52_0 = arg_52_0._event

				var_3.emit(var_52_0, var_0_3, arg_52_2, 0, arg_47_3, arg_52_0.waitTime)
			else
				arg_52_0.waitTime = 0

				arg_52_0:Result(0)
			end

			if not arg_52_0.missTime then
				return
			end

			if arg_52_0.missTime > 0 then
				arg_52_0.missTime = arg_52_0.missTime - var_0_4
			else
				arg_52_0.missTime = nil

				arg_52_0:FailMissTopping()
			end

			return
		end,
		Reset = function(arg_53_0)
			local var_53_0 = arg_53_0._tf
			local var_53_1 = var_1.GetComponent(var_53_0, "DftAniEvent")

			var_1.SetEndEvent(var_53_1, function()
				onNextTick = var_3_10000

				var_3_10000(function()
					setActive = var_4_10000

					var_4_10000(arg_53_0._tf, false)

					return
				end)

				local var_54_0 = arg_53_0._event

				var_0.emit(var_54_0, var_0_2, arg_53_0.point, arg_53_0.result, arg_53_0._info)

				return
			end)

			local var_53_2 = arg_53_0._tf
			local var_53_3 = var_1.GetComponent(var_53_2, "DftAniEvent")

			var_1.SetTriggerEvent(var_53_3, function()
				for iter_56_0 = arg_53_0._tf.name == "Cone" and 2 or 3, 1, -1 do
					setActive = var_3_10004

					local var_56_0 = arg_53_0._tf

					var_3_10004(var_5.Find(var_56_0, iter_56_0), false)
				end

				setActive = var_0

				local var_56_1 = arg_53_0._tf

				var_0(var_1.Find(var_56_1, "Back"), false)

				if arg_53_0._tf.name == "Bowl" then
					setActive = var_0

					local var_56_2 = arg_53_0._tf

					var_0(var_1.Find(var_56_2, "Front"), false)
				end

				return
			end)

			setActive = var_1

			local var_53_4 = arg_53_0._tf

			var_1(var_2.Find(var_53_4, "Back"), true)

			if arg_53_0._tf.name == "Bowl" then
				setActive = var_1

				local var_53_5 = arg_53_0._tf

				var_1(var_2.Find(var_53_5, "Front"), true)
			end

			for iter_53_0 = arg_53_0._tf.name == "Cone" and 2 or 3, 1, -1 do
				local var_53_6 = arg_53_0._tf
				local var_53_7 = var_5.Find(var_53_6, iter_53_0)

				setActive = var_53_6

				var_53_6(var_53_7, iter_53_0 <= #arg_47_2[1])

				if iter_53_0 <= #arg_47_2[1] then
					eachChild = var_6

					var_6(var_53_7, function(arg_57_0)
						setActive = var_3_10001

						var_3_10001(arg_57_0, false)

						return
					end)

					local var_53_8 = var_53_7:Find("Scoop")
					local var_53_9 = var_6.GetComponent(var_53_8, "DftAniEvent")

					var_6.SetEndEvent(var_53_9, function()
						arg_53_0.isLeftLock = false

						if arg_53_0.successLeftLight then
							local var_58_0 = arg_53_0

							var_58_0.successLeftLight = false
							setAnchoredPosition = var_58_0

							local var_58_1 = var_53_7

							var_58_0(var_1.Find(var_58_1, "Good"), {
								x = 0,
								y = -10
							})

							setActive = var_58_0

							local var_58_2 = var_53_7

							var_58_0(var_1.Find(var_58_2, "Good"), false)

							setActive = var_58_0

							local var_58_3 = var_53_7

							var_58_0(var_1.Find(var_58_3, "Good"), true)
						end

						local var_58_4 = arg_53_0

						var_0.NextDeal(var_58_4)

						return
					end)

					local var_53_10 = var_53_7:Find("Topping")
					local var_53_11 = var_6.GetComponent(var_53_10, "DftAniEvent")

					var_6.SetEndEvent(var_53_11, function()
						arg_53_0.isRightLock = false

						if arg_53_0.successRightLight then
							local var_59_0 = arg_53_0

							var_59_0.successRightLight = false
							setAnchoredPosition = var_59_0

							local var_59_1 = var_53_7

							var_59_0(var_1.Find(var_59_1, "Good"), {
								x = 10,
								y = 6
							})

							setActive = var_59_0

							local var_59_2 = var_53_7

							var_59_0(var_1.Find(var_59_2, "Good"), false)

							setActive = var_59_0

							local var_59_3 = var_53_7

							var_59_0(var_1.Find(var_59_3, "Good"), true)
						end

						local var_59_4 = arg_53_0

						var_0.NextDeal(var_59_4)

						return
					end)
				end
			end

			return
		end,
		ReadyBall = function(arg_60_0)
			local var_60_0 = arg_60_0._tf
			local var_60_1 = var_1.Find(var_60_0, #arg_60_0._info[1] + 1)

			setActive = var_60_0

			var_60_0(var_60_1:Find("Scoop_Next"), true)

			return
		end,
		MakeBall = function(arg_61_0, arg_61_1)
			arg_61_0.isLeftLock = true

			local var_61_0 = arg_61_0._tf
			local var_61_1 = var_2.Find(var_61_0, #arg_61_0._info[1] + 1)

			setActive = var_61_0

			var_61_0(var_61_1:Find("Scoop_Next"), false)

			setActive = var_61_0

			var_61_0(var_61_1:Find("Scoop"), true)

			local var_61_2 = var_61_1:Find("Scoop")
			local var_61_3 = var_3.GetComponent

			typeof = var_5
			Animator = var_6

			local var_61_4 = var_61_3(var_61_2, var_5(var_6))

			var_3.Play(var_61_4, "Scoop_" .. var_0_15[arg_61_1])

			table = var_4

			var_4.insert(arg_61_0._info[1], arg_61_1)

			arg_61_0.successLeftLight = arg_61_0._info[1][#arg_61_0._info[1]] == arg_47_2[1][#arg_61_0._info[1]]

			if arg_61_0.temporaryKey and var_0_14[#arg_47_2[1]][#arg_61_0._info[2] + 1] == #arg_61_0._info[1] then
				arg_61_0:SafeMissTopping()
			end

			pg = var_4

			local var_61_5 = var_4.CriMgr.GetInstance()

			var_4.PlaySoundEffect_V3(var_61_5, "ui-icecream_flavour")

			return
		end,
		ReadyTopping = function(arg_62_0)
			local var_62_0 = arg_62_0._tf
			local var_62_1 = var_1.Find(var_62_0, var_0_14[#arg_47_2[1]][#arg_62_0._info[2] + 1])

			setActive = var_62_0

			var_62_0(var_62_1:Find("Topping_Next"), true)

			return
		end,
		MakeTopping = function(arg_63_0, arg_63_1)
			arg_63_0.isRightLock = true

			local var_63_0 = arg_63_0._tf
			local var_63_1 = var_2.Find(var_63_0, var_0_14[#arg_47_2[1]][#arg_63_0._info[2] + 1])

			setActive = var_63_0

			var_63_0(var_63_1:Find("Topping_Next"), false)

			setActive = var_63_0

			var_63_0(var_63_1:Find("Topping"), true)

			local var_63_2 = var_63_1:Find("Topping")
			local var_63_3 = var_3.GetComponent

			typeof = var_5
			Animator = var_6

			local var_63_4 = var_63_3(var_63_2, var_5(var_6))

			var_3.Play(var_63_4, "Topping_" .. var_0_16[arg_63_1])

			table = var_4

			var_4.insert(arg_63_0._info[2], arg_63_1)

			arg_63_0.successRightLight = arg_63_0._info[2][#arg_63_0._info[2]] == arg_47_2[2][#arg_63_0._info[2]]
			pg = var_4

			local var_63_5 = var_4.CriMgr.GetInstance()

			var_4.PlaySoundEffect_V3(var_63_5, "ui-icecream_mixer")

			return
		end,
		MakeMissTopping = function(arg_64_0, arg_64_1)
			arg_64_0.isRightLock = true
			arg_64_0.temporaryKey = arg_64_1
			arg_64_0.missTime = var_0_5 * (var_0_14[#arg_47_2[1]][#arg_64_0._info[2] + 1] - #arg_64_0._info[1])

			var_0_18(true)

			local var_64_0 = arg_64_0._tf
			local var_64_1 = var_2.Find(var_64_0, var_0_14[#arg_47_2[1]][#arg_64_0._info[2] + 1])

			setActive = var_64_0

			var_64_0(var_64_1:Find("Topping_Next"), false)

			setActive = var_64_0

			var_64_0(var_64_1:Find("Topping"), true)

			local var_64_2 = var_64_1:Find("Topping")
			local var_64_3 = var_3.GetComponent

			typeof = var_5
			Animator = var_6

			local var_64_4 = var_64_3(var_64_2, var_5(var_6))

			var_3.Play(var_64_4, "Topping_pre_" .. var_0_16[arg_64_1])

			return
		end,
		FailMissTopping = function(arg_65_0)
			arg_65_0.isRightLock = true

			local var_65_0 = arg_65_0.temporaryKey

			arg_65_0.temporaryKey = nil
			arg_65_0.missTime = nil

			var_0_18(false)

			local var_65_1 = arg_65_0._tf
			local var_65_2 = var_2.Find(var_65_1, var_0_14[#arg_47_2[1]][#arg_65_0._info[2] + 1])

			setActive = var_65_1

			var_65_1(var_65_2:Find("Topping_Next"), false)

			setActive = var_65_1

			var_65_1(var_65_2:Find("Topping"), true)

			local var_65_3 = var_65_2:Find("Topping")
			local var_65_4 = var_3.GetComponent

			typeof = var_5
			Animator = var_6

			local var_65_5 = var_65_4(var_65_3, var_5(var_6))

			var_3.Play(var_65_5, "Topping_Err_" .. var_0_16[var_65_0])

			return
		end,
		SafeMissTopping = function(arg_66_0)
			arg_66_0.isRightLock = true

			local var_66_0 = arg_66_0.temporaryKey

			arg_66_0.temporaryKey = nil
			arg_66_0.missTime = nil

			var_0_18(false)

			local var_66_1 = arg_66_0._tf
			local var_66_2 = var_2.Find(var_66_1, var_0_14[#arg_47_2[1]][#arg_66_0._info[2] + 1])

			setActive = var_66_1

			var_66_1(var_66_2:Find("Topping_Next"), false)

			setActive = var_66_1

			var_66_1(var_66_2:Find("Topping"), true)

			local var_66_3 = var_66_2:Find("Topping")
			local var_66_4 = var_3.GetComponent

			typeof = var_5
			Animator = var_6

			local var_66_5 = var_66_4(var_66_3, var_5(var_6))

			var_3.Play(var_66_5, "Topping_safe_" .. var_0_16[var_66_0])

			table = var_4

			var_4.insert(arg_66_0._info[2], var_66_0)

			arg_66_0.successRightLight = arg_66_0._info[2][#arg_66_0._info[2]] == arg_47_2[2][#arg_66_0._info[2]]

			local var_66_6 = arg_66_0.missToppingMark

			var_66_6[#arg_66_0._info[2]] = true
			pg = var_66_6

			local var_66_7 = var_66_6.CriMgr.GetInstance()

			var_4.PlaySoundEffect_V3(var_66_7, "ui-icecream_mixer")

			return
		end
	}

	var_5.Ctor(var_47_0)

	return var_5
end

function var_0_1.DoIceCream(arg_67_0)
	setActive = var_1_10001

	var_1_10001(arg_67_0.rtTime, true)

	setActive = var_1_10001

	var_1_10001(arg_67_0.rtMake, true)

	local var_67_0 = #arg_67_0.targetList[arg_67_0.targetIndex]._info[1] < 3 and "Cone" or "Bowl"

	eachChild = var_3

	var_3(arg_67_0.rtMake, function(arg_68_0)
		setActive = var_2_10001

		var_2_10001(arg_68_0, arg_68_0.name == var_67_0)

		return
	end)

	local var_67_1 = arg_67_0.rtMake
	local var_67_2 = var_3.Find(var_67_1, var_67_0)

	for iter_67_0 = var_67_0 == "Cone" and 2 or 3, 1, -1 do
		setActive = var_1_10008

		var_1_10008(var_67_2:Find(iter_67_0), false)
	end

	arg_67_0.iceBuild = var_0_20(var_67_2, arg_67_0, var_1._info, var_1.time, var_1.isWaitTimeBoost)

	if var_1.timeBoost then
		local var_67_3 = arg_67_0.effectTrigger.bullet_time

		var_67_3.doingTime = var_0_12.bullet_time[2]
		var_67_3.waitTime = var_0_12.bullet_time[4]

		arg_67_0:setAnimatorSpeed(arg_67_0._tf, 0.5)
		arg_67_0:setAnimatorSpeed(arg_67_0.rtMake, 1)

		setActive = var_5

		local var_67_4 = arg_67_0.gameUI

		var_5(var_6.Find(var_67_4, "BulletTimeMask"), true)
	end

	return
end

function var_0_1.startGame(arg_69_0)
	setActive = var_1_10001

	var_1_10001(arg_69_0.gameUI, true)

	arg_69_0.gameStartFlag = true

	arg_69_0:CreateTarget(-var_0_8[1] / 3)

	arg_69_0.targetIndex = 1

	arg_69_0:RandomBG()
	arg_69_0:timerStart()

	return
end

function var_0_1.RandomBG(arg_70_0)
	local var_70_0

	if not arg_70_0.poolBG then
		var_70_0 = {
			GroupD = {
				1
			}
		}
	end

	arg_70_0.poolBG = var_70_0

	if not arg_70_0.poolBG.GroupAB or #arg_70_0.poolBG.GroupAB == 0 then
		arg_70_0.poolBG.GroupAB = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if not arg_70_0.poolBG["GroupC/Other"] or #arg_70_0.poolBG["GroupC/Other"] == 0 then
		arg_70_0.poolBG["GroupC/Other"] = {
			1,
			2,
			3,
			4
		}
	end

	local var_70_1 = arg_70_0.poolBG

	var_70_1["GroupC/Manjuu"] = {
		1,
		2,
		3
	}
	pairs = var_70_1

	for iter_70_0, iter_70_1 in var_70_1(arg_70_0.poolBG) do
		local var_70_2 = {}

		for iter_70_2 = iter_70_0 == "GroupC/Manjuu" and 2 or 1, 1, -1 do
			if iter_70_0 == "GroupD" then
				var_70_2[iter_70_1[1]] = true
				iter_70_1[1] = 3 - iter_70_1[1]
			else
				table = iter_70_3
				iter_70_3 = iter_70_3.remove
				var_1_10012 = iter_70_1
				math = var_1_10013
				var_70_2[iter_70_3(var_1_10012, var_1_10013.random(#iter_70_1))] = true
			end
		end

		local var_70_3 = arg_70_0.gameUI

		for iter_70_3 = var_7.Find(var_70_3, "BG/" .. iter_70_0).childCount, 1, -1 do
			setActive = var_1_10012

			var_1_10012(var_7:GetChild(iter_70_3 - 1), var_70_2[iter_70_3])
		end
	end

	return
end

function var_0_1.getIntervalTime(arg_71_0)
	if arg_71_0.effectTrigger.bullet_time.doingTime > 0 then
		return var_0_4 * var_0_12.bullet_time[1]
	else
		return var_0_4
	end

	return
end

function var_0_1.onTimer(arg_72_0)
	if arg_72_0.effectTrigger.bullet_time.doingTime > 0 then
		var_1.doingTime = var_1.doingTime - var_0_4

		if var_1.doingTime <= 0 then
			arg_72_0:setAnimatorSpeed(arg_72_0._tf, 1)

			setActive = var_2

			local var_72_0 = arg_72_0.gameUI

			var_2(var_3.Find(var_72_0, "BulletTimeMask"), false)
		end
	elseif var_1.waitTime > 0 then
		var_1.waitTime = var_1.waitTime - var_0_4
	end

	local var_72_1 = arg_72_0.lastTime
	local var_72_2 = arg_72_0

	arg_72_0.lastTime = var_72_1 - arg_72_0.getIntervalTime(var_72_2)

	arg_72_0:updateWalker()

	if arg_72_0.lastTime <= 0 then
		arg_72_0:endGame()
	else
		setText = var_2

		local var_72_3 = arg_72_0.timeTF

		math = var_72_2

		var_2(var_72_3, var_72_2.floor(arg_72_0.lastTime))

		if not arg_72_0.iceBuild and arg_72_0.targetList[arg_72_0.targetIndex]._tf.anchoredPosition.x > 0 then
			arg_72_0:DoIceCream()
		end

		if #arg_72_0.targetList == arg_72_0.targetIndex then
			arg_72_0:CreateTarget()
		end
	end

	if arg_72_0.iceBuild then
		local var_72_4
		local var_72_5 = var_1.doingTime > 0 and "frozen" or arg_72_0.iceBuild.isWaitTimeBoost and "extend" or "base"
		local var_72_6 = arg_72_0.iceBuild

		var_3.CountDown(var_72_6, arg_72_0:getIntervalTime(), var_72_5)
	end

	return
end

function var_0_1.updateWalker(arg_73_0)
	for iter_73_0 = #arg_73_0.targetList, 1, -1 do
		local var_73_0 = arg_73_0.targetList[iter_73_0]._tf
		local var_73_1 = var_6.GetComponent

		typeof = var_1_10008
		Animator = var_1_10009
		var_1_10008 = var_73_1(var_73_0, var_1_10008(var_1_10009))

		local var_73_2 = var_6.GetCurrentAnimatorStateInfo(var_1_10008, 0)

		if var_5.result then
			if var_5.isLeave then
				setAnchoredPosition = var_1_10008

				var_1_10008(var_5._tf, {
					x = var_5._tf.anchoredPosition.x + arg_73_0:getIntervalTime() * var_0_9[1]
				})

				var_1_10008 = var_5._tf.anchoredPosition.x

				if var_0_8[1] < var_1_10008 then
					var_1_10009 = arg_73_0

					arg_73_0.RemoveTarget(var_1_10009)
				end
			end
		else
			var_1_10008 = var_0_8[3]

			if 1 < iter_73_0 then
				math = var_1_10009
				var_1_10008 = var_1_10009.min(var_1_10008, arg_73_0.targetList[iter_73_0 - 1]._tf.anchoredPosition.x)
			end

			if var_1_10008 - var_5._tf.anchoredPosition.x < var_0_8[3] then
				if not var_5.state or var_5.state ~= "Stand" then
					var_5.state = "Stand"

					var_6:Play("Stand")
				end
			elseif var_1_10008 < var_0_8[2] then
				setAnchoredPosition = var_1_10009

				var_1_10009(var_5._tf, {
					x = var_5._tf.anchoredPosition.x + arg_73_0:getIntervalTime() * var_0_9[2]
				})

				if not var_5.state or var_5.state ~= "Walk" then
					var_5.state = "Walk"

					var_6:Play("Walk")
				end
			else
				setAnchoredPosition = var_1_10009

				var_1_10009(var_5._tf, {
					x = var_5._tf.anchoredPosition.x + arg_73_0:getIntervalTime() * var_0_9[1]
				})

				if not var_5.state or var_5.state ~= "Run" then
					var_5.state = "Run"

					var_6:Play("Run")
				end
			end
		end
	end

	return
end

function var_0_1.setAnimatorSpeed(arg_74_0, arg_74_1, arg_74_2)
	local var_74_0 = arg_74_1
	local var_74_1 = arg_74_1.GetComponentsInChildren

	typeof = var_1_10005
	Animator = var_1_10006

	local var_74_2 = var_74_1(var_74_0, var_1_10005(var_1_10006), true)
	local var_74_3 = var_3.ToTable(var_74_2)

	ipairs = var_74_2

	for iter_74_0, iter_74_1 in var_74_2(var_74_3) do
		iter_74_1.speed = arg_74_2
	end

	return
end

function var_0_1.timerStart(arg_75_0)
	if not arg_75_0.timer.running then
		local var_75_0 = arg_75_0.timer

		var_1.Start(var_75_0)
	end

	if arg_75_0.effectTrigger.bullet_time.doingTime > 0 then
		arg_75_0:setAnimatorSpeed(arg_75_0._tf, 0.5)
		arg_75_0:setAnimatorSpeed(arg_75_0.rtMake, 1)
	else
		arg_75_0:setAnimatorSpeed(arg_75_0._tf, 1)
	end

	if arg_75_0.iceBuild and arg_75_0.iceBuild.missTime then
		var_0_18(true)
	end

	return
end

function var_0_1.timerStop(arg_76_0)
	if arg_76_0.timer.running then
		local var_76_0 = arg_76_0.timer

		var_1.Stop(var_76_0)
	end

	arg_76_0:setAnimatorSpeed(arg_76_0._tf, 0)

	if arg_76_0.iceBuild and arg_76_0.iceBuild.missTime then
		var_0_18(false)
	end

	return
end

function var_0_1.addScore(arg_77_0, arg_77_1, arg_77_2)
	arg_77_0.scoreNum = arg_77_0.scoreNum + arg_77_1
	setText = var_3

	var_3(arg_77_0.scoreTF, arg_77_0.scoreNum)

	setActive = var_3

	var_3(arg_77_0.addScoreTF, false)

	setActive = var_3

	var_3(arg_77_0.addScoreTF, true)

	local var_77_0 = arg_77_0.addScoreTF
	local var_77_1 = var_3.Find(var_77_0, "score_tf")

	setText = var_77_0

	var_77_0(var_77_1, "+" .. arg_77_1)

	if arg_77_2 == 0 then
		setTextColor = var_77_0

		local var_77_2 = var_77_1

		Color = var_6

		var_77_0(var_77_2, var_6.NewHex("ED666DFF"))
	elseif arg_77_2 == 1 then
		setTextColor = var_77_0

		local var_77_3 = var_77_1

		Color = var_6

		var_77_0(var_77_3, var_6.NewHex("FAB149FF"))
	elseif arg_77_2 == 2 then
		setTextColor = var_77_0

		local var_77_4 = var_77_1

		Color = var_6

		var_77_0(var_77_4, var_6.NewHex("C6CC15FF"))
	elseif arg_77_2 == 3 then
		setTextColor = var_77_0

		local var_77_5 = var_77_1

		Color = var_6

		var_77_0(var_77_5, var_6.NewHex("80BF1CFF"))
	else
		assert = var_77_0

		var_77_0(false)
	end

	return
end

function var_0_1.pauseGame(arg_78_0)
	arg_78_0.gamePause = true

	arg_78_0:timerStop()
	arg_78_0:pauseManagedTween()

	return
end

function var_0_1.resumeGame(arg_79_0)
	arg_79_0.gamePause = false

	arg_79_0:timerStart()
	arg_79_0:resumeManagedTween()

	return
end

function var_0_1.endGame(arg_80_0)
	if arg_80_0.gameEndFlag then
		return
	end

	arg_80_0:timerStop()

	arg_80_0.gameEndFlag = true
	setActive = var_1

	var_1(arg_80_0.clickMask, true)

	local var_80_0 = arg_80_0
	local var_80_1 = arg_80_0.managedTween

	LeanTween = var_3

	var_80_1(var_80_0, var_3.delayedCall, function()
		arg_80_0.gameEndFlag = false

		local var_81_0 = arg_80_0

		var_81_0.gameStartFlag = false
		setActive = var_81_0

		var_81_0(arg_80_0.clickMask, false)

		local var_81_1 = arg_80_0

		var_0.showEndUI(var_81_1)

		return
	end, 0.1, nil)

	return
end

function var_0_1.showEndUI(arg_82_0)
	pg = var_1_10001

	local var_82_0 = var_1_10001.UIMgr.GetInstance()

	var_1.OverlayPanel(var_82_0, arg_82_0.endUI)

	setActive = var_1

	var_1(arg_82_0.endUI, true)

	local var_82_1 = arg_82_0:GetMGData()
	local var_82_2 = var_1.GetRuntimeData(var_82_1, "elements")
	local var_82_3 = arg_82_0.scoreNum

	if var_82_2 then
		local var_82_4 = #var_82_2
		local var_82_5

		if not (0 < var_82_4) or not var_82_2[1] then
			var_82_5 = 0
		end

		setActive = var_1_10004

		local var_82_6 = arg_82_0.endUI

		var_1_10004(var_5.Find(var_82_6, "panel/now/Text/new"), var_82_5 < var_82_3)

		if var_82_5 <= var_82_3 then
			var_82_5 = var_82_3

			arg_82_0:StoreDataToServer({
				var_82_5
			})
		end

		local var_82_7 = arg_82_0.endUI
		local var_82_8 = var_4.Find(var_82_7, "panel/max/Text")
		local var_82_9 = arg_82_0.endUI
		local var_82_10 = var_5.Find(var_82_9, "panel/now/Text")

		setText = var_82_9

		var_82_9(var_82_8, var_82_5)

		setText = var_82_9

		var_82_9(var_82_10, var_82_3)

		if arg_82_0:getGameTimes() and arg_82_0:getGameTimes() > 0 then
			arg_82_0:SendSuccess(0)
		end

		return
	end
end

function var_0_1.getGameTimes(arg_83_0)
	return arg_83_0:GetMGHubData().count
end

function var_0_1.getGameUsedTimes(arg_84_0)
	return arg_84_0:GetMGHubData().usedtime
end

function var_0_1.getUltimate(arg_85_0)
	return arg_85_0:GetMGHubData().ultimate
end

function var_0_1.getGameTotalTime(arg_86_0)
	local var_86_0 = arg_86_0:GetMGHubData()

	return (var_1.getConfig(var_86_0, "reward_need"))
end

function var_0_1.OnApplicationPaused(arg_87_0, arg_87_1)
	if arg_87_1 and not arg_87_0.gameEndFlag and arg_87_0.gameStartFlag and not arg_87_0.gamePause then
		arg_87_0:pauseGame()

		pg = var_2

		local var_87_0 = var_2.UIMgr.GetInstance()

		var_2.OverlayPanel(var_87_0, arg_87_0.pauseUI)

		setActive = var_2

		var_2(arg_87_0.pauseUI, true)
	end

	return
end

function var_0_1.onBackPressed(arg_88_0)
	if arg_88_0.gameEndFlag then
		return
	end

	isActive = var_1

	local var_88_1

	if var_1(arg_88_0.pauseUI) then
		pg = var_88_1

		local var_88_0 = var_88_1.UIMgr.GetInstance()

		var_88_1 = var_88_1.UnOverlayPanel

		local var_88_2 = arg_88_0.pauseUI
		local var_88_3 = arg_88_0._tf

		var_88_1(var_88_0, var_88_2, var_4.Find(var_88_3, "ui"))

		setActive = var_88_1

		var_88_1(arg_88_0.pauseUI, false)
		arg_88_0:resumeGame()

		return
	end

	isActive = var_88_1

	local var_88_5

	if var_88_1(arg_88_0.returnUI) then
		pg = var_88_5

		local var_88_4 = var_88_5.UIMgr.GetInstance()

		var_88_5 = var_88_5.UnOverlayPanel

		local var_88_6 = arg_88_0.returnUI
		local var_88_7 = arg_88_0._tf

		var_88_5(var_88_4, var_88_6, var_4.Find(var_88_7, "ui"))

		setActive = var_88_5

		var_88_5(arg_88_0.returnUI, false)
		arg_88_0:resumeGame()

		return
	end

	isActive = var_88_5

	if var_88_5(arg_88_0.endUI) then
		return
	end

	if arg_88_0.gameStartFlag then
		arg_88_0:pauseGame()

		pg = var_1

		local var_88_8 = var_1.UIMgr.GetInstance()

		var_1.OverlayPanel(var_88_8, arg_88_0.pauseUI)

		setActive = var_1

		var_1(arg_88_0.pauseUI, true)

		return
	end

	arg_88_0:emit(var_0_1.ON_BACK_PRESSED)

	return
end

function var_0_1.willExit(arg_89_0)
	if arg_89_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_89_0.handle)
	end

	arg_89_0:cleanManagedTween()

	if arg_89_0.timer and arg_89_0.timer.running then
		local var_89_0 = arg_89_0.timer

		var_1.Stop(var_89_0)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_89_0.timer = nil

	return
end

return var_0_1
