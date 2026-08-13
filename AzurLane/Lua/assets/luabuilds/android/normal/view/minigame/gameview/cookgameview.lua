class = var_0_10000

local var_0_0 = "CookGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))
local var_0_2 = "bar-soft"
local var_0_3 = "event:/ui/ddldaoshu2"
local var_0_4 = "event:/ui/break_out_full"
local var_0_5 = 60
local var_0_6 = "cookgameui_atlas"
local var_0_7 = 0.1
local var_0_8 = 8
local var_0_9 = {
	speed_num = 3,
	char_path = "ui/minigameui/",
	extend_time = 10,
	time_up = 0.5,
	cake_num = 5,
	path = "ui/minigameui/" .. var_0_6
}

var_0_1.CLICK_JUDGE_EVENT = "click judge event"
var_0_1.AC_CAKE_EVENT = "ac cake event"
var_0_1.SERVE_EVENT = "serve event"
var_0_1.EXTEND_EVENT = "extend event"

function var_0_1.getUIName(arg_1_0)
	return "CookGameUI"
end

function var_0_1.didEnter(arg_2_0)
	arg_2_0:initEvent()
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:initGameUI()
	arg_2_0:initController()
	arg_2_0:updateMenuUI()
	arg_2_0:openMenuUI()

	return
end

function var_0_1.initEvent(arg_3_0)
	if not arg_3_0.uiCam then
		GameObject = var_1

		local var_3_0 = var_1.Find("UICamera")

		arg_3_0.uiCam = var_1.GetComponent(var_3_0, "Camera")
	end

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.bind

	CookGameView = var_1_10003

	var_3_2(var_3_1, var_1_10003.CLICK_JUDGE_EVENT, function(arg_4_0, arg_4_1, arg_4_2)
		if arg_3_0.charController then
			local var_4_0 = arg_3_0.charController

			var_3.setJudgeAction(var_4_0, arg_4_1, nil, arg_4_2)
		end

		return
	end)

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.bind

	CookGameView = var_3

	var_3_4(var_3_3, var_3.AC_CAKE_EVENT, function(arg_5_0, arg_5_1, arg_5_2)
		if arg_3_0.charController then
			local var_5_0 = arg_3_0.charController

			var_3.createAcCake(var_5_0, arg_5_1, arg_5_2)
		end

		return
	end)

	local var_3_5 = arg_3_0
	local var_3_6 = arg_3_0.bind

	CookGameView = var_3

	var_3_6(var_3_5, var_3.SERVE_EVENT, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_6_1.serveData.battleData.id
		local var_6_1 = arg_6_1.right
		local var_6_2 = arg_6_1.pos
		local var_6_3 = arg_6_1.rate
		local var_6_4 = arg_6_1.weight
		local var_6_5 = var_6_1 and 1 or -1
		local var_6_6 = var_6_1 and 1 or 0
		local var_6_7 = arg_6_1.serveData.parameter.right_index
		local var_6_8
		local var_6_9 = var_6_0 ~= var_0_9.playerChar and var_6_0 ~= var_0_9.partnerChar and var_6_0 ~= var_0_9.partnerPet

		if not arg_6_1.serveData.battleData.weight then
			local var_6_10 = 0
		end

		if var_6_1 and arg_6_1.serveData.battleData.cake_allow then
			var_6_6 = 3
		end

		if var_6_1 and arg_6_1.serveData.battleData.score_added then
			var_6_5 = var_6_5 + arg_6_1.serveData.parameter.series_right_index - 1
		end

		if arg_6_1.serveData.battleData.random_score then
			math = var_13

			local var_6_11 = var_13.random
			local var_6_12 = 1

			CookGameConst = var_2_10015
			var_6_5 = var_6_5 * var_6_11(var_6_12, var_2_10015.random_score)
		end

		local var_6_13 = var_6_5 * var_6_3
		local var_6_14 = arg_3_0

		var_13.addScore(var_6_14, var_6_13, var_6_9)

		local var_6_15 = arg_3_0

		var_13.showScore(var_6_15, var_6_13, var_6_2, var_6_6)

		if arg_6_1.serveData.battleData.double_score == 8 then
			if var_6_1 and var_6_7 and var_6_7 % 2 == 0 then
				local var_6_16 = arg_3_0

				var_13.addScore(var_6_16, var_6_13, var_6_9)

				LeanTween = var_13

				local var_6_17 = var_13.delayedCall

				go = var_6_16

				local var_6_18 = var_6_16(arg_3_0._tf)
				local var_6_19 = 0.5

				System = var_16

				var_6_17(var_6_18, var_6_19, var_16.Action(function()
					local var_7_0 = arg_3_0

					var_0.showScore(var_7_0, var_6_13, var_6_2, 2)

					return
				end))
			end
		elseif arg_6_1.serveData.battleData.half_double and var_6_1 then
			math = var_13

			if var_13.random() > 0.5 then
				local var_6_20 = arg_3_0

				var_13.addScore(var_6_20, var_6_13, var_6_9)

				LeanTween = var_13

				local var_6_21 = var_13.delayedCall

				go = var_6_20

				local var_6_22 = var_6_20(arg_3_0._tf)
				local var_6_23 = 0.5

				System = var_16

				var_6_21(var_6_22, var_6_23, var_16.Action(function()
					local var_8_0 = arg_3_0

					var_0.showScore(var_8_0, var_6_13, var_6_2, 2)

					return
				end))
			end
		end

		return
	end)

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.bind

	CookGameView = var_3

	var_3_8(var_3_7, var_3.EXTEND_EVENT, function(arg_9_0, arg_9_1, arg_9_2)
		if arg_3_0.judgesController then
			local var_9_0 = arg_3_0.judgesController

			var_3.extend(var_9_0)
		end

		arg_3_0.waitingExtendTime = false
		arg_3_0.extendTime = var_0_9.extend_time
		arg_3_0.gameTime = 0

		return
	end)

	return
end

function var_0_1.showScore(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_1 == 0 then
		return
	end

	local var_10_0
	local var_10_1 = #arg_10_0.showScoresPool

	if 0 < var_10_1 then
		table = var_10_1
		var_10_0 = var_10_1.remove(arg_10_0.showScoresPool, 1)
	else
		tf = var_10_1
		Instantiate = var_6
		var_10_0 = var_10_1(var_6(arg_10_0.showScoreTpl))
		setParent = var_5

		var_5(var_10_0, arg_10_0.sceneFrontContainer)

		GetComponent = var_5
		findTF = var_6

		local var_10_2 = var_6(var_10_0, "anim")

		typeof = var_7
		DftAniEvent = var_8

		local var_10_3 = var_5(var_10_2, var_7(var_8))

		var_5.SetEndEvent(var_10_3, function()
			for iter_11_0 = #arg_10_0.showScores, 1, -1 do
				if var_10_0 == arg_10_0.showScores[iter_11_0] then
					setActive = var_4

					var_4(var_10_0, false)

					table = var_4

					local var_11_0 = var_4.insert
					local var_11_1 = arg_10_0.showScoresPool

					table = var_6

					var_11_0(var_11_1, var_6.remove(arg_10_0.showScores, iter_11_0))
				end
			end

			return
		end)
	end

	local var_10_4 = arg_10_0.sceneFrontContainer

	var_10_0.anchoredPosition = var_5.InverseTransformPoint(var_10_4, arg_10_2)
	setText = var_5
	findTF = var_10_4

	local var_10_5 = var_10_4(var_10_0, "anim/text_sub")
	local var_10_6 = ""

	tostring = var_8

	var_5(var_10_5, var_10_6 .. var_8(arg_10_1))

	setText = var_5
	findTF = var_10_5

	local var_10_7 = var_10_5(var_10_0, "anim/text_add")
	local var_10_8 = "+"

	tostring = var_8

	var_5(var_10_7, var_10_8 .. var_8(arg_10_1))

	if 0 < arg_10_1 then
		setActive = var_5
		findTF = var_10_7

		var_5(var_10_7(var_10_0, "anim/text_sub"), false)

		setActive = var_5
		findTF = var_10_7

		var_5(var_10_7(var_10_0, "anim/text_add"), true)
	else
		setActive = var_5
		findTF = var_10_7

		var_5(var_10_7(var_10_0, "anim/text_sub"), true)

		setActive = var_5
		findTF = var_6

		var_5(var_6(var_10_0, "anim/text_add"), false)
	end

	setActive = var_5

	var_5(var_10_0, false)

	setActive = var_5

	var_5(var_10_0, true)

	table = var_5

	var_5.insert(arg_10_0.showScores, var_10_0)

	return
end

function var_0_1.onEventHandle(arg_12_0, arg_12_1)
	return
end

function var_0_1.initData(arg_13_0)
	Application = var_1_10001

	local var_13_0

	if not var_1_10001.targetFrameRate then
		var_13_0 = 60
	end

	if 60 < var_13_0 then
		var_13_0 = 60
	end

	Timer = var_2
	arg_13_0.timer = var_2.New(function()
		local var_14_0 = arg_13_0

		var_0.onTimer(var_14_0)

		return
	end, 1 / var_13_0, -1)
	arg_13_0.showScores = {}
	arg_13_0.showScoresPool = {}
	pg = var_2
	arg_13_0.dropData = var_2.mini_game[arg_13_0:GetMGData().id].simple_config_data.drop_ids
	var_0_9.playerChar = nil
	var_0_9.partnerChar = nil
	var_0_9.partnerPet = nil
	var_0_9.enemy1Char = nil
	var_0_9.enemy2Char = nil
	var_0_9.enemyPet = nil
	arg_13_0.selectPlayer = true
	arg_13_0.selectPartner = false

	return
end

function var_0_1.initUI(arg_15_0)
	findTF = var_1_10001
	arg_15_0.backSceneTf = var_1_10001(arg_15_0._tf, "scene_background")
	findTF = var_1
	arg_15_0.sceneContainer = var_1(arg_15_0._tf, "sceneMask/sceneContainer")
	findTF = var_1
	arg_15_0.sceneFrontContainer = var_1(arg_15_0._tf, "sceneMask/sceneContainer/scene_front")
	findTF = var_1
	arg_15_0.clickMask = var_1(arg_15_0._tf, "clickMask")
	findTF = var_1
	arg_15_0.bg = var_1(arg_15_0._tf, "bg")
	findTF = var_1
	arg_15_0.countUI = var_1(arg_15_0._tf, "pop/CountUI")
	GetComponent = var_1
	findTF = var_2

	local var_15_0 = var_2(arg_15_0.countUI, "count")

	typeof = var_3
	Animator = var_4
	arg_15_0.countAnimator = var_1(var_15_0, var_3(var_4))
	GetOrAddComponent = var_1
	findTF = var_15_0

	local var_15_1 = var_15_0(arg_15_0.countUI, "count")

	typeof = var_3
	DftAniEvent = var_4
	arg_15_0.countDft = var_1(var_15_1, var_3(var_4))

	local var_15_2 = arg_15_0.countDft

	var_1.SetTriggerEvent(var_15_2, function()
		return
	end)

	local var_15_3 = arg_15_0.countDft

	var_1.SetEndEvent(var_15_3, function()
		setActive = var_2_10000

		var_2_10000(arg_15_0.countUI, false)

		local var_17_0 = arg_15_0

		var_0.gameStart(var_17_0)

		return
	end)

	findTF = var_1
	arg_15_0.leaveUI = var_1(arg_15_0._tf, "pop/LeaveUI")
	onButton = var_1

	local var_15_4 = arg_15_0

	findTF = var_3

	local var_15_5 = var_3(arg_15_0.leaveUI, "ad/btnOk")

	local function var_15_6()
		local var_18_0 = arg_15_0

		var_0.resumeGame(var_18_0)

		local var_18_1 = arg_15_0

		var_0.onGameOver(var_18_1)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_15_4, var_15_5, var_15_6, var_5)

	onButton = var_1

	local var_15_7 = arg_15_0

	findTF = var_15_5

	local var_15_8 = var_15_5(arg_15_0.leaveUI, "ad/btnCancel")

	local function var_15_9()
		local var_19_0 = arg_15_0

		var_0.resumeGame(var_19_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_15_7, var_15_8, var_15_9, var_5)

	setActive = var_1

	var_1(arg_15_0.leaveUI, false)

	findTF = var_1
	arg_15_0.pauseUI = var_1(arg_15_0._tf, "pop/pauseUI")
	onButton = var_1

	local var_15_10 = arg_15_0

	findTF = var_3

	local var_15_11 = var_3(arg_15_0.pauseUI, "ad/btnOk")

	local function var_15_12()
		setActive = var_2_10000

		var_2_10000(arg_15_0.pauseUI, false)

		local var_20_0 = arg_15_0

		var_0.resumeGame(var_20_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_15_10, var_15_11, var_15_12, var_5)

	findTF = var_1
	arg_15_0.settlementUI = var_1(arg_15_0._tf, "pop/SettleMentUI")
	onButton = var_1

	local var_15_13 = arg_15_0

	findTF = var_3

	local var_15_14 = var_3(arg_15_0.settlementUI, "ad/btnOver")

	local function var_15_15()
		setActive = var_2_10000

		var_2_10000(arg_15_0.settlementUI, false)

		local var_21_0 = arg_15_0

		var_0.openMenuUI(var_21_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_15_13, var_15_14, var_15_15, var_5)

	setActive = var_1

	var_1(arg_15_0.settlementUI, false)

	findTF = var_1
	arg_15_0.menuUI = var_1(arg_15_0._tf, "pop/menuUI")
	GetComponent = var_1
	findTF = var_2

	local var_15_16 = var_2(arg_15_0.menuUI, "battList")

	typeof = var_3
	ScrollRect = var_4
	arg_15_0.battleScrollRect = var_1(var_15_16, var_3(var_4))
	arg_15_0.totalTimes = arg_15_0:getGameTotalTime()

	local var_15_17, var_15_18

	if arg_15_0:getGameUsedTimes() - 4 < 0 then
		var_15_17 = 0
	else
		var_15_18 = arg_15_0
		var_15_17 = arg_15_0.getGameUsedTimes(var_15_18) - 4
	end

	scrollTo = var_15_18

	var_15_18(arg_15_0.battleScrollRect, 0, 1 - var_15_17 / (arg_15_0.totalTimes - 4))

	onButton = var_15_18

	local var_15_19 = arg_15_0

	findTF = var_4

	local var_15_20 = var_4(arg_15_0.menuUI, "rightPanelBg/arrowUp")

	local function var_15_21()
		local var_22_0 = arg_15_0.battleScrollRect.normalizedPosition.y + 1 / (arg_15_0.totalTimes - 4)

		if 1 < var_22_0 then
			var_22_0 = 1
		end

		scrollTo = var_1

		var_1(arg_15_0.battleScrollRect, 0, var_22_0)

		return
	end

	SFX_CANCEL = var_6

	var_15_18(var_15_19, var_15_20, var_15_21, var_6)

	onButton = var_15_18

	local var_15_22 = arg_15_0

	findTF = var_15_20

	local var_15_23 = var_15_20(arg_15_0.menuUI, "rightPanelBg/arrowDown")

	local function var_15_24()
		local var_23_0

		if arg_15_0.battleScrollRect.normalizedPosition.y - 1 / (arg_15_0.totalTimes - 4) < 0 then
			var_23_0 = 0
		end

		scrollTo = var_1

		var_1(arg_15_0.battleScrollRect, 0, var_23_0)

		return
	end

	SFX_CANCEL = var_6

	var_15_18(var_15_22, var_15_23, var_15_24, var_6)

	onButton = var_15_18

	local var_15_25 = arg_15_0

	findTF = var_15_23

	local var_15_26 = var_15_23(arg_15_0.menuUI, "adButton/btnBack")

	local function var_15_27()
		local var_24_0 = arg_15_0

		var_0.closeView(var_24_0)

		return
	end

	SFX_CANCEL = var_6

	var_15_18(var_15_25, var_15_26, var_15_27, var_6)

	onButton = var_15_18

	local var_15_28 = arg_15_0

	findTF = var_15_26

	local var_15_29 = var_15_26(arg_15_0.menuUI, "btnRule")

	local function var_15_30()
		pg = var_2_10000

		local var_25_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_25_1 = var_0.ShowMsgBox
		local var_25_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_25_2.type = var_2_10003
		pg = var_2_10003
		var_25_2.helps = var_2_10003.gametip.mini_cookgametip.tip

		var_25_1(var_25_0, var_25_2)

		return
	end

	SFX_CANCEL = var_6

	var_15_18(var_15_28, var_15_29, var_15_30, var_6)

	onButton = var_15_18

	local var_15_31 = arg_15_0

	findTF = var_15_29

	local var_15_32 = var_15_29(arg_15_0.menuUI, "btnStart")

	local function var_15_33()
		setActive = var_2_10000

		var_2_10000(arg_15_0.menuUI, false)

		local var_26_0 = arg_15_0

		var_0.openSelectUI(var_26_0)

		return
	end

	SFX_CANCEL = var_6

	var_15_18(var_15_31, var_15_32, var_15_33, var_6)

	findTF = var_15_18

	local var_15_34 = var_15_18(arg_15_0.menuUI, "tplBattleItem")

	arg_15_0.battleItems = {}
	arg_15_0.dropItems = {}

	for iter_15_0 = 1, 7 do
		tf = var_1_10007
		instantiate = var_1_10008
		var_1_10007 = var_1_10007(var_1_10008(var_15_34))
		var_1_10007.name = "battleItem_" .. iter_15_0
		setParent = var_1_10008
		var_1_10009 = var_1_10007
		findTF = var_1_10010

		var_1_10008(var_1_10009, var_1_10010(arg_15_0.menuUI, "battList/Viewport/Content"))

		var_1_10008 = iter_15_0
		GetSpriteFromAtlasAsync = var_1_10009

		var_1_10009("ui/minigameui/" .. var_0_6, "battleDesc" .. var_1_10008, function(arg_27_0)
			if arg_27_0 then
				setImageSprite = var_2_10001
				findTF = var_2_10002

				var_2_10001(var_2_10002(var_1_10007, "state_open/desc"), arg_27_0, true)

				setImageSprite = var_2_10001
				findTF = var_2

				var_2_10001(var_2(var_1_10007, "state_clear/desc"), arg_27_0, true)

				setImageSprite = var_2_10001
				findTF = var_2

				var_2_10001(var_2(var_1_10007, "state_current/desc"), arg_27_0, true)

				setImageSprite = var_2_10001
				findTF = var_2

				var_2_10001(var_2(var_1_10007, "state_closed/desc"), arg_27_0, true)
			end

			return
		end)

		findTF = var_1_10009
		var_1_10009 = var_1_10009(var_1_10007, "icon")
		var_1_10010 = {
			type = arg_15_0.dropData[iter_15_0][1],
			id = arg_15_0.dropData[iter_15_0][2],
			amount = arg_15_0.dropData[iter_15_0][3]
		}
		updateDrop = var_11

		var_11(var_1_10009, var_1_10010)

		onButton = var_11

		local var_15_35 = arg_15_0
		local var_15_36 = var_1_10009

		local function var_15_37()
			local var_28_0 = arg_15_0
			local var_28_1 = var_0.emit

			BaseUI = var_2_10002

			var_28_1(var_28_0, var_2_10002.ON_DROP, var_1_10010)

			return
		end

		SFX_PANEL = var_1_10015

		var_11(var_15_35, var_15_36, var_15_37, var_1_10015)

		table = var_11

		var_11.insert(arg_15_0.dropItems, var_1_10009)

		setActive = var_11

		var_11(var_1_10007, true)

		table = var_11

		var_11.insert(arg_15_0.battleItems, var_1_10007)
	end

	findTF = var_3
	arg_15_0.selectUI = var_3(arg_15_0._tf, "pop/selectUI")
	findTF = var_3
	arg_15_0.selectCharTpl = var_3(arg_15_0.selectUI, "ad/charTpl")
	setActive = var_3

	var_3(arg_15_0.selectCharTpl, false)

	findTF = var_3
	arg_15_0.selectCharsContainer = var_3(arg_15_0.selectUI, "ad/chars/Viewport/Content")
	arg_15_0.selectCharId = nil
	arg_15_0.selectChars = {}
	CookGameConst = var_3

	local var_15_38 = #var_3.char_ids

	findTF = var_4

	local var_15_39 = var_4(arg_15_0.selectUI, "ad/charDetail")

	arg_15_0.detailDescPositons = {}

	for iter_15_1 = 1, var_15_38 do
		CookGameConst = var_1_10009
		var_1_10009 = var_1_10009.char_ids[iter_15_1]

		local var_15_40 = arg_15_0
		local var_15_41 = arg_15_0.getCharDataById(var_15_40, var_1_10009)

		tf = var_15_40
		instantiate = var_12

		local var_15_42 = var_15_40(var_12(arg_15_0.selectCharTpl))

		setParent = var_15_43

		var_15_43(var_15_42, arg_15_0.selectCharsContainer)

		local var_15_43, var_15_45

		if var_15_41 then
			var_15_43 = var_15_41.icon

			local var_15_44 = var_15_41.pos

			pg = var_15_45
			var_15_45 = var_15_45.gametip[var_15_41.desc].tip
			pg = var_1_10015
			var_1_10015 = var_1_10015.ship_data_statistics[var_15_41.ship_id].name
			setScrollText = var_16
			findTF = var_1_10017

			var_16(var_1_10017(var_15_42, "name/text"), var_1_10015)

			setActive = var_16
			findTF = var_1_10017

			var_16(var_1_10017(var_15_42, "desc"), false)

			setActive = var_16
			findTF = var_1_10017

			var_16(var_1_10017(var_15_42, "desc_en"), false)

			PLATFORM_CODE = var_16
			PLATFORM_US = var_1_10017

			if var_16 == var_1_10017 then
				setActive = var_16
				findTF = var_1_10017

				var_16(var_1_10017(var_15_42, "desc_en"), true)

				setText = var_16
				findTF = var_1_10017

				var_16(var_1_10017(var_15_42, "desc_en"), var_15_45)
			else
				setActive = var_16
				findTF = var_1_10017

				var_16(var_1_10017(var_15_42, "desc"), true)

				setText = var_16
				findTF = var_1_10017

				var_16(var_1_10017(var_15_42, "desc"), var_15_45)
			end

			findTF = var_16

			local var_15_46 = var_16(var_15_42, "detailDesc")

			setActive = var_1_10017

			var_1_10017(var_15_46, false)

			if var_15_41.detail_name then
				var_1_10017 = arg_15_0.detailDescPositons
				var_1_10017[var_15_41.detail_name] = var_15_46.anchoredPosition
				setText = var_1_10017
				findTF = var_18

				local var_15_47 = var_18(var_15_46, "name")

				i18n = var_19

				var_1_10017(var_15_47, var_19(var_15_41.detail_name))

				setText = var_1_10017
				findTF = var_15_47

				local var_15_48 = var_15_47(var_15_46, "desc")

				i18n = var_19

				var_1_10017(var_15_48, var_19(var_15_41.detail_desc))

				setActive = var_1_10017
				findTF = var_15_48

				var_1_10017(var_15_48(var_15_42, "clickDesc"), true)

				onButton = var_1_10017

				local var_15_49 = arg_15_0

				findTF = var_19

				var_1_10017(var_15_49, var_19(var_15_42, "clickDesc"), function()
					isActive = var_2_10000

					local var_29_0 = var_2_10000(var_15_46)
					local var_29_1

					if not var_29_0 then
						local var_29_2 = var_15_39

						var_29_1 = var_2.InverseTransformPoint(var_29_2, var_15_46.position)
						setParent = var_2

						var_2(var_15_46, var_15_39)

						arg_15_0.detailDescTf = var_15_46
						arg_15_0.detailDescContent = var_15_42
						arg_15_0.detailDescName = var_15_41.detail_name
					else
						var_29_1 = arg_15_0.detailDescPositons[var_15_41.detail_name]
						setParent = var_2

						var_2(var_15_46, var_15_42)

						arg_15_0.detailDescTf = nil
						arg_15_0.detailDescContent = nil
						arg_15_0.detailDescName = nil
					end

					local var_29_3 = var_15_46

					var_29_3.anchoredPosition = var_29_1
					setActive = var_29_3

					var_29_3(var_15_46, not var_29_0)

					return
				end)
			end

			GetSpriteFromAtlasAsync = var_1_10017

			var_1_10017("ui/minigameui/" .. var_0_6, var_15_43, function(arg_30_0)
				findTF = var_2_10001

				local var_30_0 = var_2_10001(var_15_42, "icon/img")

				setActive = var_2

				var_2(var_30_0, true)

				var_30_0.anchoredPosition = var_15_44
				setImageSprite = var_2

				var_2(var_30_0, arg_30_0, true)

				return
			end)

			setActive = var_1_10017
			findTF = var_18

			var_1_10017(var_18(var_15_42, "selected"), false)

			onButton = var_1_10017

			local var_15_50 = arg_15_0

			findTF = var_19

			local var_15_51 = var_19(var_15_42, "click")

			local function var_15_52()
				local var_31_0 = arg_15_0

				var_0.selectChar(var_31_0, var_15_41.id)

				return
			end

			SFX_PANEL = var_21

			var_1_10017(var_15_50, var_15_51, var_15_52, var_21)
		else
			GetComponent = var_15_43

			local var_15_53 = var_15_42

			typeof = var_15_45
			CanvasGroup = var_1_10015
			var_15_43 = var_15_43(var_15_53, var_15_45(var_1_10015))
			var_15_43.alpha = 0
		end

		setActive = var_15_43

		var_15_43(var_15_42, true)

		table = var_15_43

		var_15_43.insert(arg_15_0.selectChars, {
			data = var_15_41,
			tf = var_15_42
		})
	end

	findTF = var_5
	arg_15_0.playerTf = var_5(arg_15_0.selectUI, "ad/player")
	findTF = var_5
	arg_15_0.partnerTf = var_5(arg_15_0.selectUI, "ad/partner")
	findTF = var_5
	arg_15_0.selectClickTf = var_5(arg_15_0.selectUI, "ad/click")
	setActive = var_5

	var_5(arg_15_0.selectClickTf, false)

	onButton = var_5

	local var_15_54 = arg_15_0

	findTF = var_7

	local var_15_55 = var_7(arg_15_0.selectUI, "ad/btnStart")

	local function var_15_56()
		if var_0_9.playerChar and var_0_9.partnerChar then
			local var_32_0 = arg_15_0

			var_0.randomAIShip(var_32_0)

			setActive = var_0

			var_0(arg_15_0.selectUI, false)

			local var_32_1 = arg_15_0

			var_0.readyStart(var_32_1)
		end

		return
	end

	SFX_PANEL = var_9

	var_5(var_15_54, var_15_55, var_15_56, var_9)

	onButton = var_5

	local var_15_57 = arg_15_0

	findTF = var_15_55

	local var_15_58 = var_15_55(arg_15_0.selectUI, "ad/player")

	local function var_15_59()
		arg_15_0.selectPlayer = true
		arg_15_0.selectPartner = false

		local var_33_0 = arg_15_0

		var_0.updateSelectUI(var_33_0)

		return
	end

	SFX_PANEL = var_9

	var_5(var_15_57, var_15_58, var_15_59, var_9)

	onButton = var_5

	local var_15_60 = arg_15_0

	findTF = var_15_58

	local var_15_61 = var_15_58(arg_15_0.selectUI, "ad/partner")

	local function var_15_62()
		arg_15_0.selectPlayer = false
		arg_15_0.selectPartner = true

		local var_34_0 = arg_15_0

		var_0.updateSelectUI(var_34_0)

		return
	end

	SFX_PANEL = var_9

	var_5(var_15_60, var_15_61, var_15_62, var_9)

	onButton = var_5

	local var_15_63 = arg_15_0

	findTF = var_15_61

	local var_15_64 = var_15_61(arg_15_0.selectUI, "ad/back")

	local function var_15_65()
		setActive = var_2_10000

		var_2_10000(arg_15_0.selectUI, false)

		local var_35_0 = arg_15_0

		var_0.openMenuUI(var_35_0)

		return
	end

	SFX_PANEL = var_9

	var_5(var_15_63, var_15_64, var_15_65, var_9)

	math = var_5
	arg_15_0.pageMax = var_5.ceil(var_15_38 / var_0_8) - 1
	arg_15_0.curPageIndex = 0
	arg_15_0.scrollNum = 1 / arg_15_0.pageMax
	GetComponent = var_5
	findTF = var_6

	local var_15_66 = var_6(arg_15_0.selectUI, "ad/chars")

	typeof = var_7
	ScrollRect = var_8
	arg_15_0.scrollRect = var_5(var_15_66, var_7(var_8))

	local var_15_67 = arg_15_0.scrollRect

	Vector2 = var_15_66
	var_15_67.normalizedPosition = var_15_66(0, 0)

	local var_15_68 = arg_15_0.scrollRect.onValueChanged
	local var_15_69 = var_5.Invoke

	Vector2 = var_7

	var_15_69(var_15_68, var_7(0, 0))

	local var_15_70 = arg_15_0.scrollRect

	Vector2 = var_15_68
	var_15_70.normalizedPosition = var_15_68(0, 0)

	local var_15_71 = arg_15_0.scrollRect.onValueChanged
	local var_15_72 = var_5.Invoke

	Vector2 = var_7

	var_15_72(var_15_71, var_7(0, 0))

	GetOrAddComponent = var_15_72
	findTF = var_15_71

	local var_15_73 = var_15_71(arg_15_0.selectUI, "ad/chars")

	typeof = var_7
	EventTriggerListener = var_8

	local var_15_74 = var_15_72(var_15_73, var_7(var_8))

	var_5.AddPointDownFunc(var_15_74, function(arg_36_0, arg_36_1)
		return
	end)

	local var_15_75 = arg_15_0.scrollRect.onValueChanged

	var_6.AddListener(var_15_75, function(arg_37_0, arg_37_1, arg_37_2)
		if arg_15_0.detailDescTf then
			setActive = var_3

			var_3(arg_15_0.detailDescTf, false)

			setParent = var_3

			var_3(arg_15_0.detailDescTf, arg_15_0.detailDescContent)

			arg_15_0.detailDescTf.anchoredPosition = arg_15_0.detailDescPositons[arg_15_0.detailDescName]
			arg_15_0.detailDescTf = nil
			arg_15_0.detailDescContent = nil
			arg_15_0.detailDescName = nil
		end

		return
	end)

	onButton = var_6

	local var_15_76 = arg_15_0

	findTF = var_8

	local var_15_77 = var_8(arg_15_0.selectUI, "ad/next")

	local function var_15_78()
		arg_15_0.curPageIndex = arg_15_0.curPageIndex + arg_15_0.scrollNum

		local var_38_0 = arg_15_0.curPageIndex

		if 1 < var_38_0 then
			arg_15_0.curPageIndex = 1
		end

		local var_38_1 = arg_15_0.scrollRect

		Vector2 = var_1
		var_38_1.normalizedPosition = var_1(arg_15_0.curPageIndex, 0)

		local var_38_2 = arg_15_0.scrollRect.onValueChanged
		local var_38_3 = var_0.Invoke

		Vector2 = var_2

		var_38_3(var_38_2, var_2(arg_15_0.curPageIndex, 0))

		return
	end

	SFX_PANEL = var_10

	var_6(var_15_76, var_15_77, var_15_78, var_10)

	onButton = var_6

	local var_15_79 = arg_15_0

	findTF = var_15_77

	local var_15_80 = var_15_77(arg_15_0.selectUI, "ad/pre")

	local function var_15_81()
		arg_15_0.curPageIndex = arg_15_0.curPageIndex - arg_15_0.scrollNum

		if arg_15_0.curPageIndex < 0 then
			arg_15_0.curPageIndex = 0
		end

		local var_39_0 = arg_15_0.scrollRect

		Vector2 = var_1
		var_39_0.normalizedPosition = var_1(arg_15_0.curPageIndex, 0)

		local var_39_1 = arg_15_0.scrollRect.onValueChanged
		local var_39_2 = var_0.Invoke

		Vector2 = var_2

		var_39_2(var_39_1, var_2(arg_15_0.curPageIndex, 0))

		return
	end

	SFX_PANEL = var_10

	var_6(var_15_79, var_15_80, var_15_81, var_10)

	setActive = var_6

	var_6(arg_15_0.selectUI, false)

	local var_15_82

	if not arg_15_0.handle then
		IsUnityEditor = var_6

		if var_6 then
			UpdateBeat = var_6
			var_15_82 = var_6
			arg_15_0.handle = var_6.CreateListener(var_15_82, arg_15_0.Update, arg_15_0)
			UpdateBeat = var_6
			var_15_82 = var_6

			var_6.AddListener(var_15_82, arg_15_0.handle)
		end
	end

	GetComponent = var_6
	findTF = var_15_82

	local var_15_83 = var_15_82(arg_15_0.selectUI, "ad/playerDesc")

	typeof = var_8
	Image = var_9

	local var_15_84 = var_6(var_15_83, var_8(var_9))

	var_6.SetNativeSize(var_15_84)

	GetComponent = var_6
	findTF = var_15_84

	local var_15_85 = var_15_84(arg_15_0.selectUI, "ad/partnerDesc")

	typeof = var_8
	Image = var_9

	local var_15_86 = var_6(var_15_85, var_8(var_9))

	var_6.SetNativeSize(var_15_86)

	GetComponent = var_6
	findTF = var_15_86

	local var_15_87 = var_15_86(arg_15_0.pauseUI, "ad/desc")

	typeof = var_8
	Image = var_9

	local var_15_88 = var_6(var_15_87, var_8(var_9))

	var_6.SetNativeSize(var_15_88)

	GetComponent = var_6
	findTF = var_15_88

	local var_15_89 = var_15_88(arg_15_0.leaveUI, "ad/desc")

	typeof = var_8
	Image = var_9

	local var_15_90 = var_6(var_15_89, var_8(var_9))

	var_6.SetNativeSize(var_15_90)

	return
end

function var_0_1.initGameUI(arg_40_0)
	findTF = var_1_10001
	arg_40_0.gameUI = var_1_10001(arg_40_0._tf, "ui/gameUI")
	findTF = var_1
	arg_40_0.showScoreTpl = var_1(arg_40_0.sceneFrontContainer, "score")
	setActive = var_1

	var_1(arg_40_0.showScoreTpl, false)

	onButton = var_1

	local var_40_0 = arg_40_0

	findTF = var_3

	var_1(var_40_0, var_3(arg_40_0.gameUI, "topRight/btnStop"), function()
		local var_41_0 = arg_40_0

		var_0.stopGame(var_41_0)

		setActive = var_0

		var_0(arg_40_0.pauseUI, true)

		return
	end)

	onButton = var_1

	local var_40_1 = arg_40_0

	findTF = var_3

	var_1(var_40_1, var_3(arg_40_0.gameUI, "btnLeave"), function()
		local var_42_0 = arg_40_0

		var_0.stopGame(var_42_0)

		setActive = var_0

		var_0(arg_40_0.leaveUI, true)

		return
	end)

	findTF = var_1
	arg_40_0.gameTimeS = var_1(arg_40_0.gameUI, "top/time/s")
	findTF = var_1
	arg_40_0.scoreTf = var_1(arg_40_0.gameUI, "top/score")
	findTF = var_1
	arg_40_0.otherScoreTf = var_1(arg_40_0.gameUI, "top/otherScore")

	return
end

function var_0_1.initController(arg_43_0)
	CookGameJudgesController = var_1_10001
	arg_43_0.judgesController = var_1_10001.New(arg_43_0.sceneContainer, var_0_9, arg_43_0)
	findTF = var_1

	local var_43_0 = var_1(arg_43_0.sceneContainer, "scene_background/charTpl")

	setActive = var_2

	var_2(var_43_0, false)

	CookGameCharController = var_2
	arg_43_0.charController = var_2.New(arg_43_0.sceneContainer, var_0_9, arg_43_0)

	return
end

function var_0_1.Update(arg_44_0)
	arg_44_0:AddDebugInput()

	return
end

function var_0_1.AddDebugInput(arg_45_0)
	if arg_45_0.gameStop or arg_45_0.settlementFlag then
		return
	end

	IsUnityEditor = var_1

	if var_1 then
		Input = var_1

		local var_45_0 = var_1.GetKeyDown

		KeyCode = var_1_10002

		if var_45_0(var_1_10002.S) then
			-- block empty
		end
	end

	return
end

function var_0_1.updateMenuUI(arg_46_0)
	local var_46_0 = arg_46_0:getGameUsedTimes()
	local var_46_1 = arg_46_0:getGameTimes()

	for iter_46_0 = 1, #arg_46_0.battleItems do
		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_46_0.battleItems[iter_46_0], "state_open"), false)

		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_46_0.battleItems[iter_46_0], "state_closed"), false)

		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_46_0.battleItems[iter_46_0], "state_clear"), false)

		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_46_0.battleItems[iter_46_0], "state_current"), false)

		if iter_46_0 <= var_46_0 then
			SetParent = var_1_10007
			var_1_10008 = arg_46_0.dropItems[iter_46_0]
			findTF = var_9

			var_1_10007(var_1_10008, var_9(arg_46_0.battleItems[iter_46_0], "state_clear/icon"))

			setActive = var_1_10007

			var_1_10007(arg_46_0.dropItems[iter_46_0], true)

			setActive = var_1_10007
			findTF = var_1_10008

			var_1_10007(var_1_10008(arg_46_0.battleItems[iter_46_0], "state_clear"), true)
		elseif iter_46_0 == var_46_0 + 1 and 1 <= var_46_1 then
			setActive = var_1_10007
			findTF = var_1_10008

			var_1_10007(var_1_10008(arg_46_0.battleItems[iter_46_0], "state_current"), true)

			SetParent = var_1_10007
			var_1_10008 = arg_46_0.dropItems[iter_46_0]
			findTF = var_9

			var_1_10007(var_1_10008, var_9(arg_46_0.battleItems[iter_46_0], "state_current/icon"))

			setActive = var_1_10007

			var_1_10007(arg_46_0.dropItems[iter_46_0], true)
		elseif var_46_0 < iter_46_0 and iter_46_0 <= var_46_0 + var_46_1 then
			setActive = var_1_10007
			findTF = var_1_10008

			var_1_10007(var_1_10008(arg_46_0.battleItems[iter_46_0], "state_open"), true)

			SetParent = var_1_10007
			var_1_10008 = arg_46_0.dropItems[iter_46_0]
			findTF = var_9

			var_1_10007(var_1_10008, var_9(arg_46_0.battleItems[iter_46_0], "state_open/icon"))

			setActive = var_1_10007

			var_1_10007(arg_46_0.dropItems[iter_46_0], true)
		else
			setActive = var_1_10007
			findTF = var_1_10008

			var_1_10007(var_1_10008(arg_46_0.battleItems[iter_46_0], "state_closed"), true)

			SetParent = var_1_10007
			var_1_10008 = arg_46_0.dropItems[iter_46_0]
			findTF = var_9

			var_1_10007(var_1_10008, var_9(arg_46_0.battleItems[iter_46_0], "state_closed/icon"))

			setActive = var_1_10007

			var_1_10007(arg_46_0.dropItems[iter_46_0], true)
		end
	end

	arg_46_0.totalTimes = arg_46_0:getGameTotalTime()

	local var_46_2 = 1 - (arg_46_0:getGameUsedTimes() - 3 < 0 and 0 or arg_46_0:getGameUsedTimes() - 3) / (arg_46_0.totalTimes - 4)

	if 1 < var_46_2 then
		var_46_2 = 1
	end

	scrollTo = var_5

	var_5(arg_46_0.battleScrollRect, 0, var_46_2)

	setActive = var_5
	findTF = var_6

	var_5(var_6(arg_46_0.menuUI, "btnStart/tip"), var_46_1 > 0)
	arg_46_0:CheckGet()

	return
end

function var_0_1.CheckGet(arg_47_0)
	setActive = var_1_10001
	findTF = var_1_10002

	var_1_10001(var_1_10002(arg_47_0.menuUI, "got"), false)

	if arg_47_0:getUltimate() then
		local var_47_0 = arg_47_0

		if arg_47_0.getUltimate(var_47_0) ~= 0 then
			setActive = var_1
			findTF = var_47_0

			var_1(var_47_0(arg_47_0.menuUI, "got"), true)
		end
	end

	if arg_47_0:getUltimate() == 0 then
		local var_47_1 = arg_47_0:getGameTotalTime()
		local var_47_2 = arg_47_0

		if var_47_1 > arg_47_0.getGameUsedTimes(var_47_2) then
			return
		end

		pg = var_47_2

		local var_47_3 = var_47_2.m02
		local var_47_4 = var_3.sendNotification

		GAME = var_1_10005

		local var_47_5 = var_1_10005.SEND_MINI_GAME_OP
		local var_47_6 = {
			hubid = arg_47_0:GetMGHubData().id
		}

		MiniGameOPCommand = var_7
		var_47_6.cmd = var_7.CMD_ULTIMATE
		var_47_6.args1 = {}

		var_47_4(var_47_3, var_47_5, var_47_6)

		setActive = var_47_4
		findTF = var_47_3

		var_47_4(var_47_3(arg_47_0.menuUI, "got"), true)
	end

	return
end

function var_0_1.openSelectUI(arg_48_0)
	setActive = var_1_10001

	var_1_10001(arg_48_0.selectUI, true)

	arg_48_0.selectPlayer = true
	arg_48_0.selectPartner = false

	arg_48_0:updateSelectUI()

	return
end

function var_0_1.updateSelectUI(arg_49_0)
	if var_0_9.playerChar then
		findTF = var_1_10002
		var_1_10002 = var_1_10002(arg_49_0.selectUI, "ad/player/icon/img")
		var_1_10004 = arg_49_0
		var_1_10003 = arg_49_0.getCharData(var_1_10004, var_1, "icon")

		local var_49_0 = arg_49_0

		var_1_10004 = arg_49_0.getCharData(var_49_0, var_1, "pos")
		GetSpriteFromAtlasAsync = var_49_0

		var_49_0("ui/minigameui/" .. var_0_6, var_1_10003, function(arg_50_0)
			local var_50_0 = var_1_10002

			var_50_0.anchoredPosition = var_1_10004
			setActive = var_50_0

			var_50_0(var_1_10002, true)

			setImageSprite = var_50_0

			var_50_0(var_1_10002, arg_50_0, true)

			return
		end)
	else
		setActive = var_1_10002
		findTF = var_1_10003

		var_1_10002(var_1_10003(arg_49_0.selectUI, "ad/player/icon/img"), false)
	end

	if var_0_9.partnerChar then
		findTF = var_1_10003
		var_1_10003 = var_1_10003(arg_49_0.selectUI, "ad/partner/icon/img")
		var_1_10004 = arg_49_0:getCharData(var_2, "icon")

		local var_49_1 = arg_49_0
		local var_49_2 = arg_49_0.getCharData(var_49_1, var_2, "pos")

		GetSpriteFromAtlasAsync = var_49_1

		var_49_1("ui/minigameui/" .. var_0_6, var_1_10004, function(arg_51_0)
			local var_51_0 = var_1_10003

			var_51_0.anchoredPosition = var_49_2
			setActive = var_51_0

			var_51_0(var_1_10003, true)

			setImageSprite = var_51_0

			var_51_0(var_1_10003, arg_51_0, true)

			return
		end)
	else
		setActive = var_1_10003
		findTF = var_1_10004

		var_1_10003(var_1_10004(arg_49_0.selectUI, "ad/partner/icon/img"), false)
	end

	if arg_49_0.selectPlayer then
		setActive = var_3
		findTF = var_1_10004

		var_3(var_1_10004(arg_49_0.selectUI, "ad/player/selected"), true)

		setActive = var_3
		findTF = var_1_10004

		var_3(var_1_10004(arg_49_0.selectUI, "ad/partner/selected"), false)
	elseif arg_49_0.selectPartner then
		setActive = var_3
		findTF = var_1_10004

		var_3(var_1_10004(arg_49_0.selectUI, "ad/player/selected"), false)

		setActive = var_3
		findTF = var_4

		var_3(var_4(arg_49_0.selectUI, "ad/partner/selected"), true)
	end

	return
end

function var_0_1.selectChar(arg_52_0, arg_52_1)
	arg_52_0.selectCharId = arg_52_1

	for iter_52_0 = 1, #arg_52_0.selectChars do
		if arg_52_0.selectChars[iter_52_0].data then
			local var_52_0 = arg_52_0.selectChars[iter_52_0].tf

			if var_6.id == arg_52_1 then
				setActive = var_8
				findTF = var_1_10009

				var_8(var_1_10009(var_52_0, "selected"), true)
			else
				setActive = var_8
				findTF = var_1_10009

				var_8(var_1_10009(var_52_0, "selected"), false)
			end
		end
	end

	if arg_52_0.selectPlayer then
		if var_0_9.partnerChar and var_0_9.partnerChar == arg_52_1 then
			local var_52_1 = var_0_9
			local var_52_2

			if not var_0_9.playerChar then
				var_52_2 = nil
			end

			var_52_1.partnerChar = var_52_2
		end

		var_0_9.playerChar = arg_52_1

		if not var_0_9.partnerChar then
			arg_52_0.selectPlayer = false
			arg_52_0.selectPartner = true
		end
	elseif arg_52_0.selectPartner then
		if var_0_9.playerChar and var_0_9.playerChar == arg_52_1 then
			var_0_9.playerChar = var_0_9.partnerChar
		end

		var_0_9.partnerChar = arg_52_1

		if not var_0_9.playerChar then
			arg_52_0.selectPlayer = true
			arg_52_0.selectPartner = false
		end
	end

	if var_0_9.playerChar then
		CookGameConst = var_2

		if var_2.char_battle_data[var_0_9.playerChar].pet then
			local var_52_3 = var_0_9

			CookGameConst = var_3
			var_52_3.partnerPet = var_3.char_battle_data[var_0_9.playerChar].pet

			goto label_52_0
		end
	end

	if var_0_9.partnerChar then
		CookGameConst = var_2

		if var_2.char_battle_data[var_0_9.partnerChar].pet then
			local var_52_4 = var_0_9

			CookGameConst = var_3
			var_52_4.partnerPet = var_3.char_battle_data[var_0_9.partnerChar].pet

			goto label_52_0
		end
	end

	var_0_9.partnerPet = nil

	::label_52_0::

	arg_52_0:updateSelectUI()

	return
end

function var_0_1.getCharDataById(arg_53_0, arg_53_1)
	pairs = var_1_10002
	CookGameConst = var_1_10003

	for iter_53_0, iter_53_1 in var_1_10002(var_1_10003.char_data) do
		if iter_53_1.id == arg_53_1 then
			Clone = var_7

			return var_7(iter_53_1)
		end
	end

	return nil
end

function var_0_1.getCharData(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = 1

	CookGameConst = var_1_10004

	for iter_54_0 = var_54_0, #var_1_10004.char_data do
		CookGameConst = var_1_10007

		if var_1_10007.char_data[iter_54_0].id == arg_54_1 then
			if not arg_54_2 then
				Clone = var_8

				return var_8(var_1_10007)
			else
				Clone = var_8

				return var_8(var_1_10007[arg_54_2])
			end
		end
	end

	return nil
end

function var_0_1.randomAIShip(arg_55_0)
	local var_55_0 = {}

	pairs = var_1_10002
	CookGameConst = var_1_10003

	for iter_55_0, iter_55_1 in var_1_10002(var_1_10003.char_battle_data) do
		if iter_55_1.extend then
			table = var_1_10007

			var_1_10007.insert(var_55_0, iter_55_1.id)
		end
	end

	if var_0_9.playerChar then
		table = var_2

		var_2.insert(var_55_0, var_0_9.playerChar)
	end

	if var_0_9.partnerChar then
		table = var_2

		var_2.insert(var_55_0, var_0_9.partnerChar)
	end

	Clone = var_2
	CookGameConst = var_3

	for iter_55_2 = #var_2(var_3.random_ids), 1, -1 do
		table = var_1_10007

		if var_1_10007.contains(var_55_0, var_2[iter_55_2]) then
			table = var_1_10007

			var_1_10007.remove(var_2, iter_55_2)
		end
	end

	local var_55_1 = var_0_9

	table = var_4

	local var_55_2 = var_4.remove
	local var_55_3 = var_2

	math = iter_55_2
	var_55_1.enemy1Char = var_55_2(var_55_3, iter_55_2.random(1, #var_2))

	local var_55_4 = var_0_9

	table = var_4

	local var_55_5 = var_4.remove
	local var_55_6 = var_2

	math = var_6
	var_55_4.enemy2Char = var_55_5(var_55_6, var_6.random(1, #var_2))

	local var_55_7 = var_0_9

	CookGameConst = var_4

	local var_55_8

	if not var_4.char_battle_data[var_0_9.enemy1Char].pet then
		CookGameConst = var_55_8

		if not var_55_8.char_battle_data[var_0_9.enemy2Char].pet then
			var_55_8 = nil
		end
	end

	var_55_7.enemyPet = var_55_8

	return
end

function var_0_1.openMenuUI(arg_56_0)
	setActive = var_1_10001
	findTF = var_1_10002

	var_1_10001(var_1_10002(arg_56_0.sceneContainer, "scene_front"), false)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_56_0.sceneContainer, "scene_background"), false)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_56_0.sceneContainer, "scene"), false)

	setActive = var_1_10001

	var_1_10001(arg_56_0.gameUI, false)

	setActive = var_1_10001

	var_1_10001(arg_56_0.menuUI, true)

	setActive = var_1_10001

	var_1_10001(arg_56_0.bg, true)
	arg_56_0:updateMenuUI()

	return
end

function var_0_1.clearUI(arg_57_0)
	setActive = var_1_10001

	var_1_10001(arg_57_0.sceneContainer, false)

	setActive = var_1_10001

	var_1_10001(arg_57_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_57_0.countUI, false)

	setActive = var_1_10001

	var_1_10001(arg_57_0.menuUI, false)

	setActive = var_1_10001

	var_1_10001(arg_57_0.gameUI, false)

	setActive = var_1_10001

	var_1_10001(arg_57_0.selectUI, false)

	return
end

function var_0_1.readyStart(arg_58_0)
	arg_58_0.readyStartFlag = true

	arg_58_0:controllerReady()

	setActive = var_1

	var_1(arg_58_0.countUI, true)

	local var_58_0 = arg_58_0.countAnimator

	var_1.Play(var_58_0, "count")

	pg = var_1

	local var_58_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_58_1, var_0_3)

	arg_58_0.readyStartFlag = false

	return
end

function var_0_1.gameStart(arg_59_0)
	setActive = var_1_10001
	findTF = var_1_10002

	var_1_10001(var_1_10002(arg_59_0.sceneContainer, "scene_front"), true)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_59_0.sceneContainer, "scene_background"), true)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_59_0.sceneContainer, "scene"), true)

	GetComponent = var_1_10001
	findTF = var_2

	local var_59_0 = var_2(arg_59_0.sceneContainer, "scene")

	typeof = var_3
	CanvasGroup = var_4

	local var_59_1 = var_1_10001(var_59_0, var_3(var_4))

	var_59_1.alpha = 1
	setActive = var_59_1

	var_59_1(arg_59_0.bg, false)

	local var_59_2 = arg_59_0.sceneContainer

	Vector2 = var_2
	var_59_2.anchoredPosition = var_2(0, 0)
	Vector2 = var_59_2
	arg_59_0.offsetPosition = var_59_2(0, 0)
	setActive = var_1

	var_1(arg_59_0.gameUI, true)

	arg_59_0.gameStartFlag = true
	arg_59_0.scoreNum = 0
	arg_59_0.otherScoreNum = 0
	arg_59_0.gameStepTime = 0
	arg_59_0.gameTime = var_0_5
	arg_59_0.extendTime = nil
	arg_59_0.waitingExtendTime = false

	if var_0_9.playerChar == 6 or var_0_9.partnerChar == 6 then
		arg_59_0.waitingExtendTime = true
	end

	for iter_59_0 = #arg_59_0.showScores, 1, -1 do
		table = var_1_10005

		if not var_1_10005.contains(arg_59_0.showScoresPool, arg_59_0.showScores[iter_59_0]) then
			table = var_1_10005
			var_1_10005 = var_1_10005.remove(arg_59_0.showScores, iter_59_0)
			table = var_6

			var_6.insert(arg_59_0.showScoresPool, var_1_10005)
		end
	end

	for iter_59_1 = #arg_59_0.showScoresPool, 1, -1 do
		setActive = var_1_10005

		var_1_10005(arg_59_0.showScoresPool[iter_59_1], false)
	end

	local function var_59_3(arg_60_0, arg_60_1)
		local var_60_0 = arg_59_0
		local var_60_1 = var_2.getCharData(var_60_0, arg_60_0, "icon")
		local var_60_2 = arg_59_0
		local var_60_3 = var_3.getCharData(var_60_2, arg_60_0, "pos")

		GetSpriteFromAtlasAsync = var_60_2

		var_60_2("ui/minigameui/" .. var_0_6, var_60_1, function(arg_61_0)
			setActive = var_3_10001

			var_3_10001(arg_60_1, true)

			setImageSprite = var_3_10001

			var_3_10001(arg_60_1, arg_61_0, true)

			return
		end)

		return
	end

	local var_59_4 = var_0_9.playerChar

	findTF = iter_59_1

	var_59_3(var_59_4, iter_59_1(arg_59_0.gameUI, "top/leftCharPos/player/img"))

	local var_59_5 = var_1
	local var_59_6 = var_0_9.partnerChar

	findTF = var_4

	var_59_5(var_59_6, var_4(arg_59_0.gameUI, "top/leftCharPos/partner/img"))

	local var_59_7 = var_1
	local var_59_8 = var_0_9.enemy1Char

	findTF = var_4

	var_59_7(var_59_8, var_4(arg_59_0.gameUI, "top/rightCharPos/enemy1/img"))

	local var_59_9 = var_1
	local var_59_10 = var_0_9.enemy2Char

	findTF = var_4

	var_59_9(var_59_10, var_4(arg_59_0.gameUI, "top/rightCharPos/enemy2/img"))
	arg_59_0:updateGameUI()
	arg_59_0:timerStart()
	arg_59_0:controllerStart()

	return
end

function var_0_1.controllerReady(arg_62_0)
	GetComponent = var_1_10001
	findTF = var_1_10002

	local var_62_0 = var_1_10002(arg_62_0.sceneContainer, "scene")

	typeof = var_3
	CanvasGroup = var_4

	local var_62_1 = var_1_10001(var_62_0, var_3(var_4))

	var_62_1.alpha = 0
	setActive = var_62_1
	findTF = var_2

	var_62_1(var_2(arg_62_0.sceneContainer, "scene"), true)

	local var_62_2 = arg_62_0.charController

	var_1.readyStart(var_62_2)

	return
end

function var_0_1.controllerStart(arg_63_0)
	local var_63_0 = arg_63_0.judgesController

	var_1.start(var_63_0)

	local var_63_1 = arg_63_0.charController

	var_1.start(var_63_1)

	return
end

function var_0_1.getGameTimes(arg_64_0)
	return arg_64_0:GetMGHubData().count
end

function var_0_1.getGameUsedTimes(arg_65_0)
	return arg_65_0:GetMGHubData().usedtime
end

function var_0_1.getUltimate(arg_66_0)
	return arg_66_0:GetMGHubData().ultimate
end

function var_0_1.getGameTotalTime(arg_67_0)
	local var_67_0 = arg_67_0:GetMGHubData()

	return (var_1.getConfig(var_67_0, "reward_need"))
end

function var_0_1.changeSpeed(arg_68_0, arg_68_1)
	if arg_68_0.judgesController then
		local var_68_0 = arg_68_0.judgesController

		var_2.changeSpeed(var_68_0, arg_68_1)
	end

	if arg_68_0.charController then
		local var_68_1 = arg_68_0.charController

		var_2.changeSpeed(var_68_1, arg_68_1)
	end

	return
end

function var_0_1.onTimer(arg_69_0)
	arg_69_0:gameStep()

	return
end

function var_0_1.gameStep(arg_70_0)
	if arg_70_0.gameTime then
		local var_70_0 = arg_70_0.gameTime

		if 3 < var_70_0 then
			local var_70_1 = arg_70_0.gameTime

			Time = var_1_10002

			if var_70_1 - var_1_10002.deltaTime < 3 and var_0_9.playerChar ~= 6 and var_0_9.playerChar ~= 6 then
				var_1_10002 = arg_70_0.judgesController

				var_1.timeUp(var_1_10002)
			end
		end
	end

	if arg_70_0.extendTime then
		local var_70_2 = arg_70_0.extendTime

		if 3 < var_70_2 then
			local var_70_3 = arg_70_0.extendTime

			Time = var_1_10002

			if var_70_3 - var_1_10002.deltaTime < 3 then
				var_1_10002 = arg_70_0.judgesController

				var_1.timeUp(var_1_10002)
			end
		end
	end

	local var_70_4 = arg_70_0.gameTime

	Time = var_1_10002
	arg_70_0.gameTime = var_70_4 - var_1_10002.deltaTime

	if arg_70_0.gameTime < 0 then
		arg_70_0.gameTime = 0
	end

	var_0_9.gameTime = arg_70_0.gameTime

	if arg_70_0.extendTime then
		local var_70_5 = arg_70_0.extendTime

		if 0 < var_70_5 then
			local var_70_6 = arg_70_0.extendTime

			Time = var_2
			arg_70_0.extendTime = var_70_6 - var_2.deltaTime

			if arg_70_0.extendTime < 0 then
				arg_70_0.extendTime = 0
			end
		end
	end

	local var_70_7 = arg_70_0.gameStepTime

	Time = var_2
	arg_70_0.gameStepTime = var_70_7 + var_2.deltaTime

	local var_70_8 = arg_70_0
	local var_70_9 = arg_70_0.controllerStep

	Time = var_1_10003

	var_70_9(var_70_8, var_1_10003.deltaTime)
	arg_70_0:updateGameUI()

	if not arg_70_0.waitingExtendTime and arg_70_0.gameTime <= 0 then
		if arg_70_0.extendTime then
			if arg_70_0.extendTime <= 0 then
				arg_70_0:onGameOver()
			end
		else
			arg_70_0:onGameOver()
		end

		return
	end

	return
end

function var_0_1.controllerStep(arg_71_0, arg_71_1)
	local var_71_0 = arg_71_0.judgesController

	var_2.step(var_71_0, arg_71_1)

	local var_71_1 = arg_71_0.charController

	var_2.step(var_71_1, arg_71_1)

	return
end

function var_0_1.timerStart(arg_72_0)
	if not arg_72_0.timer.running then
		local var_72_0 = arg_72_0.timer

		var_1.Start(var_72_0)
	end

	return
end

function var_0_1.timerStop(arg_73_0)
	if arg_73_0.timer.running then
		local var_73_0 = arg_73_0.timer

		var_1.Stop(var_73_0)
	end

	return
end

function var_0_1.updateGameUI(arg_74_0)
	setText = var_1_10001

	var_1_10001(arg_74_0.scoreTf, arg_74_0.scoreNum)

	setText = var_1_10001

	var_1_10001(arg_74_0.otherScoreTf, arg_74_0.otherScoreNum)

	if arg_74_0.extendTime and arg_74_0.extendTime > 0 then
		setText = var_1

		local var_74_0 = arg_74_0.gameTimeS

		math = var_3

		var_1(var_74_0, var_3.ceil(arg_74_0.extendTime))
	else
		setText = var_1

		local var_74_1 = arg_74_0.gameTimeS

		math = var_3

		var_1(var_74_1, var_3.ceil(arg_74_0.gameTime))
	end

	return
end

function var_0_1.addScore(arg_75_0, arg_75_1, arg_75_2)
	if arg_75_2 then
		arg_75_0.otherScoreNum = arg_75_0.otherScoreNum + arg_75_1

		if arg_75_0.otherScoreNum < 0 then
			arg_75_0.otherScoreNum = 0
		end
	else
		arg_75_0.scoreNum = arg_75_0.scoreNum + arg_75_1

		if arg_75_0.scoreNum < 0 then
			arg_75_0.scoreNum = 0
		end
	end

	return
end

function var_0_1.onGameOver(arg_76_0)
	if arg_76_0.settlementFlag then
		return
	end

	arg_76_0:timerStop()
	arg_76_0:controllerClear()

	arg_76_0.settlementFlag = true
	setActive = var_1

	var_1(arg_76_0.clickMask, true)

	LeanTween = var_1

	local var_76_0 = var_1.delayedCall

	go = var_2

	local var_76_1 = var_2(arg_76_0._tf)
	local var_76_2 = 0.1

	System = var_1_10004

	var_76_0(var_76_1, var_76_2, var_1_10004.Action(function()
		arg_76_0.settlementFlag = false

		local var_77_0 = arg_76_0

		var_77_0.gameStartFlag = false
		setActive = var_77_0

		var_77_0(arg_76_0.clickMask, false)

		local var_77_1 = arg_76_0

		var_0.showSettlement(var_77_1)

		return
	end))

	return
end

function var_0_1.showSettlement(arg_78_0)
	setActive = var_1_10001

	var_1_10001(arg_78_0.settlementUI, true)

	GetComponent = var_1_10001
	findTF = var_2

	local var_78_0 = var_2(arg_78_0.settlementUI, "ad")

	typeof = var_3
	Animator = var_4

	local var_78_1 = var_1_10001(var_78_0, var_3(var_4))

	var_1.Play(var_78_1, "settlement", -1, 0)

	local var_78_2 = arg_78_0:GetMGData()
	local var_78_3 = var_2.GetRuntimeData(var_78_2, "elements")
	local var_78_4 = arg_78_0.scoreNum
	local var_78_5

	if not var_78_3 or not (#var_78_3 > 0) or not var_78_3[1] then
		var_78_5 = 0
	end

	local var_78_6

	if not arg_78_0.otherScoreNum then
		var_78_6 = 0
	end

	setActive = var_6
	findTF = var_1_10007

	var_6(var_1_10007(arg_78_0.settlementUI, "ad/new"), var_78_5 < var_78_4)

	if var_78_5 <= var_78_4 then
		var_78_5 = var_78_4

		arg_78_0:StoreDataToServer({
			var_78_5
		})
	end

	findTF = var_6

	local var_78_7 = var_6(arg_78_0.settlementUI, "ad/highText")

	findTF = var_7

	local var_78_8 = var_7(arg_78_0.settlementUI, "ad/currentText")

	findTF = var_8

	local var_78_9 = var_8(arg_78_0.settlementUI, "ad/otherText")

	setText = var_9

	var_9(var_78_7, var_78_5)

	setText = var_9

	var_9(var_78_8, var_78_4)

	setText = var_9

	var_9(var_78_9, var_78_6)

	local var_78_10 = arg_78_0
	local var_78_11

	if arg_78_0.getGameTimes(var_78_10) then
		var_78_10 = arg_78_0
		var_78_11 = arg_78_0.getGameTimes(var_78_10)

		if 0 < var_78_11 then
			arg_78_0.sendSuccessFlag = true
			var_78_10 = arg_78_0

			arg_78_0.SendSuccess(var_78_10, 0)
		end
	end

	if var_78_6 < var_78_4 then
		setActive = var_78_11
		findTF = var_78_10

		var_78_11(var_78_10(arg_78_0.settlementUI, "ad/win"), true)

		setActive = var_78_11
		findTF = var_78_10

		var_78_11(var_78_10(arg_78_0.settlementUI, "ad/defeat"), false)
	elseif var_78_4 < var_78_6 then
		setActive = var_78_11
		findTF = var_78_10

		var_78_11(var_78_10(arg_78_0.settlementUI, "ad/win"), false)

		setActive = var_78_11
		findTF = var_78_10

		var_78_11(var_78_10(arg_78_0.settlementUI, "ad/defeat"), true)
	else
		setActive = var_78_11
		findTF = var_78_10

		var_78_11(var_78_10(arg_78_0.settlementUI, "ad/win"), false)

		setActive = var_78_11
		findTF = var_78_10

		var_78_11(var_78_10(arg_78_0.settlementUI, "ad/defeat"), false)
	end

	local var_78_12 = {}

	table = var_78_10

	var_78_10.insert(var_78_12, {
		name = "player",
		char_id = var_0_9.playerChar
	})

	table = var_10

	var_10.insert(var_78_12, {
		name = "partner",
		char_id = var_0_9.partnerChar
	})

	table = var_10

	var_10.insert(var_78_12, {
		name = "enemy1",
		char_id = var_0_9.enemy1Char
	})

	table = var_10

	var_10.insert(var_78_12, {
		name = "enemy2",
		char_id = var_0_9.enemy2Char
	})

	for iter_78_0 = 1, #var_78_12 do
		local var_78_13 = var_78_12[iter_78_0].char_id

		findTF = var_1_10015
		var_1_10015 = var_1_10015(arg_78_0.settlementUI, "ad/" .. var_78_12[iter_78_0].name)

		local var_78_14 = arg_78_0:getCharData(var_78_13, "icon")
		local var_78_15 = arg_78_0
		local var_78_16 = arg_78_0.getCharData(var_78_15, var_78_13, "pos")

		GetSpriteFromAtlasAsync = var_78_15

		var_78_15("ui/minigameui/" .. var_0_6, var_78_14, function(arg_79_0)
			findTF = var_2_10001

			local var_79_0 = var_2_10001(var_1_10015, "mask/img")

			setActive = var_2

			var_2(var_79_0, true)

			var_79_0.anchoredPosition = var_78_16
			setImageSprite = var_2

			var_2(var_79_0, arg_79_0, true)

			return
		end)
	end

	return
end

function var_0_1.OnApplicationPaused(arg_80_0)
	if not arg_80_0.gameStartFlag then
		return
	end

	if arg_80_0.readyStartFlag then
		return
	end

	if arg_80_0.settlementFlag then
		return
	end

	isActive = var_1

	if not var_1(arg_80_0.pauseUI) then
		isActive = var_1

		if var_1(arg_80_0.leaveUI) then
			return
		end

		isActive = var_1

		if not var_1(arg_80_0.pauseUI) then
			setActive = var_1

			var_1(arg_80_0.pauseUI, true)
		end

		arg_80_0:stopGame()

		return
	end
end

function var_0_1.controllerClear(arg_81_0)
	local var_81_0 = arg_81_0.judgesController

	var_1.clear(var_81_0)

	local var_81_1 = arg_81_0.charController

	var_1.clear(var_81_1)

	return
end

function var_0_1.resumeGame(arg_82_0)
	arg_82_0.gameStop = false
	setActive = var_1

	var_1(arg_82_0.leaveUI, false)
	arg_82_0:changeSpeed(1)
	arg_82_0:timerStart()

	return
end

function var_0_1.stopGame(arg_83_0)
	arg_83_0.gameStop = true

	arg_83_0:timerStop()
	arg_83_0:changeSpeed(0)

	return
end

function var_0_1.onBackPressed(arg_84_0)
	if arg_84_0.readyStartFlag then
		return
	end

	if not arg_84_0.gameStartFlag then
		arg_84_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		if arg_84_0.settlementFlag then
			return
		end

		isActive = var_1

		if var_1(arg_84_0.pauseUI) then
			setActive = var_1

			var_1(arg_84_0.pauseUI, false)
		end

		arg_84_0:stopGame()

		setActive = var_1

		var_1(arg_84_0.leaveUI, true)
	end

	return
end

function var_0_1.willExit(arg_85_0)
	if arg_85_0.handle then
		UpdateBeat = var_1
		var_1_10002 = var_1

		var_1.RemoveListener(var_1_10002, arg_85_0.handle)
	end

	if arg_85_0._tf then
		LeanTween = var_1

		local var_85_0 = var_1.isTweening

		go = var_1_10002

		if var_85_0(var_1_10002(arg_85_0._tf)) then
			LeanTween = var_1

			local var_85_1 = var_1.cancel

			go = var_2

			var_85_1(var_2(arg_85_0._tf))
		end
	end

	arg_85_0:destroyController()

	if arg_85_0.timer and arg_85_0.timer.running then
		local var_85_2 = arg_85_0.timer

		var_1.Stop(var_85_2)
	end

	local var_85_3 = arg_85_0.scrollRect.onValueChanged

	var_1.RemoveAllListeners(var_85_3)

	Time = var_1
	var_1.timeScale = 1
	arg_85_0.timer = nil

	return
end

function var_0_1.destroyController(arg_86_0)
	return
end

return var_0_1
