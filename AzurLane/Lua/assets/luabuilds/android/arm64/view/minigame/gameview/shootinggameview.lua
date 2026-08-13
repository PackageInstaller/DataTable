class = var_0_10000

local var_0_0 = "ShootingGameView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))

var_0_1.animTime = 0.3333333333333333
var_0_1.moveModulus = 120

function var_0_1.getUIName(arg_1_0)
	return "ShootingGameUI"
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

	local var_2_13 = arg_2_0.shootAreaTF

	arg_2_0.startMaskTF = var_2.Find(var_2_13, "start_mask")

	local var_2_14 = arg_2_0.startMaskTF

	arg_2_0.countdownTF = var_2.Find(var_2_14, "count")

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
				local var_11_0 = arg_9_0

				var_0.gameFinish(var_11_0, true)

				local var_11_1 = arg_9_0

				var_0.closeView(var_11_1)

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
	local var_9_1 = arg_9_0.helpBtn

	local function var_9_2()
		pg = var_2_10000

		local var_13_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_13_1 = var_0.ShowMsgBox
		local var_13_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_13_2.type = var_2_10004
		pg = var_2_10004
		var_13_2.helps = var_2_10004.gametip.help_summer_shooting.tip

		var_13_1(var_13_0, var_13_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_9_0, var_9_1, var_9_2, var_1_10006)

	onButton = var_1_10001

	var_1_10001(arg_9_0, arg_9_0.startMaskTF, function()
		if not arg_9_0.isPlaying then
			local var_14_0 = arg_9_0

			var_0.gameStart(var_14_0)
		end

		return
	end)
	arg_9_0:initData()
	arg_9_0:updateCount()
	arg_9_0:resetTime()
	arg_9_0:initFireFunc()
	arg_9_0:setFireLink(false)

	setActive = var_1

	var_1(arg_9_0.startMaskTF, true)

	return
end

function var_0_1.onBackPressed(arg_15_0)
	triggerButton = var_1_10001

	var_1_10001(arg_15_0.backBtn)

	return
end

local function var_0_2(arg_16_0, arg_16_1)
	Vector2 = var_1_10002
	math = var_1_10004

	local var_16_0 = var_1_10004.clamp(arg_16_0.x, -arg_16_1.x, arg_16_1.x)

	math = var_1_10005

	return var_1_10002(var_16_0, var_1_10005.clamp(arg_16_0.y, -arg_16_1.y, arg_16_1.y))
end

function var_0_1.update(arg_17_0)
	Time = var_1_10001

	local var_17_0 = var_1_10001.GetTimestamp()

	if not arg_17_0.isStopped then
		if arg_17_0.isAfterCount and arg_17_0.sightTimeMark then
			local var_17_1

			if not arg_17_0.moveRect then
				tf = var_17_1
				var_17_1 = var_17_1(arg_17_0.sightTF.parent)
				Vector2 = var_1_10003
				arg_17_0.moveRect = var_1_10003(var_17_1.rect.width - arg_17_0.sightTF.rect.width, var_17_1.rect.height - arg_17_0.sightTF.rect.height) / 2
			end

			Vector2 = var_17_1

			local var_17_2 = var_17_1(arg_17_0.uiMGR.hrz, arg_17_0.uiMGR.vtc) * arg_17_0.tempConfig.moveSpeed * (var_17_0 - arg_17_0.sightTimeMark) * var_0_1.moveModulus

			arg_17_0.sightTF.anchoredPosition = var_0_2(arg_17_0.sightTF.anchoredPosition + var_17_2 * (arg_17_0.isDown and 0.5 or 1), arg_17_0.moveRect)
		end

		arg_17_0:updateTimers()
	end

	arg_17_0.sightTimeMark = var_17_0

	return
end

function var_0_1.resetTime(arg_18_0)
	arg_18_0.countdown = arg_18_0.tempConfig.waitCountdown
	setText = var_1

	var_1(arg_18_0.countdownTF, arg_18_0.countdown)

	arg_18_0.lastTime = arg_18_0.tempConfig.baseTime
	setText = var_1

	var_1(arg_18_0.lastTimeTF, arg_18_0.lastTime)

	return
end

function var_0_1.gameStart(arg_19_0)
	arg_19_0.isPlaying = true
	UpdateBeat = var_1

	var_1:Add(arg_19_0.update, arg_19_0)

	setActive = var_1

	var_1(arg_19_0.countdownTF, true)

	setActive = var_1

	local var_19_0 = arg_19_0.startMaskTF

	var_1(var_3.Find(var_19_0, "word"), false)
	;(function(arg_20_0)
		local var_20_0 = arg_19_0

		var_1.addTimer(var_20_0, "start countdown", 1, function()
			local var_21_0 = arg_19_0

			var_21_0.countdown = arg_19_0.countdown - 1
			setText = var_21_0

			var_21_0(arg_19_0.countdownTF, arg_19_0.countdown)

			if arg_19_0.countdown > 0 then
				arg_20_0(arg_20_0)
			else
				local var_21_1 = arg_19_0

				var_0.afterCountDown(var_21_1)
			end

			return
		end)

		return
	end)(var_1)

	return
end

function var_0_1.afterCountDown(arg_22_0)
	arg_22_0.isAfterCount = true

	local var_22_0 = arg_22_0.uiMGR

	var_1.AttachStickOb(var_22_0, arg_22_0.joyStrickTF)

	setActive = var_1

	var_1(arg_22_0.sightTF, true)

	setAnchoredPosition = var_1

	local var_22_1 = arg_22_0.sightTF

	Vector2 = var_4

	var_1(var_22_1, var_4.zero)
	arg_22_0:setFireLink(true)

	setActive = var_1

	var_1(arg_22_0.startMaskTF, false)

	arg_22_0.score = 0

	arg_22_0:flushTarget(true)
	;(function(arg_23_0)
		local var_23_0 = arg_22_0

		var_1.addTimer(var_23_0, "gamefinish", 1, function()
			local var_24_0 = arg_22_0

			var_24_0.lastTime = arg_22_0.lastTime - 1
			setText = var_24_0

			var_24_0(arg_22_0.lastTimeTF, arg_22_0.lastTime)

			if arg_22_0.lastTime > 0 then
				arg_23_0(arg_23_0)
			else
				local var_24_1 = arg_22_0

				var_0.gameFinish(var_24_1)
			end

			return
		end)

		return
	end)(var_1)

	return
end

function var_0_1.gameFinish(arg_25_0, arg_25_1)
	if arg_25_0.isAfterCount then
		arg_25_0:setFireLink(false)

		local var_25_0 = arg_25_0.uiMGR

		var_2.ClearStick(var_25_0)

		arg_25_0.isAfterCount = false
	end

	arg_25_0:clearTimers()

	UpdateBeat = var_2

	var_2:Remove(arg_25_0.update, arg_25_0)

	setActive = var_2

	var_2(arg_25_0.sightTF, false)

	setActive = var_2

	var_2(arg_25_0.countdownTF, false)
	arg_25_0:resetTime()

	arg_25_0.isPlaying = false

	if not arg_25_1 then
		for iter_25_0 = 1, 3 do
			for iter_25_1 = 1, 6 do
				if arg_25_0.cell[iter_25_0][iter_25_1] then
					local var_25_1 = arg_25_0.targetPanel
					local var_25_2 = var_10.Find(var_25_1, "line_" .. iter_25_0)
					local var_25_3 = var_10.GetChild(var_25_2, iter_25_1 - 1)
					local var_25_4 = var_10.GetChild(var_25_3, 0)
					local var_25_5 = var_10.GetComponent

					typeof = var_13
					Animator = var_1_10015

					local var_25_6 = var_25_5(var_25_4, var_13(var_1_10015))

					var_10.Play(var_25_6, "targetDown")
				end
			end
		end

		Timer = var_2

		local var_25_7 = var_2.New(function()
			setActive = var_2_10000

			var_2_10000(arg_25_0.startMaskTF, true)

			setActive = var_2_10000

			local var_26_0 = arg_25_0.startMaskTF

			var_2_10000(var_2.Find(var_26_0, "word"), true)

			return
		end, var_0_1.animTime)

		var_2.Start(var_25_7)
		arg_25_0:resultFinish()
	end

	return
end

function var_0_1.resultFinish(arg_27_0)
	local var_27_0 = arg_27_0.tempConfig.score_level
	local var_27_1

	for iter_27_0 = 1, #var_27_0 do
		if arg_27_0.score >= var_27_0[#var_27_0 - iter_27_0 + 1] then
			var_27_1 = iter_27_0

			break
		end
	end

	arg_27_0.awardLevel = var_27_1

	if arg_27_0:GetMGHubData().count > 0 then
		arg_27_0:SendSuccess(var_27_1)
	else
		arg_27_0:showResultPanel({})
	end

	return
end

function var_0_1.showResultPanel(arg_28_0, arg_28_1, arg_28_2)
	local function var_28_0()
		setActive = var_2_10000

		var_2_10000(arg_28_0.resultPanel, false)

		if arg_28_2 then
			arg_28_2()
		else
			local var_29_0 = arg_28_0

			var_0.updateCount(var_29_0)
		end

		return
	end

	onButton = var_1_10004

	local var_28_1 = arg_28_0
	local var_28_2 = arg_28_0.resultPanel

	var_1_10004(var_28_1, var_7.Find(var_28_2, "bg"), var_28_0)

	onButton = var_1_10004

	local var_28_3 = arg_28_0
	local var_28_4 = arg_28_0.resultPanel

	var_1_10004(var_28_3, var_7.Find(var_28_4, "main/btn_confirm"), var_28_0)

	local var_28_5 = arg_28_0.resultPanel
	local var_28_6 = var_4.Find(var_28_5, "main")

	if arg_28_0.score > arg_28_0.bestScore then
		arg_28_0:StoreDataToServer({
			arg_28_0.score
		})

		GetImageSpriteFromAtlasAsync = var_5

		var_5("ui/minigameui/shootinggameui_atlas", "new_recode", var_28_6:Find("success"), true)
	else
		GetImageSpriteFromAtlasAsync = var_5

		var_5("ui/minigameui/shootinggameui_atlas", "success", var_28_6:Find("success"), true)
	end

	GetImageSpriteFromAtlasAsync = var_5

	var_5("ui/minigameui/shootinggameui_atlas", "level_" .. #arg_28_0.tempConfig.score_level - arg_28_0.awardLevel + 1, var_28_6:Find("success/level"), true)

	setText = var_5

	var_5(var_28_6:Find("right/score/number"), arg_28_0.score)

	setActive = var_5

	var_5(var_28_6:Find("right/awards/list"), #arg_28_1 > 0)

	setActive = var_5

	var_5(var_28_6:Find("right/awards/nothing"), #arg_28_1 == 0)

	local var_28_7

	if not arg_28_0.itemList then
		UIItemList = var_28_7
		var_28_7 = var_28_7.New(var_28_6:Find("right/awards/list"), var_28_6:Find("right/awards/list/item"))
	end

	arg_28_0.itemList = var_28_7

	local var_28_8 = arg_28_0.itemList

	var_5.make(var_28_8, function(arg_30_0, arg_30_1, arg_30_2)
		UIItemList = var_2_10003

		if arg_30_0 == var_2_10003.EventUpdate then
			updateDrop = var_3

			var_3(arg_30_2, arg_28_1[arg_30_1 + 1])

			setText = var_3

			var_3(arg_30_2:Find("number"), "x" .. arg_28_1[arg_30_1 + 1].count)
		end

		return
	end)

	local var_28_9 = arg_28_0.itemList

	var_5.align(var_28_9, #arg_28_1)

	setActive = var_5

	var_5(arg_28_0.resultPanel, true)

	return
end

function var_0_1.updateAfterFinish(arg_31_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10003

	local var_31_0 = var_1_10001(var_1_10003)
	local var_31_1 = var_1.GetMiniGameData

	MiniGameDataCreator = var_1_10004

	local var_31_2 = var_31_1(var_31_0, var_1_10004.ShrineGameID)
	local var_31_3

	if not var_1.GetRuntimeData(var_31_2, "count") then
		var_31_3 = 0
	end

	local var_31_4 = var_31_3 + 1

	pg = var_31_2

	local var_31_5 = var_31_2.m02
	local var_31_6 = var_4.sendNotification

	GAME = var_1_10007

	local var_31_7 = var_1_10007.MODIFY_MINI_GAME_DATA
	local var_31_8 = {}

	MiniGameDataCreator = var_1_10009
	var_31_8.id = var_1_10009.ShrineGameID
	var_31_8.map = {
		count = var_31_4
	}

	var_31_6(var_31_5, var_31_7, var_31_8)

	return
end

function var_0_1.OnGetAwardDone(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1.cmd

	MiniGameOPCommand = var_1_10003

	local var_32_1

	if var_32_0 == var_1_10003.CMD_COMPLETE then
		if arg_32_0:GetMGHubData().ultimate == 0 then
			var_32_1 = var_2.usedtime

			local var_32_2 = var_2

			if var_32_1 >= var_2.getConfig(var_32_2, "reward_need") then
				pg = var_32_1

				local var_32_3 = var_32_1.m02

				var_32_1 = var_32_1.sendNotification
				GAME = var_32_2

				local var_32_4 = var_32_2.SEND_MINI_GAME_OP
				local var_32_5 = {
					hubid = var_2.id
				}

				MiniGameOPCommand = var_8
				var_32_5.cmd = var_8.CMD_ULTIMATE
				var_32_5.args1 = {}

				var_32_1(var_32_3, var_32_4, var_32_5)
			end
		end
	else
		local var_32_6 = arg_32_1.cmd

		MiniGameOPCommand = var_32_1

		if var_32_6 == var_32_1.CMD_ULTIMATE then
			pg = var_32_6

			local var_32_7 = var_32_6.NewStoryMgr.GetInstance()

			var_2.Play(var_32_7, "TIANHOUYUYI2")
		end
	end

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_33_0, arg_33_1)
	arg_33_0:updateCount()

	return
end

function var_0_1.updateCount(arg_34_0)
	setText = var_1_10001

	var_1_10001(arg_34_0.ticketTF, arg_34_0:GetMGHubData().count)

	checkExist = var_1_10001

	local var_34_0 = arg_34_0:GetMGData()
	local var_34_1

	if not var_1_10001(var_3.GetRuntimeData(var_34_0, "elements"), {
		1
	}) then
		var_34_1 = 0
	end

	arg_34_0.bestScore = var_34_1
	setText = var_34_1

	var_34_1(arg_34_0.bestScoreTF, arg_34_0.bestScore)

	return
end

function var_0_1.initFireFunc(arg_35_0)
	pg = var_1_10001

	local var_35_0 = var_1_10001.TipsMgr.GetInstance()

	pg = var_1_10002

	local var_35_1 = var_1_10002.TimeMgr.GetInstance()
	local var_35_2 = arg_35_0.sightTF
	local var_35_3 = var_3.Find(var_35_2, "sight_base")
	local var_35_4 = arg_35_0.sightTF
	local var_35_5 = var_4.Find(var_35_4, "sight_ready")

	setImageAlpha = var_35_2

	var_35_2(var_35_3, 1)

	setImageAlpha = var_35_2

	var_35_2(var_35_5, 0)

	local function var_35_6()
		setActive = var_2_10000

		var_2_10000(arg_35_0.corners, true)

		LeanTween = var_2_10000

		local var_36_0 = var_2_10000.scale
		local var_36_1 = var_35_3

		Vector3 = var_3

		local var_36_2 = var_36_0(var_36_1, var_3(1.95, 1.95, 1), 0.1)
		local var_36_3 = var_0.setOnComplete

		System = var_3

		var_36_3(var_36_2, var_3.Action(function()
			LeanTween = var_3_10000

			var_3_10000.alpha(var_35_3, 0, 0.1)

			LeanTween = var_0

			var_0.alpha(var_35_5, 1, 0.1)

			return
		end))

		return
	end

	local function var_35_7()
		setActive = var_2_10000

		var_2_10000(arg_35_0.corners, false)

		LeanTween = var_2_10000

		var_2_10000.alpha(var_35_3, 1, 0.1)

		LeanTween = var_0

		local var_38_0 = var_0.alpha(var_35_5, 0, 0.1)
		local var_38_1 = var_0.setOnComplete

		System = var_3

		var_38_1(var_38_0, var_3.Action(function()
			LeanTween = var_3_10000

			local var_39_0 = var_3_10000.scale
			local var_39_1 = var_35_3

			Vector3 = var_3_10003

			var_39_0(var_39_1, var_3_10003.one, 0.1)

			return
		end))

		return
	end

	function arg_35_0._downFunc()
		var_35_6()

		return
	end

	function arg_35_0._upFunc()
		LeanTween = var_2_10000

		local var_41_0 = var_2_10000.scale
		local var_41_1 = var_35_5

		Vector3 = var_2_10003

		local var_41_2 = var_41_0(var_41_1, var_2_10003(2, 2, 2), 0.03)
		local var_41_3 = var_0.setOnComplete

		System = var_3

		var_41_3(var_41_2, var_3.Action(function()
			LeanTween = var_3_10000

			local var_42_0 = var_3_10000.scale
			local var_42_1 = var_35_5

			Vector3 = var_3_10003

			local var_42_2 = var_42_0(var_42_1, var_3_10003.one, 0.07)
			local var_42_3 = var_0.setOnComplete

			System = var_3

			var_42_3(var_42_2, var_3.Action(function()
				var_35_7()

				return
			end))

			return
		end))

		local var_41_4 = arg_35_0
		local var_41_5, var_41_6, var_41_7 = var_0.checkHit(var_41_4)

		if var_41_5 then
			local var_41_8 = arg_35_0.cell[var_41_6][var_41_7]

			arg_35_0.cell[var_41_6][var_41_7] = nil
			arg_35_0.score = arg_35_0.score + arg_35_0.tempConfig.targetScore[var_41_8]
			arg_35_0.targetCount[var_41_8] = arg_35_0.targetCount[var_41_8] - 1

			local var_41_9 = arg_35_0

			var_41_9.lastTime = arg_35_0.lastTime + arg_35_0.tempConfig.bonusTime
			setText = var_41_9

			var_41_9(arg_35_0.lastTimeTF, arg_35_0.lastTime)

			local var_41_10 = arg_35_0.targetPanel
			local var_41_11 = var_4.Find(var_41_10, "line_" .. var_41_6)
			local var_41_12 = var_4.GetChild(var_41_11, var_41_7 - 1)
			local var_41_13 = var_4.GetChild(var_41_12, 0)
			local var_41_14 = var_4.GetComponent

			typeof = var_7
			Animator = var_2_10009

			local var_41_15 = var_41_14(var_41_13, var_7(var_2_10009))

			var_4.Play(var_41_15, "targetDown")

			local var_41_16 = arg_35_0

			var_5.addTimer(var_41_16, "flush call", 0.2 + var_0_1.animTime, function()
				local var_44_0 = arg_35_0

				var_0.flushTarget(var_44_0)

				return
			end)

			_ = var_5

			if not var_5.any(arg_35_0.targetCount, function(arg_45_0)
				return arg_45_0 > 0
			end) then
				local var_41_17 = arg_35_0

				var_5.gameFinish(var_41_17)
			end
		end

		local var_41_18 = arg_35_0

		var_3.setFireLink(var_41_18, false)

		local var_41_19 = arg_35_0

		var_3.addTimer(var_41_19, "fire cd", arg_35_0.tempConfig.fireCD, function()
			local var_46_0 = arg_35_0

			var_0.setFireLink(var_46_0, true)

			return
		end)

		return
	end

	function arg_35_0._cancelFunc()
		var_35_7()

		return
	end

	arg_35_0._emptyFunc = nil

	return
end

function var_0_1.setFireLink(arg_48_0, arg_48_1)
	if arg_48_1 then
		setButtonEnabled = var_1_10002

		var_1_10002(arg_48_0.fireBtn, true)

		if arg_48_0._downFunc ~= nil then
			local var_48_0 = arg_48_0.fireBtnDelegate

			var_2.AddPointDownFunc(var_48_0, function()
				arg_48_0.isDown = true

				if arg_48_0._main_cannon_sound then
					local var_49_0 = arg_48_0._main_cannon_sound

					var_0.Stop(var_49_0, true)
				end

				local var_49_1 = arg_48_0

				pg = var_1

				local var_49_2 = var_1.CriMgr.GetInstance()

				var_49_1._main_cannon_sound = var_1.PlaySE_V3(var_49_2, "battle-cannon-main-prepared")

				arg_48_0._downFunc()

				return
			end)
		end

		if arg_48_0._upFunc ~= nil then
			local var_48_1 = arg_48_0.fireBtnDelegate

			var_2.AddPointUpFunc(var_48_1, function()
				if arg_48_0.isDown then
					if arg_48_0._main_cannon_sound then
						local var_50_0 = arg_48_0._main_cannon_sound

						var_0.Stop(var_50_0, true)
					end

					pg = var_0

					local var_50_1 = var_0.CriMgr.GetInstance()

					var_0.PlaySoundEffect_V3(var_50_1, "event:/battle/boom2")

					arg_48_0.isDown = false

					arg_48_0._upFunc()
				end

				return
			end)
		end

		if arg_48_0._cancelFunc ~= nil then
			local var_48_2 = arg_48_0.fireBtnDelegate

			var_2.AddPointExitFunc(var_48_2, function()
				if arg_48_0.isDown then
					if arg_48_0._main_cannon_sound then
						local var_51_0 = arg_48_0._main_cannon_sound

						var_0.Stop(var_51_0, true)
					end

					arg_48_0.isDown = false

					arg_48_0._cancelFunc()
				end

				return
			end)
		end
	else
		if arg_48_0.isDown then
			arg_48_0.isDown = false

			arg_48_0._cancelFunc()
		end

		setButtonEnabled = var_2

		var_2(arg_48_0.fireBtn, false)

		local var_48_3 = arg_48_0.fireBtnDelegate

		var_2.RemovePointDownFunc(var_48_3)

		local var_48_4 = arg_48_0.fireBtnDelegate

		var_2.RemovePointUpFunc(var_48_4)

		local var_48_5 = arg_48_0.fireBtnDelegate

		var_2.RemovePointExitFunc(var_48_5)
	end

	return
end

function var_0_1.flushTarget(arg_52_0, arg_52_1)
	if arg_52_1 then
		arg_52_0.targetCount = {
			2,
			4,
			6
		}
	end

	for iter_52_0 = 1, 3 do
		for iter_52_1 = 1, 6 do
			removeAllChildren = var_1_10010

			local var_52_0 = arg_52_0.targetPanel
			local var_52_1 = var_1_10012.Find(var_52_0, "line_" .. iter_52_0)

			var_1_10010(var_1_10012.GetChild(var_52_1, iter_52_1 - 1))
		end
	end

	local var_52_2 = {
		0,
		0,
		0
	}

	arg_52_0.cell = {
		{},
		{},
		{}
	}
	ipairs = var_3

	for iter_52_2, iter_52_3 in var_3(arg_52_0.targetCount) do
		for iter_52_4 = 1, iter_52_3 do
			math = var_1_10012
			var_1_10012 = var_1_10012.random(3)
			math = var_1_10013
			var_1_10013 = var_1_10013.random(6)

			::label_52_0::

			if not arg_52_0.cell[var_1_10012][var_1_10013] then
				if arg_52_1 then
					local var_52_3 = var_52_2[var_1_10012]

					if 4 <= var_52_3 then
						repeat
							math = var_52_3
							var_52_3 = var_52_3.random(3)
							math = var_15
							var_1_10013 = var_15.random(6)
							var_1_10012 = var_52_3

							goto label_52_0
						until true
					end
				end

				var_52_2[var_1_10012] = var_52_2[var_1_10012] + 1

				local var_52_4 = arg_52_0.cell[var_1_10012]

				var_52_4[var_1_10013] = iter_52_2
				cloneTplTo = var_52_4

				local var_52_5 = arg_52_0.targetTpl[iter_52_2]
				local var_52_6 = arg_52_0.targetPanel
				local var_52_7 = var_17.Find(var_52_6, "line_" .. var_1_10012)

				var_52_4(var_52_5, var_17.GetChild(var_52_7, var_1_10013 - 1))
			end
		end
	end

	setText = var_3

	var_3(arg_52_0.scoreTF, arg_52_0.score)

	return
end

function var_0_1.checkHit(arg_53_0)
	for iter_53_0 = 1, 3 do
		for iter_53_1 = 1, 6 do
			if arg_53_0.cell[iter_53_0][iter_53_1] then
				local var_53_0 = arg_53_0.targetPanel
				local var_53_1 = var_9.Find(var_53_0, "line_" .. iter_53_0)
				local var_53_2 = var_9.GetChild(var_53_1, iter_53_1 - 1)
				local var_53_3 = var_9.GetChild(var_53_2, 0)
				local var_53_4 = var_9.Find(var_53_3, "icon/face")
				local var_53_5 = arg_53_0.sightTF

				if var_10.InverseTransformPoint(var_53_5, var_53_4:TransformPoint(var_53_4.position)).x * var_10.x + var_10.y * var_10.y < arg_53_0.tempConfig.half * arg_53_0.tempConfig.half then
					return true, iter_53_0, iter_53_1
				end
			end
		end
	end

	return
end

function var_0_1.willExit(arg_54_0)
	return
end

return var_0_1
