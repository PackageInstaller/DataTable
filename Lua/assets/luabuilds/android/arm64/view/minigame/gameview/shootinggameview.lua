local var_0_0 = class("ShootingGameView", import("..BaseMiniGameView"))

var_0_0.animTime = 0.3333333333333333
var_0_0.moveModulus = 120

function var_0_0.getUIName(arg_1_0)
	return "ShootingGameUI"
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

	arg_2_0.startMaskTF = arg_2_0.shootAreaTF:Find("start_mask")
	arg_2_0.countdownTF = arg_2_0.startMaskTF:Find("count")
	arg_2_0.lastTimeTF = arg_2_0.shootAreaTF:Find("time_word")
	arg_2_0.bottomTF = arg_2_0._tf:Find("noAdaptPanel/bottom")
	arg_2_0.joyStrickTF = arg_2_0.bottomTF:Find("Stick")
	arg_2_0.fireBtn = arg_2_0.bottomTF:Find("fire/ActCtl")
	arg_2_0.fireBtnDelegate = GetOrAddComponent(arg_2_0.fireBtn, "EventTriggerListener")

	setActive(arg_2_0.fireBtn:Find("block"), false)

	arg_2_0.resultPanel = arg_2_0._tf:Find("result_panel")

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
					arg_9_0:gameFinish(true)
					arg_9_0:closeView()

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
	onButton(arg_9_0, arg_9_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_summer_shooting.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0.startMaskTF, function()
		if not arg_9_0.isPlaying then
			arg_9_0:gameStart()
		end

		return
	end)
	arg_9_0:initData()
	arg_9_0:updateCount()
	arg_9_0:resetTime()
	arg_9_0:initFireFunc()
	arg_9_0:setFireLink(false)
	setActive(arg_9_0.startMaskTF, true)

	return
end

function var_0_0.onBackPressed(arg_15_0)
	triggerButton(arg_15_0.backBtn)

	return
end

local function var_0_1(arg_16_0, arg_16_1)
	return Vector2(math.clamp(arg_16_0.x, -arg_16_1.x, arg_16_1.x), math.clamp(arg_16_0.y, -arg_16_1.y, arg_16_1.y))
end

function var_0_0.update(arg_17_0)
	local var_17_0 = Time.GetTimestamp()

	if not arg_17_0.isStopped then
		if arg_17_0.isAfterCount and arg_17_0.sightTimeMark then
			local var_17_2, var_17_3, var_17_4

			if not arg_17_0.moveRect then
				local var_17_1 = tf(arg_17_0.sightTF.parent)

				arg_17_0.moveRect = Vector2(var_17_1.rect.width - arg_17_0.sightTF.rect.width, var_17_1.rect.height - arg_17_0.sightTF.rect.height) / 2
				var_17_2 = arg_17_0.sightTF
				var_17_3 = var_0_1
				var_17_4 = arg_17_0.sightTF.anchoredPosition
			end

			var_17_2.anchoredPosition = var_17_3(var_17_4 + Vector2(arg_17_0.uiMGR.hrz, arg_17_0.uiMGR.vtc) * arg_17_0.tempConfig.moveSpeed * (var_17_0 - arg_17_0.sightTimeMark) * var_0_0.moveModulus * (arg_17_0.isDown and 0.5 or 1), arg_17_0.moveRect)
		end

		arg_17_0:updateTimers()
	end

	arg_17_0.sightTimeMark = var_17_0

	return
end

function var_0_0.resetTime(arg_18_0)
	arg_18_0.countdown = arg_18_0.tempConfig.waitCountdown

	setText(arg_18_0.countdownTF, arg_18_0.countdown)

	arg_18_0.lastTime = arg_18_0.tempConfig.baseTime

	setText(arg_18_0.lastTimeTF, arg_18_0.lastTime)

	return
end

function var_0_0.gameStart(arg_19_0)
	arg_19_0.isPlaying = true

	UpdateBeat:Add(arg_19_0.update, arg_19_0)
	setActive(arg_19_0.countdownTF, true)
	setActive(arg_19_0.startMaskTF:Find("word"), false)
	;(function(arg_20_0)
		arg_19_0:addTimer("start countdown", 1, function()
			arg_19_0.countdown = arg_19_0.countdown - 1

			setText(arg_19_0.countdownTF, arg_19_0.countdown)

			if arg_19_0.countdown > 0 then
				arg_20_0(arg_20_0)
			else
				arg_19_0:afterCountDown()
			end

			return
		end)

		return
	end)(function(arg_20_0)
		arg_19_0:addTimer("start countdown", 1, function()
			arg_19_0.countdown = arg_19_0.countdown - 1

			setText(arg_19_0.countdownTF, arg_19_0.countdown)

			if arg_19_0.countdown > 0 then
				arg_20_0(arg_20_0)
			else
				arg_19_0:afterCountDown()
			end

			return
		end)

		return
	end)

	return
end

function var_0_0.afterCountDown(arg_22_0)
	arg_22_0.isAfterCount = true

	arg_22_0.uiMGR:AttachStickOb(arg_22_0.joyStrickTF)
	setActive(arg_22_0.sightTF, true)
	setAnchoredPosition(arg_22_0.sightTF, Vector2.zero)
	arg_22_0:setFireLink(true)
	setActive(arg_22_0.startMaskTF, false)

	arg_22_0.score = 0

	arg_22_0:flushTarget(true)
	;(function(arg_23_0)
		arg_22_0:addTimer("gamefinish", 1, function()
			arg_22_0.lastTime = arg_22_0.lastTime - 1

			setText(arg_22_0.lastTimeTF, arg_22_0.lastTime)

			if arg_22_0.lastTime > 0 then
				arg_23_0(arg_23_0)
			else
				arg_22_0:gameFinish()
			end

			return
		end)

		return
	end)(function(arg_23_0)
		arg_22_0:addTimer("gamefinish", 1, function()
			arg_22_0.lastTime = arg_22_0.lastTime - 1

			setText(arg_22_0.lastTimeTF, arg_22_0.lastTime)

			if arg_22_0.lastTime > 0 then
				arg_23_0(arg_23_0)
			else
				arg_22_0:gameFinish()
			end

			return
		end)

		return
	end)

	return
end

function var_0_0.gameFinish(arg_25_0, arg_25_1)
	if arg_25_0.isAfterCount then
		arg_25_0:setFireLink(false)
		arg_25_0.uiMGR:ClearStick()

		arg_25_0.isAfterCount = false
	end

	arg_25_0:clearTimers()
	UpdateBeat:Remove(arg_25_0.update, arg_25_0)
	setActive(arg_25_0.sightTF, false)
	setActive(arg_25_0.countdownTF, false)
	arg_25_0:resetTime()

	arg_25_0.isPlaying = false

	if not arg_25_1 then
		for iter_25_0 = 1, 3 do
			for iter_25_1 = 1, 6 do
				if arg_25_0.cell[iter_25_0][iter_25_1] then
					arg_25_0.targetPanel:Find("line_" .. iter_25_0):GetChild(iter_25_1 - 1):GetChild(0):GetComponent(typeof(Animator)):Play("targetDown")
				end
			end
		end

		Timer.New(function()
			setActive(arg_25_0.startMaskTF, true)
			setActive(arg_25_0.startMaskTF:Find("word"), true)

			return
		end, var_0_0.animTime):Start()
		arg_25_0:resultFinish()
	end

	return
end

function var_0_0.resultFinish(arg_27_0)
	local var_27_0

	for iter_27_0 = 1, #arg_27_0.tempConfig.score_level do
		if arg_27_0.score >= arg_27_0.tempConfig.score_level[#arg_27_0.tempConfig.score_level - iter_27_0 + 1] then
			var_27_0 = iter_27_0

			break
		end
	end

	arg_27_0.awardLevel = var_27_0

	if arg_27_0:GetMGHubData().count > 0 then
		arg_27_0:SendSuccess(var_27_0)
	else
		arg_27_0:showResultPanel({})
	end

	return
end

function var_0_0.showResultPanel(arg_28_0, arg_28_1, arg_28_2)
	onButton(arg_28_0, arg_28_0.resultPanel:Find("bg"), function()
		setActive(arg_28_0.resultPanel, false)

		if arg_28_2 then
			arg_28_2()
		else
			arg_28_0:updateCount()
		end

		return
	end)
	onButton(arg_28_0, arg_28_0.resultPanel:Find("main/btn_confirm"), function()
		setActive(arg_28_0.resultPanel, false)

		if arg_28_2 then
			arg_28_2()
		else
			arg_28_0:updateCount()
		end

		return
	end)

	local var_28_0 = arg_28_0.resultPanel:Find("main")

	if arg_28_0.score > arg_28_0.bestScore then
		arg_28_0:StoreDataToServer({
			arg_28_0.score
		})
		GetImageSpriteFromAtlasAsync("ui/minigameui/shootinggameui_atlas", "new_recode", var_28_0:Find("success"), true)
	else
		GetImageSpriteFromAtlasAsync("ui/minigameui/shootinggameui_atlas", "success", var_28_0:Find("success"), true)
	end

	GetImageSpriteFromAtlasAsync("ui/minigameui/shootinggameui_atlas", "level_" .. #arg_28_0.tempConfig.score_level - arg_28_0.awardLevel + 1, var_28_0:Find("success/level"), true)
	setText(var_28_0:Find("right/score/number"), arg_28_0.score)
	setActive(var_28_0:Find("right/awards/list"), #arg_28_1 > 0)
	setActive(var_28_0:Find("right/awards/nothing"), #arg_28_1 == 0)

	arg_28_0.itemList = arg_28_0.itemList or UIItemList.New(var_28_0:Find("right/awards/list"), var_28_0:Find("right/awards/list/item"))

	arg_28_0.itemList:make(function(arg_30_0, arg_30_1, arg_30_2)
		if arg_30_0 == UIItemList.EventUpdate then
			updateDrop(arg_30_2, arg_28_1[arg_30_1 + 1])
			setText(arg_30_2:Find("number"), "x" .. arg_28_1[arg_30_1 + 1].count)
		end

		return
	end)
	arg_28_0.itemList:align(#arg_28_1)
	setActive(arg_28_0.resultPanel, true)

	return
end

function var_0_0.updateAfterFinish(arg_31_0)
	local var_31_0 = getProxy(MiniGameProxy):GetMiniGameData(MiniGameDataCreator.ShrineGameID):GetRuntimeData("count") or 0

	pg.m02:sendNotification(GAME.MODIFY_MINI_GAME_DATA, {
		id = MiniGameDataCreator.ShrineGameID,
		map = {
			count = var_31_0 + 1
		}
	})

	return
end

function var_0_0.OnGetAwardDone(arg_32_0, arg_32_1)
	if arg_32_1.cmd == MiniGameOPCommand.CMD_COMPLETE then
		local var_32_0 = arg_32_0:GetMGHubData()

		if var_32_0.ultimate == 0 and var_32_0.usedtime >= var_32_0:getConfig("reward_need") then
			pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
				hubid = var_32_0.id,
				cmd = MiniGameOPCommand.CMD_ULTIMATE,
				args1 = {}
			})
		end
	elseif arg_32_1.cmd == MiniGameOPCommand.CMD_ULTIMATE then
		pg.NewStoryMgr.GetInstance():Play("TIANHOUYUYI2")
	end

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_33_0, arg_33_1)
	arg_33_0:updateCount()

	return
end

function var_0_0.updateCount(arg_34_0)
	setText(arg_34_0.ticketTF, arg_34_0:GetMGHubData().count)

	arg_34_0.bestScore = checkExist(arg_34_0:GetMGData():GetRuntimeData("elements"), {
		1
	}) or 0

	setText(arg_34_0.bestScoreTF, arg_34_0.bestScore)

	return
end

function var_0_0.initFireFunc(arg_35_0)
	local var_35_0 = pg.TipsMgr.GetInstance()
	local var_35_1 = pg.TimeMgr.GetInstance()
	local var_35_2 = arg_35_0.sightTF:Find("sight_ready")

	setImageAlpha(arg_35_0.sightTF:Find("sight_base"), 1)
	setImageAlpha(arg_35_0.sightTF:Find("sight_ready"), 0)

	local function var_35_3()
		setActive(arg_35_0.corners, true)
		LeanTween.scale(var_0, Vector3(1.95, 1.95, 1), 0.1):setOnComplete(System.Action(function()
			LeanTween.alpha(var_0, 0, 0.1)
			LeanTween.alpha(var_35_2, 1, 0.1)

			return
		end))

		return
	end

	local function var_35_4()
		setActive(arg_35_0.corners, false)
		LeanTween.alpha(var_0, 1, 0.1)
		LeanTween.alpha(var_35_2, 0, 0.1):setOnComplete(System.Action(function()
			LeanTween.scale(var_0, Vector3.one, 0.1)

			return
		end))

		return
	end

	function arg_35_0._downFunc()
		var_35_3()

		return
	end

	function arg_35_0._upFunc()
		LeanTween.scale(var_35_2, Vector3(2, 2, 2), 0.03):setOnComplete(System.Action(function()
			LeanTween.scale(var_35_2, Vector3.one, 0.07):setOnComplete(System.Action(function()
				var_35_4()

				return
			end))

			return
		end))

		local var_41_0, var_41_1, var_41_2 = arg_35_0:checkHit()

		if var_41_0 then
			arg_35_0.cell[var_41_1][var_41_2] = nil
			arg_35_0.score = arg_35_0.score + arg_35_0.tempConfig.targetScore[arg_35_0.cell[var_41_1][var_41_2]]
			arg_35_0.targetCount[arg_35_0.cell[var_41_1][var_41_2]] = arg_35_0.targetCount[arg_35_0.cell[var_41_1][var_41_2]] - 1
			arg_35_0.lastTime = arg_35_0.lastTime + arg_35_0.tempConfig.bonusTime

			setText(arg_35_0.lastTimeTF, arg_35_0.lastTime)
			arg_35_0.targetPanel:Find("line_" .. var_41_1):GetChild(var_41_2 - 1):GetChild(0):GetComponent(typeof(Animator)):Play("targetDown")
			arg_35_0:addTimer("flush call", 0.2 + var_0_0.animTime, function()
				arg_35_0:flushTarget()

				return
			end)

			if not _.any(arg_35_0.targetCount, function(arg_45_0)
				return arg_45_0 > 0
			end) then
				arg_35_0:gameFinish()
			end
		end

		arg_35_0:setFireLink(false)
		arg_35_0:addTimer("fire cd", arg_35_0.tempConfig.fireCD, function()
			arg_35_0:setFireLink(true)

			return
		end)

		return
	end

	function arg_35_0._cancelFunc()
		var_35_4()

		return
	end

	arg_35_0._emptyFunc = nil

	return
end

function var_0_0.setFireLink(arg_48_0, arg_48_1)
	if arg_48_1 then
		setButtonEnabled(arg_48_0.fireBtn, true)

		if arg_48_0._downFunc ~= nil then
			arg_48_0.fireBtnDelegate:AddPointDownFunc(function()
				arg_48_0.isDown = true

				if arg_48_0._main_cannon_sound then
					arg_48_0._main_cannon_sound:Stop(true)
				end

				local var_49_0 = arg_48_0

				var_49_0._main_cannon_sound = pg.CriMgr.GetInstance():PlaySE_V3("battle-cannon-main-prepared")

				arg_48_0._downFunc()

				return
			end)
		end

		if arg_48_0._upFunc ~= nil then
			arg_48_0.fireBtnDelegate:AddPointUpFunc(function()
				if arg_48_0.isDown then
					if arg_48_0._main_cannon_sound then
						arg_48_0._main_cannon_sound:Stop(true)
					end

					pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/battle/boom2")

					arg_48_0.isDown = false

					arg_48_0._upFunc()
				end

				return
			end)
		end

		if arg_48_0._cancelFunc ~= nil then
			arg_48_0.fireBtnDelegate:AddPointExitFunc(function()
				if arg_48_0.isDown then
					if arg_48_0._main_cannon_sound then
						arg_48_0._main_cannon_sound:Stop(true)
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

		setButtonEnabled(arg_48_0.fireBtn, false)
		arg_48_0.fireBtnDelegate:RemovePointDownFunc()
		arg_48_0.fireBtnDelegate:RemovePointUpFunc()
		arg_48_0.fireBtnDelegate:RemovePointExitFunc()
	end

	return
end

function var_0_0.flushTarget(arg_52_0, arg_52_1)
	if arg_52_1 then
		arg_52_0.targetCount = {
			2,
			4,
			6
		}
	end

	for iter_52_0 = 1, 3 do
		for iter_52_1 = 1, 6 do
			local var_52_0 = arg_52_0.targetPanel:Find("line_" .. iter_52_0)

			removeAllChildren(var_52_0:GetChild(iter_52_1 - 1))
		end
	end

	local var_52_1 = {
		0,
		0,
		0
	}

	arg_52_0.cell = {
		{},
		{},
		{}
	}

	for iter_52_2, iter_52_3 in ipairs(arg_52_0.targetCount) do
		for iter_52_4 = 1, iter_52_3 do
			local var_52_2 = math.random(3)
			local var_52_3 = math.random(6)

			while arg_52_0.cell[var_52_2][var_52_3] or arg_52_1 and var_52_1[var_52_2] >= 4 do
				var_52_3 = math.random(6)
				var_52_2 = math.random(3)
			end

			var_52_1[var_52_2] = var_52_1[var_52_2] + 1
			arg_52_0.cell[var_52_2][var_52_3] = iter_52_2

			local var_52_4 = arg_52_0.targetPanel:Find("line_" .. var_52_2)

			cloneTplTo(arg_52_0.targetTpl[iter_52_2], var_52_4:GetChild(var_52_3 - 1))
		end
	end

	setText(arg_52_0.scoreTF, arg_52_0.score)

	return
end

function var_0_0.checkHit(arg_53_0)
	for iter_53_0 = 1, 3 do
		for iter_53_1 = 1, 6 do
			if arg_53_0.cell[iter_53_0][iter_53_1] then
				local var_53_0 = arg_53_0.targetPanel:Find("line_" .. iter_53_0):GetChild(iter_53_1 - 1):GetChild(0):Find("icon/face")
				local var_53_1 = arg_53_0.sightTF:InverseTransformPoint(var_53_0:TransformPoint(var_53_0.position))

				if var_53_1.x * var_53_1.x + var_53_1.y * var_53_1.y < arg_53_0.tempConfig.half * arg_53_0.tempConfig.half then
					return true, iter_53_0, iter_53_1
				end
			end
		end
	end

	return
end

function var_0_0.willExit(arg_54_0)
	return
end

return var_0_0
