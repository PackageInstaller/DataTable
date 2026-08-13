class = var_0_10000

local var_0_0 = "RyzaMiniGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.miniGame.BaseMiniGameView"))

var_0_1.EVENT_CREATE = "RyzaMiniGameView.EVENT_CREATE"
var_0_1.EVENT_DESTROY = "RyzaMiniGameView.EVENT_DESTROY"
var_0_1.EVENT_FINISH = "RyzaMiniGameView.EVENT_FINISH"
var_0_1.EVENT_WINDOW_FOCUS = "RyzaMiniGameView.EVENT_WINDOW_FOCUS"
var_0_1.EVENT_STATUS_SYNC = "RyzaMiniGameView.EVENT_STATUS_SYNC"
var_0_1.EVENT_UPDATE_HIDE = "RyzaMiniGameView.EVENT_UPDATE_HIDE"

function var_0_1.getUIName(arg_1_0)
	return "RyzaMiniGameUI"
end

function var_0_1.didEnter(arg_2_0)
	arg_2_0:initTimer()
	arg_2_0:initUI()
	arg_2_0:initGameUI()

	onNextTick = var_1

	var_1(function()
		local var_3_0 = arg_2_0

		var_0.openUI(var_3_0, "main")

		return
	end)

	return
end

local function var_0_2(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.GetComponentsInChildren

	typeof = var_1_10004
	Animator = var_1_10005

	local var_4_2 = var_4_1(var_4_0, var_1_10004(var_1_10005), true)
	local var_4_3 = var_2.ToTable(var_4_2)

	ipairs = var_4_2

	for iter_4_0, iter_4_1 in var_4_2(var_4_3) do
		iter_4_1.speed = arg_4_1
	end

	return
end

function var_0_1.openUI(arg_5_0, arg_5_1)
	if arg_5_0.status then
		setActive = var_2

		local var_5_0 = arg_5_0.rtTitlePage

		var_2(var_3.Find(var_5_0, arg_5_0.status), false)
	end

	if arg_5_1 then
		setActive = var_2

		local var_5_1 = arg_5_0.rtTitlePage

		var_2(var_3.Find(var_5_1, arg_5_1), true)
	end

	arg_5_0.status = arg_5_1
	switch = var_2

	var_2(arg_5_1, {
		main = function()
			local var_6_0 = arg_5_0

			var_0.updateMainUI(var_6_0)

			return
		end,
		pause = function()
			local var_7_0 = arg_5_0

			var_0.pauseGame(var_7_0)

			return
		end,
		exit = function()
			local var_8_0 = arg_5_0

			var_0.pauseGame(var_8_0)

			return
		end,
		result = function()
			local var_9_0 = arg_5_0
			local var_9_1 = var_0.GetMGData(var_9_0)
			local var_9_2 = var_0.GetRuntimeData(var_9_1, "elements")
			local var_9_3 = arg_5_0.scoreNum
			local var_9_4

			if not var_9_2 or not (#var_9_2 > 0) or not var_9_2[1] then
				var_9_4 = 0
			end

			local var_9_5 = arg_5_0.rtTitlePage
			local var_9_6 = var_3.Find(var_9_5, "result")

			setActive = var_9_5

			var_9_5(var_9_6:Find("window/now/new"), var_9_4 < var_9_3)

			if var_9_4 <= var_9_3 then
				var_9_4 = var_9_3

				local var_9_7 = arg_5_0

				var_9_5.StoreDataToServer(var_9_7, {
					var_9_4
				})
			end

			setText = var_9_5

			var_9_5(var_9_6:Find("window/high/Text"), var_9_4)

			setText = var_9_5

			var_9_5(var_9_6:Find("window/now/Text"), var_9_3)

			local var_9_8 = arg_5_0
			local var_9_9 = var_4.GetMGHubData(var_9_8)

			if arg_5_0.stageIndex == var_9_9.usedtime + 1 and var_9_9.count > 0 then
				local var_9_10 = arg_5_0

				var_5.SendSuccess(var_9_10, 0)
			end

			return
		end
	})

	return
end

function var_0_1.updateMainUI(arg_10_0)
	local var_10_0 = arg_10_0:GetMGHubData()
	local var_10_1 = var_1.getConfig(var_10_0, "reward_need")
	local var_10_2 = var_1.usedtime + var_1.count

	if var_3 == var_10_1 then
		var_1_10005 = 8
	else
		math = var_1_10005
		var_1_10005 = var_1_10005.min(var_1.usedtime + 1, var_10_2)
	end

	local var_10_3 = arg_10_0.itemList.container.childCount

	for iter_10_0 = 1, var_10_3 do
		var_1_10012 = {}

		if iter_10_0 <= var_3 then
			var_1_10012.finish = true
		elseif iter_10_0 <= var_10_2 then
			-- block empty
		elseif var_3 == var_10_1 then
			var_1_10012.finish = false
			var_1_10012.lock = false
		else
			var_1_10012.lock = true
		end

		local var_10_4 = var_6

		var_1_10013 = var_6.GetChild(var_10_4, iter_10_0 - 1)
		setActive = var_10_4

		var_10_4(var_1_10013:Find("finish"), var_1_10012.finish)

		setActive = var_10_4

		var_10_4(var_1_10013:Find("lock"), var_1_10012.lock)

		setToggleEnabled = var_10_4

		var_10_4(var_1_10013, iter_10_0 <= var_1_10005)

		triggerToggle = var_10_4

		var_10_4(var_1_10013, iter_10_0 == var_1_10005)
	end

	local var_10_5 = var_6:GetChild(0).anchoredPosition.y - var_6:GetChild(var_1_10005 - 1).anchoredPosition.y
	local var_10_6 = var_6.rect.height
	local var_10_7 = var_6
	local var_10_8 = var_6.GetComponent

	typeof = var_1_10012
	ScrollRect = var_1_10013

	local var_10_9 = var_10_8(var_10_7, var_1_10012(var_1_10013)).viewport.rect.height

	math = var_10_7

	local var_10_10 = var_10_7.clamp(var_10_5, 0, var_10_6 - var_10_9) / (var_10_6 - var_10_9)

	scrollTo = var_12

	var_12(var_6, nil, 1 - var_10_10)

	setActive = var_12

	local var_10_11 = arg_10_0.rtTitlePage

	var_12(var_13.Find(var_10_11, "main/tip/Image"), var_3 == var_10_1)
	arg_10_0:checkGet()

	if var_3 == 1 and var_1_10005 == 2 then
		PlayerPrefs = var_12

		if var_12.GetInt("ryza_minigame_guide", 0) == 0 then
			scrollTo = var_12

			var_12(var_6, nil, 1)

			pg = var_12

			local var_10_12 = var_12.NewGuideMgr.GetInstance()

			var_12.Play(var_10_12, "Ryza_MiniGame")

			PlayerPrefs = var_12

			var_12.SetInt("ryza_minigame_guide", 1)
		end
	else
		PlayerPrefs = var_12

		if var_12.GetInt("ryza_minigame_help", 0) == 0 then
			triggerButton = var_12

			local var_10_13 = arg_10_0.rtTitlePage

			var_12(var_13.Find(var_10_13, "main/btn_rule"))
		end
	end

	return
end

function var_0_1.checkGet(arg_11_0)
	if arg_11_0:GetMGHubData().ultimate == 0 then
		local var_11_0 = var_1.usedtime
		local var_11_1 = var_1

		if var_11_0 < var_1.getConfig(var_11_1, "reward_need") then
			return
		end

		pg = var_11_0

		local var_11_2 = var_11_0.m02
		local var_11_3 = var_2.sendNotification

		GAME = var_11_1

		local var_11_4 = var_11_1.SEND_MINI_GAME_OP
		local var_11_5 = {
			hubid = var_1.id
		}

		MiniGameOPCommand = var_6
		var_11_5.cmd = var_6.CMD_ULTIMATE
		var_11_5.args1 = {}

		var_11_3(var_11_2, var_11_4, var_11_5)
	end

	return
end

function var_0_1.initUI(arg_12_0)
	local var_12_0 = arg_12_0._tf

	arg_12_0.rtTitlePage = var_1.Find(var_12_0, "TitlePage")

	local var_12_1 = arg_12_0.rtTitlePage
	local var_12_2 = var_1.Find(var_12_1, "main")

	onButton = var_12_1

	local var_12_3 = arg_12_0
	local var_12_4 = var_12_2:Find("btn_back")

	local function var_12_5()
		local var_13_0 = arg_12_0

		var_0.closeView(var_13_0)

		return
	end

	SFX_CANCEL = var_6

	var_12_1(var_12_3, var_12_4, var_12_5, var_6)

	onButton = var_12_1

	local var_12_6 = arg_12_0
	local var_12_7 = var_12_2:Find("btn_rule")

	local function var_12_8()
		PlayerPrefs = var_2_10000

		var_2_10000.SetInt("ryza_minigame_help", 1)

		pg = var_0

		local var_14_0 = var_0.MsgboxMgr.GetInstance()
		local var_14_1 = var_0.ShowMsgBox
		local var_14_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_14_2.type = var_2_10003
		pg = var_2_10003
		var_14_2.helps = var_2_10003.gametip.ryza_mini_game.tip

		var_14_1(var_14_0, var_14_2)

		return
	end

	SFX_PANEL = var_6

	var_12_1(var_12_6, var_12_7, var_12_8, var_6)

	local var_12_9 = arg_12_0:GetMGData()
	local var_12_10 = var_2.GetSimpleValue(var_12_9, "story")

	onButton = var_12_9

	local var_12_11 = arg_12_0
	local var_12_12 = var_12_2:Find("btn_start")

	local function var_12_13()
		local var_15_0 = {}

		checkExist = var_2_10001

		if var_2_10001(var_12_10, {
			arg_12_0.stageIndex
		}, {
			1
		}) then
			table = var_2

			var_2.insert(var_15_0, function(arg_16_0)
				pg = var_3_10001

				local var_16_0 = var_3_10001.NewStoryMgr.GetInstance()

				var_1.Play(var_16_0, var_0, arg_16_0)

				return
			end)
		end

		seriesAsync = var_2

		var_2(var_15_0, function()
			local var_17_0 = arg_12_0

			var_0.readyStart(var_17_0)

			return
		end)

		return
	end

	SFX_CONFIRM = var_7

	var_12_9(var_12_11, var_12_12, var_12_13, var_7)

	arg_12_0.stageIndex = 0
	pg = var_3

	local var_12_14 = var_3.mini_game[arg_12_0:GetMGData().id].simple_config_data.drop_ids
	local var_12_15 = var_12_2
	local var_12_16 = var_12_2.Find(var_12_15, "side_panel/award/content")

	UIItemList = var_12_15
	arg_12_0.itemList = var_12_15.New(var_12_16, var_12_16:GetChild(0))

	local var_12_17 = arg_12_0.itemList

	var_5.make(var_12_17, function(arg_18_0, arg_18_1, arg_18_2)
		arg_18_1 = arg_18_1 + 1
		UIItemList = var_2_10003

		if arg_18_0 == var_2_10003.EventUpdate then
			local var_18_0 = arg_18_2:Find("IconTpl")
			local var_18_1 = {}

			unpack = var_5

			local var_18_2, var_18_3, var_18_4 = var_5(var_12_14[arg_18_1])

			var_18_1.count = var_18_4
			var_18_1.id = var_18_3
			var_18_1.type = var_18_2
			updateDrop = var_18_2

			var_18_2(var_18_0, var_18_1)

			onButton = var_18_2

			local var_18_5 = arg_12_0
			local var_18_6 = var_18_0

			local function var_18_7()
				local var_19_0 = arg_12_0

				var_0.emit(var_19_0, var_0_1.ON_DROP, var_18_1)

				return
			end

			SFX_PANEL = var_2_10009

			var_18_2(var_18_5, var_18_6, var_18_7, var_2_10009)

			onToggle = var_18_2

			var_18_2(arg_12_0, arg_18_2, function(arg_20_0)
				if arg_20_0 then
					arg_12_0.stageIndex = arg_18_1
				end

				return
			end)
		end

		return
	end)

	local var_12_18 = arg_12_0.itemList

	var_5.align(var_12_18, #var_12_14)

	local var_12_19 = arg_12_0:GetMGHubData()
	local var_12_20 = var_5.getConfig(var_12_19, "reward_need")

	setActive = var_12_19

	var_12_19(var_12_16:GetChild(var_12_20), true)

	onToggle = var_12_19

	var_12_19(arg_12_0, var_12_16:GetChild(var_12_20), function(arg_21_0)
		if arg_21_0 then
			arg_12_0.stageIndex = 0
		end

		return
	end)

	local var_12_21 = arg_12_0.rtTitlePage
	local var_12_22 = var_7.Find(var_12_21, "countdown")
	local var_12_23 = var_7.Find(var_12_22, "bg/Image")
	local var_12_24 = var_8.GetComponent

	typeof = var_10
	DftAniEvent = var_11

	local var_12_25 = var_12_24(var_12_23, var_10(var_11))

	var_8.SetEndEvent(var_12_25, function()
		local var_22_0 = arg_12_0

		var_0.openUI(var_22_0)

		local var_22_1 = arg_12_0

		var_0.startGame(var_22_1)

		return
	end)

	local var_12_26 = arg_12_0.rtTitlePage
	local var_12_27 = var_8.Find(var_12_26, "pause")

	onButton = var_12_26

	local var_12_28 = arg_12_0
	local var_12_29 = var_12_27:Find("window/btn_confirm")

	local function var_12_30()
		local var_23_0 = arg_12_0

		var_0.openUI(var_23_0)

		local var_23_1 = arg_12_0

		var_0.resumeGame(var_23_1)

		return
	end

	SFX_CONFIRM = var_13

	var_12_26(var_12_28, var_12_29, var_12_30, var_13)

	local var_12_31 = arg_12_0.rtTitlePage
	local var_12_32 = var_9.Find(var_12_31, "exit")

	onButton = var_12_31

	local var_12_33 = arg_12_0
	local var_12_34 = var_12_32:Find("window/btn_cancel")

	local function var_12_35()
		local var_24_0 = arg_12_0

		var_0.openUI(var_24_0)

		local var_24_1 = arg_12_0

		var_0.resumeGame(var_24_1)

		return
	end

	SFX_CANCEL = var_14

	var_12_31(var_12_33, var_12_34, var_12_35, var_14)

	onButton = var_12_31

	local var_12_36 = arg_12_0
	local var_12_37 = var_12_32:Find("window/btn_confirm")

	local function var_12_38()
		local var_25_0 = arg_12_0

		var_0.openUI(var_25_0)

		local var_25_1 = arg_12_0

		var_0.resumeGame(var_25_1)

		local var_25_2 = arg_12_0

		var_0.endGame(var_25_2)

		return
	end

	SFX_CONFIRM = var_14

	var_12_31(var_12_36, var_12_37, var_12_38, var_14)

	local var_12_39 = arg_12_0.rtTitlePage
	local var_12_40 = var_10.Find(var_12_39, "result")

	onButton = var_12_39

	local var_12_41 = arg_12_0
	local var_12_42 = var_12_40:Find("window/btn_finish")

	local function var_12_43()
		setActive = var_2_10000

		local var_26_0 = arg_12_0._tf

		var_2_10000(var_1.Find(var_26_0, "Viewport"), false)

		local var_26_1 = arg_12_0

		var_0.openUI(var_26_1, "main")

		pg = var_0

		local var_26_2 = var_0.BgmMgr.GetInstance()

		var_0.Push(var_26_2, arg_12_0.__cname, "ryza-5")

		return
	end

	SFX_CONFIRM = var_15

	var_12_39(var_12_41, var_12_42, var_12_43, var_15)

	return
end

function var_0_1.initGameUI(arg_27_0)
	pg = var_1_10001
	arg_27_0.uiMgr = var_1_10001.UIMgr.GetInstance()

	local var_27_0 = arg_27_0._tf

	arg_27_0.rtResource = var_1.Find(var_27_0, "Resource")

	local var_27_1 = arg_27_0._tf

	arg_27_0.rtMain = var_1.Find(var_27_1, "Viewport/MainContent")

	local var_27_2 = arg_27_0.rtMain

	arg_27_0.rtPlane = var_1.Find(var_27_2, "plane")
	arg_27_0.sprites = {}
	eachChild = var_1

	var_1(arg_27_0.rtPlane, function(arg_28_0)
		local var_28_0 = arg_27_0.sprites
		local var_28_1 = arg_28_0.name

		getImageSprite = var_2_10003
		var_28_0[var_28_1] = var_2_10003(arg_28_0)

		return
	end)

	local var_27_3 = arg_27_0._tf

	arg_27_0.rtController = var_1.Find(var_27_3, "Controller")

	local var_27_4 = arg_27_0.rtController

	arg_27_0.rtJoyStick = var_1.Find(var_27_4, "bottom/handle_stick")
	onButton = var_1

	local var_27_5 = arg_27_0
	local var_27_6 = arg_27_0.rtController

	var_1(var_27_5, var_3.Find(var_27_6, "bottom/btn_bomb"), function()
		local var_29_0 = arg_27_0.responder

		var_0.RyzaBomb(var_29_0)

		return
	end)

	local var_27_7 = arg_27_0.rtController

	arg_27_0.rtScore = var_1.Find(var_27_7, "top/title/SCORE/Text")

	local var_27_8 = arg_27_0.rtController

	arg_27_0.rtTime = var_1.Find(var_27_8, "top/title/TIME/Text")
	onButton = var_1

	local var_27_9 = arg_27_0
	local var_27_10 = arg_27_0.rtController
	local var_27_11 = var_3.Find(var_27_10, "top/btn_back")

	local function var_27_12()
		local var_30_0 = arg_27_0

		var_0.openUI(var_30_0, "exit")

		return
	end

	SFX_PANEL = var_5

	var_1(var_27_9, var_27_11, var_27_12, var_5)

	onButton = var_1

	local var_27_13 = arg_27_0
	local var_27_14 = arg_27_0.rtController
	local var_27_15 = var_3.Find(var_27_14, "top/btn_pause")

	local function var_27_16()
		local var_31_0 = arg_27_0

		var_0.openUI(var_31_0, "pause")

		return
	end

	SFX_PANEL = var_5

	var_1(var_27_13, var_27_15, var_27_16, var_5)

	local var_27_17 = arg_27_0.rtController

	arg_27_0.rtStatus = var_1.Find(var_27_17, "bottom/status")

	local var_27_18 = arg_27_0.rtController

	arg_27_0.rtRyzaHP = var_1.Find(var_27_18, "top/title/HP/heart")

	local var_27_19 = arg_27_0.rtController

	arg_27_0.rtControllerUI = var_1.Find(var_27_19, "UI")
	eachChild = var_1

	var_1(arg_27_0.rtControllerUI, function(arg_32_0)
		local var_32_0 = arg_27_0

		var_32_0["tplUI" .. arg_32_0.name] = arg_32_0
		setActive = var_32_0

		var_32_0(arg_32_0, false)

		return
	end)

	Responder = var_1
	arg_27_0.responder = var_1.New(arg_27_0)

	arg_27_0:bind(var_0_1.EVENT_CREATE, function(arg_33_0, ...)
		local var_33_0 = arg_27_0

		var_1.CreateReactor(var_33_0, ...)

		return
	end)
	arg_27_0:bind(var_0_1.EVENT_DESTROY, function(arg_34_0, ...)
		local var_34_0 = arg_27_0

		var_1.DestroyReactor(var_34_0, ...)

		return
	end)
	arg_27_0:bind(var_0_1.EVENT_FINISH, function(arg_35_0, arg_35_1)
		local var_35_0 = arg_27_0

		var_2.endGame(var_35_0, arg_35_1)

		return
	end)
	arg_27_0:bind(var_0_1.EVENT_WINDOW_FOCUS, function(arg_36_0, arg_36_1)
		setAnchoredPosition = var_2_10002

		local var_36_0 = arg_27_0.rtMain
		local var_36_1 = {}

		math = var_2_10005
		var_36_1.x = var_2_10005.clamp(-arg_36_1.x, -arg_27_0.buffer.x, arg_27_0.buffer.x)
		math = var_5
		var_36_1.y = var_5.clamp(-arg_36_1.y, -arg_27_0.buffer.y - 48, arg_27_0.buffer.y - 48)

		var_2_10002(var_36_0, var_36_1)

		return
	end)
	arg_27_0:bind(var_0_1.EVENT_STATUS_SYNC, function(arg_37_0, ...)
		local var_37_0 = arg_27_0

		var_1.updateControllerStatus(var_37_0, ...)

		local var_37_1 = arg_27_0

		var_1.popRyzaUI(var_37_1, ...)

		return
	end)
	arg_27_0:bind(var_0_1.EVENT_UPDATE_HIDE, function(arg_38_0, arg_38_1, arg_38_2)
		isa = var_2_10003

		local var_38_0 = arg_38_1

		MoveEnemy = var_2_10005

		if var_2_10003(var_38_0, var_2_10005) then
			GetOrAddComponent = var_3

			local var_38_1 = arg_27_0.reactorUIs[arg_38_1]

			typeof = var_2_10005
			CanvasGroup = var_2_10006
			var_3(var_38_1, var_2_10005(var_2_10006)).alpha = arg_38_2 and 0 or 1
		end

		return
	end)

	return
end

function var_0_1.initTimer(arg_39_0)
	Timer = var_1_10001

	local var_39_0 = var_1_10001.New

	local function var_39_1()
		local var_40_0 = arg_39_0

		var_0.onTimer(var_40_0)

		return
	end

	RyzaMiniGameConfig = var_1_10003
	arg_39_0.timer = var_39_0(var_39_1, var_1_10003.TIME_INTERVAL, -1)

	return
end

function var_0_1.readyStart(arg_41_0)
	arg_41_0:resetGame()

	setActive = var_1

	local var_41_0 = arg_41_0._tf

	var_1(var_2.Find(var_41_0, "Viewport"), true)
	var_0_2(arg_41_0.rtMain, 1)
	arg_41_0:initConfig()
	arg_41_0:buildMap()
	arg_41_0:initController()
	arg_41_0:openUI("countdown")

	return
end

function var_0_1.startGame(arg_42_0)
	pg = var_1_10001

	local var_42_0 = var_1_10001.BgmMgr.GetInstance()

	var_1.Push(var_42_0, arg_42_0.__cname, "ryza-az-battle")

	arg_42_0.gameStartFlag = true

	arg_42_0:startTimer()

	return
end

function var_0_1.endGame(arg_43_0, arg_43_1)
	if arg_43_1 then
		local var_43_0 = arg_43_0.scoreNum

		RyzaMiniGameConfig = var_1_10003
		arg_43_0.scoreNum = var_43_0 + var_1_10003.GetPassGamePoint(arg_43_0.countTime)
		setText = var_2

		var_2(arg_43_0.rtScore, arg_43_0.scoreNum)
	end

	arg_43_0.gameEndFlag = true

	arg_43_0:stopTimer()
	arg_43_0:openUI("result")

	return
end

function var_0_1.pauseGame(arg_44_0)
	arg_44_0.gamePause = true

	arg_44_0:stopTimer()
	arg_44_0:pauseManagedTween()

	return
end

function var_0_1.resumeGame(arg_45_0)
	arg_45_0.gamePause = false

	arg_45_0:startTimer()
	arg_45_0:resumeManagedTween()

	return
end

function var_0_1.resetGame(arg_46_0)
	arg_46_0.gameStartFlag = false
	arg_46_0.gamePause = false
	arg_46_0.gameEndFlag = false
	arg_46_0.scoreNum = 0
	arg_46_0.countTime = 0

	local var_46_0 = arg_46_0.responder

	var_1.reset(var_46_0)

	if arg_46_0.reactorUIs then
		pairs = var_1

		for iter_46_0, iter_46_1 in var_1(arg_46_0.reactorUIs) do
			Destroy = var_1_10006

			var_1_10006(iter_46_1)
		end
	end

	arg_46_0.reactorUIs = {}

	return
end

function var_0_1.initConfig(arg_47_0)
	if arg_47_0.stageIndex == 0 then
		math = var_1

		local var_47_0

		if not var_1.random(7) then
			var_47_0 = arg_47_0.stageIndex
		end

		local var_47_1 = 0

		underscore = var_1_10003

		local var_47_2 = var_1_10003.rest

		RyzaMiniGameConfig = var_1_10004

		local var_47_3 = var_47_2(var_1_10004.ENEMY_TYPE_LIST, 1)
		local var_47_4 = {}

		pg = var_5

		local var_47_5 = var_5.MiniGameTileMgr.GetInstance()
		local var_47_6 = var_5.getDataLayers(var_47_5, "BoomGame", "BoomLevel_" .. var_47_0)

		arg_47_0.config = {}

		local var_47_7 = arg_47_0.config

		NewPos = var_7
		var_47_7.mapSize = var_7(var_47_6[1].width, var_47_6[1].height)

		local var_47_8 = arg_47_0.config

		var_47_8.reactorList = {}
		ipairs = var_47_8

		for iter_47_0, iter_47_1 in var_47_8(var_47_6) do
			ipairs = var_1_10011

			for iter_47_2, iter_47_3 in var_1_10011(iter_47_1.layer) do
				if iter_47_3.item then
					local var_47_9 = {
						name = iter_47_3.item
					}

					if arg_47_0.stageIndex == 0 then
						isa = var_17
						RyzaMiniGameConfig = var_1_10018
						var_1_10018 = var_1_10018.CreateInfo(var_47_9.name)
						TargetMove = var_19

						if var_17(var_1_10018, var_19) then
							if var_47_9.name == "Ryza" then
								-- block empty
							else
								math = var_17

								local var_47_10 = var_17.random(#var_47_3)

								string = var_1_10018

								if var_1_10018.find(var_47_3[var_47_10], "BOSS_") then
									table = var_1_10018
									var_47_9.name = var_1_10018.remove(var_47_3, var_47_10)
									var_47_1 = var_47_1 + 1
									RyzaMiniGameConfig = var_1_10018

									if var_47_1 == var_1_10018.FREE_MAP_BOSS_LIMIT[var_47_0] then
										::label_47_0::

										string = var_1_10018

										if var_1_10018.find(var_47_3[#var_47_3], "BOSS_") then
											repeat
												table = var_1_10018

												var_1_10018.remove(var_47_3)

												goto label_47_0
											until true
										end
									end
								else
									var_47_9.name = var_47_3[var_47_10]
								end

								table = var_1_10018

								var_1_10018.insert(var_47_4, #arg_47_0.config.reactorList + 1)
							end

							goto label_47_1
						end
					end

					if iter_47_3.prop then
						pairs = var_17

						for iter_47_4, iter_47_5 in var_17(iter_47_3.prop) do
							var_47_9[iter_47_4] = iter_47_5
						end
					end

					::label_47_1::

					local var_47_11 = {
						(iter_47_3.index - 1) % arg_47_0.config.mapSize.x
					}

					math = var_1_10018
					var_47_11[2] = var_1_10018.floor((iter_47_3.index - 1) / arg_47_0.config.mapSize.x)
					var_47_9.pos = var_47_11
					table = var_47_11

					var_47_11.insert(arg_47_0.config.reactorList, var_47_9)
				end
			end
		end

		if arg_47_0.stageIndex == 0 and var_47_1 == 0 then
			math = var_6

			local var_47_12 = var_6.random(#var_47_4)
			local var_47_13 = arg_47_0.config.reactorList[var_47_12]

			arg_47_0.config.reactorList[var_47_12] = {
				name = "BOSS_" .. var_47_13.name,
				pos = var_47_13.pos
			}
		end

		return
	end
end

function var_0_1.buildMap(arg_48_0)
	setSizeDelta = var_1_10001

	var_1_10001(arg_48_0.rtMain, arg_48_0.config.mapSize * 32)

	eachChild = var_1_10001

	local var_48_0 = arg_48_0.rtMain

	var_1_10001(var_2.Find(var_48_0, "bg/NW"), function(arg_49_0)
		setActive = var_2_10001

		local var_49_0 = arg_49_0
		local var_49_1 = arg_49_0.name

		tostring = var_2_10004
		math = var_2_10005

		var_2_10001(var_49_0, var_49_1 == var_2_10004(var_2_10005.floor((arg_48_0.stageIndex - 1) % 8 / 2) + 1))

		return
	end)

	local var_48_1 = arg_48_0._tf
	local var_48_2 = var_1.Find(var_48_1, "Viewport").rect
	local var_48_3 = arg_48_0.rtMain.rect

	NewPos = var_3
	math = var_4

	local var_48_4 = var_4.max(var_48_3.width + 0 - var_48_2.width, 0)

	math = var_5
	arg_48_0.buffer = var_3(var_48_4, var_5.max(var_48_3.height + 160 - var_48_2.height, 0)) * 0.5
	Time = var_3

	local var_48_5 = var_3.realtimeSinceStartup
	local var_48_6 = arg_48_0.config.mapSize.x
	local var_48_7 = arg_48_0.config.mapSize.y

	UIItemList = var_6

	local var_48_8 = var_6.New
	local var_48_9 = arg_48_0.rtPlane
	local var_48_10 = arg_48_0.rtPlane
	local var_48_11 = var_48_8(var_48_9, var_8.GetChild(var_48_10, 0))

	var_6.make(var_48_11, function(arg_50_0, arg_50_1, arg_50_2)
		UIItemList = var_2_10003

		if arg_50_0 == var_2_10003.EventUpdate then
			local var_50_0 = arg_50_1 % var_48_7

			math = var_2_10004

			local var_50_1 = var_2_10004.floor(arg_50_1 / var_48_7)

			arg_50_2.name = var_50_0 .. "_" .. var_50_1
			math = var_5

			local var_50_2 = var_5.random()

			RyzaMiniGameConfig = var_6

			if var_50_2 < var_6.GRASS_CHAGNE_RATE then
				setImageAlpha = var_50_2

				var_50_2(arg_50_2, 1)

				var_50_2 = "Grass_"
				math = var_6
				var_50_2 = var_50_2 .. 3 + var_6.random(3)
				setImageSprite = var_6

				var_6(arg_50_2, arg_48_0.sprites[var_50_2])
			else
				setImageAlpha = var_50_2

				var_50_2(arg_50_2, 0)
			end
		end

		return
	end)
	var_6:align(var_48_6 * var_48_7)

	local var_48_12 = arg_48_0
	local var_48_13 = arg_48_0.soilMapPartition

	Vector2 = var_9

	var_48_13(var_48_12, var_9.zero, arg_48_0.config.mapSize)

	ipairs = var_48_13

	for iter_48_0, iter_48_1 in var_48_13(arg_48_0.config.reactorList) do
		arg_48_0:CreateReactor(iter_48_1)
	end

	return
end

function var_0_1.initController(arg_51_0)
	setText = var_1_10001

	var_1_10001(arg_51_0.rtScore, arg_51_0.scoreNum)

	setText = var_1_10001

	local var_51_0 = arg_51_0.rtTime

	string = var_3

	local var_51_1 = var_3.format
	local var_51_2 = "%02d:%02d"

	math = var_1_10005

	local var_51_3 = var_1_10005.floor(arg_51_0.countTime / 60)

	math = var_6

	var_1_10001(var_51_0, var_51_1(var_51_2, var_51_3, var_6.floor(arg_51_0.countTime % 60)))

	local var_51_4 = arg_51_0.responder.reactorRyza

	arg_51_0:updateControllerStatus(var_51_4, "hp", {
		num = var_51_4.hp
	})
	arg_51_0:updateControllerStatus(var_51_4, "bomb", {
		num = var_51_4.bomb
	})
	arg_51_0:updateControllerStatus(var_51_4, "power", {
		num = var_51_4.power
	})
	arg_51_0:updateControllerStatus(var_51_4, "speed", {
		num = var_51_4.speed
	})

	return
end

function var_0_1.updateControllerStatus(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	local var_52_0 = arg_52_0.reactorUIs[arg_52_1]

	isa = var_1_10005

	local var_52_1 = arg_52_1

	MoveRyza = var_1_10007

	if var_1_10005(var_52_1, var_1_10007) then
		if arg_52_2 == "hp" then
			eachChild = var_5

			var_5(arg_52_0.rtRyzaHP, function(arg_53_0)
				setActive = var_2_10001

				local var_53_0 = arg_53_0
				local var_53_1 = arg_53_0.Find(var_53_0, "active")

				tonumber = var_53_0

				var_2_10001(var_53_1, var_53_0(arg_53_0.name) <= arg_52_3.num)

				return
			end)
		else
			eachChild = var_5
			var_1_10007 = arg_52_0.rtStatus

			local var_52_2 = var_6.Find

			string = var_1_10008

			var_5(var_52_2(var_1_10007, var_1_10008.upper(arg_52_2) .. "/bit"), function(arg_54_0)
				setActive = var_2_10001

				local var_54_0 = arg_54_0

				tonumber = var_2_10003

				var_2_10001(var_54_0, var_2_10003(arg_54_0.name) <= arg_52_3.num)

				return
			end)
		end
	else
		isa = var_5

		local var_52_3 = arg_52_1

		MoveEnemy = var_1_10007

		if var_5(var_52_3, var_1_10007) then
			setSlider = var_5

			var_5(var_52_0:Find("hp"), 0, arg_52_3.max, arg_52_3.num)
		end
	end

	return
end

function var_0_1.popRyzaUI(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	isa = var_1_10004

	local var_55_0 = arg_55_1

	MoveRyza = var_1_10006

	if var_1_10004(var_55_0, var_1_10006) then
		local var_55_1 = arg_55_0.reactorUIs[arg_55_1]

		if arg_55_2 == "hp" then
			local var_55_2 = var_55_1:Find("pop/hp_" .. (arg_55_3.delta > 0 and "up" or "down"))

			for iter_55_0 = 1, 2 do
				setActive = var_1_10010

				var_1_10010(var_55_2:Find(iter_55_0), iter_55_0 * iter_55_0 == arg_55_3.delta * arg_55_3.delta)
			end

			setActive = var_6

			var_6(var_55_2, false)

			setActive = var_6

			var_6(var_55_2, true)
		else
			local var_55_3 = var_55_1
			local var_55_4 = var_55_1.Find(var_55_3, "pop/" .. arg_55_2 .. "_up")

			setActive = var_55_3

			var_55_3(var_55_4, false)

			setActive = var_55_3

			var_55_3(var_55_4, true)
		end
	end

	return
end

function var_0_1.CreateReactor(arg_56_0, arg_56_1)
	RyzaMiniGameConfig = var_1_10002

	local var_56_0, var_56_1, var_56_2 = var_1_10002.CreateInfo(arg_56_1.name)

	if not var_56_0 then
		warning = var_1_10005

		var_1_10005(arg_56_1.name)

		return
	end

	local var_56_3 = var_56_0.New
	local var_56_4 = arg_56_1

	cloneTplTo = var_1_10007

	local var_56_5 = arg_56_0.rtResource
	local var_56_6 = var_8.Find(var_56_5, var_56_1)
	local var_56_7 = arg_56_0.rtMain
	local var_56_8 = var_56_3(var_56_4, var_1_10007(var_56_6, var_9.Find(var_56_7, var_56_2)), arg_56_0.responder)

	isa = var_56_4

	local var_56_9 = var_56_8

	MoveRyza = var_56_11

	local var_56_10, var_56_11

	if var_56_4(var_56_9, var_56_11) then
		var_56_10 = arg_56_0.reactorUIs
		cloneTplTo = var_56_9
		var_56_10[var_56_8] = var_56_9(arg_56_0.tplUIRyza, arg_56_0.rtControllerUI)
		eachChild = var_56_10
		var_56_11 = arg_56_0.reactorUIs[var_56_8]

		var_56_10(var_7.Find(var_56_11, "pop"), function(arg_57_0)
			local var_57_0 = arg_57_0
			local var_57_1 = arg_57_0.GetComponent

			typeof = var_2_10003
			DftAniEvent = var_2_10004

			local var_57_2 = var_57_1(var_57_0, var_2_10003(var_2_10004))

			var_1.SetEndEvent(var_57_2, function()
				setActive = var_3_10000

				var_3_10000(arg_57_0, false)

				return
			end)

			return
		end)

		var_56_10 = arg_56_0.reactorUIs[var_56_8]
		var_56_10.position = var_56_8._tf.position
	else
		isa = var_56_10

		local var_56_12 = var_56_8

		MoveEnemy = var_56_11

		if var_56_10(var_56_12, var_56_11) then
			local var_56_13 = arg_56_0.reactorUIs

			cloneTplTo = var_56_12
			var_56_13[var_56_8] = var_56_12(arg_56_0.tplUIEnemy, arg_56_0.rtControllerUI)
			setAnchoredPosition = var_56_13

			local var_56_14 = arg_56_0.reactorUIs[var_56_8]

			var_56_13(var_7.Find(var_56_14, "hp"), {
				y = var_56_8:GetUIHeight()
			})

			arg_56_0.reactorUIs[var_56_8].position = var_56_8._tf.position
		end
	end

	return
end

function var_0_1.DestroyReactor(arg_59_0, arg_59_1, arg_59_2)
	if arg_59_0.reactorUIs[arg_59_1] then
		Destroy = var_3

		var_3(arg_59_0.reactorUIs[arg_59_1])

		arg_59_0.reactorUIs[arg_59_1] = nil
	end

	arg_59_0.scoreNum = arg_59_0.scoreNum + arg_59_2
	setText = var_3

	var_3(arg_59_0.rtScore, arg_59_0.scoreNum)

	return
end

function var_0_1.soilMapPartition(arg_60_0, arg_60_1, arg_60_2)
	RyzaMiniGameConfig = var_1_10003

	local var_60_0 = var_1_10003.SOIL_RANDOM_CONFIG

	math = var_1_10004

	local var_60_1 = var_1_10004.floor

	math = var_1_10005

	local var_60_2 = var_1_10005.min(arg_60_2.x, arg_60_2.y)
	local var_60_3 = var_60_0.size_rate[1]

	math = var_7

	if var_60_1(var_60_2 * (var_60_3 + var_7.random() * (var_60_0.size_rate[2] - var_60_0.size_rate[1]))) < 2 then
		return
	end

	math = var_5

	local var_60_4 = var_5.random(4) % 4
	local var_60_5 = arg_60_0
	local var_60_6 = arg_60_0.dealSoilMap

	NewPos = var_8

	local var_60_7 = arg_60_1.x
	local var_60_8

	if not (var_60_4 % 2 > 0) or not (arg_60_2.x - var_4) then
		var_60_8 = 0
	end

	local var_60_9 = var_60_7 + var_60_8
	local var_60_10 = arg_60_1.y
	local var_60_11

	if not (var_60_4 > 1) or not (arg_60_2.y - var_4) then
		var_60_11 = 0
	end

	var_60_6(var_60_5, var_8(var_60_9, var_60_10 + var_60_11), var_4)

	math = var_60_6

	local var_60_12 = var_4 + var_60_6.ceil((arg_60_2.x - var_4) * var_60_0.spacer_rate)

	math = var_7

	local var_60_13 = var_4 + var_7.ceil((arg_60_2.y - var_4) * var_60_0.spacer_rate)
	local var_60_16

	if arg_60_2.x > arg_60_2.y then
		local var_60_14 = arg_60_0
		local var_60_15 = arg_60_0.soilMapPartition

		NewPos = var_60_16
		var_60_16 = var_60_16(arg_60_1.x + (var_60_4 % 2 > 0 and 0 or var_60_12), arg_60_1.y)
		NewPos = var_11

		var_60_15(var_60_14, var_60_16, var_11(arg_60_2.x - var_60_12, arg_60_2.y))

		local var_60_17 = arg_60_0
		local var_60_18 = arg_60_0.soilMapPartition

		NewPos = var_60_16

		local var_60_19 = arg_60_1.x
		local var_60_20

		if not (var_60_4 % 2 > 0) or not (arg_60_2.x - var_4) then
			var_60_20 = 0
		end

		var_60_16 = var_60_16(var_60_19 + var_60_20, arg_60_1.y + (var_60_4 > 1 and 0 or var_60_13))
		NewPos = var_11

		var_60_18(var_60_17, var_60_16, var_11(var_4, arg_60_2.y - var_60_13))
	else
		local var_60_21 = arg_60_0
		local var_60_22 = arg_60_0.soilMapPartition

		NewPos = var_60_16

		local var_60_23 = arg_60_1.x + (var_60_4 % 2 > 0 and 0 or var_60_12)
		local var_60_24 = arg_60_1.y
		local var_60_25

		if not (var_60_4 > 1) or not (arg_60_2.y - var_4) then
			var_60_25 = 0
		end

		local var_60_26 = var_60_16(var_60_23, var_60_24 + var_60_25)

		NewPos = var_60_23

		var_60_22(var_60_21, var_60_26, var_60_23(arg_60_2.x - var_60_12, var_4))

		local var_60_27 = arg_60_0
		local var_60_28 = arg_60_0.soilMapPartition

		NewPos = var_60_26

		local var_60_29 = var_60_26(arg_60_1.x, arg_60_1.y + (var_60_4 > 1 and 0 or var_60_13))

		NewPos = var_11

		var_60_28(var_60_27, var_60_29, var_11(arg_60_2.x, arg_60_2.y - var_60_13))
	end

	return
end

local var_0_3 = {
	{
		0,
		1
	},
	{
		1,
		0
	},
	{
		0,
		-1
	},
	{
		-1,
		0
	}
}
local var_0_4 = {
	{
		0,
		1
	},
	{
		1,
		0
	},
	{
		0,
		-1
	},
	{
		-1,
		0
	},
	{
		1,
		1
	},
	{
		1,
		-1
	},
	{
		-1,
		-1
	},
	{
		-1,
		1
	}
}

function var_0_1.dealSoilMap(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = {}

	for iter_61_0 = 0, 3 do
		table = var_1_10008
		var_1_10008 = var_1_10008.insert
		var_1_10009 = var_61_0
		NewPos = var_1_10010

		local var_61_1

		if not (iter_61_0 % 2 > 0) or not (arg_61_2 - 1) then
			var_61_1 = 0
		end

		local var_61_2

		if not (iter_61_0 > 1) or not (arg_61_2 - 1) then
			var_61_2 = 0
		end

		var_1_10008(var_1_10009, arg_61_1 + var_1_10010(var_61_1, var_61_2))
	end

	local function var_61_3(arg_62_0)
		if arg_62_0.x < arg_61_1.x or arg_62_0.y < arg_61_1.y or arg_62_0.x >= arg_61_1.x + arg_61_2 or arg_62_0.y >= arg_61_1.y + arg_61_2 then
			return false
		else
			return true
		end

		return
	end

	local var_61_4 = {}

	local function var_61_5(arg_63_0)
		local var_63_0 = 0
		local var_63_1 = 1

		ipairs = var_2_10003

		for iter_63_0, iter_63_1 in var_2_10003(var_0_4) do
			NewPos = var_2_10008
			unpack = var_2_10009
			var_2_10008 = arg_63_0 + var_2_10008(var_2_10009(iter_63_1))

			if var_61_3(var_2_10008) then
				defaultValue = var_2_10009

				if var_2_10009(var_61_4[var_2_10008.x .. "_" .. var_2_10008.y], true) then
					var_63_0 = var_63_0 + var_63_1
				end
			end

			var_63_1 = var_63_1 + var_63_1
		end

		return var_63_0
	end

	local function var_61_6(arg_64_0)
		ipairs = var_2_10001

		for iter_64_0, iter_64_1 in var_2_10001(var_0_4) do
			NewPos = var_2_10006
			unpack = var_2_10007
			var_2_10006 = arg_64_0 + var_2_10006(var_2_10007(iter_64_1))

			if var_61_3(var_2_10006) then
				defaultValue = var_2_10007

				if var_2_10007(var_61_4[var_2_10006.x .. "_" .. var_2_10006.y], true) then
					RyzaMiniGameConfig = var_2_10007

					if not var_2_10007.SOIL_SPRITES_DIC[var_61_5(var_2_10006)] then
						return false
					end
				end
			end
		end

		return true
	end

	local var_61_7 = 0

	RyzaMiniGameConfig = var_1_10009

	local var_61_8 = var_1_10009.SOIL_RANDOM_CONFIG.cancel_rate
	local var_61_9
	local var_61_10 = 0

	while var_61_10 < #var_61_0 do
		var_61_4[var_61_0[var_61_10 + 1].x .. "_" .. var_10.y] = false
		math = var_12

		if var_12.random() < var_61_8[1] + var_61_8[2] * (1 - var_61_7 / arg_61_2 / arg_61_2) * (1 - var_61_7 / arg_61_2 / arg_61_2) and var_61_6(var_10) then
			var_61_7 = var_61_7 + 1
		else
			var_61_4[var_10.x .. "_" .. var_10.y] = true
		end

		ipairs = var_12

		for iter_61_1, iter_61_2 in var_12(var_0_3) do
			NewPos = var_1_10017
			unpack = var_1_10018
			var_1_10017 = var_10 + var_1_10017(var_1_10018(iter_61_2))

			if var_61_3(var_1_10017) and var_61_4[var_1_10017.x .. "_" .. var_1_10017.y] == nil then
				table = var_1_10018

				var_1_10018.insert(var_61_0, var_1_10017)
			end
		end
	end

	local var_61_11 = arg_61_0.config.mapSize.x
	local var_61_12 = arg_61_0.config.mapSize.y

	for iter_61_3 = arg_61_1.x, arg_61_1.x + arg_61_2 - 1 do
		for iter_61_4 = arg_61_1.y, arg_61_1.y + arg_61_2 - 1 do
			defaultValue = var_1_10022

			if var_1_10022(var_61_4[iter_61_3 .. "_" .. iter_61_4], true) then
				RyzaMiniGameConfig = var_1_10022
				var_1_10022 = var_1_10022.SOIL_SPRITES_DIC

				local var_61_13 = var_61_5

				NewPos = var_24
				var_1_10022 = var_1_10022[var_61_13(var_24(iter_61_3, iter_61_4))]
				assert = var_23

				var_23(var_1_10022)

				local var_61_14 = arg_61_0.rtPlane
				local var_61_15 = var_23.GetChild(var_61_14, iter_61_4 * var_61_11 + iter_61_3)

				setImageAlpha = var_61_14

				var_61_14(var_61_15, 1)

				setImageSprite = var_61_14

				var_61_14(var_61_15, arg_61_0.sprites[var_1_10022])
			end
		end
	end

	return
end

function var_0_1.startTimer(arg_65_0)
	if not arg_65_0.timer.running then
		local var_65_0 = arg_65_0.timer

		var_1.Start(var_65_0)
	end

	local var_65_1 = arg_65_0.uiMgr

	var_1.AttachStickOb(var_65_1, arg_65_0.rtJoyStick)
	var_0_2(arg_65_0.rtMain, 1)

	return
end

function var_0_1.stopTimer(arg_66_0)
	if arg_66_0.timer.running then
		local var_66_0 = arg_66_0.timer

		var_1.Stop(var_66_0)
	end

	local var_66_1 = arg_66_0.uiMgr

	var_1.ClearStick(var_66_1)
	var_0_2(arg_66_0.rtMain, 0)

	return
end

function var_0_1.onTimer(arg_67_0)
	local var_67_0 = arg_67_0.countTime

	RyzaMiniGameConfig = var_1_10002
	arg_67_0.countTime = var_67_0 + var_1_10002.TIME_INTERVAL
	setText = var_1

	local var_67_1 = arg_67_0.rtTime

	string = var_1_10003

	local var_67_2 = var_1_10003.format
	local var_67_3 = "%02d:%02d"

	math = var_1_10005

	local var_67_4 = var_1_10005.floor(arg_67_0.countTime / 60)

	math = var_6

	var_1(var_67_1, var_67_2(var_67_3, var_67_4, var_6.floor(arg_67_0.countTime % 60)))

	local var_67_5 = arg_67_0.responder
	local var_67_6 = var_1.TimeFlow

	RyzaMiniGameConfig = var_3

	var_67_6(var_67_5, var_3.TIME_INTERVAL)

	pairs = var_67_6

	for iter_67_0, iter_67_1 in var_67_6(arg_67_0.reactorUIs) do
		iter_67_1.position = iter_67_0._tf.position
	end

	local var_67_7 = arg_67_0.responder

	if var_1.GetJoyStick(var_67_7).x ~= 0 or var_1.y ~= 0 then
		RyzaMiniGameConfig = var_2

		local var_67_8 = var_2.ReSetDir(var_1)
		local var_67_9 = arg_67_0.reactorUIs[arg_67_0.responder.reactorRyza]
		local var_67_10 = var_2.Find(var_67_9, "dir")
		local var_67_13

		if var_67_8.x == 0 then
			setLocalEulerAngles = var_3

			local var_67_11 = var_67_10
			local var_67_12 = {}

			var_67_13 = var_67_8.y > 0 and 270 or 90
			var_67_12.z = var_67_13

			var_3(var_67_11, var_67_12)
		else
			setLocalEulerAngles = var_3

			local var_67_14 = var_67_10
			local var_67_15 = {}

			math = var_67_13

			local var_67_16 = var_67_13.atan2(-var_67_8.y, var_67_8.x)

			math = var_7
			var_67_15.z = var_67_16 / var_7.pi * 180

			var_3(var_67_14, var_67_15)
		end
	end

	return
end

function var_0_1.OnApplicationPaused(arg_68_0, arg_68_1)
	if arg_68_1 then
		-- block empty
	end

	return
end

function var_0_1.onBackPressed(arg_69_0)
	switch = var_1_10001

	var_1_10001(arg_69_0.status, {
		main = function()
			var_0_1.super.onBackPressed(arg_69_0)

			return
		end,
		countdown = function()
			return
		end,
		pause = function()
			local var_72_0 = arg_69_0

			var_0.openUI(var_72_0)

			local var_72_1 = arg_69_0

			var_0.resumeGame(var_72_1)

			return
		end,
		exit = function()
			local var_73_0 = arg_69_0

			var_0.openUI(var_73_0)

			local var_73_1 = arg_69_0

			var_0.resumeGame(var_73_1)

			return
		end,
		result = function()
			return
		end
	}, function()
		assert = var_2_10000

		var_2_10000(arg_69_0.gameStartFlag, "game start false")

		local var_75_0 = arg_69_0

		var_0.openUI(var_75_0, "pause")

		return
	end)

	return
end

function var_0_1.willExit(arg_76_0)
	return
end

return var_0_1
