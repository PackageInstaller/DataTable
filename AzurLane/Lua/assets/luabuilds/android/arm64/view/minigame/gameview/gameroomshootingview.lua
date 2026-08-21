local var_0_0 = class("GameRoomShootingView", import("..BaseMiniGameView"))

var_0_0.animTime = 0.3333333333333333
var_0_0.moveModulus = 120

function var_0_0.getUIName(arg_1_0)
	return "GameRoomShootingUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.uiMGR = pg.UIMgr.GetInstance()
	arg_2_0.blurPanel = arg_2_0._tf:Find("noAdaptPanel/blur_panel")
	arg_2_0.top = arg_2_0.blurPanel:Find("top")
	arg_2_0.backBtn = arg_2_0.top:Find("back")
	arg_2_0.scoreTF = arg_2_0.top:Find("score/Text")

	setText(arg_2_0.scoreTF, 0)

	arg_2_0.bestScoreTF = arg_2_0.top:Find("score_heightest/Text")
	arg_2_0.ticketTF = arg_2_0.top:Find("ticket/Text")
	arg_2_0.helpBtn = arg_2_0.top:Find("help_btn")

	setActive(arg_2_0.helpBtn, false)

	arg_2_0.sightTF = arg_2_0.blurPanel:Find("MoveArea/Sight")

	setActive(arg_2_0.sightTF, false)

	arg_2_0.corners = arg_2_0.blurPanel:Find("Corners")
	arg_2_0.shootAreaTF = arg_2_0._tf:Find("noAdaptPanel/ShootArea")
	arg_2_0.targetPanel = arg_2_0.shootAreaTF:Find("target_panel")
	arg_2_0.targetTpl = {}

	local var_2_0 = arg_2_0.shootAreaTF:Find("tpl")

	for iter_2_0 = 1, var_2_0.childCount do
		arg_2_0.targetTpl[iter_2_0] = var_2_0:GetChild(iter_2_0 - 1)
	end

	setActive(var_2_0, false)

	arg_2_0.startMaskTF = arg_2_0._tf:Find("noAdaptPanel/blur_panel/start_mask")
	arg_2_0.countdownTF = arg_2_0._tf:Find("noAdaptPanel/blur_panel/countUI")
	arg_2_0.lastTimeTF = arg_2_0.shootAreaTF:Find("time_word")
	arg_2_0.bottomTF = arg_2_0._tf:Find("noAdaptPanel/bottom")
	arg_2_0.joyStrickTF = arg_2_0.bottomTF:Find("Stick")
	arg_2_0.fireBtn = arg_2_0.bottomTF:Find("fire/ActCtl")
	arg_2_0.fireBtnDelegate = GetOrAddComponent(arg_2_0.fireBtn, "EventTriggerListener")

	setActive(arg_2_0.fireBtn:Find("block"), false)

	arg_2_0.resultPanel = arg_2_0._tf:Find("result_panel")

	setText(findTF(arg_2_0.resultPanel, "main/right/score/Text"), i18n("game_room_shooting_tip"))
	setActive(arg_2_0.resultPanel, false)

	return
end

function var_0_0.initData(arg_3_0)
	arg_3_0.tempConfig = arg_3_0:GetMGData():getConfig("simple_config_data")
	arg_3_0.tempConfig.waitCountdown = 3
	arg_3_0.tempConfig.half = 56

	return
end

function var_0_0.addTimer(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.timerList = arg_4_0.timerList or {}

	assert(arg_4_0.timerList[arg_4_1] == nil, "error Timers")
	assert(arg_4_2 > 0, "duration must >0")

	arg_4_0.timerList[arg_4_1] = {
		timeMark = Time.realtimeSinceStartup + arg_4_2,
		func = arg_4_3
	}

	return
end

function var_0_0.updateTimers(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.timerList) do
		if Time.realtimeSinceStartup > iter_5_1.timeMark then
			arg_5_0.timerList[iter_5_0] = nil

			iter_5_1.func()
		end
	end

	return
end

function var_0_0.stopTimers(arg_6_0)
	arg_6_0.isStopped = true

	for iter_6_0, iter_6_1 in pairs(arg_6_0.timerList) do
		iter_6_1.timeMark = iter_6_1.timeMark - Time.realtimeSinceStartup
	end

	return
end

function var_0_0.restartTimers(arg_7_0)
	arg_7_0.isStopped = false

	for iter_7_0, iter_7_1 in pairs(arg_7_0.timerList) do
		iter_7_1.timeMark = iter_7_1.timeMark + Time.realtimeSinceStartup
	end

	return
end

function var_0_0.clearTimers(arg_8_0)
	arg_8_0.timerList = {}

	return
end

function var_0_0.didEnter(arg_9_0)
	onButton(arg_9_0, arg_9_0.backBtn, function()
		if arg_9_0.isPlaying then
			arg_9_0:stopTimers()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("tips_summergame_exit"),
				onYes = function()
					arg_9_0.lastTime = 0

					arg_9_0:restartTimers()
					arg_9_0:gameFinish()

					return
				end,
				onNo = function()
					arg_9_0:restartTimers()

					return
				end
			})
		else
			arg_9_0:closeView()
		end

		return
	end)
	onButton(arg_9_0, findTF(arg_9_0.startMaskTF, "startGame"), function()
		if not arg_9_0.isPlaying then
			arg_9_0:openCoinLayer(false)
			arg_9_0:gameStart()
		end

		return
	end)

	if arg_9_0:getGameRoomData() then
		arg_9_0.gameHelpTip = arg_9_0:getGameRoomData().game_help
	end

	onButton(arg_9_0, findTF(arg_9_0.startMaskTF, "ruleGame"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = arg_9_0.gameHelpTip
		})

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

function var_0_0.changeStartMaskUI(arg_15_0, arg_15_1)
	setActive(arg_15_0.bottomTF, not arg_15_1)
	setActive(arg_15_0.startMaskTF, arg_15_1)

	return
end

function var_0_0.onBackPressed(arg_16_0)
	triggerButton(arg_16_0.backBtn)

	return
end

local function var_0_1(arg_17_0, arg_17_1)
	return Vector2(math.clamp(arg_17_0.x, -arg_17_1.x, arg_17_1.x), math.clamp(arg_17_0.y, -arg_17_1.y, arg_17_1.y))
end

function var_0_0.update(arg_18_0)
	local var_18_0 = Time.GetTimestamp()

	if not arg_18_0.isStopped then
		if arg_18_0.isAfterCount and arg_18_0.sightTimeMark then
			local var_18_2, var_18_3, var_18_4

			if not arg_18_0.moveRect then
				local var_18_1 = tf(arg_18_0.sightTF.parent)

				arg_18_0.moveRect = Vector2(var_18_1.rect.width - arg_18_0.sightTF.rect.width, var_18_1.rect.height - arg_18_0.sightTF.rect.height) / 2
				var_18_2 = arg_18_0.sightTF
				var_18_3 = var_0_1
				var_18_4 = arg_18_0.sightTF.anchoredPosition
			end

			var_18_2.anchoredPosition = var_18_3(var_18_4 + Vector2(arg_18_0.uiMGR.hrz, arg_18_0.uiMGR.vtc) * arg_18_0.tempConfig.moveSpeed * (var_18_0 - arg_18_0.sightTimeMark) * var_0_0.moveModulus * (arg_18_0.isDown and 0.5 or 1), arg_18_0.moveRect)
		end

		arg_18_0:updateTimers()
	end

	arg_18_0.sightTimeMark = var_18_0

	return
end

function var_0_0.resetTime(arg_19_0)
	arg_19_0.countdown = arg_19_0.tempConfig.waitCountdown

	setText(findTF(arg_19_0.countdownTF, "count"), arg_19_0.countdown)

	arg_19_0.lastTime = arg_19_0.tempConfig.baseTime

	setText(arg_19_0.lastTimeTF, arg_19_0.lastTime)

	return
end

function var_0_0.gameStart(arg_20_0)
	arg_20_0.isPlaying = true

	arg_20_0:changeStartMaskUI(false)
	UpdateBeat:Add(arg_20_0.update, arg_20_0)
	setActive(arg_20_0.countdownTF, true)
	;(function(arg_21_0)
		arg_20_0:addTimer("start countdown", 1, function()
			arg_20_0.countdown = arg_20_0.countdown - 1

			setText(findTF(arg_20_0.countdownTF, "count"), arg_20_0.countdown)

			if arg_20_0.countdown > 0 then
				arg_21_0(arg_21_0)
			else
				arg_20_0:afterCountDown()
			end

			return
		end)

		return
	end)(function(arg_21_0)
		arg_20_0:addTimer("start countdown", 1, function()
			arg_20_0.countdown = arg_20_0.countdown - 1

			setText(findTF(arg_20_0.countdownTF, "count"), arg_20_0.countdown)

			if arg_20_0.countdown > 0 then
				arg_21_0(arg_21_0)
			else
				arg_20_0:afterCountDown()
			end

			return
		end)

		return
	end)

	return
end

function var_0_0.afterCountDown(arg_23_0)
	arg_23_0.isAfterCount = true

	arg_23_0.uiMGR:AttachStickOb(arg_23_0.joyStrickTF)
	setActive(arg_23_0.sightTF, true)
	setActive(arg_23_0.countdownTF, false)
	setAnchoredPosition(arg_23_0.sightTF, Vector2.zero)
	arg_23_0:setFireLink(true)

	arg_23_0.score = 0

	arg_23_0:flushTarget(true)
	;(function(arg_24_0)
		arg_23_0:addTimer("gamefinish", 1, function()
			arg_23_0.lastTime = arg_23_0.lastTime - 1

			setText(arg_23_0.lastTimeTF, arg_23_0.lastTime)

			if arg_23_0.lastTime > 0 then
				arg_24_0(arg_24_0)
			else
				arg_23_0:gameFinish()
			end

			return
		end)

		return
	end)(function(arg_24_0)
		arg_23_0:addTimer("gamefinish", 1, function()
			arg_23_0.lastTime = arg_23_0.lastTime - 1

			setText(arg_23_0.lastTimeTF, arg_23_0.lastTime)

			if arg_23_0.lastTime > 0 then
				arg_24_0(arg_24_0)
			else
				arg_23_0:gameFinish()
			end

			return
		end)

		return
	end)

	return
end

function var_0_0.gameFinish(arg_26_0, arg_26_1)
	if arg_26_0.isAfterCount then
		arg_26_0:setFireLink(false)
		arg_26_0.uiMGR:ClearStick()

		arg_26_0.isAfterCount = false
	end

	arg_26_0:clearTimers()
	UpdateBeat:Remove(arg_26_0.update, arg_26_0)
	setActive(arg_26_0.sightTF, false)
	setActive(arg_26_0.countdownTF, false)
	arg_26_0:resetTime()

	arg_26_0.isPlaying = false

	if not arg_26_1 then
		for iter_26_0 = 1, 3 do
			for iter_26_1 = 1, 6 do
				if arg_26_0.cell[iter_26_0][iter_26_1] then
					arg_26_0.targetPanel:Find("line_" .. iter_26_0):GetChild(iter_26_1 - 1):GetChild(0):GetComponent(typeof(Animator)):Play("targetDown")
				end
			end
		end

		Timer.New(function()
			arg_26_0:changeStartMaskUI(true)

			return
		end, var_0_0.animTime):Start()
		arg_26_0:resultFinish()
	end

	return
end

function var_0_0.resultFinish(arg_28_0)
	local var_28_0 = 1

	for iter_28_0 = 1, #arg_28_0.tempConfig.score_level do
		if arg_28_0.score >= arg_28_0.tempConfig.score_level[iter_28_0] then
			var_28_0 = iter_28_0
		end
	end

	arg_28_0.awardLevel = var_28_0

	arg_28_0:SendSuccess(arg_28_0.score)
	arg_28_0:showResultPanel({})

	return
end

function var_0_0.showResultPanel(arg_29_0, arg_29_1, arg_29_2)
	onButton(arg_29_0, arg_29_0.resultPanel:Find("bg"), function()
		setActive(arg_29_0.resultPanel, false)
		arg_29_0:openCoinLayer(true)

		if arg_29_2 then
			arg_29_2()
		else
			arg_29_0:updateCount()
		end

		return
	end)
	onButton(arg_29_0, arg_29_0.resultPanel:Find("main/btn_confirm"), function()
		setActive(arg_29_0.resultPanel, false)
		arg_29_0:openCoinLayer(true)

		if arg_29_2 then
			arg_29_2()
		else
			arg_29_0:updateCount()
		end

		return
	end)

	local var_29_0 = arg_29_0.resultPanel:Find("main")

	if arg_29_0.score > arg_29_0.bestScore then
		arg_29_0:StoreDataToServer({
			arg_29_0.score
		})
		GetImageSpriteFromAtlasAsync("ui/minigameui/shootinggameui_atlas", "new_recode", var_29_0:Find("success"), true)
	else
		GetImageSpriteFromAtlasAsync("ui/minigameui/shootinggameui_atlas", "success", var_29_0:Find("success"), true)
	end

	GetImageSpriteFromAtlasAsync("ui/minigameui/shootinggameui_atlas", "level_" .. arg_29_0.awardLevel, var_29_0:Find("success/level"), true)
	setText(var_29_0:Find("right/score/number"), arg_29_0.score)
	setActive(var_29_0:Find("right/awards/list"), #arg_29_1 > 0)
	setActive(var_29_0:Find("right/awards/nothing"), #arg_29_1 == 0)

	arg_29_0.itemList = arg_29_0.itemList or UIItemList.New(var_29_0:Find("right/awards/list"), var_29_0:Find("right/awards/list/item"))

	arg_29_0.itemList:make(function(arg_31_0, arg_31_1, arg_31_2)
		if arg_31_0 == UIItemList.EventUpdate then
			updateDrop(arg_31_2, arg_29_1[arg_31_1 + 1])
			setText(arg_31_2:Find("number"), "x" .. arg_29_1[arg_31_1 + 1].count)
		end

		return
	end)
	arg_29_0.itemList:align(#arg_29_1)
	setActive(arg_29_0.resultPanel, true)

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_32_0, arg_32_1)
	arg_32_0:updateCount()

	return
end

function var_0_0.updateCount(arg_33_0)
	setText(arg_33_0.ticketTF, arg_33_0:GetMGHubData().count)

	arg_33_0.bestScore = getProxy(GameRoomProxy):getRoomScore(arg_33_0:getGameRoomData().id)

	setText(arg_33_0.bestScoreTF, arg_33_0.bestScore)

	return
end

function var_0_0.initFireFunc(arg_34_0)
	local var_34_0 = pg.TipsMgr.GetInstance()
	local var_34_1 = pg.TimeMgr.GetInstance()
	local var_34_2 = arg_34_0.sightTF:Find("sight_ready")

	setImageAlpha(arg_34_0.sightTF:Find("sight_base"), 1)
	setImageAlpha(arg_34_0.sightTF:Find("sight_ready"), 0)

	local function var_34_3()
		setActive(arg_34_0.corners, true)
		LeanTween.scale(var_0, Vector3(1.95, 1.95, 1), 0.1):setOnComplete(System.Action(function()
			LeanTween.alpha(var_0, 0, 0.1)
			LeanTween.alpha(var_34_2, 1, 0.1)

			return
		end))

		return
	end

	local function var_34_4()
		setActive(arg_34_0.corners, false)
		LeanTween.alpha(var_0, 1, 0.1)
		LeanTween.alpha(var_34_2, 0, 0.1):setOnComplete(System.Action(function()
			LeanTween.scale(var_0, Vector3.one, 0.1)

			return
		end))

		return
	end

	function arg_34_0._downFunc()
		var_34_3()

		return
	end

	function arg_34_0._upFunc()
		LeanTween.scale(var_34_2, Vector3(2, 2, 2), 0.03):setOnComplete(System.Action(function()
			LeanTween.scale(var_34_2, Vector3.one, 0.07):setOnComplete(System.Action(function()
				var_34_4()

				return
			end))

			return
		end))

		local var_40_0, var_40_1, var_40_2 = arg_34_0:checkHit()

		if var_40_0 then
			arg_34_0.cell[var_40_1][var_40_2] = nil
			arg_34_0.score = arg_34_0.score + arg_34_0.tempConfig.targetScore[arg_34_0.cell[var_40_1][var_40_2]]
			arg_34_0.targetCount[arg_34_0.cell[var_40_1][var_40_2]] = arg_34_0.targetCount[arg_34_0.cell[var_40_1][var_40_2]] - 1
			arg_34_0.lastTime = arg_34_0.lastTime + arg_34_0.tempConfig.bonusTime

			setText(arg_34_0.lastTimeTF, arg_34_0.lastTime)
			arg_34_0.targetPanel:Find("line_" .. var_40_1):GetChild(var_40_2 - 1):GetChild(0):GetComponent(typeof(Animator)):Play("targetDown")
			arg_34_0:addTimer("flush call", 0.2 + var_0_0.animTime, function()
				arg_34_0:flushTarget()

				return
			end)

			if not _.any(arg_34_0.targetCount, function(arg_44_0)
				return arg_44_0 > 0
			end) then
				arg_34_0:gameFinish()
			end
		end

		arg_34_0:setFireLink(false)
		arg_34_0:addTimer("fire cd", arg_34_0.tempConfig.fireCD, function()
			arg_34_0:setFireLink(true)

			return
		end)

		return
	end

	function arg_34_0._cancelFunc()
		var_34_4()

		return
	end

	arg_34_0._emptyFunc = nil

	return
end

function var_0_0.setFireLink(arg_47_0, arg_47_1)
	if arg_47_1 then
		setButtonEnabled(arg_47_0.fireBtn, true)

		if arg_47_0._downFunc ~= nil then
			arg_47_0.fireBtnDelegate:AddPointDownFunc(function()
				arg_47_0.isDown = true

				if arg_47_0._main_cannon_sound then
					arg_47_0._main_cannon_sound:Stop(true)
				end

				local var_48_0 = arg_47_0

				var_48_0._main_cannon_sound = pg.CriMgr.GetInstance():PlaySE_V3("battle-cannon-main-prepared")

				arg_47_0._downFunc()

				return
			end)
		end

		if arg_47_0._upFunc ~= nil then
			arg_47_0.fireBtnDelegate:AddPointUpFunc(function()
				if arg_47_0.isDown then
					if arg_47_0._main_cannon_sound then
						arg_47_0._main_cannon_sound:Stop(true)
					end

					pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/battle/boom2")

					arg_47_0.isDown = false

					arg_47_0._upFunc()
				end

				return
			end)
		end

		if arg_47_0._cancelFunc ~= nil then
			arg_47_0.fireBtnDelegate:AddPointExitFunc(function()
				if arg_47_0.isDown then
					if arg_47_0._main_cannon_sound then
						arg_47_0._main_cannon_sound:Stop(true)
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

		setButtonEnabled(arg_47_0.fireBtn, false)
		arg_47_0.fireBtnDelegate:RemovePointDownFunc()
		arg_47_0.fireBtnDelegate:RemovePointUpFunc()
		arg_47_0.fireBtnDelegate:RemovePointExitFunc()
	end

	return
end

function var_0_0.flushTarget(arg_51_0, arg_51_1)
	if arg_51_1 then
		arg_51_0.targetCount = {
			2,
			4,
			6
		}
	end

	for iter_51_0 = 1, 3 do
		for iter_51_1 = 1, 6 do
			local var_51_0 = arg_51_0.targetPanel:Find("line_" .. iter_51_0)

			removeAllChildren(var_51_0:GetChild(iter_51_1 - 1))
		end
	end

	local var_51_1 = {
		0,
		0,
		0
	}

	arg_51_0.cell = {
		{},
		{},
		{}
	}

	for iter_51_2, iter_51_3 in ipairs(arg_51_0.targetCount) do
		for iter_51_4 = 1, iter_51_3 do
			local var_51_2 = math.random(3)
			local var_51_3 = math.random(6)

			while arg_51_0.cell[var_51_2][var_51_3] or arg_51_1 and var_51_1[var_51_2] >= 4 do
				var_51_3 = math.random(6)
				var_51_2 = math.random(3)
			end

			var_51_1[var_51_2] = var_51_1[var_51_2] + 1
			arg_51_0.cell[var_51_2][var_51_3] = iter_51_2

			local var_51_4 = arg_51_0.targetPanel:Find("line_" .. var_51_2)

			cloneTplTo(arg_51_0.targetTpl[iter_51_2], var_51_4:GetChild(var_51_3 - 1))
		end
	end

	setText(arg_51_0.scoreTF, arg_51_0.score)

	return
end

function var_0_0.checkHit(arg_52_0)
	for iter_52_0 = 1, 3 do
		for iter_52_1 = 1, 6 do
			if arg_52_0.cell[iter_52_0][iter_52_1] then
				local var_52_0 = arg_52_0.targetPanel:Find("line_" .. iter_52_0):GetChild(iter_52_1 - 1):GetChild(0):Find("icon/face")
				local var_52_1 = arg_52_0.sightTF:InverseTransformPoint(var_52_0:TransformPoint(var_52_0.position))

				if var_52_1.x * var_52_1.x + var_52_1.y * var_52_1.y < arg_52_0.tempConfig.half * arg_52_0.tempConfig.half then
					return true, iter_52_0, iter_52_1
				end
			end
		end
	end

	return
end

function var_0_0.willExit(arg_53_0)
	return
end

return var_0_0
