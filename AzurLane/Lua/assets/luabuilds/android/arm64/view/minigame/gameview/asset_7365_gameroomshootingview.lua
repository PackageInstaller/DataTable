class = var_0_10000

local var_0_0 = "GameRoomShootingView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))

var_0_1.animTime = 0.3333333333333333
var_0_1.moveModulus = 120

function var_0_1.getUIName(arg_1_0)
	return "GameRoomShootingUI"
end

function var_0_1.init(arg_2_0)
	pg = var_1_10001
	arg_2_0.uiMGR = var_1_10001.UIMgr.GetInstance()

	local var_2_0 = arg_2_0._tf

	arg_2_0.blurPanel = var_1.Find(var_2_0, "noAdaptPanel/blur_panel")

	local var_2_1 = arg_2_0.blurPanel

	arg_2_0.top = var_1.Find(var_2_1, "top")

	local var_2_2 = arg_2_0.top

	arg_2_0.backBtn = var_1.Find(var_2_2, "back")

	local var_2_3 = arg_2_0.top

	arg_2_0.scoreTF = var_1.Find(var_2_3, "score/Text")
	setText = var_1

	var_1(arg_2_0.scoreTF, 0)

	local var_2_4 = arg_2_0.top

	arg_2_0.bestScoreTF = var_1.Find(var_2_4, "score_heightest/Text")

	local var_2_5 = arg_2_0.top

	arg_2_0.ticketTF = var_1.Find(var_2_5, "ticket/Text")

	local var_2_6 = arg_2_0.top

	arg_2_0.helpBtn = var_1.Find(var_2_6, "help_btn")
	setActive = var_1

	var_1(arg_2_0.helpBtn, false)

	local var_2_7 = arg_2_0.blurPanel

	arg_2_0.sightTF = var_1.Find(var_2_7, "MoveArea/Sight")
	setActive = var_1

	var_1(arg_2_0.sightTF, false)

	local var_2_8 = arg_2_0.blurPanel

	arg_2_0.corners = var_1.Find(var_2_8, "Corners")

	local var_2_9 = arg_2_0._tf

	arg_2_0.shootAreaTF = var_1.Find(var_2_9, "noAdaptPanel/ShootArea")

	local var_2_10 = arg_2_0.shootAreaTF

	arg_2_0.targetPanel = var_1.Find(var_2_10, "target_panel")
	arg_2_0.targetTpl = {}

	local var_2_11 = arg_2_0.shootAreaTF
	local var_2_12 = var_1.Find(var_2_11, "tpl")

	for iter_2_0 = 1, var_2_12.childCount do
		arg_2_0.targetTpl[iter_2_0] = var_2_12:GetChild(iter_2_0 - 1)
	end

	setActive = var_2

	var_2(var_2_12, false)

	local var_2_13 = arg_2_0._tf

	arg_2_0.startMaskTF = var_2.Find(var_2_13, "noAdaptPanel/blur_panel/start_mask")

	local var_2_14 = arg_2_0._tf

	arg_2_0.countdownTF = var_2.Find(var_2_14, "noAdaptPanel/blur_panel/countUI")

	local var_2_15 = arg_2_0.shootAreaTF

	arg_2_0.lastTimeTF = var_2.Find(var_2_15, "time_word")

	local var_2_16 = arg_2_0._tf

	arg_2_0.bottomTF = var_2.Find(var_2_16, "noAdaptPanel/bottom")

	local var_2_17 = arg_2_0.bottomTF

	arg_2_0.joyStrickTF = var_2.Find(var_2_17, "Stick")

	local var_2_18 = arg_2_0.bottomTF

	arg_2_0.fireBtn = var_2.Find(var_2_18, "fire/ActCtl")
	GetOrAddComponent = var_2
	arg_2_0.fireBtnDelegate = var_2(arg_2_0.fireBtn, "EventTriggerListener")
	setActive = var_2

	local var_2_19 = arg_2_0.fireBtn

	var_2(var_4.Find(var_2_19, "block"), false)

	local var_2_20 = arg_2_0._tf

	arg_2_0.resultPanel = var_2.Find(var_2_20, "result_panel")
	setText = var_2
	findTF = var_2_20

	local var_2_21 = var_2_20(arg_2_0.resultPanel, "main/right/score/Text")

	i18n = var_5

	var_2(var_2_21, var_5("game_room_shooting_tip"))

	setActive = var_2

	var_2(arg_2_0.resultPanel, false)

	return
end

function var_0_1.initData(arg_3_0)
	local var_3_0 = arg_3_0:GetMGData()

	arg_3_0.tempConfig = var_1.getConfig(var_3_0, "simple_config_data")
	arg_3_0.tempConfig.waitCountdown = 3
	arg_3_0.tempConfig.half = 56

	return
end

function var_0_1.addTimer(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0

	if not arg_4_0.timerList then
		var_4_0 = {}
	end

	arg_4_0.timerList = var_4_0
	assert = var_4_0

	var_4_0(arg_4_0.timerList[arg_4_1] == nil, "error Timers")

	assert = var_4_0

	var_4_0(arg_4_2 > 0, "duration must >0")

	local var_4_1 = arg_4_0.timerList
	local var_4_2 = {}

	Time = var_6
	var_4_2.timeMark = var_6.realtimeSinceStartup + arg_4_2
	var_4_2.func = arg_4_3
	var_4_1[arg_4_1] = var_4_2

	return
end

function var_0_1.updateTimers(arg_5_0)
	Time = var_1_10001

	local var_5_0 = var_1_10001.realtimeSinceStartup

	pairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_0.timerList) do
		if var_5_0 > iter_5_1.timeMark then
			local var_5_1 = iter_5_1.func

			arg_5_0.timerList[iter_5_0] = nil

			var_5_1()
		end
	end

	return
end

function var_0_1.stopTimers(arg_6_0)
	arg_6_0.isStopped = true
	Time = var_1

	local var_6_0 = var_1.realtimeSinceStartup

	pairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.timerList) do
		iter_6_1.timeMark = iter_6_1.timeMark - var_6_0
	end

	return
end

function var_0_1.restartTimers(arg_7_0)
	arg_7_0.isStopped = false
	Time = var_1

	local var_7_0 = var_1.realtimeSinceStartup

	pairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(arg_7_0.timerList) do
		iter_7_1.timeMark = iter_7_1.timeMark + var_7_0
	end

	return
end

function var_0_1.clearTimers(arg_8_0)
	arg_8_0.timerList = {}

	return
end

function var_0_1.didEnter(arg_9_0)
	onButton = var_1_10001

	var_1_10001(arg_9_0, arg_9_0.backBtn, function()
		if arg_9_0.isPlaying then
			local var_10_0 = arg_9_0

			var_0.stopTimers(var_10_0)

			pg = var_0

			local var_10_1 = var_0.MsgboxMgr.GetInstance()
			local var_10_2 = var_0.ShowMsgBox
			local var_10_3 = {}

			i18n = var_2_10004
			var_10_3.content = var_2_10004("tips_summergame_exit")

			function var_10_3.onYes()
				arg_9_0.lastTime = 0

				local var_11_0 = arg_9_0

				var_0.restartTimers(var_11_0)

				local var_11_1 = arg_9_0

				var_0.gameFinish(var_11_1)

				return
			end

			function var_10_3.onNo()
				local var_12_0 = arg_9_0

				var_0.restartTimers(var_12_0)

				return
			end

			var_10_2(var_10_1, var_10_3)
		else
			local var_10_4 = arg_9_0

			var_0.closeView(var_10_4)
		end

		return
	end)

	onButton = var_1_10001

	local var_9_0 = arg_9_0

	findTF = var_4

	var_1_10001(var_9_0, var_4(arg_9_0.startMaskTF, "startGame"), function()
		if not arg_9_0.isPlaying then
			local var_13_0 = arg_9_0

			var_0.openCoinLayer(var_13_0, false)

			local var_13_1 = arg_9_0

			var_0.gameStart(var_13_1)
		end

		return
	end)

	if arg_9_0:getGameRoomData() then
		arg_9_0.gameHelpTip = arg_9_0:getGameRoomData().game_help
	end

	onButton = var_1

	local var_9_1 = arg_9_0

	findTF = var_4

	var_1(var_9_1, var_4(arg_9_0.startMaskTF, "ruleGame"), function()
		pg = var_2_10000

		local var_14_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_14_1 = var_0.ShowMsgBox
		local var_14_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_14_2.type = var_2_10004
		var_14_2.helps = arg_9_0.gameHelpTip

		var_14_1(var_14_0, var_14_2)

		return
	end)
	arg_9_0:initData()
	arg_9_0:updateCount()
	arg_9_0:resetTime()
	arg_9_0:initFireFunc()
	arg_9_0:setFireLink(false)
	arg_9_0:changeStartMaskUI(true)

	return
end

function var_0_1.changeStartMaskUI(arg_15_0, arg_15_1)
	setActive = var_1_10002

	var_1_10002(arg_15_0.bottomTF, not arg_15_1)

	setActive = var_1_10002

	var_1_10002(arg_15_0.startMaskTF, arg_15_1)

	return
end

function var_0_1.onBackPressed(arg_16_0)
	triggerButton = var_1_10001

	var_1_10001(arg_16_0.backBtn)

	return
end

local function var_0_2(arg_17_0, arg_17_1)
	Vector2 = var_1_10002
	math = var_1_10004

	local var_17_0 = var_1_10004.clamp(arg_17_0.x, -arg_17_1.x, arg_17_1.x)

	math = var_1_10005

	return var_1_10002(var_17_0, var_1_10005.clamp(arg_17_0.y, -arg_17_1.y, arg_17_1.y))
end

function var_0_1.update(arg_18_0)
	Time = var_1_10001

	local var_18_0 = var_1_10001.GetTimestamp()

	if not arg_18_0.isStopped then
		if arg_18_0.isAfterCount and arg_18_0.sightTimeMark then
			local var_18_1

			if not arg_18_0.moveRect then
				tf = var_18_1
				var_18_1 = var_18_1(arg_18_0.sightTF.parent)
				Vector2 = var_1_10003
				arg_18_0.moveRect = var_1_10003(var_18_1.rect.width - arg_18_0.sightTF.rect.width, var_18_1.rect.height - arg_18_0.sightTF.rect.height) / 2
			end

			Vector2 = var_18_1

			local var_18_2 = var_18_1(arg_18_0.uiMGR.hrz, arg_18_0.uiMGR.vtc) * arg_18_0.tempConfig.moveSpeed * (var_18_0 - arg_18_0.sightTimeMark) * var_0_1.moveModulus

			arg_18_0.sightTF.anchoredPosition = var_0_2(arg_18_0.sightTF.anchoredPosition + var_18_2 * (arg_18_0.isDown and 0.5 or 1), arg_18_0.moveRect)
		end

		arg_18_0:updateTimers()
	end

	arg_18_0.sightTimeMark = var_18_0

	return
end

function var_0_1.resetTime(arg_19_0)
	arg_19_0.countdown = arg_19_0.tempConfig.waitCountdown
	setText = var_1
	findTF = var_1_10003

	var_1(var_1_10003(arg_19_0.countdownTF, "count"), arg_19_0.countdown)

	arg_19_0.lastTime = arg_19_0.tempConfig.baseTime
	setText = var_1

	var_1(arg_19_0.lastTimeTF, arg_19_0.lastTime)

	return
end

function var_0_1.gameStart(arg_20_0)
	arg_20_0.isPlaying = true

	arg_20_0:changeStartMaskUI(false)

	UpdateBeat = var_1

	var_1:Add(arg_20_0.update, arg_20_0)

	setActive = var_1

	var_1(arg_20_0.countdownTF, true)
	;(function(arg_21_0)
		local var_21_0 = arg_20_0

		var_1.addTimer(var_21_0, "start countdown", 1, function()
			local var_22_0 = arg_20_0

			var_22_0.countdown = arg_20_0.countdown - 1
			setText = var_22_0
			findTF = var_3_10002

			var_22_0(var_3_10002(arg_20_0.countdownTF, "count"), arg_20_0.countdown)

			if arg_20_0.countdown > 0 then
				arg_21_0(arg_21_0)
			else
				local var_22_1 = arg_20_0

				var_0.afterCountDown(var_22_1)
			end

			return
		end)

		return
	end)(var_1)

	return
end

function var_0_1.afterCountDown(arg_23_0)
	arg_23_0.isAfterCount = true

	local var_23_0 = arg_23_0.uiMGR

	var_1.AttachStickOb(var_23_0, arg_23_0.joyStrickTF)

	setActive = var_1

	var_1(arg_23_0.sightTF, true)

	setActive = var_1

	var_1(arg_23_0.countdownTF, false)

	setAnchoredPosition = var_1

	local var_23_1 = arg_23_0.sightTF

	Vector2 = var_4

	var_1(var_23_1, var_4.zero)
	arg_23_0:setFireLink(true)

	arg_23_0.score = 0

	arg_23_0:flushTarget(true)
	;(function(arg_24_0)
		local var_24_0 = arg_23_0

		var_1.addTimer(var_24_0, "gamefinish", 1, function()
			local var_25_0 = arg_23_0

			var_25_0.lastTime = arg_23_0.lastTime - 1
			setText = var_25_0

			var_25_0(arg_23_0.lastTimeTF, arg_23_0.lastTime)

			if arg_23_0.lastTime > 0 then
				arg_24_0(arg_24_0)
			else
				local var_25_1 = arg_23_0

				var_0.gameFinish(var_25_1)
			end

			return
		end)

		return
	end)(var_1)

	return
end

function var_0_1.gameFinish(arg_26_0, arg_26_1)
	if arg_26_0.isAfterCount then
		arg_26_0:setFireLink(false)

		local var_26_0 = arg_26_0.uiMGR

		var_2.ClearStick(var_26_0)

		arg_26_0.isAfterCount = false
	end

	arg_26_0:clearTimers()

	UpdateBeat = var_2

	var_2:Remove(arg_26_0.update, arg_26_0)

	setActive = var_2

	var_2(arg_26_0.sightTF, false)

	setActive = var_2

	var_2(arg_26_0.countdownTF, false)
	arg_26_0:resetTime()

	arg_26_0.isPlaying = false

	if not arg_26_1 then
		for iter_26_0 = 1, 3 do
			for iter_26_1 = 1, 6 do
				if arg_26_0.cell[iter_26_0][iter_26_1] then
					local var_26_1 = arg_26_0.targetPanel
					local var_26_2 = var_10.Find(var_26_1, "line_" .. iter_26_0)
					local var_26_3 = var_10.GetChild(var_26_2, iter_26_1 - 1)
					local var_26_4 = var_10.GetChild(var_26_3, 0)
					local var_26_5 = var_10.GetComponent

					typeof = var_13
					Animator = var_1_10015

					local var_26_6 = var_26_5(var_26_4, var_13(var_1_10015))

					var_10.Play(var_26_6, "targetDown")
				end
			end
		end

		Timer = var_2

		local var_26_7 = var_2.New(function()
			local var_27_0 = arg_26_0

			var_0.changeStartMaskUI(var_27_0, true)

			return
		end, var_0_1.animTime)

		var_2.Start(var_26_7)
		arg_26_0:resultFinish()
	end

	return
end

function var_0_1.resultFinish(arg_28_0)
	local var_28_0 = arg_28_0.tempConfig.score_level
	local var_28_1 = 1

	for iter_28_0 = 1, #var_28_0 do
		if arg_28_0.score >= var_28_0[iter_28_0] then
			var_28_1 = iter_28_0
		end
	end

	arg_28_0.awardLevel = var_28_1

	arg_28_0:SendSuccess(arg_28_0.score)
	arg_28_0:showResultPanel({})

	return
end

function var_0_1.showResultPanel(arg_29_0, arg_29_1, arg_29_2)
	local function var_29_0()
		setActive = var_2_10000

		var_2_10000(arg_29_0.resultPanel, false)

		local var_30_0 = arg_29_0

		var_0.openCoinLayer(var_30_0, true)

		if arg_29_2 then
			arg_29_2()
		else
			local var_30_1 = arg_29_0

			var_0.updateCount(var_30_1)
		end

		return
	end

	onButton = var_1_10004

	local var_29_1 = arg_29_0
	local var_29_2 = arg_29_0.resultPanel

	var_1_10004(var_29_1, var_7.Find(var_29_2, "bg"), var_29_0)

	onButton = var_1_10004

	local var_29_3 = arg_29_0
	local var_29_4 = arg_29_0.resultPanel

	var_1_10004(var_29_3, var_7.Find(var_29_4, "main/btn_confirm"), var_29_0)

	local var_29_5 = arg_29_0.resultPanel
	local var_29_6 = var_4.Find(var_29_5, "main")

	if arg_29_0.score > arg_29_0.bestScore then
		arg_29_0:StoreDataToServer({
			arg_29_0.score
		})

		GetImageSpriteFromAtlasAsync = var_5

		var_5("ui/minigameui/shootinggameui_atlas", "new_recode", var_29_6:Find("success"), true)
	else
		GetImageSpriteFromAtlasAsync = var_5

		var_5("ui/minigameui/shootinggameui_atlas", "success", var_29_6:Find("success"), true)
	end

	GetImageSpriteFromAtlasAsync = var_5

	var_5("ui/minigameui/shootinggameui_atlas", "level_" .. arg_29_0.awardLevel, var_29_6:Find("success/level"), true)

	setText = var_5

	var_5(var_29_6:Find("right/score/number"), arg_29_0.score)

	setActive = var_5

	var_5(var_29_6:Find("right/awards/list"), #arg_29_1 > 0)

	setActive = var_5

	var_5(var_29_6:Find("right/awards/nothing"), #arg_29_1 == 0)

	local var_29_7

	if not arg_29_0.itemList then
		UIItemList = var_29_7
		var_29_7 = var_29_7.New(var_29_6:Find("right/awards/list"), var_29_6:Find("right/awards/list/item"))
	end

	arg_29_0.itemList = var_29_7

	local var_29_8 = arg_29_0.itemList

	var_5.make(var_29_8, function(arg_31_0, arg_31_1, arg_31_2)
		UIItemList = var_2_10003

		if arg_31_0 == var_2_10003.EventUpdate then
			updateDrop = var_3

			var_3(arg_31_2, arg_29_1[arg_31_1 + 1])

			setText = var_3

			var_3(arg_31_2:Find("number"), "x" .. arg_29_1[arg_31_1 + 1].count)
		end

		return
	end)

	local var_29_9 = arg_29_0.itemList

	var_5.align(var_29_9, #arg_29_1)

	setActive = var_5

	var_5(arg_29_0.resultPanel, true)

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_32_0, arg_32_1)
	arg_32_0:updateCount()

	return
end

function var_0_1.updateCount(arg_33_0)
	setText = var_1_10001

	var_1_10001(arg_33_0.ticketTF, arg_33_0:GetMGHubData().count)

	getProxy = var_1_10001
	GameRoomProxy = var_3

	local var_33_0 = var_1_10001(var_3)

	arg_33_0.bestScore = var_1.getRoomScore(var_33_0, arg_33_0:getGameRoomData().id)
	setText = var_1

	var_1(arg_33_0.bestScoreTF, arg_33_0.bestScore)

	return
end

function var_0_1.initFireFunc(arg_34_0)
	pg = var_1_10001

	local var_34_0 = var_1_10001.TipsMgr.GetInstance()

	pg = var_1_10002

	local var_34_1 = var_1_10002.TimeMgr.GetInstance()
	local var_34_2 = arg_34_0.sightTF
	local var_34_3 = var_3.Find(var_34_2, "sight_base")
	local var_34_4 = arg_34_0.sightTF
	local var_34_5 = var_4.Find(var_34_4, "sight_ready")

	setImageAlpha = var_34_2

	var_34_2(var_34_3, 1)

	setImageAlpha = var_34_2

	var_34_2(var_34_5, 0)

	local function var_34_6()
		setActive = var_2_10000

		var_2_10000(arg_34_0.corners, true)

		LeanTween = var_2_10000

		local var_35_0 = var_2_10000.scale
		local var_35_1 = var_34_3

		Vector3 = var_3

		local var_35_2 = var_35_0(var_35_1, var_3(1.95, 1.95, 1), 0.1)
		local var_35_3 = var_0.setOnComplete

		System = var_3

		var_35_3(var_35_2, var_3.Action(function()
			LeanTween = var_3_10000

			var_3_10000.alpha(var_34_3, 0, 0.1)

			LeanTween = var_0

			var_0.alpha(var_34_5, 1, 0.1)

			return
		end))

		return
	end

	local function var_34_7()
		setActive = var_2_10000

		var_2_10000(arg_34_0.corners, false)

		LeanTween = var_2_10000

		var_2_10000.alpha(var_34_3, 1, 0.1)

		LeanTween = var_0

		local var_37_0 = var_0.alpha(var_34_5, 0, 0.1)
		local var_37_1 = var_0.setOnComplete

		System = var_3

		var_37_1(var_37_0, var_3.Action(function()
			LeanTween = var_3_10000

			local var_38_0 = var_3_10000.scale
			local var_38_1 = var_34_3

			Vector3 = var_3_10003

			var_38_0(var_38_1, var_3_10003.one, 0.1)

			return
		end))

		return
	end

	function arg_34_0._downFunc()
		var_34_6()

		return
	end

	function arg_34_0._upFunc()
		LeanTween = var_2_10000

		local var_40_0 = var_2_10000.scale
		local var_40_1 = var_34_5

		Vector3 = var_2_10003

		local var_40_2 = var_40_0(var_40_1, var_2_10003(2, 2, 2), 0.03)
		local var_40_3 = var_0.setOnComplete

		System = var_3

		var_40_3(var_40_2, var_3.Action(function()
			LeanTween = var_3_10000

			local var_41_0 = var_3_10000.scale
			local var_41_1 = var_34_5

			Vector3 = var_3_10003

			local var_41_2 = var_41_0(var_41_1, var_3_10003.one, 0.07)
			local var_41_3 = var_0.setOnComplete

			System = var_3

			var_41_3(var_41_2, var_3.Action(function()
				var_34_7()

				return
			end))

			return
		end))

		local var_40_4 = arg_34_0
		local var_40_5, var_40_6, var_40_7 = var_0.checkHit(var_40_4)

		if var_40_5 then
			local var_40_8 = arg_34_0.cell[var_40_6][var_40_7]

			arg_34_0.cell[var_40_6][var_40_7] = nil
			arg_34_0.score = arg_34_0.score + arg_34_0.tempConfig.targetScore[var_40_8]
			arg_34_0.targetCount[var_40_8] = arg_34_0.targetCount[var_40_8] - 1

			local var_40_9 = arg_34_0

			var_40_9.lastTime = arg_34_0.lastTime + arg_34_0.tempConfig.bonusTime
			setText = var_40_9

			var_40_9(arg_34_0.lastTimeTF, arg_34_0.lastTime)

			local var_40_10 = arg_34_0.targetPanel
			local var_40_11 = var_4.Find(var_40_10, "line_" .. var_40_6)
			local var_40_12 = var_4.GetChild(var_40_11, var_40_7 - 1)
			local var_40_13 = var_4.GetChild(var_40_12, 0)
			local var_40_14 = var_4.GetComponent

			typeof = var_7
			Animator = var_2_10009

			local var_40_15 = var_40_14(var_40_13, var_7(var_2_10009))

			var_4.Play(var_40_15, "targetDown")

			local var_40_16 = arg_34_0

			var_5.addTimer(var_40_16, "flush call", 0.2 + var_0_1.animTime, function()
				local var_43_0 = arg_34_0

				var_0.flushTarget(var_43_0)

				return
			end)

			_ = var_5

			if not var_5.any(arg_34_0.targetCount, function(arg_44_0)
				return arg_44_0 > 0
			end) then
				local var_40_17 = arg_34_0

				var_5.gameFinish(var_40_17)
			end
		end

		local var_40_18 = arg_34_0

		var_3.setFireLink(var_40_18, false)

		local var_40_19 = arg_34_0

		var_3.addTimer(var_40_19, "fire cd", arg_34_0.tempConfig.fireCD, function()
			local var_45_0 = arg_34_0

			var_0.setFireLink(var_45_0, true)

			return
		end)

		return
	end

	function arg_34_0._cancelFunc()
		var_34_7()

		return
	end

	arg_34_0._emptyFunc = nil

	return
end

function var_0_1.setFireLink(arg_47_0, arg_47_1)
	if arg_47_1 then
		setButtonEnabled = var_1_10002

		var_1_10002(arg_47_0.fireBtn, true)

		if arg_47_0._downFunc ~= nil then
			local var_47_0 = arg_47_0.fireBtnDelegate

			var_2.AddPointDownFunc(var_47_0, function()
				arg_47_0.isDown = true

				if arg_47_0._main_cannon_sound then
					local var_48_0 = arg_47_0._main_cannon_sound

					var_0.Stop(var_48_0, true)
				end

				local var_48_1 = arg_47_0

				pg = var_1

				local var_48_2 = var_1.CriMgr.GetInstance()

				var_48_1._main_cannon_sound = var_1.PlaySE_V3(var_48_2, "battle-cannon-main-prepared")

				arg_47_0._downFunc()

				return
			end)
		end

		if arg_47_0._upFunc ~= nil then
			local var_47_1 = arg_47_0.fireBtnDelegate

			var_2.AddPointUpFunc(var_47_1, function()
				if arg_47_0.isDown then
					if arg_47_0._main_cannon_sound then
						local var_49_0 = arg_47_0._main_cannon_sound

						var_0.Stop(var_49_0, true)
					end

					pg = var_0

					local var_49_1 = var_0.CriMgr.GetInstance()

					var_0.PlaySoundEffect_V3(var_49_1, "event:/battle/boom2")

					arg_47_0.isDown = false

					arg_47_0._upFunc()
				end

				return
			end)
		end

		if arg_47_0._cancelFunc ~= nil then
			local var_47_2 = arg_47_0.fireBtnDelegate

			var_2.AddPointExitFunc(var_47_2, function()
				if arg_47_0.isDown then
					if arg_47_0._main_cannon_sound then
						local var_50_0 = arg_47_0._main_cannon_sound

						var_0.Stop(var_50_0, true)
					end

					arg_47_0.isDown = false

					arg_47_0._cancelFunc()
				end

				return
			end)
		end
	else
		if arg_47_0.isDown then
			arg_47_0.isDown = false

			arg_47_0._cancelFunc()
		end

		setButtonEnabled = var_2

		var_2(arg_47_0.fireBtn, false)

		local var_47_3 = arg_47_0.fireBtnDelegate

		var_2.RemovePointDownFunc(var_47_3)

		local var_47_4 = arg_47_0.fireBtnDelegate

		var_2.RemovePointUpFunc(var_47_4)

		local var_47_5 = arg_47_0.fireBtnDelegate

		var_2.RemovePointExitFunc(var_47_5)
	end

	return
end

function var_0_1.flushTarget(arg_51_0, arg_51_1)
	if arg_51_1 then
		arg_51_0.targetCount = {
			2,
			4,
			6
		}
	end

	for iter_51_0 = 1, 3 do
		for iter_51_1 = 1, 6 do
			removeAllChildren = var_1_10010

			local var_51_0 = arg_51_0.targetPanel
			local var_51_1 = var_1_10012.Find(var_51_0, "line_" .. iter_51_0)

			var_1_10010(var_1_10012.GetChild(var_51_1, iter_51_1 - 1))
		end
	end

	local var_51_2 = {
		0,
		0,
		0
	}

	arg_51_0.cell = {
		{},
		{},
		{}
	}
	ipairs = var_3

	for iter_51_2, iter_51_3 in var_3(arg_51_0.targetCount) do
		for iter_51_4 = 1, iter_51_3 do
			math = var_1_10012
			var_1_10012 = var_1_10012.random(3)
			math = var_1_10013
			var_1_10013 = var_1_10013.random(6)

			::label_51_0::

			if not arg_51_0.cell[var_1_10012][var_1_10013] then
				if arg_51_1 then
					local var_51_3 = var_51_2[var_1_10012]

					if 4 <= var_51_3 then
						repeat
							math = var_51_3
							var_51_3 = var_51_3.random(3)
							math = var_15
							var_1_10013 = var_15.random(6)
							var_1_10012 = var_51_3

							goto label_51_0
						until true
					end
				end

				var_51_2[var_1_10012] = var_51_2[var_1_10012] + 1

				local var_51_4 = arg_51_0.cell[var_1_10012]

				var_51_4[var_1_10013] = iter_51_2
				cloneTplTo = var_51_4

				local var_51_5 = arg_51_0.targetTpl[iter_51_2]
				local var_51_6 = arg_51_0.targetPanel
				local var_51_7 = var_17.Find(var_51_6, "line_" .. var_1_10012)

				var_51_4(var_51_5, var_17.GetChild(var_51_7, var_1_10013 - 1))
			end
		end
	end

	setText = var_3

	var_3(arg_51_0.scoreTF, arg_51_0.score)

	return
end

function var_0_1.checkHit(arg_52_0)
	for iter_52_0 = 1, 3 do
		for iter_52_1 = 1, 6 do
			if arg_52_0.cell[iter_52_0][iter_52_1] then
				local var_52_0 = arg_52_0.targetPanel
				local var_52_1 = var_9.Find(var_52_0, "line_" .. iter_52_0)
				local var_52_2 = var_9.GetChild(var_52_1, iter_52_1 - 1)
				local var_52_3 = var_9.GetChild(var_52_2, 0)
				local var_52_4 = var_9.Find(var_52_3, "icon/face")
				local var_52_5 = arg_52_0.sightTF

				if var_10.InverseTransformPoint(var_52_5, var_52_4:TransformPoint(var_52_4.position)).x * var_10.x + var_10.y * var_10.y < arg_52_0.tempConfig.half * arg_52_0.tempConfig.half then
					return true, iter_52_0, iter_52_1
				end
			end
		end
	end

	return
end

function var_0_1.willExit(arg_53_0)
	return
end

return var_0_1
