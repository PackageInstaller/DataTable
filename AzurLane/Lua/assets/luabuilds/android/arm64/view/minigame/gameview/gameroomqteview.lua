local var_0_0 = class("GameRoomQTEView", import("..BaseMiniGameView"))

function var_0_0.getUIName(arg_1_0)
	return "GameRoomQTEUI"
end

function var_0_0.init(arg_2_0)
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
	arg_2_0.startUI = arg_2_0._tf:Find("start_ui")
	arg_2_0.startBtn = arg_2_0.startUI:Find("start_btn")
	arg_2_0.ruleBtn = arg_2_0.startUI:Find("rule_btn")
	arg_2_0.qBtn = arg_2_0.startUI:Find("q_btn")
	arg_2_0.countUI = arg_2_0._tf:Find("count_ui")
	arg_2_0.countNumTxt = arg_2_0.countUI:Find("num")
	arg_2_0.endUI = arg_2_0._tf:Find("end_ui")
	arg_2_0.endExitBtn = arg_2_0.endUI:Find("exit_btn")
	arg_2_0.endBestTxt = arg_2_0.endUI:Find("rope/paper/best_txt")
	arg_2_0.endScoreTxt = arg_2_0.endUI:Find("rope/paper/score_txt")
	arg_2_0.endComboTxt = arg_2_0.endUI:Find("rope/paper/combo_txt")
	arg_2_0.endMissTxt = arg_2_0.endUI:Find("rope/paper/miss_txt")
	arg_2_0.endHitTxt = arg_2_0.endUI:Find("rope/paper/hit_txt")
	arg_2_0.endUIEvent = arg_2_0.endUI:Find("rope"):GetComponent("DftAniEvent")
	arg_2_0.content = arg_2_0._tf:Find("content")
	arg_2_0.res = arg_2_0._tf:Find("res")
	arg_2_0.gameBg = arg_2_0.content:Find("game_bg")
	arg_2_0.xgmPos = arg_2_0.content:Find("xiongguimao_pos")
	arg_2_0.guinuPos = arg_2_0.content:Find("guinu_pos")
	arg_2_0.bucketA = arg_2_0._tf:Find("content/bucket_A")
	arg_2_0.bucketASpine = arg_2_0.bucketA:GetComponent("SpineAnimUI")
	arg_2_0.bucketAGraphic = arg_2_0.bucketA:GetComponent("SkeletonGraphic")
	arg_2_0.bucketB = arg_2_0._tf:Find("content/bucket_B")
	arg_2_0.bucketBSpine = arg_2_0.bucketB:GetComponent("SpineAnimUI")
	arg_2_0.bucketBGraphic = arg_2_0.bucketB:GetComponent("SkeletonGraphic")
	arg_2_0.bucketC = arg_2_0._tf:Find("content/bucket_C")
	arg_2_0.msHand = arg_2_0.bucketC:Find("ani")
	arg_2_0.msHandAnimator = arg_2_0.msHand:GetComponent("Animator")
	arg_2_0.msHandSlot = arg_2_0.msHand:Find("slot")
	arg_2_0.msHandEvent = arg_2_0.msHand:GetComponent("DftAniEvent")
	arg_2_0.msBlockList = {}

	arg_2_0.msHandEvent:SetEndEvent(function()
		arg_2_0:msClearHold()
		setActive(arg_2_0.msHand, false)

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
	arg_2_0.cut1 = arg_2_0.bucketB:Find("cut_1")
	arg_2_0.cut2 = arg_2_0.bucketB:Find("cut_2")
	arg_2_0.cut3 = arg_2_0.bucketB:Find("cut_3")
	arg_2_0.cut1Animator = arg_2_0.cut1:GetComponent("Animator")
	arg_2_0.cut2Animator = arg_2_0.cut2:GetComponent("Animator")
	arg_2_0.cut3Animator = arg_2_0.cut3:GetComponent("Animator")
	arg_2_0.cut1Event = arg_2_0.cut1:GetComponent("DftAniEvent")
	arg_2_0.cut2Event = arg_2_0.cut2:GetComponent("DftAniEvent")
	arg_2_0.cut3Event = arg_2_0.cut3:GetComponent("DftAniEvent")

	arg_2_0.cut1Event:SetEndEvent(function()
		setActive(arg_2_0.cut1, false)

		return
	end)
	arg_2_0.cut2Event:SetEndEvent(function()
		setActive(arg_2_0.cut2, false)

		return
	end)
	arg_2_0.cut3Event:SetEndEvent(function()
		setActive(arg_2_0.cut3, false)

		return
	end)

	arg_2_0.keyUI = arg_2_0.content:Find("key_ui")
	arg_2_0.keyBar = arg_2_0.keyUI:Find("key_bar")
	arg_2_0.aBtn = arg_2_0.keyUI:Find("A_btn")
	arg_2_0.bBtn = arg_2_0.keyUI:Find("B_btn")
	arg_2_0.cBtn = arg_2_0.keyUI:Find("C_btn")
	arg_2_0.comboAni = arg_2_0.content:Find("combo_bar/center"):GetComponent("Animator")
	arg_2_0.comboTxt = arg_2_0.content:Find("combo_bar/center/combo_txt")
	arg_2_0.comboAni.enabled = false
	arg_2_0.scoreTxt = arg_2_0.content:Find("score_bar/txt")
	arg_2_0.remainTxt = arg_2_0.content:Find("remain_time_bar/txt")
	arg_2_0.roundTxt = arg_2_0.keyUI:Find("round_time_bar/txt")
	arg_2_0.firePos = arg_2_0._tf:Find("content/pos/fire_pos").anchoredPosition
	arg_2_0.hitPos = arg_2_0._tf:Find("content/pos/hit_pos").anchoredPosition
	arg_2_0.aPos = arg_2_0._tf:Find("content/pos/a_pos").anchoredPosition
	arg_2_0.bPos = arg_2_0._tf:Find("content/pos/b_pos").anchoredPosition
	arg_2_0.cPos = arg_2_0._tf:Find("content/pos/c_pos").anchoredPosition
	arg_2_0.missPos = arg_2_0._tf:Find("content/pos/miss_pos").anchoredPosition
	arg_2_0.backBtn = arg_2_0.content:Find("back_btn")
	arg_2_0.autoLoader = AutoLoader.New()

	arg_2_0.autoLoader:LoadSprite("ui/minigameui/qtegameuiasync_atlas", "background", arg_2_0.gameBg, false)

	return
end

function var_0_0.didEnter(arg_7_0)
	arg_7_0:initGame()
	onButton(arg_7_0, arg_7_0.backBtn, function()
		arg_7_0:SendSuccess(arg_7_0.score)
		arg_7_0:setGameState(arg_7_0.STATE_BEGIN)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.qBtn, function()
		arg_7_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_PANEL)

	if arg_7_0:getGameRoomData() then
		arg_7_0.gameHelpTip = arg_7_0:getGameRoomData().game_help
	end

	onButton(arg_7_0, arg_7_0.ruleBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = arg_7_0.gameHelpTip
		})

		return
	end)
	onButton(arg_7_0, arg_7_0.startBtn, function()
		setButtonEnabled(arg_7_0.startBtn, false)
		parallelAsync({
			function(arg_12_0)
				arg_7_0:loadXGM(arg_12_0)

				return
			end,
			function(arg_13_0)
				arg_7_0:loadGuinu(arg_13_0)

				return
			end
		}, function()
			arg_7_0:setGameState(arg_7_0.STATE_COUNT)

			return
		end)

		return
	end, SFX_PANEL)

	if QTEGAME_DEBUG then
		onButton(arg_7_0, arg_7_0.xgm, function()
			arg_7_0:setGameState(arg_7_0.STATE_SHOW)

			return
		end)
	end

	onButton(arg_7_0, arg_7_0.endExitBtn, function()
		arg_7_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_PANEL)
	arg_7_0.endUIEvent:SetEndEvent(function()
		arg_7_0:SendSuccess(arg_7_0.score)
		setActive(arg_7_0.endExitBtn, true)

		return
	end)

	local function var_7_0(arg_18_0)
		if arg_7_0.gameState == arg_7_0.STATE_CLICK and arg_7_0.curShowBlock then
			arg_7_0.curShowBlock:select(arg_18_0)

			arg_7_0.curShowBlock = arg_7_0.curShowBlock.nextBlock

			if arg_7_0.curShowBlock == nil then
				arg_7_0:managedTween(LeanTween.delayedCall, function()
					arg_7_0:setGameState(arg_7_0.STATE_SHOW)

					return
				end, 0.2, nil)
			end
		end

		return
	end

	onButton(arg_7_0, arg_7_0.aBtn, function()
		var_7_0(arg_7_0.TYPE_A)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.bBtn, function()
		var_7_0(arg_7_0.TYPE_B)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.cBtn, function()
		var_7_0(arg_7_0.TYPE_C)

		return
	end, SFX_PANEL)
	arg_7_0:setGameState(arg_7_0.STATE_BEGIN)
	arg_7_0:checkHelp()

	return
end

function var_0_0.initGame(arg_23_0)
	arg_23_0.curShowBlock = nil
	arg_23_0.randomBlockList = nil
	arg_23_0.scorePerHit = arg_23_0:GetMGData():GetSimpleValue("scorePerHit")
	arg_23_0.comboRange = arg_23_0:GetMGData():GetSimpleValue("comboRange")
	arg_23_0.comboAddScore = arg_23_0:GetMGData():GetSimpleValue("comboAddScore")
	arg_23_0.targetCombo = arg_23_0:GetMGData():GetSimpleValue("targetCombo")
	arg_23_0.targetComboScore = arg_23_0:GetMGData():GetSimpleValue("targetComboScore")
	arg_23_0.usingBlockList = {}
	arg_23_0.blockUniId = 0

	arg_23_0:resetGame()
	arg_23_0.bucketASpine:SetActionCallBack(function(arg_24_0)
		if arg_24_0 == "FINISH" then
			arg_23_0:setBucketAAction("idle")
		end

		return
	end)
	arg_23_0.bucketBSpine:SetActionCallBack(function(arg_25_0)
		if arg_25_0 == "FINISH" then
			arg_23_0:setBucketBAction("idle")
		end

		return
	end)

	return
end

function var_0_0.resetGame(arg_26_0)
	arg_26_0:setXgmAction("idle")
	arg_26_0:setGuinuAction("normal")
	arg_26_0:setBucketAAction("idle")
	arg_26_0:setBucketBAction("idle")
	setActive(arg_26_0.msHand, false)

	arg_26_0.score = 0
	arg_26_0.bestComboNum = 0
	arg_26_0.comboNum = 0
	arg_26_0.missNum = 0
	arg_26_0.hitNum = 0
	arg_26_0.remainTime = arg_26_0:GetMGData():GetSimpleValue("gameTime")
	arg_26_0.roundTime = arg_26_0:GetMGData():GetSimpleValue("roundTime")

	setText(arg_26_0.comboTxt, 0)
	setText(arg_26_0.scoreTxt, 0)
	setText(arg_26_0.remainTxt, arg_26_0.remainTime .. "S")
	setText(arg_26_0.roundTxt, arg_26_0.roundTime)
	arg_26_0:clearTimer()
	arg_26_0:hideRandomList()
	arg_26_0:clearUsingBlock()
	arg_26_0:cleanManagedTween()

	return
end

function var_0_0.setGameState(arg_27_0, arg_27_1)
	if arg_27_1 == arg_27_0.gameState then
		return
	end

	arg_27_0.gameState = arg_27_1

	if arg_27_0.gameState == arg_27_0.STATE_BEGIN then
		arg_27_0:openCoinLayer(true)
		setButtonEnabled(arg_27_0.startBtn, true)
		;(function(arg_28_0)
			for iter_28_0, iter_28_1 in pairs({
				arg_27_0.startUI,
				arg_27_0.content,
				arg_27_0.endUI,
				arg_27_0.countUI,
				arg_27_0.keyUI,
				arg_27_0.keyBar
			}) do
				local var_28_0 = table.indexof(arg_28_0, iter_28_1) and true

				setActive(iter_28_1, var_28_0)
			end

			if isActive(arg_27_0.endUI) then
				pg.UIMgr.GetInstance():BlurPanel(arg_27_0.endUI)
			else
				pg.UIMgr.GetInstance():UnOverlayPanel(arg_27_0.endUI, arg_27_0._tf)
			end

			return
		end)({
			arg_27_0.startUI
		})
		arg_27_0:resetGame()
	elseif arg_27_0.gameState == arg_27_0.STATE_COUNT then
		arg_27_0:openCoinLayer(false)
		;(function(arg_28_0)
			for iter_28_0, iter_28_1 in pairs({
				arg_27_0.startUI,
				arg_27_0.content,
				arg_27_0.endUI,
				arg_27_0.countUI,
				arg_27_0.keyUI,
				arg_27_0.keyBar
			}) do
				local var_28_0 = table.indexof(arg_28_0, iter_28_1) and true

				setActive(iter_28_1, var_28_0)
			end

			if isActive(arg_27_0.endUI) then
				pg.UIMgr.GetInstance():BlurPanel(arg_27_0.endUI)
			else
				pg.UIMgr.GetInstance():UnOverlayPanel(arg_27_0.endUI, arg_27_0._tf)
			end

			return
		end)({
			arg_27_0.countUI,
			arg_27_0.content
		})

		local var_27_0 = Time.realtimeSinceStartup

		arg_27_0:managedTween(LeanTween.delayedCall, function()
			arg_27_0:startGameTimer()
			arg_27_0:setGameState(arg_27_0.STATE_CLICK)

			return
		end, 3, nil):setOnUpdate(System.Action_float(function(arg_30_0)
			setText(arg_27_0.countNumTxt, math.ceil(3 - (Time.realtimeSinceStartup - var_27_0)))

			return
		end))
	elseif arg_27_0.gameState == arg_27_0.STATE_CLICK then
		(function(arg_28_0)
			for iter_28_0, iter_28_1 in pairs({
				arg_27_0.startUI,
				arg_27_0.content,
				arg_27_0.endUI,
				arg_27_0.countUI,
				arg_27_0.keyUI,
				arg_27_0.keyBar
			}) do
				local var_28_0 = table.indexof(arg_28_0, iter_28_1) and true

				setActive(iter_28_1, var_28_0)
			end

			if isActive(arg_27_0.endUI) then
				pg.UIMgr.GetInstance():BlurPanel(arg_27_0.endUI)
			else
				pg.UIMgr.GetInstance():UnOverlayPanel(arg_27_0.endUI, arg_27_0._tf)
			end

			return
		end)({
			arg_27_0.content,
			arg_27_0.keyUI,
			arg_27_0.keyBar
		})

		arg_27_0.randomBlockList, arg_27_0.curShowBlock, arg_27_0.firstShowBlock = arg_27_0:getRandomList()

		arg_27_0:startRoundTimer()
	elseif arg_27_0.gameState == arg_27_0.STATE_SHOW then
		(function(arg_28_0)
			for iter_28_0, iter_28_1 in pairs({
				arg_27_0.startUI,
				arg_27_0.content,
				arg_27_0.endUI,
				arg_27_0.countUI,
				arg_27_0.keyUI,
				arg_27_0.keyBar
			}) do
				local var_28_0 = table.indexof(arg_28_0, iter_28_1) and true

				setActive(iter_28_1, var_28_0)
			end

			if isActive(arg_27_0.endUI) then
				pg.UIMgr.GetInstance():BlurPanel(arg_27_0.endUI)
			else
				pg.UIMgr.GetInstance():UnOverlayPanel(arg_27_0.endUI, arg_27_0._tf)
			end

			return
		end)({
			arg_27_0.content
		})
		arg_27_0:hideRandomList()
		arg_27_0:playArchiveAnim(arg_27_0.randomBlockList, arg_27_0:getUserResult())
	elseif arg_27_0.gameState == arg_27_0.STATE_END then
		(function(arg_28_0)
			for iter_28_0, iter_28_1 in pairs({
				arg_27_0.startUI,
				arg_27_0.content,
				arg_27_0.endUI,
				arg_27_0.countUI,
				arg_27_0.keyUI,
				arg_27_0.keyBar
			}) do
				local var_28_0 = table.indexof(arg_28_0, iter_28_1) and true

				setActive(iter_28_1, var_28_0)
			end

			if isActive(arg_27_0.endUI) then
				pg.UIMgr.GetInstance():BlurPanel(arg_27_0.endUI)
			else
				pg.UIMgr.GetInstance():UnOverlayPanel(arg_27_0.endUI, arg_27_0._tf)
			end

			return
		end)({
			arg_27_0.content,
			arg_27_0.endUI
		})
		setActive(arg_27_0.endExitBtn, false)

		local var_27_1 = 0
		local var_27_2 = arg_27_0:GetMGData():GetRuntimeData("elements")

		if var_27_2 and #var_27_2 > 0 then
			var_27_1 = var_27_2[1]
		end

		if var_27_1 < arg_27_0.score then
			var_27_1 = arg_27_0.score

			arg_27_0:StoreDataToServer({
				arg_27_0.score
			})
		end

		setText(arg_27_0.endBestTxt, var_27_1)
		setText(arg_27_0.endScoreTxt, arg_27_0.score)
		setText(arg_27_0.endComboTxt, arg_27_0.bestComboNum)
		setText(arg_27_0.endMissTxt, arg_27_0.missNum)
		setText(arg_27_0.endHitTxt, arg_27_0.hitNum)
		arg_27_0:clearTimer()
	end

	return
end

function var_0_0.fireBlocks(arg_31_0)
	local var_31_0 = arg_31_0.arBlockList[arg_31_0.opIndex].type
	local var_31_1 = arg_31_0.opList[arg_31_0.opIndex]
	local var_31_2 = arg_31_0:getBlock(arg_31_0.arBlockList[arg_31_0.opIndex].type, arg_31_0.arBlockList[arg_31_0.opIndex].id)
	local var_31_3 = var_31_2.tf

	arg_31_0:addUsingBlock(var_31_2)

	local var_31_4

	if arg_31_0.opList[arg_31_0.opIndex] then
		if arg_31_0.arBlockList[arg_31_0.opIndex].type == arg_31_0.TYPE_A then
			var_31_4 = arg_31_0.aPos
		elseif arg_31_0.arBlockList[arg_31_0.opIndex].type == arg_31_0.TYPE_B then
			var_31_4 = arg_31_0.bPos
		elseif arg_31_0.arBlockList[arg_31_0.opIndex].type == arg_31_0.TYPE_C then
			var_31_4 = arg_31_0.cPos
		end
	else
		var_31_4 = arg_31_0.missPos
	end

	var_31_3.anchoredPosition = arg_31_0.firePos

	arg_31_0:hitFly(var_31_3, 0.5, arg_31_0.hitPos, function()
		var_31_3.anchoredPosition = arg_31_0.hitPos

		if var_31_1 then
			local var_32_0 = 0.4
			local var_32_1 = arg_31_0.parabolaMove

			if var_31_0 == arg_31_0.TYPE_A then
				var_32_0 = 0.3
				var_32_1 = arg_31_0.parabolaMove_center

				arg_31_0:setBucketAAction("attack")
			elseif var_31_0 == arg_31_0.TYPE_B then
				arg_31_0:managedTween(LeanTween.delayedCall, function()
					arg_31_0:setBucketBAction("attack")

					return
				end, 0.2, nil)
			elseif var_31_0 == arg_31_0.TYPE_C then
				var_32_0 = 0.3
				var_32_1 = arg_31_0.parabolaMove_center

				setActive(arg_31_0.msHand, true)
				arg_31_0.msHandAnimator:Play("mingshi_hand", -1, 0)
			end

			var_32_1(arg_31_0, var_31_3, var_32_0, var_31_4, function()
				if var_31_0 == arg_31_0.TYPE_A then
					arg_31_0:removeUsingBlock(var_31_2)
					arg_31_0:showBucketAEffect()
					pg.CriMgr.GetInstance():PlaySE_V3("ui-minigame_hitcake")
				elseif var_31_0 == arg_31_0.TYPE_B then
					setActive(arg_31_0["cut" .. var_0], true)
					arg_31_0["cut" .. var_0 .. "Animator"]:Play("cut_fruit", -1, 0)
					arg_31_0:removeUsingBlock(var_31_2)
					pg.CriMgr.GetInstance():PlaySE_V3("ui-minigame_sword")
				elseif var_31_0 == arg_31_0.TYPE_C then
					arg_31_0:msClearHold()
					arg_31_0:msHoldBlock(var_31_2)
				end

				arg_31_0:checkEnd(var_0)

				return
			end)
		else
			arg_31_0:hitFly(var_31_3, 0.6, var_31_4, function()
				arg_31_0:removeUsingBlock(var_31_2)
				arg_31_0:checkEnd(var_0)

				return
			end)
		end

		pg.CriMgr.GetInstance():PlaySE_V3("ui-minigame_hitwood")
		arg_31_0:countScore(var_31_1)

		return
	end)
	arg_31_0:managedTween(LeanTween.delayedCall, function()
		arg_31_0:setGuinuAction("attack")

		return
	end, 0.2, nil)

	return
end

function var_0_0.getRandomList(arg_37_0)
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

	local var_37_0 = Clone(arg_37_0.allList)

	for iter_37_2 = 1, arg_37_0.limitNum do
		({})[#{} + 1] = table.remove(var_37_0, math.random(1, #var_37_0))
	end

	local var_37_1

	for iter_37_3, iter_37_4 in ipairs({}) do
		local var_37_2 = arg_37_0:getShowBlock(iter_37_4.type, iter_37_4.id)

		if nil then
			(nil).nextBlock = var_37_2
		end

		if iter_37_3 >= arg_37_0.limitNum then
			var_37_2.nextBlock = nil
		end

		local var_37_3

		if iter_37_3 == 1 then
			var_37_1 = var_37_2
			var_37_3 = var_37_2
		end

		var_37_2:showOrHide(true)
	end

	return {}, var_37_1, nil
end

function var_0_0.hideRandomList(arg_38_0)
	while arg_38_0.firstShowBlock do
		arg_38_0.firstShowBlock:showOrHide(false)
	end

	return
end

function var_0_0.countScore(arg_39_0, arg_39_1)
	if arg_39_1 then
		local var_39_0

		for iter_39_0, iter_39_1 in ipairs(arg_39_0.comboRange) do
			if iter_39_1 > arg_39_0.comboNum then
				var_39_0 = iter_39_0 - 1

				break
			elseif iter_39_0 == #arg_39_0.comboRange then
				var_39_0 = #arg_39_0.comboRange
			end
		end

		local var_39_1 = arg_39_0.comboAddScore[var_39_0] or 0

		arg_39_0.comboNum = arg_39_0.comboNum + 1

		local var_39_2 = arg_39_0.targetComboScore[table.indexof(arg_39_0.targetCombo, arg_39_0.comboNum)] or 0

		arg_39_0.score = arg_39_0.score + arg_39_0.scorePerHit + var_39_1 + var_39_2
		arg_39_0.hitNum = arg_39_0.hitNum + 1
		arg_39_0.comboAni.enabled = true

		arg_39_0.comboAni:Play("combo_shake", -1, 0)
	else
		arg_39_0.comboNum = 0
		arg_39_0.missNum = arg_39_0.missNum + 1
	end

	if arg_39_0.comboNum > arg_39_0.bestComboNum then
		arg_39_0.bestComboNum = arg_39_0.comboNum
	end

	setText(arg_39_0.comboTxt, arg_39_0.comboNum < 0 and 0 or arg_39_0.comboNum)
	setText(arg_39_0.scoreTxt, arg_39_0.score)

	return
end

function var_0_0.getUserResult(arg_40_0)
	while arg_40_0.firstShowBlock do
		({})[#{} + 1] = arg_40_0.firstShowBlock:isRight()
	end

	return {}
end

function var_0_0.playArchiveAnim(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0.arBlockList = arg_41_1
	arg_41_0.opList = arg_41_2
	arg_41_0.opIndex = 1

	arg_41_0:setXgmAction("attack")

	return
end

function var_0_0.checkPlayFinished(arg_42_0)
	if arg_42_0.opIndex >= #arg_42_0.opList and arg_42_0.remainTime > 0 then
		arg_42_0:setGameState(arg_42_0.STATE_CLICK)
	end

	return
end

function var_0_0.checkEnd(arg_43_0, arg_43_1)
	if arg_43_1 >= #arg_43_0.opList and arg_43_0.remainTime <= 0 then
		arg_43_0:setGameState(arg_43_0.STATE_END)
	end

	return
end

function var_0_0.parabolaMove(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	arg_44_0:managedTween(LeanTween.rotate, nil, arg_44_1, 135, arg_44_2)
	arg_44_0:managedTween(LeanTween.moveX, nil, arg_44_1, arg_44_3.x, arg_44_2):setEase(LeanTweenType.linear)
	arg_44_0:managedTween(LeanTween.moveY, function()
		if arg_44_4 then
			arg_44_4()
		end

		return
	end, arg_44_1, arg_44_3.y, arg_44_2):setEase(LeanTweenType.easeInQuad)

	return
end

function var_0_0.parabolaMove_center(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	arg_46_0:managedTween(LeanTween.rotate, nil, arg_46_1, 135, arg_46_2)
	arg_46_0:managedTween(LeanTween.moveX, nil, arg_46_1, arg_46_3.x, arg_46_2):setEase(LeanTweenType.easeOutQuad)
	arg_46_0:managedTween(LeanTween.moveY, function()
		if arg_46_4 then
			arg_46_4()
		end

		return
	end, arg_46_1, arg_46_3.y, arg_46_2):setEase(LeanTweenType.linear)

	return
end

function var_0_0.hitFly(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	arg_48_0:managedTween(LeanTween.rotate, nil, arg_48_1, 135, arg_48_2)
	arg_48_0:managedTween(LeanTween.moveX, nil, arg_48_1, arg_48_3.x, arg_48_2):setEase(LeanTweenType.linear)
	arg_48_0:managedTween(LeanTween.moveY, function()
		if arg_48_4 then
			arg_48_4()
		end

		return
	end, arg_48_1, arg_48_3.y, arg_48_2):setEase(LeanTweenType.easeOutQuad)

	return
end

function var_0_0.loadXGM(arg_50_0, arg_50_1)
	if arg_50_0.xgm then
		arg_50_1()
	else
		arg_50_0.autoLoader:LoadPrefab("ui/minigameui/qtegameuiasync_atlas", "xiongguimaoTpl", function(arg_51_0)
			arg_50_0.xgm = tf(arg_51_0)
			arg_50_0.xgmSpine = arg_50_0.xgm:GetComponent("SpineAnimUI")
			arg_50_0.xgmSklGraphic = arg_50_0.xgm:GetComponent("SkeletonGraphic")

			setParent(arg_50_0.xgm, arg_50_0.xgmPos, false)
			arg_50_0:initXGM()
			arg_50_1()

			return
		end)
	end

	return
end

function var_0_0.initXGM(arg_52_0)
	arg_52_0.xgmSpine:SetActionCallBack(function(arg_53_0)
		if arg_53_0 == "FIRE" then
			arg_52_0:fireBlocks()
		elseif arg_53_0 == "FINISH" then
			if arg_52_0.opIndex < #arg_52_0.opList then
				arg_52_0.opIndex = arg_52_0.opIndex + 1

				arg_52_0:setXgmAction("attack")
			else
				arg_52_0:setXgmAction("idle")
				arg_52_0:checkPlayFinished()
			end
		end

		return
	end)

	return
end

function var_0_0.loadGuinu(arg_54_0, arg_54_1)
	if arg_54_0.guinuChar then
		arg_54_1()
	else
		arg_54_0.autoLoader:GetSpine("guinu_2", function(arg_55_0)
			arg_54_0.guinuChar = arg_55_0
			arg_54_0.guinuSklGraphic = arg_55_0:GetSkeletonGraphic()

			arg_54_0.guinuChar:SetParent(arg_54_0.guinuPos)
			arg_54_0:initGuinu()
			arg_54_1()

			return
		end)
	end

	return
end

function var_0_0.initGuinu(arg_56_0)
	arg_56_0.guinuChar:SetLocalScale(Vector3.one)
	arg_56_0:setGuinuAction("normal")
	arg_56_0.guinuChar:SetActionCallBack(function(arg_57_0)
		if arg_57_0 == "finish" then
			arg_56_0:setGuinuAction("normal")
		end

		return
	end)

	return
end

function var_0_0.setXgmAction(arg_58_0, arg_58_1)
	if not arg_58_0.xgm then
		return
	end

	arg_58_0.xgmSklGraphic.timeScale = arg_58_0.xgmAnimLength[arg_58_1] / arg_58_0.xgmAnimTargetLength[arg_58_1]

	arg_58_0.xgmSpine:SetAction(arg_58_1, 0)

	return
end

function var_0_0.setGuinuAction(arg_59_0, arg_59_1)
	if not arg_59_0.guinuChar then
		return
	end

	arg_59_0.guinuSklGraphic.timeScale = arg_59_0.guinuAnimLength[arg_59_1] / arg_59_0.guinuAnimTargetLength[arg_59_1]

	arg_59_0.guinuChar:SetAction(arg_59_1, 0)

	return
end

function var_0_0.setBucketAAction(arg_60_0, arg_60_1)
	arg_60_0.bucketAGraphic.timeScale = arg_60_0.bucketAAnimLength[arg_60_1] / arg_60_0.bucketAAnimTargetLength[arg_60_1]

	arg_60_0.bucketASpine:SetAction(arg_60_1, 0)

	return
end

function var_0_0.setBucketBAction(arg_61_0, arg_61_1)
	arg_61_0.bucketBGraphic.timeScale = arg_61_0.bucketBAnimLength[arg_61_1] / arg_61_0.bucketBAnimTargetLength[arg_61_1]

	arg_61_0.bucketBSpine:SetAction(arg_61_1, 0)

	return
end

function var_0_0.showBucketAEffect(arg_62_0)
	arg_62_0.aEffectList = arg_62_0.aEffectList or {}
	arg_62_0.aEffectUsingList = arg_62_0.aEffectUsingList or {}

	local function var_62_0()
		local var_63_0 = table.remove(arg_62_0.aEffectList, #arg_62_0.aEffectList)

		arg_62_0.aEffectUsingList[#arg_62_0.aEffectUsingList + 1] = var_63_0

		setParent(var_63_0, arg_62_0.bucketA, false)

		var_63_0.localScale = Vector3.one

		setActive(var_63_0, true)
		arg_62_0:managedTween(LeanTween.delayedCall, function()
			arg_62_0:recycleBucketAEffect(var_63_0)

			return
		end, 2, nil)

		return
	end

	if #arg_62_0.aEffectList == 0 then
		arg_62_0.autoLoader:LoadPrefab("effect/xinnianyouxi_baozha", nil, function(arg_65_0)
			arg_62_0.aEffectList[#arg_62_0.aEffectList + 1] = tf(arg_65_0)

			var_62_0()

			return
		end)
	else
		(function()
			local var_63_0 = table.remove(arg_62_0.aEffectList, #arg_62_0.aEffectList)

			arg_62_0.aEffectUsingList[#arg_62_0.aEffectUsingList + 1] = var_63_0

			setParent(var_63_0, arg_62_0.bucketA, false)

			var_63_0.localScale = Vector3.one

			setActive(var_63_0, true)
			arg_62_0:managedTween(LeanTween.delayedCall, function()
				arg_62_0:recycleBucketAEffect(var_63_0)

				return
			end, 2, nil)

			return
		end)()
	end

	return
end

function var_0_0.recycleBucketAEffect(arg_66_0, arg_66_1)
	for iter_66_0 = #arg_66_0.aEffectUsingList, 1, -1 do
		if arg_66_0.aEffectUsingList[iter_66_0] == arg_66_1 then
			setActive(arg_66_1, false)

			arg_66_0.aEffectList[#arg_66_0.aEffectList + 1] = table.remove(arg_66_0.aEffectUsingList, iter_66_0)
		end
	end

	return
end

function var_0_0.getBlock(arg_67_0, arg_67_1, arg_67_2)
	local var_67_0 = arg_67_1 .. "-" .. arg_67_2

	if not arg_67_0.blockPool then
		arg_67_0.blockPool = {}
		arg_67_0.blockSource = {}

		for iter_67_0 = 1, 3 do
			for iter_67_1 = 1, 3 do
				local var_67_1 = arg_67_0._tf:Find("res/item" .. iter_67_0 .. "-" .. iter_67_1)

				arg_67_0.blockPool[iter_67_0 .. "-" .. iter_67_1] = {}
				arg_67_0.blockPool[iter_67_0 .. "-" .. iter_67_1][#arg_67_0.blockPool[iter_67_0 .. "-" .. iter_67_1] + 1] = var_67_1
				arg_67_0.blockSource[iter_67_0 .. "-" .. iter_67_1] = var_67_1
			end
		end
	end

	local var_67_2

	if #arg_67_0.blockPool[var_67_0] > 0 then
		var_67_2 = table.remove(arg_67_0.blockPool[var_67_0], #arg_67_0.blockPool[var_67_0])

		var_67_2:SetParent(arg_67_0.content, false)
	else
		var_67_2 = cloneTplTo(arg_67_0.blockSource[var_67_0], arg_67_0.content)
	end

	setActive(var_67_2, true)

	arg_67_0.blockUniId = arg_67_0.blockUniId + 1

	return {
		uid = arg_67_0.blockUniId,
		key = var_67_0,
		tf = var_67_2
	}
end

function var_0_0.recycleBlock(arg_68_0, arg_68_1)
	arg_68_0.blockPool[arg_68_1.key][#arg_68_0.blockPool[arg_68_1.key] + 1] = arg_68_1.tf

	arg_68_1.tf:SetParent(arg_68_0.res, false)
	setActive(arg_68_1.tf, false)

	return
end

function var_0_0.msHoldBlock(arg_69_0, arg_69_1)
	setParent(arg_69_1.tf, arg_69_0.msHandSlot, false)

	arg_69_1.tf.localPosition = Vector2.zero
	arg_69_0.msBlockList[#arg_69_0.msBlockList + 1] = arg_69_1

	return
end

function var_0_0.msClearHold(arg_70_0)
	for iter_70_0 = #arg_70_0.msBlockList, 1, -1 do
		arg_70_0:removeUsingBlock(table.remove(arg_70_0.msBlockList, iter_70_0))
	end

	return
end

function var_0_0.addUsingBlock(arg_71_0, arg_71_1)
	arg_71_0.usingBlockList[#arg_71_0.usingBlockList + 1] = arg_71_1

	return
end

function var_0_0.removeUsingBlock(arg_72_0, arg_72_1)
	for iter_72_0 = #arg_72_0.usingBlockList, 1, -1 do
		if arg_72_0.usingBlockList[iter_72_0].uid == arg_72_1.uid then
			arg_72_0:recycleBlock(arg_72_0.usingBlockList[iter_72_0])
			table.remove(arg_72_0.usingBlockList, iter_72_0)
		end
	end

	return
end

function var_0_0.clearUsingBlock(arg_73_0)
	for iter_73_0 = #arg_73_0.usingBlockList, 1, -1 do
		arg_73_0:recycleBlock(arg_73_0.usingBlockList[iter_73_0])
		table.remove(arg_73_0.usingBlockList, iter_73_0)
	end

	return
end

function var_0_0.getShowBlock(arg_74_0, arg_74_1, arg_74_2)
	arg_74_0.showBlockDic = arg_74_0.showBlockDic or {}

	local var_74_0

	if arg_74_0.showBlockDic[arg_74_1 .. "-" .. arg_74_2] then
		var_74_0 = arg_74_0.showBlockDic[arg_74_1 .. "-" .. arg_74_2]
	else
		var_74_0 = {
			type = arg_74_1,
			id = arg_74_2,
			goName = "item" .. arg_74_1 .. "-" .. arg_74_2,
			tf = arg_74_0.keyBar:Find("item" .. arg_74_1 .. "-" .. arg_74_2)
		}
		var_74_0.wrongTag = var_74_0.tf:Find("wrong")
		var_74_0.rightTag = var_74_0.tf:Find("right")
		var_74_0.nextBlock = nil
		var_74_0.userChoose = nil

		function var_74_0.init(arg_75_0)
			setActive(arg_75_0.wrongTag, false)
			setActive(arg_75_0.rightTag, false)

			arg_75_0.userChoose = nil

			arg_75_0.tf:SetAsLastSibling()

			return
		end

		function var_74_0.select(arg_76_0, arg_76_1)
			arg_76_0.userChoose = arg_76_1

			setActive(arg_76_0.wrongTag, not arg_76_0:isRight())
			setActive(arg_76_0.rightTag, arg_76_0:isRight())

			return
		end

		function var_74_0.showOrHide(arg_77_0, arg_77_1)
			setActive(arg_77_0.tf, arg_77_1)

			return
		end

		function var_74_0.isRight(arg_78_0)
			return arg_78_0.userChoose == arg_78_0.type
		end
	end

	var_74_0:init()

	return var_74_0
end

function var_0_0.startGameTimer(arg_79_0)
	arg_79_0.remainTime = arg_79_0:GetMGData():GetSimpleValue("gameTime")

	setText(arg_79_0.remainTxt, arg_79_0.remainTime .. "S")

	if arg_79_0.remainTimer then
		arg_79_0.remainTimer:Reset(function()
			arg_79_0.remainTime = arg_79_0.remainTime - 1

			setText(arg_79_0.remainTxt, arg_79_0.remainTime .. "S")

			if arg_79_0.remainTime <= 0 then
				arg_79_0.remainTime = 0

				arg_79_0.remainTimer:Stop()
			end

			return
		end, 1, -1)
	else
		arg_79_0.remainTimer = Timer.New(function()
			arg_79_0.remainTime = arg_79_0.remainTime - 1

			setText(arg_79_0.remainTxt, arg_79_0.remainTime .. "S")

			if arg_79_0.remainTime <= 0 then
				arg_79_0.remainTime = 0

				arg_79_0.remainTimer:Stop()
			end

			return
		end, 1, -1)
	end

	arg_79_0.remainTimer:Start()

	return
end

function var_0_0.startRoundTimer(arg_81_0)
	arg_81_0.roundTime = arg_81_0:GetMGData():GetSimpleValue("roundTime")

	setText(arg_81_0.roundTxt, arg_81_0.roundTime)

	if arg_81_0.roundTimer then
		arg_81_0.roundTimer:Reset(function()
			arg_81_0.roundTime = arg_81_0.roundTime - 1

			setText(arg_81_0.roundTxt, arg_81_0.roundTime)

			if arg_81_0.roundTime <= 0 then
				arg_81_0.roundTimer:Stop()

				if not QTEGAME_DEBUG then
					arg_81_0:setGameState(arg_81_0.STATE_SHOW)
				end
			end

			return
		end, 1, -1)
	else
		arg_81_0.roundTimer = Timer.New(function()
			arg_81_0.roundTime = arg_81_0.roundTime - 1

			setText(arg_81_0.roundTxt, arg_81_0.roundTime)

			if arg_81_0.roundTime <= 0 then
				arg_81_0.roundTimer:Stop()

				if not QTEGAME_DEBUG then
					arg_81_0:setGameState(arg_81_0.STATE_SHOW)
				end
			end

			return
		end, 1, -1)
	end

	arg_81_0.roundTimer:Start()

	return
end

function var_0_0.clearTimer(arg_83_0)
	if arg_83_0.remainTimer then
		arg_83_0.remainTimer:Stop()

		arg_83_0.remainTimer = nil
	end

	if arg_83_0.roundTimer then
		arg_83_0.roundTimer:Stop()

		arg_83_0.roundTimer = nil
	end

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_84_0, arg_84_1)
	if arg_84_1.cmd == MiniGameOPCommand.CMD_COMPLETE and arg_84_1.argList[1] == 0 then
		({
			nil,
			1
		})[1] = arg_84_0:GetMGData():GetSimpleValue("shrineGameId")

		arg_84_0:SendOperator(MiniGameOPCommand.CMD_SPECIAL_GAME, {
			nil,
			1
		})
	end

	return
end

function var_0_0.checkHelp(arg_85_0)
	if PlayerPrefs.GetInt("QTEGameGuide", 0) == 0 then
		triggerButton(arg_85_0.ruleBtn)
		PlayerPrefs.SetInt("QTEGameGuide", 1)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.willExit(arg_86_0)
	arg_86_0:clearTimer()
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_86_0.endUI, arg_86_0._tf)

	arg_86_0.xgm = nil
	arg_86_0.xgmSpine = nil
	arg_86_0.xgmSklGraphic = nil
	arg_86_0.guinuChar = nil
	arg_86_0.guinuSklGraphic = nil

	arg_86_0.autoLoader:Clear()

	return
end

return var_0_0
