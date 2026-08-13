class = var_0_10000

local var_0_0 = "GameRoomCookView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))
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
	return "GameRoomCookUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	AssetBundleHelper = var_1_10002

	var_1_10002.StoreAssetBundle(var_0_9.path, false, true)

	arg_2_0.cookGameUIAtlasStored = true

	arg_2_1()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:initEvent()
	arg_3_0:initData()
	arg_3_0:initUI()
	arg_3_0:initGameUI()
	arg_3_0:initController()
	arg_3_0:updateMenuUI()
	arg_3_0:openMenuUI()

	return
end

function var_0_1.initEvent(arg_4_0)
	if not arg_4_0.uiCam then
		GameObject = var_1

		local var_4_0 = var_1.Find("UICamera")

		arg_4_0.uiCam = var_1.GetComponent(var_4_0, "Camera")
	end

	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0.bind

	CookGameView = var_1_10004

	var_4_2(var_4_1, var_1_10004.CLICK_JUDGE_EVENT, function(arg_5_0, arg_5_1, arg_5_2)
		if arg_4_0.charController then
			local var_5_0 = arg_4_0.charController

			var_3.setJudgeAction(var_5_0, arg_5_1, nil, arg_5_2)
		end

		return
	end)

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.bind

	CookGameView = var_4

	var_4_4(var_4_3, var_4.AC_CAKE_EVENT, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_4_0.charController then
			local var_6_0 = arg_4_0.charController

			var_3.createAcCake(var_6_0, arg_6_1, arg_6_2)
		end

		return
	end)

	local var_4_5 = arg_4_0
	local var_4_6 = arg_4_0.bind

	CookGameView = var_4

	var_4_6(var_4_5, var_4.SERVE_EVENT, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_7_1.serveData.battleData.id
		local var_7_1 = arg_7_1.right
		local var_7_2 = arg_7_1.pos
		local var_7_3 = arg_7_1.rate
		local var_7_4 = arg_7_1.weight
		local var_7_5 = var_7_1 and 1 or -1
		local var_7_6 = var_7_1 and 1 or 0
		local var_7_7 = arg_7_1.serveData.parameter.right_index
		local var_7_8
		local var_7_9 = var_7_0 ~= var_0_9.playerChar and var_7_0 ~= var_0_9.partnerChar and var_7_0 ~= var_0_9.partnerPet

		if not arg_7_1.serveData.battleData.weight then
			local var_7_10 = 0
		end

		if var_7_1 and arg_7_1.serveData.battleData.cake_allow then
			var_7_6 = 3
		end

		if var_7_1 and arg_7_1.serveData.battleData.score_added then
			var_7_5 = var_7_5 + arg_7_1.serveData.parameter.series_right_index - 1
		end

		if arg_7_1.serveData.battleData.random_score then
			math = var_13

			local var_7_11 = var_13.random
			local var_7_12 = 1

			CookGameConst = var_2_10016
			var_7_5 = var_7_5 * var_7_11(var_7_12, var_2_10016.random_score)
		end

		local var_7_13 = var_7_5 * var_7_3
		local var_7_14 = arg_4_0

		var_13.addScore(var_7_14, var_7_13, var_7_9)

		local var_7_15 = arg_4_0

		var_13.showScore(var_7_15, var_7_13, var_7_2, var_7_6)

		if arg_7_1.serveData.battleData.double_score == 8 then
			if var_7_1 and var_7_7 and var_7_7 % 2 == 0 then
				local var_7_16 = arg_4_0

				var_13.addScore(var_7_16, var_7_13, var_7_9)

				LeanTween = var_13

				local var_7_17 = var_13.delayedCall

				go = var_7_16

				local var_7_18 = var_7_16(arg_4_0._tf)
				local var_7_19 = 0.5

				System = var_17

				var_7_17(var_7_18, var_7_19, var_17.Action(function()
					local var_8_0 = arg_4_0

					var_0.showScore(var_8_0, var_7_13, var_7_2, 2)

					return
				end))
			end
		elseif arg_7_1.serveData.battleData.half_double and var_7_1 then
			math = var_13

			if var_13.random() > 0.5 then
				local var_7_20 = arg_4_0

				var_13.addScore(var_7_20, var_7_13, var_7_9)

				LeanTween = var_13

				local var_7_21 = var_13.delayedCall

				go = var_7_20

				local var_7_22 = var_7_20(arg_4_0._tf)
				local var_7_23 = 0.5

				System = var_17

				var_7_21(var_7_22, var_7_23, var_17.Action(function()
					local var_9_0 = arg_4_0

					var_0.showScore(var_9_0, var_7_13, var_7_2, 2)

					return
				end))
			end
		end

		return
	end)

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0.bind

	CookGameView = var_4

	var_4_8(var_4_7, var_4.EXTEND_EVENT, function(arg_10_0, arg_10_1, arg_10_2)
		if arg_4_0.judgesController then
			local var_10_0 = arg_4_0.judgesController

			var_3.extend(var_10_0)
		end

		arg_4_0.waitingExtendTime = false
		arg_4_0.extendTime = var_0_9.extend_time
		arg_4_0.gameTime = 0

		return
	end)

	return
end

function var_0_1.showScore(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_1 == 0 then
		return
	end

	local var_11_0

	if #arg_11_0.showScoresPool > 0 then
		table = var_5
		var_11_0 = var_5.remove(arg_11_0.showScoresPool, 1)
	else
		tf = var_5
		Instantiate = var_1_10007
		var_11_0 = var_5(var_1_10007(arg_11_0.showScoreTpl))
		setParent = var_5

		var_5(var_11_0, arg_11_0.sceneFrontContainer)

		GetComponent = var_5
		findTF = var_7

		local var_11_1 = var_7(var_11_0, "anim")

		typeof = var_8
		DftAniEvent = var_10

		local var_11_2 = var_5(var_11_1, var_8(var_10))

		var_5.SetEndEvent(var_11_2, function()
			for iter_12_0 = #arg_11_0.showScores, 1, -1 do
				if var_11_0 == arg_11_0.showScores[iter_12_0] then
					setActive = var_4

					var_4(var_11_0, false)

					table = var_4

					local var_12_0 = var_4.insert
					local var_12_1 = arg_11_0.showScoresPool

					table = var_7

					var_12_0(var_12_1, var_7.remove(arg_11_0.showScores, iter_12_0))
				end
			end

			return
		end)
	end

	local var_11_3 = arg_11_0.sceneFrontContainer

	var_11_0.anchoredPosition = var_5.InverseTransformPoint(var_11_3, arg_11_2)
	setText = var_5
	findTF = var_11_3

	local var_11_4 = var_11_3(var_11_0, "anim/text_sub")
	local var_11_5 = ""

	tostring = var_9

	var_5(var_11_4, var_11_5 .. var_9(arg_11_1))

	setText = var_5
	findTF = var_11_4

	local var_11_6 = var_11_4(var_11_0, "anim/text_add")
	local var_11_7 = "+"

	tostring = var_9

	var_5(var_11_6, var_11_7 .. var_9(arg_11_1))

	if 0 < arg_11_1 then
		setActive = var_5
		findTF = var_11_6

		var_5(var_11_6(var_11_0, "anim/text_sub"), false)

		setActive = var_5
		findTF = var_11_6

		var_5(var_11_6(var_11_0, "anim/text_add"), true)
	else
		setActive = var_5
		findTF = var_11_6

		var_5(var_11_6(var_11_0, "anim/text_sub"), true)

		setActive = var_5
		findTF = var_7

		var_5(var_7(var_11_0, "anim/text_add"), false)
	end

	setActive = var_5

	var_5(var_11_0, false)

	setActive = var_5

	var_5(var_11_0, true)

	table = var_5

	var_5.insert(arg_11_0.showScores, var_11_0)

	return
end

function var_0_1.onEventHandle(arg_13_0, arg_13_1)
	return
end

function var_0_1.initData(arg_14_0)
	Application = var_1_10001

	local var_14_0

	if not var_1_10001.targetFrameRate then
		var_14_0 = 60
	end

	if 60 < var_14_0 then
		var_14_0 = 60
	end

	Timer = var_2
	arg_14_0.timer = var_2.New(function()
		local var_15_0 = arg_14_0

		var_0.onTimer(var_15_0)

		return
	end, 1 / var_14_0, -1)
	arg_14_0.showScores = {}
	arg_14_0.showScoresPool = {}
	pg = var_2
	arg_14_0.dropData = var_2.mini_game[arg_14_0:GetMGData().id].simple_config_data.drop_ids
	var_0_9.playerChar = nil
	var_0_9.partnerChar = nil
	var_0_9.partnerPet = nil
	var_0_9.enemy1Char = nil
	var_0_9.enemy2Char = nil
	var_0_9.enemyPet = nil
	arg_14_0.selectPlayer = true
	arg_14_0.selectPartner = false

	return
end

function var_0_1.initUI(arg_16_0)
	findTF = var_1_10001
	arg_16_0.backSceneTf = var_1_10001(arg_16_0._tf, "scene_background")
	findTF = var_1
	arg_16_0.sceneContainer = var_1(arg_16_0._tf, "sceneMask/sceneContainer")
	findTF = var_1
	arg_16_0.sceneFrontContainer = var_1(arg_16_0._tf, "sceneMask/sceneContainer/scene_front")
	findTF = var_1
	arg_16_0.clickMask = var_1(arg_16_0._tf, "clickMask")
	findTF = var_1
	arg_16_0.bg = var_1(arg_16_0._tf, "bg")
	findTF = var_1
	arg_16_0.countUI = var_1(arg_16_0._tf, "pop/CountUI")
	GetComponent = var_1
	findTF = var_3

	local var_16_0 = var_3(arg_16_0.countUI, "count")

	typeof = var_4
	Animator = var_6
	arg_16_0.countAnimator = var_1(var_16_0, var_4(var_6))
	GetOrAddComponent = var_1
	findTF = var_16_0

	local var_16_1 = var_16_0(arg_16_0.countUI, "count")

	typeof = var_4
	DftAniEvent = var_6
	arg_16_0.countDft = var_1(var_16_1, var_4(var_6))

	local var_16_2 = arg_16_0.countDft

	var_1.SetTriggerEvent(var_16_2, function()
		return
	end)

	local var_16_3 = arg_16_0.countDft

	var_1.SetEndEvent(var_16_3, function()
		setActive = var_2_10000

		var_2_10000(arg_16_0.countUI, false)

		local var_18_0 = arg_16_0

		var_0.gameStart(var_18_0)

		return
	end)

	findTF = var_1
	arg_16_0.leaveUI = var_1(arg_16_0._tf, "pop/LeaveUI")
	onButton = var_1

	local var_16_4 = arg_16_0

	findTF = var_4

	local var_16_5 = var_4(arg_16_0.leaveUI, "ad/btnOk")

	local function var_16_6()
		local var_19_0 = arg_16_0

		var_0.resumeGame(var_19_0)

		local var_19_1 = arg_16_0

		var_0.onGameOver(var_19_1)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_16_4, var_16_5, var_16_6, var_6)

	onButton = var_1

	local var_16_7 = arg_16_0

	findTF = var_16_5

	local var_16_8 = var_16_5(arg_16_0.leaveUI, "ad/btnCancel")

	local function var_16_9()
		local var_20_0 = arg_16_0

		var_0.resumeGame(var_20_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_16_7, var_16_8, var_16_9, var_6)

	setActive = var_1

	var_1(arg_16_0.leaveUI, false)

	findTF = var_1
	arg_16_0.pauseUI = var_1(arg_16_0._tf, "pop/pauseUI")
	onButton = var_1

	local var_16_10 = arg_16_0

	findTF = var_4

	local var_16_11 = var_4(arg_16_0.pauseUI, "ad/btnOk")

	local function var_16_12()
		setActive = var_2_10000

		var_2_10000(arg_16_0.pauseUI, false)

		local var_21_0 = arg_16_0

		var_0.resumeGame(var_21_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_16_10, var_16_11, var_16_12, var_6)

	findTF = var_1
	arg_16_0.settlementUI = var_1(arg_16_0._tf, "pop/SettleMentUI")
	onButton = var_1

	local var_16_13 = arg_16_0

	findTF = var_4

	local var_16_14 = var_4(arg_16_0.settlementUI, "ad/btnOver")

	local function var_16_15()
		setActive = var_2_10000

		var_2_10000(arg_16_0.settlementUI, false)

		local var_22_0 = arg_16_0

		var_0.openMenuUI(var_22_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_16_13, var_16_14, var_16_15, var_6)

	setActive = var_1

	var_1(arg_16_0.settlementUI, false)

	findTF = var_1
	arg_16_0.menuUI = var_1(arg_16_0._tf, "pop/menuUI")
	GetComponent = var_1
	findTF = var_3

	local var_16_16 = var_3(arg_16_0.menuUI, "battList")

	typeof = var_4
	ScrollRect = var_6
	arg_16_0.battleScrollRect = var_1(var_16_16, var_4(var_6))
	arg_16_0.totalTimes = arg_16_0:getGameTotalTime()

	local var_16_17 = arg_16_0:getGameUsedTimes() - 4 < 0 and 0 or arg_16_0:getGameUsedTimes() - 4

	scrollTo = var_2

	var_2(arg_16_0.battleScrollRect, 0, 1 - var_16_17 / (arg_16_0.totalTimes - 4))

	onButton = var_2

	local var_16_18 = arg_16_0

	findTF = var_5

	local var_16_19 = var_5(arg_16_0.menuUI, "rightPanelBg/arrowUp")

	local function var_16_20()
		local var_23_0 = arg_16_0.battleScrollRect.normalizedPosition.y + 1 / (arg_16_0.totalTimes - 4)

		if 1 < var_23_0 then
			var_23_0 = 1
		end

		scrollTo = var_1

		var_1(arg_16_0.battleScrollRect, 0, var_23_0)

		return
	end

	SFX_CANCEL = var_7

	var_2(var_16_18, var_16_19, var_16_20, var_7)

	onButton = var_2

	local var_16_21 = arg_16_0

	findTF = var_16_19

	local var_16_22 = var_16_19(arg_16_0.menuUI, "rightPanelBg/arrowDown")

	local function var_16_23()
		local var_24_0

		if arg_16_0.battleScrollRect.normalizedPosition.y - 1 / (arg_16_0.totalTimes - 4) < 0 then
			var_24_0 = 0
		end

		scrollTo = var_1

		var_1(arg_16_0.battleScrollRect, 0, var_24_0)

		return
	end

	SFX_CANCEL = var_7

	var_2(var_16_21, var_16_22, var_16_23, var_7)

	onButton = var_2

	local var_16_24 = arg_16_0

	findTF = var_16_22

	local var_16_25 = var_16_22(arg_16_0.menuUI, "adButton/btnBack")

	local function var_16_26()
		local var_25_0 = arg_16_0

		var_0.closeView(var_25_0)

		return
	end

	SFX_CANCEL = var_7

	var_2(var_16_24, var_16_25, var_16_26, var_7)

	onButton = var_2

	local var_16_27 = arg_16_0

	findTF = var_16_25

	local var_16_28 = var_16_25(arg_16_0.menuUI, "btnRule")

	local function var_16_29()
		pg = var_2_10000

		local var_26_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_26_1 = var_0.ShowMsgBox
		local var_26_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_26_2.type = var_2_10004

		local var_26_3 = arg_16_0

		var_26_2.helps = var_4.getGameRoomData(var_26_3).game_help

		var_26_1(var_26_0, var_26_2)

		return
	end

	SFX_CANCEL = var_7

	var_2(var_16_27, var_16_28, var_16_29, var_7)

	onButton = var_2

	local var_16_30 = arg_16_0

	findTF = var_16_28

	local var_16_31 = var_16_28(arg_16_0.menuUI, "btnStart")

	local function var_16_32()
		setActive = var_2_10000

		var_2_10000(arg_16_0.menuUI, false)

		local var_27_0 = arg_16_0

		var_0.openCoinLayer(var_27_0, false)

		local var_27_1 = arg_16_0

		var_0.openSelectUI(var_27_1)

		return
	end

	SFX_CANCEL = var_16_34

	var_2(var_16_30, var_16_31, var_16_32, var_16_34)

	findTF = var_2

	local var_16_33 = var_2(arg_16_0.menuUI, "tplBattleItem")

	arg_16_0.battleItems = {}
	arg_16_0.dropItems = {}

	for iter_16_0 = 1, 7 do
		tf = var_16_34
		instantiate = var_1_10009

		local var_16_34 = var_16_34(var_1_10009(var_16_33))

		var_16_34.name = "battleItem_" .. iter_16_0
		setParent = var_8

		local var_16_35 = var_16_34

		findTF = var_1_10011

		var_8(var_16_35, var_1_10011(arg_16_0.menuUI, "battList/Viewport/Content"))

		local var_16_36 = iter_16_0

		GetSpriteFromAtlasAsync = var_1_10009

		var_1_10009("ui/minigameui/" .. var_0_6, "battleDesc" .. var_16_36, function(arg_28_0)
			if arg_28_0 then
				setImageSprite = var_2_10001
				findTF = var_2_10003

				var_2_10001(var_2_10003(var_16_34, "state_open/desc"), arg_28_0, true)

				setImageSprite = var_2_10001
				findTF = var_3

				var_2_10001(var_3(var_16_34, "state_clear/desc"), arg_28_0, true)

				setImageSprite = var_2_10001
				findTF = var_3

				var_2_10001(var_3(var_16_34, "state_current/desc"), arg_28_0, true)

				setImageSprite = var_2_10001
				findTF = var_3

				var_2_10001(var_3(var_16_34, "state_closed/desc"), arg_28_0, true)
			end

			return
		end)

		findTF = var_1_10009
		var_1_10009 = var_1_10009(var_16_34, "icon")

		local var_16_37 = {
			type = arg_16_0.dropData[iter_16_0][1],
			id = arg_16_0.dropData[iter_16_0][2],
			amount = arg_16_0.dropData[iter_16_0][3]
		}

		updateDrop = var_1_10011

		var_1_10011(var_1_10009, var_16_37)

		onButton = var_1_10011

		local var_16_38 = arg_16_0
		local var_16_39 = var_1_10009

		local function var_16_40()
			local var_29_0 = arg_16_0
			local var_29_1 = var_0.emit

			BaseUI = var_2_10003

			var_29_1(var_29_0, var_2_10003.ON_DROP, var_16_37)

			return
		end

		SFX_PANEL = var_1_10016

		var_1_10011(var_16_38, var_16_39, var_16_40, var_1_10016)

		table = var_1_10011

		var_1_10011.insert(arg_16_0.dropItems, var_1_10009)

		setActive = var_1_10011

		var_1_10011(var_16_34, true)

		table = var_1_10011

		var_1_10011.insert(arg_16_0.battleItems, var_16_34)
	end

	findTF = var_3
	arg_16_0.selectUI = var_3(arg_16_0._tf, "pop/selectUI")
	findTF = var_3
	arg_16_0.selectCharTpl = var_3(arg_16_0.selectUI, "ad/charTpl")
	setActive = var_3

	var_3(arg_16_0.selectCharTpl, false)

	findTF = var_3
	arg_16_0.selectCharsContainer = var_3(arg_16_0.selectUI, "ad/chars/Viewport/Content")
	arg_16_0.selectCharId = nil
	arg_16_0.selectChars = {}
	CookGameConst = var_3

	local var_16_41 = #var_3.char_ids

	findTF = var_4

	local var_16_42 = var_4(arg_16_0.selectUI, "ad/charDetail")

	arg_16_0.detailDescPositons = {}

	for iter_16_1 = 1, var_16_41 do
		CookGameConst = var_1_10009
		var_1_10009 = var_1_10009.char_ids[iter_16_1]

		local var_16_43 = arg_16_0
		local var_16_44 = arg_16_0.getCharDataById(var_16_43, var_1_10009)

		tf = var_1_10011
		instantiate = var_13
		var_1_10011 = var_1_10011(var_13(arg_16_0.selectCharTpl))
		setParent = var_16_43

		var_16_43(var_1_10011, arg_16_0.selectCharsContainer)

		local var_16_47

		if var_16_44 then
			var_16_43 = var_16_44.icon

			local var_16_45 = var_16_44.pos

			pg = var_14

			local var_16_46 = var_14.gametip[var_16_44.desc].tip

			pg = var_16_47
			var_16_47 = var_16_47.ship_data_statistics[var_16_44.ship_id].name
			setScrollText = var_16
			findTF = var_1_10018

			var_16(var_1_10018(var_1_10011, "name/text"), var_16_47)

			setActive = var_16
			findTF = var_1_10018

			var_16(var_1_10018(var_1_10011, "desc"), false)

			setActive = var_16
			findTF = var_1_10018

			var_16(var_1_10018(var_1_10011, "desc_en"), false)

			PLATFORM_CODE = var_16
			PLATFORM_US = var_1_10017

			if var_16 == var_1_10017 then
				setActive = var_16
				findTF = var_1_10018

				var_16(var_1_10018(var_1_10011, "desc_en"), true)

				setText = var_16
				findTF = var_1_10018

				var_16(var_1_10018(var_1_10011, "desc_en"), var_16_46)
			else
				setActive = var_16
				findTF = var_1_10018

				var_16(var_1_10018(var_1_10011, "desc"), true)

				setText = var_16
				findTF = var_1_10018

				var_16(var_1_10018(var_1_10011, "desc"), var_16_46)
			end

			findTF = var_16

			local var_16_48 = var_16(var_1_10011, "detailDesc")

			setActive = var_1_10017

			var_1_10017(var_16_48, false)

			if var_16_44.detail_name then
				var_1_10017 = arg_16_0.detailDescPositons
				var_1_10017[var_16_44.detail_name] = var_16_48.anchoredPosition
				setText = var_1_10017
				findTF = var_19

				local var_16_49 = var_19(var_16_48, "name")

				i18n = var_20

				var_1_10017(var_16_49, var_20(var_16_44.detail_name))

				setText = var_1_10017
				findTF = var_16_49

				local var_16_50 = var_16_49(var_16_48, "desc")

				i18n = var_20

				var_1_10017(var_16_50, var_20(var_16_44.detail_desc))

				setActive = var_1_10017
				findTF = var_16_50

				var_1_10017(var_16_50(var_1_10011, "clickDesc"), true)

				onButton = var_1_10017

				local var_16_51 = arg_16_0

				findTF = var_20

				var_1_10017(var_16_51, var_20(var_1_10011, "clickDesc"), function()
					isActive = var_2_10000

					local var_30_0 = var_2_10000(var_16_48)
					local var_30_1

					if not var_30_0 then
						local var_30_2 = var_16_42

						var_30_1 = var_2.InverseTransformPoint(var_30_2, var_16_48.position)
						setParent = var_2

						var_2(var_16_48, var_16_42)

						arg_16_0.detailDescTf = var_16_48
						arg_16_0.detailDescContent = var_1_10011
						arg_16_0.detailDescName = var_16_44.detail_name
					else
						var_30_1 = arg_16_0.detailDescPositons[var_16_44.detail_name]
						setParent = var_2

						var_2(var_16_48, var_1_10011)

						arg_16_0.detailDescTf = nil
						arg_16_0.detailDescContent = nil
						arg_16_0.detailDescName = nil
					end

					local var_30_3 = var_16_48

					var_30_3.anchoredPosition = var_30_1
					setActive = var_30_3

					var_30_3(var_16_48, not var_30_0)

					return
				end)
			end

			GetSpriteFromAtlasAsync = var_1_10017

			var_1_10017("ui/minigameui/" .. var_0_6, var_16_43, function(arg_31_0)
				findTF = var_2_10001

				local var_31_0 = var_2_10001(var_1_10011, "icon/img")

				setActive = var_2_10002

				var_2_10002(var_31_0, true)

				var_31_0.anchoredPosition = var_16_45
				setImageSprite = var_2

				var_2(var_31_0, arg_31_0, true)

				return
			end)

			setActive = var_1_10017
			findTF = var_19

			var_1_10017(var_19(var_1_10011, "selected"), false)

			onButton = var_1_10017

			local var_16_52 = arg_16_0

			findTF = var_20

			local var_16_53 = var_20(var_1_10011, "click")

			local function var_16_54()
				local var_32_0 = arg_16_0

				var_0.selectChar(var_32_0, var_16_44.id)

				return
			end

			SFX_PANEL = var_22

			var_1_10017(var_16_52, var_16_53, var_16_54, var_22)
		else
			GetComponent = var_16_43

			local var_16_55 = var_1_10011

			typeof = var_16_47
			CanvasGroup = var_1_10017
			var_16_43 = var_16_43(var_16_55, var_16_47(var_1_10017))
			var_16_43.alpha = 0
		end

		setActive = var_16_43

		var_16_43(var_1_10011, true)

		table = var_16_43

		var_16_43.insert(arg_16_0.selectChars, {
			data = var_16_44,
			tf = var_1_10011
		})
	end

	findTF = var_5
	arg_16_0.playerTf = var_5(arg_16_0.selectUI, "ad/player")
	findTF = var_5
	arg_16_0.partnerTf = var_5(arg_16_0.selectUI, "ad/partner")
	findTF = var_5
	arg_16_0.selectClickTf = var_5(arg_16_0.selectUI, "ad/click")
	setActive = var_5

	var_5(arg_16_0.selectClickTf, false)

	onButton = var_5

	local var_16_56 = arg_16_0

	findTF = var_8

	local var_16_57 = var_8(arg_16_0.selectUI, "ad/btnStart")

	local function var_16_58()
		if var_0_9.playerChar and var_0_9.partnerChar then
			local var_33_0 = arg_16_0

			var_0.randomAIShip(var_33_0)

			setActive = var_0

			var_0(arg_16_0.selectUI, false)

			local var_33_1 = arg_16_0

			var_0.readyStart(var_33_1)
		end

		return
	end

	SFX_PANEL = var_10

	var_5(var_16_56, var_16_57, var_16_58, var_10)

	onButton = var_5

	local var_16_59 = arg_16_0

	findTF = var_16_57

	local var_16_60 = var_16_57(arg_16_0.selectUI, "ad/player")

	local function var_16_61()
		arg_16_0.selectPlayer = true
		arg_16_0.selectPartner = false

		local var_34_0 = arg_16_0

		var_0.updateSelectUI(var_34_0)

		return
	end

	SFX_PANEL = var_10

	var_5(var_16_59, var_16_60, var_16_61, var_10)

	onButton = var_5

	local var_16_62 = arg_16_0

	findTF = var_16_60

	local var_16_63 = var_16_60(arg_16_0.selectUI, "ad/partner")

	local function var_16_64()
		arg_16_0.selectPlayer = false
		arg_16_0.selectPartner = true

		local var_35_0 = arg_16_0

		var_0.updateSelectUI(var_35_0)

		return
	end

	SFX_PANEL = var_10

	var_5(var_16_62, var_16_63, var_16_64, var_10)

	onButton = var_5

	local var_16_65 = arg_16_0

	findTF = var_16_63

	local var_16_66 = var_16_63(arg_16_0.selectUI, "ad/back")

	local function var_16_67()
		setActive = var_2_10000

		var_2_10000(arg_16_0.selectUI, false)

		local var_36_0 = arg_16_0

		var_0.openMenuUI(var_36_0)

		return
	end

	SFX_PANEL = var_10

	var_5(var_16_65, var_16_66, var_16_67, var_10)

	math = var_5
	arg_16_0.pageMax = var_5.ceil(var_16_41 / var_0_8) - 1
	arg_16_0.curPageIndex = 0
	arg_16_0.scrollNum = 1 / arg_16_0.pageMax
	GetComponent = var_5
	findTF = var_7

	local var_16_68 = var_7(arg_16_0.selectUI, "ad/chars")

	typeof = var_16_66
	ScrollRect = var_10
	arg_16_0.scrollRect = var_5(var_16_68, var_16_66(var_10))

	local var_16_69 = arg_16_0.scrollRect

	Vector2 = var_6
	var_16_69.normalizedPosition = var_6(0, 0)

	local var_16_70 = arg_16_0.scrollRect.onValueChanged
	local var_16_71 = var_5.Invoke

	Vector2 = var_8

	var_16_71(var_16_70, var_8(0, 0))

	local var_16_72 = arg_16_0.scrollRect

	Vector2 = var_6
	var_16_72.normalizedPosition = var_6(0, 0)

	local var_16_73 = arg_16_0.scrollRect.onValueChanged
	local var_16_74 = var_5.Invoke

	Vector2 = var_8

	var_16_74(var_16_73, var_8(0, 0))

	GetOrAddComponent = var_16_74
	findTF = var_16_73

	local var_16_75 = var_16_73(arg_16_0.selectUI, "ad/chars")

	typeof = var_8
	EventTriggerListener = var_10

	local var_16_76 = var_16_74(var_16_75, var_8(var_10))

	var_5.AddPointDownFunc(var_16_76, function(arg_37_0, arg_37_1)
		return
	end)

	local var_16_77 = arg_16_0.scrollRect.onValueChanged

	var_6.AddListener(var_16_77, function(arg_38_0, arg_38_1, arg_38_2)
		if arg_16_0.detailDescTf then
			setActive = var_3

			var_3(arg_16_0.detailDescTf, false)

			setParent = var_3

			var_3(arg_16_0.detailDescTf, arg_16_0.detailDescContent)

			arg_16_0.detailDescTf.anchoredPosition = arg_16_0.detailDescPositons[arg_16_0.detailDescName]
			arg_16_0.detailDescTf = nil
			arg_16_0.detailDescContent = nil
			arg_16_0.detailDescName = nil
		end

		return
	end)

	onButton = var_6

	local var_16_78 = arg_16_0

	findTF = var_9

	local var_16_79 = var_9(arg_16_0.selectUI, "ad/next")

	local function var_16_80()
		arg_16_0.curPageIndex = arg_16_0.curPageIndex + arg_16_0.scrollNum

		local var_39_0 = arg_16_0.curPageIndex

		if 1 < var_39_0 then
			arg_16_0.curPageIndex = 1
		end

		local var_39_1 = arg_16_0.scrollRect

		Vector2 = var_1
		var_39_1.normalizedPosition = var_1(arg_16_0.curPageIndex, 0)

		local var_39_2 = arg_16_0.scrollRect.onValueChanged
		local var_39_3 = var_0.Invoke

		Vector2 = var_3

		var_39_3(var_39_2, var_3(arg_16_0.curPageIndex, 0))

		return
	end

	SFX_PANEL = var_11

	var_6(var_16_78, var_16_79, var_16_80, var_11)

	onButton = var_6

	local var_16_81 = arg_16_0

	findTF = var_16_79

	local var_16_82 = var_16_79(arg_16_0.selectUI, "ad/pre")

	local function var_16_83()
		arg_16_0.curPageIndex = arg_16_0.curPageIndex - arg_16_0.scrollNum

		if arg_16_0.curPageIndex < 0 then
			arg_16_0.curPageIndex = 0
		end

		local var_40_0 = arg_16_0.scrollRect

		Vector2 = var_1
		var_40_0.normalizedPosition = var_1(arg_16_0.curPageIndex, 0)

		local var_40_1 = arg_16_0.scrollRect.onValueChanged
		local var_40_2 = var_0.Invoke

		Vector2 = var_3

		var_40_2(var_40_1, var_3(arg_16_0.curPageIndex, 0))

		return
	end

	SFX_PANEL = var_11

	var_6(var_16_81, var_16_82, var_16_83, var_11)

	setActive = var_6

	var_6(arg_16_0.selectUI, false)

	local var_16_84

	if not arg_16_0.handle then
		IsUnityEditor = var_6

		if var_6 then
			UpdateBeat = var_6
			var_16_84 = var_6
			arg_16_0.handle = var_6.CreateListener(var_16_84, arg_16_0.Update, arg_16_0)
			UpdateBeat = var_6
			var_16_84 = var_6

			var_6.AddListener(var_16_84, arg_16_0.handle)
		end
	end

	GetComponent = var_6
	findTF = var_16_84

	local var_16_85 = var_16_84(arg_16_0.selectUI, "ad/playerDesc")

	typeof = var_9
	Image = var_11

	local var_16_86 = var_6(var_16_85, var_9(var_11))

	var_6.SetNativeSize(var_16_86)

	GetComponent = var_6
	findTF = var_16_86

	local var_16_87 = var_16_86(arg_16_0.selectUI, "ad/partnerDesc")

	typeof = var_9
	Image = var_11

	local var_16_88 = var_6(var_16_87, var_9(var_11))

	var_6.SetNativeSize(var_16_88)

	GetComponent = var_6
	findTF = var_16_88

	local var_16_89 = var_16_88(arg_16_0.pauseUI, "ad/desc")

	typeof = var_9
	Image = var_11

	local var_16_90 = var_6(var_16_89, var_9(var_11))

	var_6.SetNativeSize(var_16_90)

	GetComponent = var_6
	findTF = var_16_90

	local var_16_91 = var_16_90(arg_16_0.leaveUI, "ad/desc")

	typeof = var_9
	Image = var_11

	local var_16_92 = var_6(var_16_91, var_9(var_11))

	var_6.SetNativeSize(var_16_92)

	return
end

function var_0_1.initGameUI(arg_41_0)
	findTF = var_1_10001
	arg_41_0.gameUI = var_1_10001(arg_41_0._tf, "ui/gameUI")
	findTF = var_1
	arg_41_0.showScoreTpl = var_1(arg_41_0.sceneFrontContainer, "score")
	setActive = var_1

	var_1(arg_41_0.showScoreTpl, false)

	onButton = var_1

	local var_41_0 = arg_41_0

	findTF = var_4

	var_1(var_41_0, var_4(arg_41_0.gameUI, "topRight/btnStop"), function()
		local var_42_0 = arg_41_0

		var_0.stopGame(var_42_0)

		setActive = var_0

		var_0(arg_41_0.pauseUI, true)

		return
	end)

	onButton = var_1

	local var_41_1 = arg_41_0

	findTF = var_4

	var_1(var_41_1, var_4(arg_41_0.gameUI, "btnLeave"), function()
		local var_43_0 = arg_41_0

		var_0.stopGame(var_43_0)

		setActive = var_0

		var_0(arg_41_0.leaveUI, true)

		return
	end)

	findTF = var_1
	arg_41_0.gameTimeS = var_1(arg_41_0.gameUI, "top/time/s")
	findTF = var_1
	arg_41_0.scoreTf = var_1(arg_41_0.gameUI, "top/score")
	findTF = var_1
	arg_41_0.otherScoreTf = var_1(arg_41_0.gameUI, "top/otherScore")

	return
end

function var_0_1.initController(arg_44_0)
	CookGameJudgesController = var_1_10001
	arg_44_0.judgesController = var_1_10001.New(arg_44_0.sceneContainer, var_0_9, arg_44_0)
	findTF = var_1

	local var_44_0 = var_1(arg_44_0.sceneContainer, "scene_background/charTpl")

	setActive = var_1_10002

	var_1_10002(var_44_0, false)

	CookGameCharController = var_1_10002
	arg_44_0.charController = var_1_10002.New(arg_44_0.sceneContainer, var_0_9, arg_44_0)

	return
end

function var_0_1.Update(arg_45_0)
	arg_45_0:AddDebugInput()

	return
end

function var_0_1.AddDebugInput(arg_46_0)
	if arg_46_0.gameStop or arg_46_0.settlementFlag then
		return
	end

	IsUnityEditor = var_1

	if var_1 then
		Input = var_1

		local var_46_0 = var_1.GetKeyDown

		KeyCode = var_1_10003

		if var_46_0(var_1_10003.S) then
			-- block empty
		end
	end

	return
end

function var_0_1.updateMenuUI(arg_47_0)
	local var_47_0 = arg_47_0:getGameUsedTimes()
	local var_47_1 = arg_47_0:getGameTimes()

	for iter_47_0 = 1, #arg_47_0.battleItems do
		setActive = var_1_10007
		findTF = var_1_10009

		var_1_10007(var_1_10009(arg_47_0.battleItems[iter_47_0], "state_open"), false)

		setActive = var_1_10007
		findTF = var_1_10009

		var_1_10007(var_1_10009(arg_47_0.battleItems[iter_47_0], "state_closed"), false)

		setActive = var_1_10007
		findTF = var_1_10009

		var_1_10007(var_1_10009(arg_47_0.battleItems[iter_47_0], "state_clear"), false)

		setActive = var_1_10007
		findTF = var_1_10009

		var_1_10007(var_1_10009(arg_47_0.battleItems[iter_47_0], "state_current"), false)

		if iter_47_0 <= var_47_0 then
			SetParent = var_1_10007
			var_1_10009 = arg_47_0.dropItems[iter_47_0]
			findTF = var_10

			var_1_10007(var_1_10009, var_10(arg_47_0.battleItems[iter_47_0], "state_clear/icon"))

			setActive = var_1_10007

			var_1_10007(arg_47_0.dropItems[iter_47_0], true)

			setActive = var_1_10007
			findTF = var_1_10009

			var_1_10007(var_1_10009(arg_47_0.battleItems[iter_47_0], "state_clear"), true)
		elseif iter_47_0 == var_47_0 + 1 and 1 <= var_47_1 then
			setActive = var_1_10007
			findTF = var_1_10009

			var_1_10007(var_1_10009(arg_47_0.battleItems[iter_47_0], "state_current"), true)

			SetParent = var_1_10007
			var_1_10009 = arg_47_0.dropItems[iter_47_0]
			findTF = var_10

			var_1_10007(var_1_10009, var_10(arg_47_0.battleItems[iter_47_0], "state_current/icon"))

			setActive = var_1_10007

			var_1_10007(arg_47_0.dropItems[iter_47_0], true)
		elseif var_47_0 < iter_47_0 and iter_47_0 <= var_47_0 + var_47_1 then
			setActive = var_1_10007
			findTF = var_1_10009

			var_1_10007(var_1_10009(arg_47_0.battleItems[iter_47_0], "state_open"), true)

			SetParent = var_1_10007
			var_1_10009 = arg_47_0.dropItems[iter_47_0]
			findTF = var_10

			var_1_10007(var_1_10009, var_10(arg_47_0.battleItems[iter_47_0], "state_open/icon"))

			setActive = var_1_10007

			var_1_10007(arg_47_0.dropItems[iter_47_0], true)
		else
			setActive = var_1_10007
			findTF = var_1_10009

			var_1_10007(var_1_10009(arg_47_0.battleItems[iter_47_0], "state_closed"), true)

			SetParent = var_1_10007
			var_1_10009 = arg_47_0.dropItems[iter_47_0]
			findTF = var_10

			var_1_10007(var_1_10009, var_10(arg_47_0.battleItems[iter_47_0], "state_closed/icon"))

			setActive = var_1_10007

			var_1_10007(arg_47_0.dropItems[iter_47_0], true)
		end
	end

	arg_47_0.totalTimes = arg_47_0:getGameTotalTime()

	local var_47_2 = 1 - (arg_47_0:getGameUsedTimes() - 3 < 0 and 0 or arg_47_0:getGameUsedTimes() - 3) / (arg_47_0.totalTimes - 4)

	if 1 < var_47_2 then
		var_47_2 = 1
	end

	scrollTo = var_5

	var_5(arg_47_0.battleScrollRect, 0, var_47_2)

	setActive = var_5
	findTF = var_7

	var_5(var_7(arg_47_0.menuUI, "btnStart/tip"), var_47_1 > 0)
	arg_47_0:CheckGet()

	return
end

function var_0_1.CheckGet(arg_48_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_48_0.menuUI, "got"), false)

	if arg_48_0:getUltimate() then
		local var_48_0 = arg_48_0

		if arg_48_0.getUltimate(var_48_0) ~= 0 then
			setActive = var_1
			findTF = var_48_0

			var_1(var_48_0(arg_48_0.menuUI, "got"), true)
		end
	end

	if arg_48_0:getUltimate() == 0 then
		local var_48_1 = arg_48_0

		if arg_48_0.getGameTotalTime(var_48_1) > arg_48_0:getGameUsedTimes() then
			return
		end

		pg = var_48_1

		local var_48_2 = var_48_1.m02
		local var_48_3 = var_3.sendNotification

		GAME = var_6

		local var_48_4 = var_6.SEND_MINI_GAME_OP
		local var_48_5 = {
			hubid = arg_48_0:GetMGHubData().id
		}

		MiniGameOPCommand = var_8
		var_48_5.cmd = var_8.CMD_ULTIMATE
		var_48_5.args1 = {}

		var_48_3(var_48_2, var_48_4, var_48_5)

		setActive = var_48_3
		findTF = var_48_2

		var_48_3(var_48_2(arg_48_0.menuUI, "got"), true)
	end

	return
end

function var_0_1.openSelectUI(arg_49_0)
	setActive = var_1_10001

	var_1_10001(arg_49_0.selectUI, true)

	arg_49_0.selectPlayer = true
	arg_49_0.selectPartner = false

	arg_49_0:updateSelectUI()

	return
end

function var_0_1.updateSelectUI(arg_50_0)
	if var_0_9.playerChar then
		findTF = var_1_10002
		var_1_10002 = var_1_10002(arg_50_0.selectUI, "ad/player/icon/img")
		var_1_10005 = arg_50_0
		var_1_10003 = arg_50_0.getCharData(var_1_10005, var_1, "icon")
		var_1_10004 = arg_50_0:getCharData(var_1, "pos")
		GetSpriteFromAtlasAsync = var_1_10005

		var_1_10005("ui/minigameui/" .. var_0_6, var_1_10003, function(arg_51_0)
			local var_51_0 = var_1_10002

			var_51_0.anchoredPosition = var_1_10004
			setActive = var_51_0

			var_51_0(var_1_10002, true)

			setImageSprite = var_51_0

			var_51_0(var_1_10002, arg_51_0, true)

			return
		end)
	else
		setActive = var_1_10002
		findTF = var_1_10004

		var_1_10002(var_1_10004(arg_50_0.selectUI, "ad/player/icon/img"), false)
	end

	if var_0_9.partnerChar then
		findTF = var_1_10003
		var_1_10003 = var_1_10003(arg_50_0.selectUI, "ad/partner/icon/img")

		local var_50_0 = arg_50_0
		local var_50_1 = arg_50_0.getCharData(var_50_0, var_2, "icon")

		var_1_10005 = arg_50_0:getCharData(var_2, "pos")
		GetSpriteFromAtlasAsync = var_50_0

		var_50_0("ui/minigameui/" .. var_0_6, var_50_1, function(arg_52_0)
			local var_52_0 = var_1_10003

			var_52_0.anchoredPosition = var_1_10005
			setActive = var_52_0

			var_52_0(var_1_10003, true)

			setImageSprite = var_52_0

			var_52_0(var_1_10003, arg_52_0, true)

			return
		end)
	else
		setActive = var_1_10003
		findTF = var_1_10005

		var_1_10003(var_1_10005(arg_50_0.selectUI, "ad/partner/icon/img"), false)
	end

	if arg_50_0.selectPlayer then
		setActive = var_3
		findTF = var_1_10005

		var_3(var_1_10005(arg_50_0.selectUI, "ad/player/selected"), true)

		setActive = var_3
		findTF = var_1_10005

		var_3(var_1_10005(arg_50_0.selectUI, "ad/partner/selected"), false)
	elseif arg_50_0.selectPartner then
		setActive = var_3
		findTF = var_1_10005

		var_3(var_1_10005(arg_50_0.selectUI, "ad/player/selected"), false)

		setActive = var_3
		findTF = var_5

		var_3(var_5(arg_50_0.selectUI, "ad/partner/selected"), true)
	end

	return
end

function var_0_1.selectChar(arg_53_0, arg_53_1)
	arg_53_0.selectCharId = arg_53_1

	for iter_53_0 = 1, #arg_53_0.selectChars do
		if arg_53_0.selectChars[iter_53_0].data then
			local var_53_0 = arg_53_0.selectChars[iter_53_0].tf

			if var_6.id == arg_53_1 then
				setActive = var_8
				findTF = var_1_10010

				var_8(var_1_10010(var_53_0, "selected"), true)
			else
				setActive = var_8
				findTF = var_1_10010

				var_8(var_1_10010(var_53_0, "selected"), false)
			end
		end
	end

	if arg_53_0.selectPlayer then
		if var_0_9.partnerChar and var_0_9.partnerChar == arg_53_1 then
			local var_53_1 = var_0_9
			local var_53_2

			if not var_0_9.playerChar then
				var_53_2 = nil
			end

			var_53_1.partnerChar = var_53_2
		end

		var_0_9.playerChar = arg_53_1

		if not var_0_9.partnerChar then
			arg_53_0.selectPlayer = false
			arg_53_0.selectPartner = true
		end
	elseif arg_53_0.selectPartner then
		if var_0_9.playerChar and var_0_9.playerChar == arg_53_1 then
			var_0_9.playerChar = var_0_9.partnerChar
		end

		var_0_9.partnerChar = arg_53_1

		if not var_0_9.playerChar then
			arg_53_0.selectPlayer = true
			arg_53_0.selectPartner = false
		end
	end

	if var_0_9.playerChar then
		CookGameConst = var_2

		if var_2.char_battle_data[var_0_9.playerChar].pet then
			local var_53_3 = var_0_9

			CookGameConst = var_3
			var_53_3.partnerPet = var_3.char_battle_data[var_0_9.playerChar].pet

			goto label_53_0
		end
	end

	if var_0_9.partnerChar then
		CookGameConst = var_2

		if var_2.char_battle_data[var_0_9.partnerChar].pet then
			local var_53_4 = var_0_9

			CookGameConst = var_3
			var_53_4.partnerPet = var_3.char_battle_data[var_0_9.partnerChar].pet

			goto label_53_0
		end
	end

	var_0_9.partnerPet = nil

	::label_53_0::

	arg_53_0:updateSelectUI()

	return
end

function var_0_1.getCharDataById(arg_54_0, arg_54_1)
	pairs = var_1_10002
	CookGameConst = var_1_10004

	for iter_54_0, iter_54_1 in var_1_10002(var_1_10004.char_data) do
		if iter_54_1.id == arg_54_1 then
			Clone = var_7

			return var_7(iter_54_1)
		end
	end

	return nil
end

function var_0_1.getCharData(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = 1

	CookGameConst = var_1_10004

	for iter_55_0 = var_55_0, #var_1_10004.char_data do
		CookGameConst = var_1_10007

		if var_1_10007.char_data[iter_55_0].id == arg_55_1 then
			if not arg_55_2 then
				Clone = var_8

				return var_8(var_1_10007)
			else
				Clone = var_8

				return var_8(var_1_10007[arg_55_2])
			end
		end
	end

	return nil
end

function var_0_1.randomAIShip(arg_56_0)
	local var_56_0 = {}

	pairs = var_1_10002
	CookGameConst = var_1_10004

	for iter_56_0, iter_56_1 in var_1_10002(var_1_10004.char_battle_data) do
		if iter_56_1.extend then
			table = var_1_10007

			var_1_10007.insert(var_56_0, iter_56_1.id)
		end
	end

	if var_0_9.playerChar then
		table = var_2

		var_2.insert(var_56_0, var_0_9.playerChar)
	end

	if var_0_9.partnerChar then
		table = var_2

		var_2.insert(var_56_0, var_0_9.partnerChar)
	end

	Clone = var_2
	CookGameConst = var_4

	for iter_56_2 = #var_2(var_4.random_ids), 1, -1 do
		table = var_1_10007

		if var_1_10007.contains(var_56_0, var_2[iter_56_2]) then
			table = var_1_10007

			var_1_10007.remove(var_2, iter_56_2)
		end
	end

	local var_56_1 = var_0_9

	table = var_4

	local var_56_2 = var_4.remove
	local var_56_3 = var_2

	math = var_1_10007
	var_56_1.enemy1Char = var_56_2(var_56_3, var_1_10007.random(1, #var_2))

	local var_56_4 = var_0_9

	table = var_4

	local var_56_5 = var_4.remove
	local var_56_6 = var_2

	math = var_7
	var_56_4.enemy2Char = var_56_5(var_56_6, var_7.random(1, #var_2))

	local var_56_7 = var_0_9

	CookGameConst = var_4

	local var_56_8

	if not var_4.char_battle_data[var_0_9.enemy1Char].pet then
		CookGameConst = var_56_8

		if not var_56_8.char_battle_data[var_0_9.enemy2Char].pet then
			var_56_8 = nil
		end
	end

	var_56_7.enemyPet = var_56_8

	return
end

function var_0_1.openMenuUI(arg_57_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_57_0.sceneContainer, "scene_front"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_57_0.sceneContainer, "scene_background"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_57_0.sceneContainer, "scene"), false)

	setActive = var_1_10001

	var_1_10001(arg_57_0.gameUI, false)

	setActive = var_1_10001

	var_1_10001(arg_57_0.menuUI, true)
	arg_57_0:openCoinLayer(true)

	setActive = var_1

	var_1(arg_57_0.bg, true)
	arg_57_0:updateMenuUI()

	return
end

function var_0_1.clearUI(arg_58_0)
	setActive = var_1_10001

	var_1_10001(arg_58_0.sceneContainer, false)

	setActive = var_1_10001

	var_1_10001(arg_58_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_58_0.countUI, false)

	setActive = var_1_10001

	var_1_10001(arg_58_0.menuUI, false)

	setActive = var_1_10001

	var_1_10001(arg_58_0.gameUI, false)

	setActive = var_1_10001

	var_1_10001(arg_58_0.selectUI, false)

	return
end

function var_0_1.readyStart(arg_59_0)
	arg_59_0.readyStartFlag = true

	arg_59_0:controllerReady()

	setActive = var_1

	var_1(arg_59_0.countUI, true)

	local var_59_0 = arg_59_0.countAnimator

	var_1.Play(var_59_0, "count")

	pg = var_1

	local var_59_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_59_1, var_0_3)

	arg_59_0.readyStartFlag = false

	return
end

function var_0_1.gameStart(arg_60_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_60_0.sceneContainer, "scene_front"), true)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_60_0.sceneContainer, "scene_background"), true)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_60_0.sceneContainer, "scene"), true)

	GetComponent = var_1_10001
	findTF = var_3

	local var_60_0 = var_3(arg_60_0.sceneContainer, "scene")

	typeof = var_4
	CanvasGroup = var_6

	local var_60_1 = var_1_10001(var_60_0, var_4(var_6))

	var_60_1.alpha = 1
	setActive = var_60_1

	var_60_1(arg_60_0.bg, false)

	local var_60_2 = arg_60_0.sceneContainer

	Vector2 = var_2
	var_60_2.anchoredPosition = var_2(0, 0)
	Vector2 = var_60_2
	arg_60_0.offsetPosition = var_60_2(0, 0)
	setActive = var_1

	var_1(arg_60_0.gameUI, true)

	arg_60_0.gameStartFlag = true
	arg_60_0.scoreNum = 0
	arg_60_0.otherScoreNum = 0
	arg_60_0.gameStepTime = 0
	arg_60_0.gameTime = var_0_5
	arg_60_0.extendTime = nil
	arg_60_0.waitingExtendTime = false

	if var_0_9.playerChar == 6 or var_0_9.partnerChar == 6 then
		arg_60_0.waitingExtendTime = true
	end

	for iter_60_0 = #arg_60_0.showScores, 1, -1 do
		table = var_60_3

		local var_60_3

		if not var_60_3.contains(arg_60_0.showScoresPool, arg_60_0.showScores[iter_60_0]) then
			table = var_60_3
			var_60_3 = var_60_3.remove(arg_60_0.showScores, iter_60_0)
			table = var_6

			var_6.insert(arg_60_0.showScoresPool, var_60_3)
		end
	end

	for iter_60_1 = #arg_60_0.showScoresPool, 1, -1 do
		setActive = var_60_3

		var_60_3(arg_60_0.showScoresPool[iter_60_1], false)
	end

	local function var_60_4(arg_61_0, arg_61_1)
		local var_61_0 = arg_60_0
		local var_61_1 = var_2.getCharData(var_61_0, arg_61_0, "icon")
		local var_61_2 = arg_60_0
		local var_61_3 = var_3.getCharData(var_61_2, arg_61_0, "pos")

		GetSpriteFromAtlasAsync = var_61_0

		var_61_0("ui/minigameui/" .. var_0_6, var_61_1, function(arg_62_0)
			setActive = var_3_10001

			var_3_10001(arg_61_1, true)

			setImageSprite = var_3_10001

			var_3_10001(arg_61_1, arg_62_0, true)

			return
		end)

		return
	end

	local var_60_5 = var_0_9.playerChar

	findTF = var_60_3

	var_60_4(var_60_5, var_60_3(arg_60_0.gameUI, "top/leftCharPos/player/img"))

	local var_60_6 = var_1
	local var_60_7 = var_0_9.partnerChar

	findTF = var_5

	var_60_6(var_60_7, var_5(arg_60_0.gameUI, "top/leftCharPos/partner/img"))

	local var_60_8 = var_1
	local var_60_9 = var_0_9.enemy1Char

	findTF = var_5

	var_60_8(var_60_9, var_5(arg_60_0.gameUI, "top/rightCharPos/enemy1/img"))

	local var_60_10 = var_1
	local var_60_11 = var_0_9.enemy2Char

	findTF = var_5

	var_60_10(var_60_11, var_5(arg_60_0.gameUI, "top/rightCharPos/enemy2/img"))
	arg_60_0:updateGameUI()
	arg_60_0:timerStart()
	arg_60_0:controllerStart()

	return
end

function var_0_1.controllerReady(arg_63_0)
	GetComponent = var_1_10001
	findTF = var_1_10003

	local var_63_0 = var_1_10003(arg_63_0.sceneContainer, "scene")

	typeof = var_1_10004
	CanvasGroup = var_6

	local var_63_1 = var_1_10001(var_63_0, var_1_10004(var_6))

	var_63_1.alpha = 0
	setActive = var_63_1
	findTF = var_63_0

	var_63_1(var_63_0(arg_63_0.sceneContainer, "scene"), true)

	local var_63_2 = arg_63_0.charController

	var_1.readyStart(var_63_2)

	return
end

function var_0_1.controllerStart(arg_64_0)
	local var_64_0 = arg_64_0.judgesController

	var_1.start(var_64_0)

	local var_64_1 = arg_64_0.charController

	var_1.start(var_64_1)

	return
end

function var_0_1.getGameTimes(arg_65_0)
	return arg_65_0:GetMGHubData().count
end

function var_0_1.getGameUsedTimes(arg_66_0)
	return arg_66_0:GetMGHubData().usedtime
end

function var_0_1.getUltimate(arg_67_0)
	return arg_67_0:GetMGHubData().ultimate
end

function var_0_1.getGameTotalTime(arg_68_0)
	local var_68_0 = arg_68_0:GetMGHubData()

	return (var_1.getConfig(var_68_0, "reward_need"))
end

function var_0_1.changeSpeed(arg_69_0, arg_69_1)
	if arg_69_0.judgesController then
		local var_69_0 = arg_69_0.judgesController

		var_2.changeSpeed(var_69_0, arg_69_1)
	end

	if arg_69_0.charController then
		local var_69_1 = arg_69_0.charController

		var_2.changeSpeed(var_69_1, arg_69_1)
	end

	return
end

function var_0_1.onTimer(arg_70_0)
	arg_70_0:gameStep()

	return
end

function var_0_1.gameStep(arg_71_0)
	if arg_71_0.gameTime then
		local var_71_0 = arg_71_0.gameTime

		if 3 < var_71_0 then
			local var_71_1 = arg_71_0.gameTime

			Time = var_1_10002

			if var_71_1 - var_1_10002.deltaTime < 3 and var_0_9.playerChar ~= 6 and var_0_9.playerChar ~= 6 then
				local var_71_2 = arg_71_0.judgesController

				var_1.timeUp(var_71_2)
			end
		end
	end

	if arg_71_0.extendTime then
		local var_71_3 = arg_71_0.extendTime

		if 3 < var_71_3 then
			local var_71_4 = arg_71_0.extendTime

			Time = var_1_10002

			if var_71_4 - var_1_10002.deltaTime < 3 then
				local var_71_5 = arg_71_0.judgesController

				var_1.timeUp(var_71_5)
			end
		end
	end

	local var_71_6 = arg_71_0.gameTime

	Time = var_1_10002
	arg_71_0.gameTime = var_71_6 - var_1_10002.deltaTime

	if arg_71_0.gameTime < 0 then
		arg_71_0.gameTime = 0
	end

	var_0_9.gameTime = arg_71_0.gameTime

	if arg_71_0.extendTime then
		local var_71_7 = arg_71_0.extendTime

		if 0 < var_71_7 then
			local var_71_8 = arg_71_0.extendTime

			Time = var_2
			arg_71_0.extendTime = var_71_8 - var_2.deltaTime

			if arg_71_0.extendTime < 0 then
				arg_71_0.extendTime = 0
			end
		end
	end

	local var_71_9 = arg_71_0.gameStepTime

	Time = var_2
	arg_71_0.gameStepTime = var_71_9 + var_2.deltaTime

	local var_71_10 = arg_71_0
	local var_71_11 = arg_71_0.controllerStep

	Time = var_1_10004

	var_71_11(var_71_10, var_1_10004.deltaTime)
	arg_71_0:updateGameUI()

	if not arg_71_0.waitingExtendTime and arg_71_0.gameTime <= 0 then
		if arg_71_0.extendTime then
			if arg_71_0.extendTime <= 0 then
				arg_71_0:onGameOver()
			end
		else
			arg_71_0:onGameOver()
		end

		return
	end

	return
end

function var_0_1.controllerStep(arg_72_0, arg_72_1)
	local var_72_0 = arg_72_0.judgesController

	var_2.step(var_72_0, arg_72_1)

	local var_72_1 = arg_72_0.charController

	var_2.step(var_72_1, arg_72_1)

	return
end

function var_0_1.timerStart(arg_73_0)
	if not arg_73_0.timer.running then
		local var_73_0 = arg_73_0.timer

		var_1.Start(var_73_0)
	end

	return
end

function var_0_1.timerStop(arg_74_0)
	if arg_74_0.timer.running then
		local var_74_0 = arg_74_0.timer

		var_1.Stop(var_74_0)
	end

	return
end

function var_0_1.updateGameUI(arg_75_0)
	setText = var_1_10001

	var_1_10001(arg_75_0.scoreTf, arg_75_0.scoreNum)

	setText = var_1_10001

	var_1_10001(arg_75_0.otherScoreTf, arg_75_0.otherScoreNum)

	if arg_75_0.extendTime and arg_75_0.extendTime > 0 then
		setText = var_1

		local var_75_0 = arg_75_0.gameTimeS

		math = var_4

		var_1(var_75_0, var_4.ceil(arg_75_0.extendTime))
	else
		setText = var_1

		local var_75_1 = arg_75_0.gameTimeS

		math = var_4

		var_1(var_75_1, var_4.ceil(arg_75_0.gameTime))
	end

	return
end

function var_0_1.addScore(arg_76_0, arg_76_1, arg_76_2)
	if arg_76_2 then
		arg_76_0.otherScoreNum = arg_76_0.otherScoreNum + arg_76_1

		if arg_76_0.otherScoreNum < 0 then
			arg_76_0.otherScoreNum = 0
		end
	else
		arg_76_0.scoreNum = arg_76_0.scoreNum + arg_76_1

		if arg_76_0.scoreNum < 0 then
			arg_76_0.scoreNum = 0
		end
	end

	return
end

function var_0_1.onGameOver(arg_77_0)
	if arg_77_0.settlementFlag then
		return
	end

	arg_77_0:timerStop()
	arg_77_0:controllerClear()

	arg_77_0.settlementFlag = true
	setActive = var_1

	var_1(arg_77_0.clickMask, true)

	LeanTween = var_1

	local var_77_0 = var_1.delayedCall

	go = var_3

	local var_77_1 = var_3(arg_77_0._tf)
	local var_77_2 = 0.1

	System = var_5

	var_77_0(var_77_1, var_77_2, var_5.Action(function()
		arg_77_0.settlementFlag = false

		local var_78_0 = arg_77_0

		var_78_0.gameStartFlag = false
		setActive = var_78_0

		var_78_0(arg_77_0.clickMask, false)

		local var_78_1 = arg_77_0

		var_0.showSettlement(var_78_1)

		return
	end))

	return
end

function var_0_1.showSettlement(arg_79_0)
	setActive = var_1_10001

	var_1_10001(arg_79_0.settlementUI, true)

	GetComponent = var_1_10001
	findTF = var_3

	local var_79_0 = var_3(arg_79_0.settlementUI, "ad")

	typeof = var_4
	Animator = var_6

	local var_79_1 = var_1_10001(var_79_0, var_4(var_6))

	var_1.Play(var_79_1, "settlement", -1, 0)

	local var_79_2 = arg_79_0.scoreNum

	getProxy = var_79_0
	GameRoomProxy = var_5

	local var_79_3 = var_79_0(var_5)
	local var_79_4 = var_3.getRoomScore(var_79_3, arg_79_0:getGameRoomData().id)
	local var_79_5

	if not arg_79_0.otherScoreNum then
		var_79_5 = 0
	end

	setActive = var_79_3
	findTF = var_7

	var_79_3(var_7(arg_79_0.settlementUI, "ad/new"), var_79_4 < var_79_2)

	if var_79_4 <= var_79_2 then
		var_79_4 = var_79_2

		arg_79_0:StoreDataToServer({
			var_79_4
		})
	end

	findTF = var_79_3

	local var_79_6 = var_79_3(arg_79_0.settlementUI, "ad/highText")

	findTF = var_6

	local var_79_7 = var_6(arg_79_0.settlementUI, "ad/currentText")

	findTF = var_7

	local var_79_8 = var_7(arg_79_0.settlementUI, "ad/otherText")

	setText = var_8

	var_8(var_79_6, var_79_4)

	setText = var_8

	var_8(var_79_7, var_79_2)

	setText = var_8

	var_8(var_79_8, var_79_5)

	local var_79_9 = arg_79_0
	local var_79_10

	if arg_79_0.getGameTimes(var_79_9) then
		var_79_9 = arg_79_0
		var_79_10 = arg_79_0.getGameTimes(var_79_9)

		if 0 < var_79_10 then
			arg_79_0.sendSuccessFlag = true
			var_79_9 = arg_79_0

			arg_79_0.SendSuccess(var_79_9, var_79_2)
		end
	end

	if var_79_5 < var_79_2 then
		setActive = var_79_10
		findTF = var_79_9

		var_79_10(var_79_9(arg_79_0.settlementUI, "ad/win"), true)

		setActive = var_79_10
		findTF = var_79_9

		var_79_10(var_79_9(arg_79_0.settlementUI, "ad/defeat"), false)
	elseif var_79_2 < var_79_5 then
		setActive = var_79_10
		findTF = var_79_9

		var_79_10(var_79_9(arg_79_0.settlementUI, "ad/win"), false)

		setActive = var_79_10
		findTF = var_79_9

		var_79_10(var_79_9(arg_79_0.settlementUI, "ad/defeat"), true)
	else
		setActive = var_79_10
		findTF = var_79_9

		var_79_10(var_79_9(arg_79_0.settlementUI, "ad/win"), false)

		setActive = var_79_10
		findTF = var_10

		var_79_10(var_10(arg_79_0.settlementUI, "ad/defeat"), false)
	end

	local var_79_11 = {}

	table = var_9

	var_9.insert(var_79_11, {
		name = "player",
		char_id = var_0_9.playerChar
	})

	table = var_9

	var_9.insert(var_79_11, {
		name = "partner",
		char_id = var_0_9.partnerChar
	})

	table = var_9

	var_9.insert(var_79_11, {
		name = "enemy1",
		char_id = var_0_9.enemy1Char
	})

	table = var_9

	var_9.insert(var_79_11, {
		name = "enemy2",
		char_id = var_0_9.enemy2Char
	})

	for iter_79_0 = 1, #var_79_11 do
		local var_79_12 = var_79_11[iter_79_0].char_id

		findTF = var_1_10014
		var_1_10014 = var_1_10014(arg_79_0.settlementUI, "ad/" .. var_79_11[iter_79_0].name)

		local var_79_13 = arg_79_0
		local var_79_14 = arg_79_0.getCharData(var_79_13, var_79_12, "icon")
		local var_79_15 = arg_79_0:getCharData(var_79_12, "pos")

		GetSpriteFromAtlasAsync = var_79_13

		var_79_13("ui/minigameui/" .. var_0_6, var_79_14, function(arg_80_0)
			findTF = var_2_10001

			local var_80_0 = var_2_10001(var_1_10014, "mask/img")

			setActive = var_2_10002

			var_2_10002(var_80_0, true)

			var_80_0.anchoredPosition = var_79_15
			setImageSprite = var_2

			var_2(var_80_0, arg_80_0, true)

			return
		end)
	end

	return
end

function var_0_1.OnApplicationPaused(arg_81_0)
	if not arg_81_0.gameStartFlag then
		return
	end

	if arg_81_0.readyStartFlag then
		return
	end

	if arg_81_0.settlementFlag then
		return
	end

	isActive = var_1

	if not var_1(arg_81_0.pauseUI) then
		isActive = var_1

		if var_1(arg_81_0.leaveUI) then
			return
		end

		isActive = var_1

		if not var_1(arg_81_0.pauseUI) then
			setActive = var_1

			var_1(arg_81_0.pauseUI, true)
		end

		arg_81_0:stopGame()

		return
	end
end

function var_0_1.controllerClear(arg_82_0)
	local var_82_0 = arg_82_0.judgesController

	var_1.clear(var_82_0)

	local var_82_1 = arg_82_0.charController

	var_1.clear(var_82_1)

	return
end

function var_0_1.resumeGame(arg_83_0)
	arg_83_0.gameStop = false
	setActive = var_1

	var_1(arg_83_0.leaveUI, false)
	arg_83_0:changeSpeed(1)
	arg_83_0:timerStart()

	return
end

function var_0_1.stopGame(arg_84_0)
	arg_84_0.gameStop = true

	arg_84_0:timerStop()
	arg_84_0:changeSpeed(0)

	return
end

function var_0_1.onBackPressed(arg_85_0)
	if arg_85_0.readyStartFlag then
		return
	end

	if not arg_85_0.gameStartFlag then
		arg_85_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		if arg_85_0.settlementFlag then
			return
		end

		isActive = var_1

		if var_1(arg_85_0.pauseUI) then
			setActive = var_1

			var_1(arg_85_0.pauseUI, false)
		end

		arg_85_0:stopGame()

		setActive = var_1

		var_1(arg_85_0.leaveUI, true)
	end

	return
end

function var_0_1.willExit(arg_86_0)
	if arg_86_0.cookGameUIAtlasStored then
		AssetBundleHelper = var_1

		var_1.UnstoreAssetBundle(var_0_9.path, true)

		arg_86_0.cookGameUIAtlasStored = false
	end

	if arg_86_0.handle then
		UpdateBeat = var_1
		var_1_10003 = var_1

		var_1.RemoveListener(var_1_10003, arg_86_0.handle)
	end

	if arg_86_0._tf then
		LeanTween = var_1

		local var_86_0 = var_1.isTweening

		go = var_1_10003

		if var_86_0(var_1_10003(arg_86_0._tf)) then
			LeanTween = var_1

			local var_86_1 = var_1.cancel

			go = var_3

			var_86_1(var_3(arg_86_0._tf))
		end
	end

	arg_86_0:destroyController()

	if arg_86_0.timer and arg_86_0.timer.running then
		local var_86_2 = arg_86_0.timer

		var_1.Stop(var_86_2)
	end

	local var_86_3 = arg_86_0.scrollRect.onValueChanged

	var_1.RemoveAllListeners(var_86_3)

	Time = var_1
	var_1.timeScale = 1
	arg_86_0.timer = nil

	return
end

function var_0_1.destroyController(arg_87_0)
	return
end

return var_0_1
