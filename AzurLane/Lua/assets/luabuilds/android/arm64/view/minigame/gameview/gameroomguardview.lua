local var_0_0 = class("GameRoomGuardView", import("..BaseMiniGameView"))
local var_0_4 = 120
local var_0_6

if not Application.targetFrameRate then
	var_0_6 = 60
end

function var_0_0.getUIName(arg_1_0)
	return "GameRoomGuardUI"
end

function var_0_0.didEnter(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initEvent()
	arg_2_0:initUI()
	arg_2_0:initController()
	arg_2_0.beachGuardUI:clearUI()
	setActive(arg_2_0.bg, true)
	arg_2_0.menuUI:show(true)
	arg_2_0.menuUI:update(arg_2_0:GetMGHubData())
	arg_2_0:PlayGuider("NG0035")

	return
end

function var_0_0.PlayGuider(arg_3_0, arg_3_1)
	if not pg.NewStoryMgr.GetInstance():IsPlayed(arg_3_1) then
		pg.NewGuideMgr.GetInstance():Play(arg_3_1)
		pg.m02:sendNotification(GAME.STORY_UPDATE, {
			storyId = arg_3_1
		})
	end

	return
end

function var_0_0.initData(arg_4_0)
	if var_0_6 > 60 then
		var_0_6 = 60
	end

	arg_4_0.timer = Timer.New(function()
		arg_4_0:onTimer()

		return
	end, 1 / var_0_6, -1)

	local var_4_0 = {
		path = "ui/minigameui/beachguardgameui_atlas",
		game_time = var_0_4,
		drop = pg.mini_game[arg_4_0:GetMGData().id].simple_config_data.drop
	}

	var_4_0.total_times = arg_4_0:GetMGHubData():getConfig("reward_need")
	var_4_0.rule_tip = arg_4_0:getGameRoomData().game_help
	var_4_0.asset = BeachGuardAsset.New(arg_4_0._tf)
	arg_4_0.gameData = var_4_0

	return
end

function var_0_0.initEvent(arg_6_0)
	if not arg_6_0.handle and IsUnityEditor then
		arg_6_0.handle = UpdateBeat:CreateListener(arg_6_0.Update, arg_6_0)

		UpdateBeat:AddListener(arg_6_0.handle)
	end

	arg_6_0:bind(BeachGuardGameView.LEVEL_GAME, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_1 then
			arg_6_0:resumeGame()
			arg_6_0:onGameOver()
		else
			arg_6_0:resumeGame()
		end

		return
	end)
	arg_6_0:bind(BeachGuardGameView.COUNT_DOWN, function(arg_8_0, arg_8_1, arg_8_2)
		arg_6_0:gameStart()

		return
	end)
	arg_6_0:bind(BeachGuardGameView.OPEN_PAUSE_UI, function(arg_9_0, arg_9_1, arg_9_2)
		arg_6_0.beachGuardUI:popPauseUI()

		return
	end)
	arg_6_0:bind(BeachGuardGameView.OPEN_LEVEL_UI, function(arg_10_0, arg_10_1, arg_10_2)
		arg_6_0.beachGuardUI:popLeaveUI()

		return
	end)
	arg_6_0:bind(BeachGuardGameView.PAUSE_GAME, function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_1 then
			arg_6_0:pauseGame()
		else
			arg_6_0:resumeGame()
		end

		return
	end)
	arg_6_0:bind(BeachGuardGameView.BACK_MENU, function(arg_12_0, arg_12_1, arg_12_2)
		setActive(arg_6_0.sceneContainer, false)
		arg_6_0.menuUI:update(arg_6_0:GetMGHubData())
		arg_6_0.menuUI:show(true)
		arg_6_0.gameUI:show(false)
		arg_6_0:openCoinLayer(true)

		return
	end)
	arg_6_0:bind(BeachGuardGameView.CLOSE_GAME, function(arg_13_0, arg_13_1, arg_13_2)
		arg_6_0:closeView()

		return
	end)
	arg_6_0:bind(BeachGuardGameView.ENEMY_COMMING, function(arg_14_0, arg_14_1, arg_14_2)
		arg_6_0.gameUI:setEnemyComming()

		return
	end)
	arg_6_0:bind(BeachGuardGameView.GAME_OVER, function(arg_15_0, arg_15_1, arg_15_2)
		arg_6_0:onGameOver()

		return
	end)
	arg_6_0:bind(BeachGuardGameView.SHOW_RULE, function(arg_16_0, arg_16_1, arg_16_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = arg_6_0:getGameRoomData().game_help
		})

		return
	end)
	arg_6_0:bind(BeachGuardGameView.READY_START, function(arg_17_0, arg_17_1, arg_17_2)
		arg_6_0:readyStart()

		return
	end)
	arg_6_0:bind(BeachGuardGameView.STORE_SERVER, function(arg_18_0, arg_18_1, arg_18_2)
		arg_6_0:StoreDataToServer({
			arg_18_1
		})

		return
	end)
	arg_6_0:bind(BeachGuardGameView.SUBMIT_GAME_SUCCESS, function(arg_19_0, arg_19_1, arg_19_2)
		if not arg_6_0.sendSuccessFlag then
			arg_6_0.sendSuccessFlag = true

			arg_6_0:SendSuccess(0)
		end

		return
	end)
	arg_6_0:bind(BeachGuardGameView.OPEN_BOOK, function(arg_20_0, arg_20_1, arg_20_2)
		arg_6_0:openCoinLayer(not arg_20_1)

		return
	end)
	arg_6_0:bind(BeachGuardGameView.RECYCLES_CHAR, function(arg_21_0, arg_21_1, arg_21_2)
		arg_6_0:changeRecycles(arg_21_1)

		return
	end)
	arg_6_0:bind(BeachGuardGameView.RECYCLES_CHAR_CANCEL, function(arg_22_0, arg_22_1, arg_22_2)
		arg_6_0.gameUI:cancelRecycle()
		arg_6_0:changeRecycles(false)

		return
	end)
	arg_6_0:bind(BeachGuardGameView.DRAG_CHAR, function(arg_23_0, arg_23_1, arg_23_2)
		arg_6_0.sceneMgr:setDrag(arg_23_1)

		return
	end)
	arg_6_0:bind(BeachGuardGameView.PULL_CHAR, function(arg_24_0, arg_24_1, arg_24_2)
		if arg_6_0.runningData.goodsNum < BeachGuardConst.char_card[arg_24_1.card_id].cost then
			return
		end

		if BeachGuardConst.char_card[arg_24_1.card_id].once and table.contains(arg_6_0.runningData.sceneChars, BeachGuardConst.char_card[arg_24_1.card_id].char_id) then
			return
		end

		if arg_6_0.sceneMgr:pullChar(BeachGuardConst.char_card[arg_24_1.card_id].char_id, arg_24_1.line_index, arg_24_1.grid_index) then
			arg_6_0:goodsUpdate(-1 * math.abs(BeachGuardConst.char_card[arg_24_1.card_id].cost))
			arg_6_0:pullSceneChar(BeachGuardConst.char_card[arg_24_1.card_id].char_id)
		end

		return
	end)
	arg_6_0:bind(BeachGuardGameView.USE_SKILL, function(arg_25_0, arg_25_1, arg_25_2)
		arg_6_0.sceneMgr:useSkill(arg_25_1)

		return
	end)
	arg_6_0:bind(BeachGuardGameView.ADD_CRAFT, function(arg_26_0, arg_26_1, arg_26_2)
		arg_6_0:goodsUpdate(arg_26_1.num)

		return
	end)
	arg_6_0:bind(BeachGuardGameView.ADD_ENEMY, function(arg_27_0, arg_27_1, arg_27_2)
		arg_6_0.sceneMgr:addEnemy(arg_27_1)

		return
	end)
	arg_6_0:bind(BeachGuardGameView.CREATE_CHAR_DAMAGE, function(arg_28_0, arg_28_1, arg_28_2)
		arg_6_0.sceneMgr:craeteCharDamage(arg_28_1)

		return
	end)
	arg_6_0:bind(BeachGuardGameView.REMOVE_CHAR, function(arg_29_0, arg_29_1, arg_29_2)
		arg_6_0:removeSceneChar(arg_29_1:getId())
		arg_6_0.sceneMgr:removeChar(arg_29_1)

		if arg_29_1 and arg_29_1:getCamp() == 2 then
			arg_6_0:addScore(arg_29_1:getScore())
		end

		return
	end)
	arg_6_0:bind(BeachGuardGameView.BULLET_DAMAGE, function(arg_30_0, arg_30_1, arg_30_2)
		arg_6_0.sceneMgr:bulletDamage(arg_30_1)

		return
	end)

	return
end

function var_0_0.onEventHandle(arg_31_0, arg_31_1)
	return
end

function var_0_0.initUI(arg_32_0)
	arg_32_0.sceneMask = findTF(arg_32_0._tf, "sceneMask")
	arg_32_0.sceneContainer = findTF(arg_32_0._tf, "sceneMask/sceneContainer")
	arg_32_0.clickMask = findTF(arg_32_0._tf, "clickMask")
	arg_32_0.bg = findTF(arg_32_0._tf, "bg")
	arg_32_0.beachGuardUI = BeachGuardUI.New(arg_32_0._tf, arg_32_0.gameData, arg_32_0)
	arg_32_0.gameUI = BeachGuardGameUI.New(arg_32_0._tf, arg_32_0.gameData, arg_32_0)
	arg_32_0.menuUI = BeachGuardMenuUI.New(arg_32_0._tf, arg_32_0.gameData, arg_32_0)

	return
end

function var_0_0.initController(arg_33_0)
	arg_33_0.sceneMgr = BeachGuardSceneMgr.New(arg_33_0.sceneMask, arg_33_0.gameData, arg_33_0)

	return
end

function var_0_0.Update(arg_34_0)
	if arg_34_0.gameStop or arg_34_0.settlementFlag then
		return
	end

	if IsUnityEditor and Input.GetKeyDown(KeyCode.S) then
		-- block empty
	end

	return
end

function var_0_0.readyStart(arg_35_0)
	arg_35_0.readyStartFlag = true

	arg_35_0:openCoinLayer(false)
	arg_35_0.beachGuardUI:readyStart()
	arg_35_0.menuUI:show(false)
	arg_35_0.gameUI:show(false)

	local var_35_0 = arg_35_0:getChapter()
	local var_35_1 = BeachGuardConst.chapater_enemy[var_35_0].init_goods
	local var_35_2 = BeachGuardConst.chapter_data[var_35_0]

	BeachGuardConst.enemy_bullet_width = BeachGuardConst.chapter_data[var_35_0].fog and BeachGuardConst.enemy_bullet_fog or BeachGuardConst.enemy_bullet_defaut
	arg_35_0.runningData = {
		scoreNum = 0,
		stepTime = 0,
		gameStepTime = 0,
		gameTime = arg_35_0.gameData.game_time,
		chapter = var_35_0,
		goodsNum = var_35_1 or 0,
		sceneChars = {},
		fog = var_35_2.fog
	}

	arg_35_0.sceneMgr:setData(arg_35_0.runningData)

	return
end

function var_0_0.getChapter(arg_36_0)
	return 9
end

function var_0_0.gameStart(arg_37_0)
	arg_37_0.readyStartFlag = false
	arg_37_0.gameStartFlag = true
	arg_37_0.sendSuccessFlag = false

	setActive(arg_37_0.sceneContainer, true)
	setActive(arg_37_0.bg, false)
	arg_37_0.beachGuardUI:popCountUI(false)
	arg_37_0.gameUI:firstUpdate(arg_37_0.runningData)
	arg_37_0.gameUI:show(true)
	arg_37_0.sceneMgr:start()
	arg_37_0:timerStart()

	return
end

function var_0_0.changeSpeed(arg_38_0, arg_38_1)
	return
end

function var_0_0.onTimer(arg_39_0)
	arg_39_0:gameStep()

	return
end

function var_0_0.gameStep(arg_40_0)
	arg_40_0:stepRunTimeData()
	arg_40_0.sceneMgr:step()
	arg_40_0.gameUI:update(arg_40_0.runningData)

	if arg_40_0.runningData.gameTime <= 0 then
		arg_40_0:onGameOver()
	end

	return
end

function var_0_0.timerStart(arg_41_0)
	if not arg_41_0.timer.running then
		arg_41_0.timer:Start()
	end

	return
end

function var_0_0.timerResume(arg_42_0)
	if not arg_42_0.timer.running then
		arg_42_0.timer:Start()
	end

	return
end

function var_0_0.timerStop(arg_43_0)
	if arg_43_0.timer.running then
		arg_43_0.timer:Stop()
	end

	return
end

function var_0_0.stepRunTimeData(arg_44_0)
	local var_44_0 = Time.deltaTime

	if Time.deltaTime > 0.016 then
		var_44_0 = 0.016
	end

	arg_44_0.runningData.gameTime = arg_44_0.runningData.gameTime - var_44_0
	arg_44_0.runningData.gameStepTime = arg_44_0.runningData.gameStepTime + var_44_0
	arg_44_0.runningData.deltaTime = var_44_0

	return
end

function var_0_0.changeRecycles(arg_45_0, arg_45_1)
	arg_45_0.runningData.recycles = arg_45_1

	arg_45_0.sceneMgr:changeRecycles(arg_45_1)
	arg_45_0:runningUpdate()

	return
end

function var_0_0.addScore(arg_46_0, arg_46_1)
	arg_46_0.runningData.scoreNum = arg_46_0.runningData.scoreNum + arg_46_1

	return
end

function var_0_0.pullSceneChar(arg_47_0, arg_47_1)
	table.insert(arg_47_0.runningData.sceneChars, arg_47_1)
	arg_47_0:runningUpdate()

	return
end

function var_0_0.removeSceneChar(arg_48_0, arg_48_1)
	for iter_48_0 = #arg_48_0.runningData.sceneChars, 1, -1 do
		if arg_48_0.runningData.sceneChars[iter_48_0] == arg_48_1 then
			table.remove(arg_48_0.runningData.sceneChars, iter_48_0)
		end
	end

	return
end

function var_0_0.goodsUpdate(arg_49_0, arg_49_1)
	arg_49_0.runningData.goodsNum = arg_49_0.runningData.goodsNum + arg_49_1

	arg_49_0.gameUI:updateGoods(arg_49_1)

	return
end

function var_0_0.runningUpdate(arg_50_0)
	return
end

function var_0_0.onGameOver(arg_51_0)
	if arg_51_0.settlementFlag then
		return
	end

	arg_51_0:timerStop()
	arg_51_0:clearGame()

	arg_51_0.settlementFlag = true

	setActive(arg_51_0.clickMask, true)
	LeanTween.delayedCall(go(arg_51_0._tf), 0.1, System.Action(function()
		arg_51_0.settlementFlag = false
		arg_51_0.gameStartFlag = false

		setActive(arg_51_0.clickMask, false)
		arg_51_0.beachGuardUI:updateSettlementUI(arg_51_0:GetMGData(), arg_51_0:GetMGHubData(), arg_51_0.runningData)
		arg_51_0.beachGuardUI:openSettlementUI(true)

		return
	end))

	return
end

function var_0_0.OnApplicationPaused(arg_53_0)
	if not arg_53_0.gameStartFlag then
		return
	end

	if arg_53_0.readyStartFlag then
		return
	end

	if arg_53_0.settlementFlag then
		return
	end

	arg_53_0:pauseGame()
	arg_53_0.beachGuardUI:popPauseUI()

	return
end

function var_0_0.clearGame(arg_54_0)
	arg_54_0.sceneMgr:clear()

	return
end

function var_0_0.pauseGame(arg_55_0)
	arg_55_0.gameStop = true

	arg_55_0:changeSpeed(0)
	arg_55_0:timerStop()

	return
end

function var_0_0.resumeGame(arg_56_0)
	arg_56_0.gameStop = false

	arg_56_0:changeSpeed(1)
	arg_56_0:timerStart()

	return
end

function var_0_0.onBackPressed(arg_57_0)
	if arg_57_0.readyStartFlag then
		return
	end

	if not arg_57_0.gameStartFlag then
		arg_57_0:emit(var_0_0.ON_BACK_PRESSED)
	else
		if arg_57_0.settlementFlag then
			return
		end

		arg_57_0.beachGuardUI:backPressed()
	end

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_58_0, arg_58_1)
	return
end

function var_0_0.willExit(arg_59_0)
	if arg_59_0.handle then
		UpdateBeat:RemoveListener(arg_59_0.handle)
	end

	if arg_59_0._tf and LeanTween.isTweening(go(arg_59_0._tf)) then
		LeanTween.cancel(go(arg_59_0._tf))
	end

	if arg_59_0.timer and arg_59_0.timer.running then
		arg_59_0.timer:Stop()
	end

	Time.timeScale = 1
	arg_59_0.timer = nil

	arg_59_0:destroyController()
	BeachGuardAsset.clear()

	return
end

function var_0_0.destroyController(arg_60_0)
	return
end

return var_0_0
