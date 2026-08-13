class = var_0_10000

local var_0_0 = "GameRoomQTEView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))

function var_0_1.getUIName(arg_1_0)
	return "GameRoomQTEUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0.STATE_BEGIN = 1
	arg_2_0.STATE_COUNT = 2
	arg_2_0.STATE_CLICK = 3
	arg_2_0.STATE_SHOW = 4
	arg_2_0.STATE_END = 5
	arg_2_0.gameState = -1
	arg_2_0.typeNum = 3
	arg_2_0.idNum = 3
	arg_2_0.limitNum = 5
	arg_2_0.TYPE_A = 1
	arg_2_0.TYPE_B = 2
	arg_2_0.TYPE_C = 3
	arg_2_0.ITEM_ID_1 = 1
	arg_2_0.ITEM_ID_2 = 2
	arg_2_0.ITEM_ID_3 = 3

	local var_2_0 = arg_2_0._tf

	arg_2_0.startUI = var_1.Find(var_2_0, "start_ui")

	local var_2_1 = arg_2_0.startUI

	arg_2_0.startBtn = var_1.Find(var_2_1, "start_btn")

	local var_2_2 = arg_2_0.startUI

	arg_2_0.ruleBtn = var_1.Find(var_2_2, "rule_btn")

	local var_2_3 = arg_2_0.startUI

	arg_2_0.qBtn = var_1.Find(var_2_3, "q_btn")

	local var_2_4 = arg_2_0._tf

	arg_2_0.countUI = var_1.Find(var_2_4, "count_ui")

	local var_2_5 = arg_2_0.countUI

	arg_2_0.countNumTxt = var_1.Find(var_2_5, "num")

	local var_2_6 = arg_2_0._tf

	arg_2_0.endUI = var_1.Find(var_2_6, "end_ui")

	local var_2_7 = arg_2_0.endUI

	arg_2_0.endExitBtn = var_1.Find(var_2_7, "exit_btn")

	local var_2_8 = arg_2_0.endUI

	arg_2_0.endBestTxt = var_1.Find(var_2_8, "rope/paper/best_txt")

	local var_2_9 = arg_2_0.endUI

	arg_2_0.endScoreTxt = var_1.Find(var_2_9, "rope/paper/score_txt")

	local var_2_10 = arg_2_0.endUI

	arg_2_0.endComboTxt = var_1.Find(var_2_10, "rope/paper/combo_txt")

	local var_2_11 = arg_2_0.endUI

	arg_2_0.endMissTxt = var_1.Find(var_2_11, "rope/paper/miss_txt")

	local var_2_12 = arg_2_0.endUI

	arg_2_0.endHitTxt = var_1.Find(var_2_12, "rope/paper/hit_txt")

	local var_2_13 = arg_2_0.endUI
	local var_2_14 = var_1.Find(var_2_13, "rope")

	arg_2_0.endUIEvent = var_1.GetComponent(var_2_14, "DftAniEvent")

	local var_2_15 = arg_2_0._tf

	arg_2_0.content = var_1.Find(var_2_15, "content")

	local var_2_16 = arg_2_0._tf

	arg_2_0.res = var_1.Find(var_2_16, "res")

	local var_2_17 = arg_2_0.content

	arg_2_0.gameBg = var_1.Find(var_2_17, "game_bg")

	local var_2_18 = arg_2_0.content

	arg_2_0.xgmPos = var_1.Find(var_2_18, "xiongguimao_pos")

	local var_2_19 = arg_2_0.content

	arg_2_0.guinuPos = var_1.Find(var_2_19, "guinu_pos")

	local var_2_20 = arg_2_0._tf

	arg_2_0.bucketA = var_1.Find(var_2_20, "content/bucket_A")

	local var_2_21 = arg_2_0.bucketA

	arg_2_0.bucketASpine = var_1.GetComponent(var_2_21, "SpineAnimUI")

	local var_2_22 = arg_2_0.bucketA

	arg_2_0.bucketAGraphic = var_1.GetComponent(var_2_22, "SkeletonGraphic")

	local var_2_23 = arg_2_0._tf

	arg_2_0.bucketB = var_1.Find(var_2_23, "content/bucket_B")

	local var_2_24 = arg_2_0.bucketB

	arg_2_0.bucketBSpine = var_1.GetComponent(var_2_24, "SpineAnimUI")

	local var_2_25 = arg_2_0.bucketB

	arg_2_0.bucketBGraphic = var_1.GetComponent(var_2_25, "SkeletonGraphic")

	local var_2_26 = arg_2_0._tf

	arg_2_0.bucketC = var_1.Find(var_2_26, "content/bucket_C")

	local var_2_27 = arg_2_0.bucketC

	arg_2_0.msHand = var_1.Find(var_2_27, "ani")

	local var_2_28 = arg_2_0.msHand

	arg_2_0.msHandAnimator = var_1.GetComponent(var_2_28, "Animator")

	local var_2_29 = arg_2_0.msHand

	arg_2_0.msHandSlot = var_1.Find(var_2_29, "slot")

	local var_2_30 = arg_2_0.msHand

	arg_2_0.msHandEvent = var_1.GetComponent(var_2_30, "DftAniEvent")
	arg_2_0.msBlockList = {}

	local var_2_31 = arg_2_0.msHandEvent

	var_1.SetEndEvent(var_2_31, function()
		local var_3_0 = arg_2_0

		var_0.msClearHold(var_3_0)

		setActive = var_0

		var_0(arg_2_0.msHand, false)

		return
	end)

	arg_2_0.xgmAnimLength = {
		idle = 1,
		attack = 1
	}
	arg_2_0.xgmAnimTargetLength = {
		idle = 1,
		attack = 0.5
	}
	arg_2_0.guinuAnimLength = {
		attack = 1,
		normal = 4.667
	}
	arg_2_0.guinuAnimTargetLength = {
		attack = 1,
		normal = 4.667
	}
	arg_2_0.bucketAAnimLength = {
		idle = 0.167,
		attack = 0.8
	}
	arg_2_0.bucketAAnimTargetLength = {
		idle = 1,
		attack = 0.6
	}
	arg_2_0.bucketBAnimLength = {
		idle = 0.167,
		attack = 0.8
	}
	arg_2_0.bucketBAnimTargetLength = {
		idle = 1,
		attack = 0.6
	}

	local var_2_32 = arg_2_0.bucketB

	arg_2_0.cut1 = var_1.Find(var_2_32, "cut_1")

	local var_2_33 = arg_2_0.bucketB

	arg_2_0.cut2 = var_1.Find(var_2_33, "cut_2")

	local var_2_34 = arg_2_0.bucketB

	arg_2_0.cut3 = var_1.Find(var_2_34, "cut_3")

	local var_2_35 = arg_2_0.cut1

	arg_2_0.cut1Animator = var_1.GetComponent(var_2_35, "Animator")

	local var_2_36 = arg_2_0.cut2

	arg_2_0.cut2Animator = var_1.GetComponent(var_2_36, "Animator")

	local var_2_37 = arg_2_0.cut3

	arg_2_0.cut3Animator = var_1.GetComponent(var_2_37, "Animator")

	local var_2_38 = arg_2_0.cut1

	arg_2_0.cut1Event = var_1.GetComponent(var_2_38, "DftAniEvent")

	local var_2_39 = arg_2_0.cut2

	arg_2_0.cut2Event = var_1.GetComponent(var_2_39, "DftAniEvent")

	local var_2_40 = arg_2_0.cut3

	arg_2_0.cut3Event = var_1.GetComponent(var_2_40, "DftAniEvent")

	local var_2_41 = arg_2_0.cut1Event

	var_1.SetEndEvent(var_2_41, function()
		setActive = var_2_10000

		var_2_10000(arg_2_0.cut1, false)

		return
	end)

	local var_2_42 = arg_2_0.cut2Event

	var_1.SetEndEvent(var_2_42, function()
		setActive = var_2_10000

		var_2_10000(arg_2_0.cut2, false)

		return
	end)

	local var_2_43 = arg_2_0.cut3Event

	var_1.SetEndEvent(var_2_43, function()
		setActive = var_2_10000

		var_2_10000(arg_2_0.cut3, false)

		return
	end)

	local var_2_44 = arg_2_0.content

	arg_2_0.keyUI = var_1.Find(var_2_44, "key_ui")

	local var_2_45 = arg_2_0.keyUI

	arg_2_0.keyBar = var_1.Find(var_2_45, "key_bar")

	local var_2_46 = arg_2_0.keyUI

	arg_2_0.aBtn = var_1.Find(var_2_46, "A_btn")

	local var_2_47 = arg_2_0.keyUI

	arg_2_0.bBtn = var_1.Find(var_2_47, "B_btn")

	local var_2_48 = arg_2_0.keyUI

	arg_2_0.cBtn = var_1.Find(var_2_48, "C_btn")

	local var_2_49 = arg_2_0.content
	local var_2_50 = var_1.Find(var_2_49, "combo_bar/center")

	arg_2_0.comboAni = var_1.GetComponent(var_2_50, "Animator")

	local var_2_51 = arg_2_0.content

	arg_2_0.comboTxt = var_1.Find(var_2_51, "combo_bar/center/combo_txt")
	arg_2_0.comboAni.enabled = false

	local var_2_52 = arg_2_0.content

	arg_2_0.scoreTxt = var_1.Find(var_2_52, "score_bar/txt")

	local var_2_53 = arg_2_0.content

	arg_2_0.remainTxt = var_1.Find(var_2_53, "remain_time_bar/txt")

	local var_2_54 = arg_2_0.keyUI

	arg_2_0.roundTxt = var_1.Find(var_2_54, "round_time_bar/txt")

	local var_2_55 = arg_2_0._tf

	arg_2_0.firePos = var_1.Find(var_2_55, "content/pos/fire_pos").anchoredPosition

	local var_2_56 = arg_2_0._tf

	arg_2_0.hitPos = var_1.Find(var_2_56, "content/pos/hit_pos").anchoredPosition

	local var_2_57 = arg_2_0._tf

	arg_2_0.aPos = var_1.Find(var_2_57, "content/pos/a_pos").anchoredPosition

	local var_2_58 = arg_2_0._tf

	arg_2_0.bPos = var_1.Find(var_2_58, "content/pos/b_pos").anchoredPosition

	local var_2_59 = arg_2_0._tf

	arg_2_0.cPos = var_1.Find(var_2_59, "content/pos/c_pos").anchoredPosition

	local var_2_60 = arg_2_0._tf

	arg_2_0.missPos = var_1.Find(var_2_60, "content/pos/miss_pos").anchoredPosition

	local var_2_61 = arg_2_0.content

	arg_2_0.backBtn = var_1.Find(var_2_61, "back_btn")
	AutoLoader = var_1
	arg_2_0.autoLoader = var_1.New()

	local var_2_62 = arg_2_0.autoLoader

	var_1.LoadSprite(var_2_62, "ui/minigameui/qtegameuiasync_atlas", "background", arg_2_0.gameBg, false)

	return
end

function var_0_1.didEnter(arg_7_0)
	arg_7_0:initGame()

	onButton = var_1

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.backBtn

	local function var_7_2()
		local var_8_0 = arg_7_0

		var_0.SendSuccess(var_8_0, arg_7_0.score)

		local var_8_1 = arg_7_0

		var_0.setGameState(var_8_1, arg_7_0.STATE_BEGIN)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_7_0, var_7_1, var_7_2, var_1_10006)

	onButton = var_1

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.qBtn

	local function var_7_5()
		local var_9_0 = arg_7_0

		var_0.emit(var_9_0, var_0_1.ON_BACK)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_7_3, var_7_4, var_7_5, var_1_10006)

	if arg_7_0:getGameRoomData() then
		arg_7_0.gameHelpTip = arg_7_0:getGameRoomData().game_help
	end

	onButton = var_1

	var_1(arg_7_0, arg_7_0.ruleBtn, function()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_10_2.type = var_2_10004
		var_10_2.helps = arg_7_0.gameHelpTip

		var_10_1(var_10_0, var_10_2)

		return
	end)

	onButton = var_1

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.startBtn

	local function var_7_8()
		setButtonEnabled = var_2_10000

		var_2_10000(arg_7_0.startBtn, false)

		parallelAsync = var_2_10000

		var_2_10000({
			function(arg_12_0)
				local var_12_0 = arg_7_0

				var_1.loadXGM(var_12_0, arg_12_0)

				return
			end,
			function(arg_13_0)
				local var_13_0 = arg_7_0

				var_1.loadGuinu(var_13_0, arg_13_0)

				return
			end
		}, function()
			local var_14_0 = arg_7_0

			var_0.setGameState(var_14_0, arg_7_0.STATE_COUNT)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_7_6, var_7_7, var_7_8, var_1_10006)

	QTEGAME_DEBUG = var_1

	if var_1 then
		onButton = var_1

		var_1(arg_7_0, arg_7_0.xgm, function()
			local var_15_0 = arg_7_0

			var_0.setGameState(var_15_0, arg_7_0.STATE_SHOW)

			return
		end)
	end

	onButton = var_1

	local var_7_9 = arg_7_0
	local var_7_10 = arg_7_0.endExitBtn

	local function var_7_11()
		local var_16_0 = arg_7_0

		var_0.emit(var_16_0, var_0_1.ON_BACK)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_7_9, var_7_10, var_7_11, var_1_10006)

	local var_7_12 = arg_7_0.endUIEvent

	var_1.SetEndEvent(var_7_12, function()
		local var_17_0 = arg_7_0

		var_0.SendSuccess(var_17_0, arg_7_0.score)

		setActive = var_0

		var_0(arg_7_0.endExitBtn, true)

		return
	end)

	local function var_7_13(arg_18_0)
		if arg_7_0.gameState == arg_7_0.STATE_CLICK and arg_7_0.curShowBlock then
			local var_18_0 = arg_7_0.curShowBlock

			var_1.select(var_18_0, arg_18_0)

			arg_7_0.curShowBlock = arg_7_0.curShowBlock.nextBlock

			if arg_7_0.curShowBlock == nil then
				local var_18_1 = arg_7_0
				local var_18_2 = var_1.managedTween

				LeanTween = var_4

				var_18_2(var_18_1, var_4.delayedCall, function()
					local var_19_0 = arg_7_0

					var_0.setGameState(var_19_0, arg_7_0.STATE_SHOW)

					return
				end, 0.2, nil)
			end
		end

		return
	end

	onButton = var_1_10002

	local var_7_14 = arg_7_0
	local var_7_15 = arg_7_0.aBtn

	local function var_7_16()
		var_7_13(arg_7_0.TYPE_A)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_7_14, var_7_15, var_7_16, var_1_10007)

	onButton = var_1_10002

	local var_7_17 = arg_7_0
	local var_7_18 = arg_7_0.bBtn

	local function var_7_19()
		var_7_13(arg_7_0.TYPE_B)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_7_17, var_7_18, var_7_19, var_1_10007)

	onButton = var_1_10002

	local var_7_20 = arg_7_0
	local var_7_21 = arg_7_0.cBtn

	local function var_7_22()
		var_7_13(arg_7_0.TYPE_C)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_7_20, var_7_21, var_7_22, var_1_10007)
	arg_7_0:setGameState(arg_7_0.STATE_BEGIN)
	arg_7_0:checkHelp()

	return
end

function var_0_1.initGame(arg_23_0)
	arg_23_0.curShowBlock = nil
	arg_23_0.randomBlockList = nil

	local var_23_0 = arg_23_0:GetMGData()

	arg_23_0.scorePerHit = var_1.GetSimpleValue(var_23_0, "scorePerHit")

	local var_23_1 = arg_23_0:GetMGData()

	arg_23_0.comboRange = var_1.GetSimpleValue(var_23_1, "comboRange")

	local var_23_2 = arg_23_0:GetMGData()

	arg_23_0.comboAddScore = var_1.GetSimpleValue(var_23_2, "comboAddScore")

	local var_23_3 = arg_23_0:GetMGData()

	arg_23_0.targetCombo = var_1.GetSimpleValue(var_23_3, "targetCombo")

	local var_23_4 = arg_23_0:GetMGData()

	arg_23_0.targetComboScore = var_1.GetSimpleValue(var_23_4, "targetComboScore")
	arg_23_0.usingBlockList = {}
	arg_23_0.blockUniId = 0

	arg_23_0:resetGame()

	local var_23_5 = arg_23_0.bucketASpine

	var_1.SetActionCallBack(var_23_5, function(arg_24_0)
		if arg_24_0 == "FINISH" then
			local var_24_0 = arg_23_0

			var_1.setBucketAAction(var_24_0, "idle")
		end

		return
	end)

	local var_23_6 = arg_23_0.bucketBSpine

	var_1.SetActionCallBack(var_23_6, function(arg_25_0)
		if arg_25_0 == "FINISH" then
			local var_25_0 = arg_23_0

			var_1.setBucketBAction(var_25_0, "idle")
		end

		return
	end)

	return
end

function var_0_1.resetGame(arg_26_0)
	arg_26_0:setXgmAction("idle")
	arg_26_0:setGuinuAction("normal")
	arg_26_0:setBucketAAction("idle")
	arg_26_0:setBucketBAction("idle")

	setActive = var_1

	var_1(arg_26_0.msHand, false)

	arg_26_0.score = 0
	arg_26_0.bestComboNum = 0
	arg_26_0.comboNum = 0
	arg_26_0.missNum = 0
	arg_26_0.hitNum = 0

	local var_26_0 = arg_26_0:GetMGData()

	arg_26_0.remainTime = var_1.GetSimpleValue(var_26_0, "gameTime")

	local var_26_1 = arg_26_0:GetMGData()

	arg_26_0.roundTime = var_1.GetSimpleValue(var_26_1, "roundTime")
	setText = var_1

	var_1(arg_26_0.comboTxt, 0)

	setText = var_1

	var_1(arg_26_0.scoreTxt, 0)

	setText = var_1

	var_1(arg_26_0.remainTxt, arg_26_0.remainTime .. "S")

	setText = var_1

	var_1(arg_26_0.roundTxt, arg_26_0.roundTime)
	arg_26_0:clearTimer()
	arg_26_0:hideRandomList()
	arg_26_0:clearUsingBlock()
	arg_26_0:cleanManagedTween()

	return
end

function var_0_1.setGameState(arg_27_0, arg_27_1)
	if arg_27_1 == arg_27_0.gameState then
		return
	end

	arg_27_0.gameState = arg_27_1

	local function var_27_0(arg_28_0)
		local var_28_0 = {
			arg_27_0.startUI,
			arg_27_0.content,
			arg_27_0.endUI,
			arg_27_0.countUI,
			arg_27_0.keyUI,
			arg_27_0.keyBar
		}

		pairs = var_2

		for iter_28_0, iter_28_1 in var_2(var_28_0) do
			table = var_2_10007

			if var_2_10007.indexof(arg_28_0, iter_28_1) then
				var_2_10007 = true
			end

			setActive = var_2_10008

			var_2_10008(iter_28_1, var_2_10007)
		end

		isActive = var_2

		if var_2(arg_27_0.endUI) then
			pg = var_2

			local var_28_1 = var_2.UIMgr.GetInstance()

			var_2.BlurPanel(var_28_1, arg_27_0.endUI)
		else
			pg = var_2

			local var_28_2 = var_2.UIMgr.GetInstance()

			var_2.UnOverlayPanel(var_28_2, arg_27_0.endUI, arg_27_0._tf)
		end

		return
	end

	if arg_27_0.gameState == arg_27_0.STATE_BEGIN then
		arg_27_0:openCoinLayer(true)

		setButtonEnabled = var_3

		var_3(arg_27_0.startBtn, true)
		var_27_0({
			arg_27_0.startUI
		})
		arg_27_0:resetGame()
	elseif arg_27_0.gameState == arg_27_0.STATE_COUNT then
		arg_27_0:openCoinLayer(false)
		var_27_0({
			arg_27_0.countUI,
			arg_27_0.content
		})

		Time = var_3

		local var_27_1 = var_3.realtimeSinceStartup
		local var_27_2 = arg_27_0
		local var_27_3 = arg_27_0.managedTween

		LeanTween = var_1_10007

		local var_27_4 = var_27_3(var_27_2, var_1_10007.delayedCall, function()
			local var_29_0 = arg_27_0

			var_0.startGameTimer(var_29_0)

			local var_29_1 = arg_27_0

			var_0.setGameState(var_29_1, arg_27_0.STATE_CLICK)

			return
		end, 3, nil)
		local var_27_5 = var_4.setOnUpdate

		System = var_7

		var_27_5(var_27_4, var_7.Action_float(function(arg_30_0)
			setText = var_2_10001

			local var_30_0 = arg_27_0.countNumTxt

			math = var_2_10004

			local var_30_1 = var_2_10004.ceil

			Time = var_2_10006

			var_2_10001(var_30_0, var_30_1(3 - (var_2_10006.realtimeSinceStartup - var_27_1)))

			return
		end))
	elseif arg_27_0.gameState == arg_27_0.STATE_CLICK then
		var_27_0({
			arg_27_0.content,
			arg_27_0.keyUI,
			arg_27_0.keyBar
		})

		arg_27_0.randomBlockList, arg_27_0.curShowBlock, arg_27_0.firstShowBlock = arg_27_0:getRandomList()

		arg_27_0:startRoundTimer()
	elseif arg_27_0.gameState == arg_27_0.STATE_SHOW then
		var_27_0({
			arg_27_0.content
		})
		arg_27_0:hideRandomList()
		arg_27_0:playArchiveAnim(arg_27_0.randomBlockList, arg_27_0:getUserResult())
	elseif arg_27_0.gameState == arg_27_0.STATE_END then
		var_27_0({
			arg_27_0.content,
			arg_27_0.endUI
		})

		setActive = var_3

		var_3(arg_27_0.endExitBtn, false)

		local var_27_6 = 0
		local var_27_7 = arg_27_0:GetMGData()

		if var_4.GetRuntimeData(var_27_7, "elements") and #var_4 > 0 then
			var_27_6 = var_4[1]
		end

		if var_27_6 < arg_27_0.score then
			var_27_6 = arg_27_0.score

			arg_27_0:StoreDataToServer({
				var_27_6
			})
		end

		setText = var_5

		var_5(arg_27_0.endBestTxt, var_27_6)

		setText = var_5

		var_5(arg_27_0.endScoreTxt, arg_27_0.score)

		setText = var_5

		var_5(arg_27_0.endComboTxt, arg_27_0.bestComboNum)

		setText = var_5

		var_5(arg_27_0.endMissTxt, arg_27_0.missNum)

		setText = var_5

		var_5(arg_27_0.endHitTxt, arg_27_0.hitNum)
		arg_27_0:clearTimer()
	end

	return
end

function var_0_1.fireBlocks(arg_31_0)
	local var_31_0 = arg_31_0.opIndex
	local var_31_1 = arg_31_0.arBlockList[var_31_0].type
	local var_31_2 = arg_31_0.arBlockList[var_31_0].id
	local var_31_3 = arg_31_0.opList[var_31_0]
	local var_31_4 = arg_31_0:getBlock(var_31_1, var_31_2).tf

	arg_31_0:addUsingBlock(var_5)

	local var_31_5

	if var_31_3 then
		if var_31_1 == arg_31_0.TYPE_A then
			var_31_5 = arg_31_0.aPos
		elseif var_31_1 == arg_31_0.TYPE_B then
			var_31_5 = arg_31_0.bPos
		elseif var_31_1 == arg_31_0.TYPE_C then
			var_31_5 = arg_31_0.cPos
		end
	else
		var_31_5 = arg_31_0.missPos
	end

	var_31_4.anchoredPosition = arg_31_0.firePos

	arg_31_0:hitFly(var_31_4, 0.5, arg_31_0.hitPos, function()
		var_31_4.anchoredPosition = arg_31_0.hitPos

		local var_32_0

		if var_31_3 then
			var_32_0 = 0.4

			local var_32_1 = arg_31_0.parabolaMove

			if var_31_1 == arg_31_0.TYPE_A then
				var_32_0 = 0.3
				var_32_1 = arg_31_0.parabolaMove_center

				local var_32_2 = arg_31_0

				var_2.setBucketAAction(var_32_2, "attack")
			elseif var_31_1 == arg_31_0.TYPE_B then
				local var_32_3 = arg_31_0
				local var_32_4 = var_2.managedTween

				LeanTween = var_2_10005

				var_32_4(var_32_3, var_2_10005.delayedCall, function()
					local var_33_0 = arg_31_0

					var_0.setBucketBAction(var_33_0, "attack")

					return
				end, 0.2, nil)
			elseif var_31_1 == arg_31_0.TYPE_C then
				var_32_0 = 0.3
				var_32_1 = arg_31_0.parabolaMove_center
				setActive = var_2

				var_2(arg_31_0.msHand, true)

				local var_32_5 = arg_31_0.msHandAnimator

				var_2.Play(var_32_5, "mingshi_hand", -1, 0)
			end

			var_32_1(arg_31_0, var_31_4, var_32_0, var_31_5, function()
				if var_31_1 == arg_31_0.TYPE_A then
					local var_34_0 = arg_31_0

					var_0.removeUsingBlock(var_34_0, var_0)

					local var_34_1 = arg_31_0

					var_0.showBucketAEffect(var_34_1)

					pg = var_0

					local var_34_2 = var_0.CriMgr.GetInstance()

					var_0.PlaySE_V3(var_34_2, "ui-minigame_hitcake")
				elseif var_31_1 == arg_31_0.TYPE_B then
					setActive = var_0

					var_0(arg_31_0["cut" .. var_31_2], true)

					local var_34_3 = arg_31_0["cut" .. var_31_2 .. "Animator"]

					var_0.Play(var_34_3, "cut_fruit", -1, 0)

					local var_34_4 = arg_31_0

					var_0.removeUsingBlock(var_34_4, var_0)

					pg = var_0

					local var_34_5 = var_0.CriMgr.GetInstance()

					var_0.PlaySE_V3(var_34_5, "ui-minigame_sword")
				elseif var_31_1 == arg_31_0.TYPE_C then
					local var_34_6 = arg_31_0

					var_0.msClearHold(var_34_6)

					local var_34_7 = arg_31_0

					var_0.msHoldBlock(var_34_7, var_0)
				end

				local var_34_8 = arg_31_0

				var_0.checkEnd(var_34_8, var_31_0)

				return
			end)
		else
			local var_32_6 = arg_31_0

			var_32_0.hitFly(var_32_6, var_31_4, 0.6, var_31_5, function()
				local var_35_0 = arg_31_0

				var_0.removeUsingBlock(var_35_0, var_0)

				local var_35_1 = arg_31_0

				var_0.checkEnd(var_35_1, var_31_0)

				return
			end)
		end

		pg = var_32_0

		local var_32_7 = var_32_0.CriMgr.GetInstance()

		var_0.PlaySE_V3(var_32_7, "ui-minigame_hitwood")

		local var_32_8 = arg_31_0

		var_0.countScore(var_32_8, var_31_3)

		return
	end)

	local var_31_6 = arg_31_0
	local var_31_7 = arg_31_0.managedTween

	LeanTween = var_11

	var_31_7(var_31_6, var_11.delayedCall, function()
		local var_36_0 = arg_31_0

		var_0.setGuinuAction(var_36_0, "attack")

		return
	end, 0.2, nil)

	return
end

function var_0_1.getRandomList(arg_37_0)
	if not arg_37_0.allList then
		arg_37_0.allList = {}

		for iter_37_0 = 1, arg_37_0.typeNum do
			for iter_37_1 = 1, arg_37_0.idNum do
				arg_37_0.allList[#arg_37_0.allList + 1] = {
					type = iter_37_0,
					id = iter_37_1
				}
			end
		end
	end

	Clone = var_1

	local var_37_0 = var_1(arg_37_0.allList)
	local var_37_1 = {}

	for iter_37_2 = 1, arg_37_0.limitNum do
		local var_37_2 = #var_37_1 + 1

		table = iter_37_1
		iter_37_1 = iter_37_1.remove

		local var_37_3 = var_37_0

		math = var_1_10011
		var_37_1[var_37_2] = iter_37_1(var_37_3, var_1_10011.random(1, #var_37_0))
	end

	local var_37_4
	local var_37_5
	local var_37_6

	ipairs = iter_37_2

	for iter_37_3, iter_37_4 in iter_37_2(var_37_1) do
		local var_37_7 = arg_37_0:getShowBlock(iter_37_4.type, iter_37_4.id)

		if var_37_4 then
			var_37_4.nextBlock = var_37_7
		end

		if iter_37_3 >= arg_37_0.limitNum then
			var_37_7.nextBlock = nil
		end

		if iter_37_3 == 1 then
			var_37_5 = var_37_7
			var_37_6 = var_37_7
		end

		var_37_7:showOrHide(true)

		var_37_4 = var_37_7
	end

	return var_37_1, var_37_5, var_37_6
end

function var_0_1.hideRandomList(arg_38_0)
	local var_38_0 = arg_38_0.firstShowBlock

	while var_38_0 do
		var_38_0:showOrHide(false)

		var_38_0 = var_38_0.nextBlock
	end

	return
end

function var_0_1.countScore(arg_39_0, arg_39_1)
	if arg_39_1 then
		local var_39_0

		ipairs = var_1_10003

		for iter_39_0, iter_39_1 in var_1_10003(arg_39_0.comboRange) do
			if iter_39_1 > arg_39_0.comboNum then
				var_39_0 = iter_39_0 - 1

				break
			elseif iter_39_0 == #arg_39_0.comboRange then
				var_39_0 = #arg_39_0.comboRange
			end
		end

		local var_39_1

		if not arg_39_0.comboAddScore[var_39_0] then
			var_39_1 = 0
		end

		arg_39_0.comboNum = arg_39_0.comboNum + 1
		table = var_4

		local var_39_2 = var_4.indexof(arg_39_0.targetCombo, arg_39_0.comboNum)
		local var_39_3

		if not arg_39_0.targetComboScore[var_39_2] then
			var_39_3 = 0
		end

		arg_39_0.score = arg_39_0.score + arg_39_0.scorePerHit + var_39_1 + var_39_3
		arg_39_0.hitNum = arg_39_0.hitNum + 1
		arg_39_0.comboAni.enabled = true

		local var_39_4 = arg_39_0.comboAni

		var_6.Play(var_39_4, "combo_shake", -1, 0)
	else
		arg_39_0.comboNum = 0
		arg_39_0.missNum = arg_39_0.missNum + 1
	end

	if arg_39_0.comboNum > arg_39_0.bestComboNum then
		arg_39_0.bestComboNum = arg_39_0.comboNum
	end

	setText = var_2

	var_2(arg_39_0.comboTxt, arg_39_0.comboNum < 0 and 0 or arg_39_0.comboNum)

	setText = var_2

	var_2(arg_39_0.scoreTxt, arg_39_0.score)

	return
end

function var_0_1.getUserResult(arg_40_0)
	local var_40_0 = {}
	local var_40_1 = arg_40_0.firstShowBlock

	while var_40_1 do
		var_40_0[#var_40_0 + 1] = var_40_1:isRight()
		var_40_1 = var_40_1.nextBlock
	end

	return var_40_0
end

function var_0_1.playArchiveAnim(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0.arBlockList = arg_41_1
	arg_41_0.opList = arg_41_2
	arg_41_0.opIndex = 1

	arg_41_0:setXgmAction("attack")

	return
end

function var_0_1.checkPlayFinished(arg_42_0)
	if arg_42_0.opIndex >= #arg_42_0.opList and arg_42_0.remainTime > 0 then
		arg_42_0:setGameState(arg_42_0.STATE_CLICK)
	end

	return
end

function var_0_1.checkEnd(arg_43_0, arg_43_1)
	if arg_43_1 >= #arg_43_0.opList and arg_43_0.remainTime <= 0 then
		arg_43_0:setGameState(arg_43_0.STATE_END)
	end

	return
end

function var_0_1.parabolaMove(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	local var_44_0 = arg_44_0
	local var_44_1 = arg_44_0.managedTween

	LeanTween = var_1_10008

	var_44_1(var_44_0, var_1_10008.rotate, nil, arg_44_1, 135, arg_44_2)

	local var_44_2 = arg_44_0
	local var_44_3 = arg_44_0.managedTween

	LeanTween = var_8

	local var_44_4 = var_44_3(var_44_2, var_8.moveX, nil, arg_44_1, arg_44_3.x, arg_44_2)
	local var_44_5 = var_5.setEase

	LeanTweenType = var_8

	var_44_5(var_44_4, var_8.linear)

	local var_44_6 = arg_44_0
	local var_44_7 = arg_44_0.managedTween

	LeanTween = var_8

	local var_44_8 = var_44_7(var_44_6, var_8.moveY, function()
		if arg_44_4 then
			arg_44_4()
		end

		return
	end, arg_44_1, arg_44_3.y, arg_44_2)
	local var_44_9 = var_5.setEase

	LeanTweenType = var_8

	var_44_9(var_44_8, var_8.easeInQuad)

	return
end

function var_0_1.parabolaMove_center(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	local var_46_0 = arg_46_0
	local var_46_1 = arg_46_0.managedTween

	LeanTween = var_1_10008

	var_46_1(var_46_0, var_1_10008.rotate, nil, arg_46_1, 135, arg_46_2)

	local var_46_2 = arg_46_0
	local var_46_3 = arg_46_0.managedTween

	LeanTween = var_8

	local var_46_4 = var_46_3(var_46_2, var_8.moveX, nil, arg_46_1, arg_46_3.x, arg_46_2)
	local var_46_5 = var_5.setEase

	LeanTweenType = var_8

	var_46_5(var_46_4, var_8.easeOutQuad)

	local var_46_6 = arg_46_0
	local var_46_7 = arg_46_0.managedTween

	LeanTween = var_8

	local var_46_8 = var_46_7(var_46_6, var_8.moveY, function()
		if arg_46_4 then
			arg_46_4()
		end

		return
	end, arg_46_1, arg_46_3.y, arg_46_2)
	local var_46_9 = var_5.setEase

	LeanTweenType = var_8

	var_46_9(var_46_8, var_8.linear)

	return
end

function var_0_1.hitFly(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	local var_48_0 = arg_48_0
	local var_48_1 = arg_48_0.managedTween

	LeanTween = var_1_10008

	var_48_1(var_48_0, var_1_10008.rotate, nil, arg_48_1, 135, arg_48_2)

	local var_48_2 = arg_48_0
	local var_48_3 = arg_48_0.managedTween

	LeanTween = var_8

	local var_48_4 = var_48_3(var_48_2, var_8.moveX, nil, arg_48_1, arg_48_3.x, arg_48_2)
	local var_48_5 = var_5.setEase

	LeanTweenType = var_8

	var_48_5(var_48_4, var_8.linear)

	local var_48_6 = arg_48_0
	local var_48_7 = arg_48_0.managedTween

	LeanTween = var_8

	local var_48_8 = var_48_7(var_48_6, var_8.moveY, function()
		if arg_48_4 then
			arg_48_4()
		end

		return
	end, arg_48_1, arg_48_3.y, arg_48_2)
	local var_48_9 = var_5.setEase

	LeanTweenType = var_8

	var_48_9(var_48_8, var_8.easeOutQuad)

	return
end

function var_0_1.loadXGM(arg_50_0, arg_50_1)
	if arg_50_0.xgm then
		arg_50_1()
	else
		local var_50_0 = arg_50_0.autoLoader

		var_2.LoadPrefab(var_50_0, "ui/minigameui/qtegameuiasync_atlas", "xiongguimaoTpl", function(arg_51_0)
			local var_51_0 = arg_50_0

			tf = var_2_10002
			var_51_0.xgm = var_2_10002(arg_51_0)

			local var_51_1 = arg_50_0
			local var_51_2 = arg_50_0.xgm

			var_51_1.xgmSpine = var_2.GetComponent(var_51_2, "SpineAnimUI")

			local var_51_3 = arg_50_0
			local var_51_4 = arg_50_0.xgm

			var_51_3.xgmSklGraphic = var_2.GetComponent(var_51_4, "SkeletonGraphic")
			setParent = var_51_3

			var_51_3(arg_50_0.xgm, arg_50_0.xgmPos, false)

			local var_51_5 = arg_50_0

			var_1.initXGM(var_51_5)
			arg_50_1()

			return
		end)
	end

	return
end

function var_0_1.initXGM(arg_52_0)
	local var_52_0 = arg_52_0.xgmSpine

	var_1.SetActionCallBack(var_52_0, function(arg_53_0)
		if arg_53_0 == "FIRE" then
			local var_53_0 = arg_52_0

			var_1.fireBlocks(var_53_0)
		elseif arg_53_0 == "FINISH" then
			if arg_52_0.opIndex < #arg_52_0.opList then
				arg_52_0.opIndex = arg_52_0.opIndex + 1

				local var_53_1 = arg_52_0

				var_1.setXgmAction(var_53_1, "attack")
			else
				local var_53_2 = arg_52_0

				var_1.setXgmAction(var_53_2, "idle")

				local var_53_3 = arg_52_0

				var_1.checkPlayFinished(var_53_3)
			end
		end

		return
	end)

	return
end

function var_0_1.loadGuinu(arg_54_0, arg_54_1)
	if arg_54_0.guinuChar then
		arg_54_1()
	else
		local var_54_0 = arg_54_0.autoLoader

		var_2.GetSpine(var_54_0, "guinu_2", function(arg_55_0)
			arg_54_0.guinuChar = arg_55_0
			arg_54_0.guinuSklGraphic = arg_55_0:GetSkeletonGraphic()

			local var_55_0 = arg_54_0.guinuChar

			var_1.SetParent(var_55_0, arg_54_0.guinuPos)

			local var_55_1 = arg_54_0

			var_1.initGuinu(var_55_1)
			arg_54_1()

			return
		end)
	end

	return
end

function var_0_1.initGuinu(arg_56_0)
	local var_56_0 = arg_56_0.guinuChar
	local var_56_1 = var_1.SetLocalScale

	Vector3 = var_1_10004

	var_56_1(var_56_0, var_1_10004.one)
	arg_56_0:setGuinuAction("normal")

	local var_56_2 = arg_56_0.guinuChar

	var_1.SetActionCallBack(var_56_2, function(arg_57_0)
		if arg_57_0 == "finish" then
			local var_57_0 = arg_56_0

			var_1.setGuinuAction(var_57_0, "normal")
		end

		return
	end)

	return
end

function var_0_1.setXgmAction(arg_58_0, arg_58_1)
	if not arg_58_0.xgm then
		return
	end

	local var_58_0 = arg_58_0.xgmAnimLength[arg_58_1] / arg_58_0.xgmAnimTargetLength[arg_58_1]

	arg_58_0.xgmSklGraphic.timeScale = var_58_0

	local var_58_1 = arg_58_0.xgmSpine

	var_3.SetAction(var_58_1, arg_58_1, 0)

	return
end

function var_0_1.setGuinuAction(arg_59_0, arg_59_1)
	if not arg_59_0.guinuChar then
		return
	end

	local var_59_0 = arg_59_0.guinuAnimLength[arg_59_1] / arg_59_0.guinuAnimTargetLength[arg_59_1]

	arg_59_0.guinuSklGraphic.timeScale = var_59_0

	local var_59_1 = arg_59_0.guinuChar

	var_3.SetAction(var_59_1, arg_59_1, 0)

	return
end

function var_0_1.setBucketAAction(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0.bucketAAnimLength[arg_60_1] / arg_60_0.bucketAAnimTargetLength[arg_60_1]

	arg_60_0.bucketAGraphic.timeScale = var_60_0

	local var_60_1 = arg_60_0.bucketASpine

	var_3.SetAction(var_60_1, arg_60_1, 0)

	return
end

function var_0_1.setBucketBAction(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0.bucketBAnimLength[arg_61_1] / arg_61_0.bucketBAnimTargetLength[arg_61_1]

	arg_61_0.bucketBGraphic.timeScale = var_61_0

	local var_61_1 = arg_61_0.bucketBSpine

	var_3.SetAction(var_61_1, arg_61_1, 0)

	return
end

function var_0_1.showBucketAEffect(arg_62_0)
	local var_62_0

	if not arg_62_0.aEffectList then
		var_62_0 = {}
	end

	arg_62_0.aEffectList = var_62_0

	local var_62_1

	if not arg_62_0.aEffectUsingList then
		var_62_1 = {}
	end

	arg_62_0.aEffectUsingList = var_62_1

	local function var_62_2()
		table = var_2_10000

		local var_63_0 = var_2_10000.remove(arg_62_0.aEffectList, #arg_62_0.aEffectList)
		local var_63_1 = arg_62_0.aEffectUsingList

		var_63_1[#arg_62_0.aEffectUsingList + 1] = var_63_0
		setParent = var_63_1

		var_63_1(var_63_0, arg_62_0.bucketA, false)

		Vector3 = var_63_1
		var_63_0.localScale = var_63_1.one
		setActive = var_1

		var_1(var_63_0, true)

		local var_63_2 = arg_62_0
		local var_63_3 = var_1.managedTween

		LeanTween = var_4

		var_63_3(var_63_2, var_4.delayedCall, function()
			local var_64_0 = arg_62_0

			var_0.recycleBucketAEffect(var_64_0, var_63_0)

			return
		end, 2, nil)

		return
	end

	if #arg_62_0.aEffectList == 0 then
		local var_62_3 = arg_62_0.autoLoader

		var_2.LoadPrefab(var_62_3, "effect/xinnianyouxi_baozha", nil, function(arg_65_0)
			local var_65_0 = arg_62_0.aEffectList
			local var_65_1 = #arg_62_0.aEffectList + 1

			tf = var_2_10003
			var_65_0[var_65_1] = var_2_10003(arg_65_0)

			var_62_2()

			return
		end)
	else
		var_62_2()
	end

	return
end

function var_0_1.recycleBucketAEffect(arg_66_0, arg_66_1)
	for iter_66_0 = #arg_66_0.aEffectUsingList, 1, -1 do
		if arg_66_0.aEffectUsingList[iter_66_0] == arg_66_1 then
			setActive = var_1_10007

			var_1_10007(arg_66_1, false)

			var_1_10007 = arg_66_0.aEffectList

			local var_66_0 = #arg_66_0.aEffectList + 1

			table = var_9
			var_1_10007[var_66_0] = var_9.remove(arg_66_0.aEffectUsingList, iter_66_0)
		end
	end

	return
end

function var_0_1.getBlock(arg_67_0, arg_67_1, arg_67_2)
	local var_67_0 = arg_67_1 .. "-" .. arg_67_2

	if not arg_67_0.blockPool then
		arg_67_0.blockPool = {}
		arg_67_0.blockSource = {}

		for iter_67_0 = 1, 3 do
			for iter_67_1 = 1, 3 do
				local var_67_1 = iter_67_0 .. "-" .. iter_67_1
				local var_67_2 = arg_67_0._tf
				local var_67_3 = var_13.Find(var_67_2, "res/item" .. var_67_1)

				arg_67_0.blockPool[var_67_1] = {}
				arg_67_0.blockPool[var_67_1][#arg_67_0.blockPool[var_67_1] + 1] = var_67_3
				arg_67_0.blockSource[var_67_1] = var_67_3
			end
		end
	end

	local var_67_4

	if #arg_67_0.blockPool[var_67_0] > 0 then
		table = var_5

		local var_67_5 = var_5.remove(arg_67_0.blockPool[var_67_0], #arg_67_0.blockPool[var_67_0])

		var_67_4.SetParent(var_67_5, arg_67_0.content, false)
	else
		cloneTplTo = var_5
		var_67_4 = var_5(arg_67_0.blockSource[var_67_0], arg_67_0.content)
	end

	setActive = var_5

	var_5(var_67_4, true)

	arg_67_0.blockUniId = arg_67_0.blockUniId + 1

	return {
		uid = arg_67_0.blockUniId,
		key = var_67_0,
		tf = var_67_4
	}
end

function var_0_1.recycleBlock(arg_68_0, arg_68_1)
	local var_68_0 = arg_68_1.tf

	var_3[#arg_68_0.blockPool[arg_68_1.key] + 1] = var_68_0

	var_68_0:SetParent(arg_68_0.res, false)

	setActive = var_4

	var_4(var_68_0, false)

	return
end

function var_0_1.msHoldBlock(arg_69_0, arg_69_1)
	setParent = var_1_10002

	var_1_10002(arg_69_1.tf, arg_69_0.msHandSlot, false)

	local var_69_0 = arg_69_1.tf

	Vector2 = var_1_10003
	var_69_0.localPosition = var_1_10003.zero
	arg_69_0.msBlockList[#arg_69_0.msBlockList + 1] = arg_69_1

	return
end

function var_0_1.msClearHold(arg_70_0)
	for iter_70_0 = #arg_70_0.msBlockList, 1, -1 do
		local var_70_0 = arg_70_0
		local var_70_1 = arg_70_0.removeUsingBlock

		table = var_1_10008

		var_70_1(var_70_0, var_1_10008.remove(arg_70_0.msBlockList, iter_70_0))
	end

	return
end

function var_0_1.addUsingBlock(arg_71_0, arg_71_1)
	arg_71_0.usingBlockList[#arg_71_0.usingBlockList + 1] = arg_71_1

	return
end

function var_0_1.removeUsingBlock(arg_72_0, arg_72_1)
	for iter_72_0 = #arg_72_0.usingBlockList, 1, -1 do
		if arg_72_0.usingBlockList[iter_72_0].uid == arg_72_1.uid then
			arg_72_0:recycleBlock(arg_72_0.usingBlockList[iter_72_0])

			table = var_6

			var_6.remove(arg_72_0.usingBlockList, iter_72_0)
		end
	end

	return
end

function var_0_1.clearUsingBlock(arg_73_0)
	for iter_73_0 = #arg_73_0.usingBlockList, 1, -1 do
		arg_73_0:recycleBlock(arg_73_0.usingBlockList[iter_73_0])

		table = var_5

		var_5.remove(arg_73_0.usingBlockList, iter_73_0)
	end

	return
end

function var_0_1.getShowBlock(arg_74_0, arg_74_1, arg_74_2)
	local var_74_0 = arg_74_1 .. "-" .. arg_74_2
	local var_74_1 = "item" .. var_74_0
	local var_74_2

	if not arg_74_0.showBlockDic then
		var_74_2 = {}
	end

	arg_74_0.showBlockDic = var_74_2

	local var_74_3

	if arg_74_0.showBlockDic[var_74_0] then
		var_74_3 = arg_74_0.showBlockDic[var_74_0]
	else
		var_74_3 = {
			type = arg_74_1,
			id = arg_74_2,
			goName = var_74_1
		}

		local var_74_4 = arg_74_0.keyBar

		var_74_3.tf = var_6.Find(var_74_4, var_74_1)

		local var_74_5 = var_74_3.tf

		var_74_3.wrongTag = var_6.Find(var_74_5, "wrong")

		local var_74_6 = var_74_3.tf

		var_74_3.rightTag = var_6.Find(var_74_6, "right")
		var_74_3.nextBlock = nil
		var_74_3.userChoose = nil

		function var_74_3.init(arg_75_0)
			setActive = var_2_10001

			var_2_10001(arg_75_0.wrongTag, false)

			setActive = var_2_10001

			var_2_10001(arg_75_0.rightTag, false)

			arg_75_0.userChoose = nil

			local var_75_0 = arg_75_0.tf

			var_1.SetAsLastSibling(var_75_0)

			return
		end

		function var_74_3.select(arg_76_0, arg_76_1)
			arg_76_0.userChoose = arg_76_1
			setActive = var_2_10002

			var_2_10002(arg_76_0.wrongTag, not arg_76_0:isRight())

			setActive = var_2_10002

			var_2_10002(arg_76_0.rightTag, arg_76_0:isRight())

			return
		end

		function var_74_3.showOrHide(arg_77_0, arg_77_1)
			setActive = var_2_10002

			var_2_10002(arg_77_0.tf, arg_77_1)

			return
		end

		function var_74_3.isRight(arg_78_0)
			return arg_78_0.userChoose == arg_78_0.type
		end
	end

	var_74_3:init()

	return var_74_3
end

function var_0_1.startGameTimer(arg_79_0)
	local var_79_0 = arg_79_0:GetMGData()

	arg_79_0.remainTime = var_1.GetSimpleValue(var_79_0, "gameTime")
	setText = var_1

	var_1(arg_79_0.remainTxt, arg_79_0.remainTime .. "S")

	local function var_79_1()
		local var_80_0 = arg_79_0

		var_80_0.remainTime = arg_79_0.remainTime - 1
		setText = var_80_0

		var_80_0(arg_79_0.remainTxt, arg_79_0.remainTime .. "S")

		if arg_79_0.remainTime <= 0 then
			arg_79_0.remainTime = 0

			local var_80_1 = arg_79_0.remainTimer

			var_0.Stop(var_80_1)
		end

		return
	end

	if arg_79_0.remainTimer then
		local var_79_2 = arg_79_0.remainTimer

		var_2.Reset(var_79_2, var_79_1, 1, -1)
	else
		Timer = var_2
		arg_79_0.remainTimer = var_2.New(var_79_1, 1, -1)
	end

	local var_79_3 = arg_79_0.remainTimer

	var_2.Start(var_79_3)

	return
end

function var_0_1.startRoundTimer(arg_81_0)
	local var_81_0 = arg_81_0:GetMGData()

	arg_81_0.roundTime = var_1.GetSimpleValue(var_81_0, "roundTime")
	setText = var_1

	var_1(arg_81_0.roundTxt, arg_81_0.roundTime)

	local function var_81_1()
		local var_82_0 = arg_81_0

		var_82_0.roundTime = arg_81_0.roundTime - 1
		setText = var_82_0

		var_82_0(arg_81_0.roundTxt, arg_81_0.roundTime)

		if arg_81_0.roundTime <= 0 then
			local var_82_1 = arg_81_0.roundTimer

			var_0.Stop(var_82_1)

			QTEGAME_DEBUG = var_0

			if not var_0 then
				local var_82_2 = arg_81_0

				var_0.setGameState(var_82_2, arg_81_0.STATE_SHOW)
			end
		end

		return
	end

	if arg_81_0.roundTimer then
		local var_81_2 = arg_81_0.roundTimer

		var_2.Reset(var_81_2, var_81_1, 1, -1)
	else
		Timer = var_2
		arg_81_0.roundTimer = var_2.New(var_81_1, 1, -1)
	end

	local var_81_3 = arg_81_0.roundTimer

	var_2.Start(var_81_3)

	return
end

function var_0_1.clearTimer(arg_83_0)
	if arg_83_0.remainTimer then
		local var_83_0 = arg_83_0.remainTimer

		var_1.Stop(var_83_0)

		arg_83_0.remainTimer = nil
	end

	if arg_83_0.roundTimer then
		local var_83_1 = arg_83_0.roundTimer

		var_1.Stop(var_83_1)

		arg_83_0.roundTimer = nil
	end

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_84_0, arg_84_1)
	local var_84_0 = arg_84_1.argList
	local var_84_1 = arg_84_1.cmd

	MiniGameOPCommand = var_1_10004

	if var_84_1 == var_1_10004.CMD_COMPLETE and var_84_0[1] == 0 then
		local var_84_2 = arg_84_0
		local var_84_3 = arg_84_0.SendOperator

		MiniGameOPCommand = var_1_10007

		local var_84_4 = var_1_10007.CMD_SPECIAL_GAME
		local var_84_5 = {
			nil,
			1
		}
		local var_84_6 = arg_84_0:GetMGData()

		var_84_5[1] = var_9.GetSimpleValue(var_84_6, "shrineGameId")

		var_84_3(var_84_2, var_84_4, var_84_5)
	end

	return
end

function var_0_1.checkHelp(arg_85_0)
	PlayerPrefs = var_1_10001

	if var_1_10001.GetInt("QTEGameGuide", 0) == 0 then
		triggerButton = var_1

		var_1(arg_85_0.ruleBtn)

		PlayerPrefs = var_1

		var_1.SetInt("QTEGameGuide", 1)

		PlayerPrefs = var_1

		var_1.Save()
	end

	return
end

function var_0_1.willExit(arg_86_0)
	arg_86_0:clearTimer()

	pg = var_1

	local var_86_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_86_0, arg_86_0.endUI, arg_86_0._tf)

	arg_86_0.xgm = nil
	arg_86_0.xgmSpine = nil
	arg_86_0.xgmSklGraphic = nil
	arg_86_0.guinuChar = nil
	arg_86_0.guinuSklGraphic = nil

	local var_86_1 = arg_86_0.autoLoader

	var_1.Clear(var_86_1)

	return
end

return var_0_1
