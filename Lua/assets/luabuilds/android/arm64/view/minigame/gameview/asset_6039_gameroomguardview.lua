local GameRoomGuardView = class("GameRoomGuardView", import("..BaseMiniGameView"))
local var_0_4 = 120
local var_0_6 = Application.targetFrameRate or 60

function GameRoomGuardView:getUIName()
	return "GameRoomGuardUI"
end

function GameRoomGuardView:didEnter()
	self:initData()
	self:initEvent()
	self:initUI()
	self:initController()
	self.beachGuardUI:clearUI()
	setActive(self.bg, true)
	self.menuUI:show(true)
	self.menuUI:update(self:GetMGHubData())
	self:PlayGuider("NG0035")

	return
end

function GameRoomGuardView:PlayGuider(arg_3_1)
	if not pg.NewStoryMgr.GetInstance():IsPlayed(arg_3_1) then
		pg.NewGuideMgr.GetInstance():Play(arg_3_1)
		pg.m02:sendNotification(GAME.STORY_UPDATE, {
			storyId = arg_3_1
		})
	end

	return
end

function GameRoomGuardView:initData()
	if var_0_6 > 60 then
		var_0_6 = 60
	end

	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 1 / var_0_6, -1)

	local var_4_0 = {
		path = "ui/minigameui/beachguardgameui_atlas",
		game_time = var_0_4,
		drop = pg.mini_game[self:GetMGData().id].simple_config_data.drop
	}

	var_4_0.total_times = self:GetMGHubData():getConfig("reward_need")
	var_4_0.rule_tip = self:getGameRoomData().game_help
	var_4_0.asset = BeachGuardAsset.New(self._tf)
	self.gameData = var_4_0

	return
end

function GameRoomGuardView:initEvent()
	if not self.handle and IsUnityEditor then
		self.handle = UpdateBeat:CreateListener(self.Update, self)

		UpdateBeat:AddListener(self.handle)
	end

	self:bind(BeachGuardGameView.LEVEL_GAME, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_1 then
			self:resumeGame()
			self:onGameOver()
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(BeachGuardGameView.COUNT_DOWN, function(arg_8_0, arg_8_1, arg_8_2)
		self:gameStart()

		return
	end)
	self:bind(BeachGuardGameView.OPEN_PAUSE_UI, function(arg_9_0, arg_9_1, arg_9_2)
		self.beachGuardUI:popPauseUI()

		return
	end)
	self:bind(BeachGuardGameView.OPEN_LEVEL_UI, function(arg_10_0, arg_10_1, arg_10_2)
		self.beachGuardUI:popLeaveUI()

		return
	end)
	self:bind(BeachGuardGameView.PAUSE_GAME, function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_1 then
			self:pauseGame()
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(BeachGuardGameView.BACK_MENU, function(arg_12_0, arg_12_1, arg_12_2)
		setActive(self.sceneContainer, false)
		self.menuUI:update(self:GetMGHubData())
		self.menuUI:show(true)
		self.gameUI:show(false)
		self:openCoinLayer(true)

		return
	end)
	self:bind(BeachGuardGameView.CLOSE_GAME, function(arg_13_0, arg_13_1, arg_13_2)
		self:closeView()

		return
	end)
	self:bind(BeachGuardGameView.ENEMY_COMMING, function(arg_14_0, arg_14_1, arg_14_2)
		self.gameUI:setEnemyComming()

		return
	end)
	self:bind(BeachGuardGameView.GAME_OVER, function(arg_15_0, arg_15_1, arg_15_2)
		self:onGameOver()

		return
	end)
	self:bind(BeachGuardGameView.SHOW_RULE, function(arg_16_0, arg_16_1, arg_16_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = self:getGameRoomData().game_help
		})

		return
	end)
	self:bind(BeachGuardGameView.READY_START, function(arg_17_0, arg_17_1, arg_17_2)
		self:readyStart()

		return
	end)
	self:bind(BeachGuardGameView.STORE_SERVER, function(arg_18_0, arg_18_1, arg_18_2)
		self:StoreDataToServer({
			arg_18_1
		})

		return
	end)
	self:bind(BeachGuardGameView.SUBMIT_GAME_SUCCESS, function(arg_19_0, arg_19_1, arg_19_2)
		if not self.sendSuccessFlag then
			self.sendSuccessFlag = true

			self:SendSuccess(0)
		end

		return
	end)
	self:bind(BeachGuardGameView.OPEN_BOOK, function(arg_20_0, arg_20_1, arg_20_2)
		self:openCoinLayer(not arg_20_1)

		return
	end)
	self:bind(BeachGuardGameView.RECYCLES_CHAR, function(arg_21_0, arg_21_1, arg_21_2)
		self:changeRecycles(arg_21_1)

		return
	end)
	self:bind(BeachGuardGameView.RECYCLES_CHAR_CANCEL, function(arg_22_0, arg_22_1, arg_22_2)
		self.gameUI:cancelRecycle()
		self:changeRecycles(false)

		return
	end)
	self:bind(BeachGuardGameView.DRAG_CHAR, function(arg_23_0, arg_23_1, arg_23_2)
		self.sceneMgr:setDrag(arg_23_1)

		return
	end)
	self:bind(BeachGuardGameView.PULL_CHAR, function(arg_24_0, arg_24_1, arg_24_2)
		if self.runningData.goodsNum < BeachGuardConst.char_card[arg_24_1.card_id].cost then
			return
		end

		if BeachGuardConst.char_card[arg_24_1.card_id].once and table.contains(self.runningData.sceneChars, BeachGuardConst.char_card[arg_24_1.card_id].char_id) then
			return
		end

		if self.sceneMgr:pullChar(BeachGuardConst.char_card[arg_24_1.card_id].char_id, arg_24_1.line_index, arg_24_1.grid_index) then
			self:goodsUpdate(-1 * math.abs(BeachGuardConst.char_card[arg_24_1.card_id].cost))
			self:pullSceneChar(BeachGuardConst.char_card[arg_24_1.card_id].char_id)
		end

		return
	end)
	self:bind(BeachGuardGameView.USE_SKILL, function(arg_25_0, arg_25_1, arg_25_2)
		self.sceneMgr:useSkill(arg_25_1)

		return
	end)
	self:bind(BeachGuardGameView.ADD_CRAFT, function(arg_26_0, arg_26_1, arg_26_2)
		self:goodsUpdate(arg_26_1.num)

		return
	end)
	self:bind(BeachGuardGameView.ADD_ENEMY, function(arg_27_0, arg_27_1, arg_27_2)
		self.sceneMgr:addEnemy(arg_27_1)

		return
	end)
	self:bind(BeachGuardGameView.CREATE_CHAR_DAMAGE, function(arg_28_0, arg_28_1, arg_28_2)
		self.sceneMgr:craeteCharDamage(arg_28_1)

		return
	end)
	self:bind(BeachGuardGameView.REMOVE_CHAR, function(arg_29_0, arg_29_1, arg_29_2)
		self:removeSceneChar(arg_29_1:getId())
		self.sceneMgr:removeChar(arg_29_1)

		if arg_29_1 and arg_29_1:getCamp() == 2 then
			self:addScore(arg_29_1:getScore())
		end

		return
	end)
	self:bind(BeachGuardGameView.BULLET_DAMAGE, function(arg_30_0, arg_30_1, arg_30_2)
		self.sceneMgr:bulletDamage(arg_30_1)

		return
	end)

	return
end

function GameRoomGuardView:onEventHandle(arg_31_1)
	return
end

function GameRoomGuardView:initUI()
	self.sceneMask = findTF(self._tf, "sceneMask")
	self.sceneContainer = findTF(self._tf, "sceneMask/sceneContainer")
	self.clickMask = findTF(self._tf, "clickMask")
	self.bg = findTF(self._tf, "bg")
	self.beachGuardUI = BeachGuardUI.New(self._tf, self.gameData, self)
	self.gameUI = BeachGuardGameUI.New(self._tf, self.gameData, self)
	self.menuUI = BeachGuardMenuUI.New(self._tf, self.gameData, self)

	return
end

function GameRoomGuardView:initController()
	self.sceneMgr = BeachGuardSceneMgr.New(self.sceneMask, self.gameData, self)

	return
end

function GameRoomGuardView:Update()
	if self.gameStop or self.settlementFlag then
		return
	end

	if IsUnityEditor and Input.GetKeyDown(KeyCode.S) then
		-- block empty
	end

	return
end

function GameRoomGuardView:readyStart()
	self.readyStartFlag = true

	self:openCoinLayer(false)
	self.beachGuardUI:readyStart()
	self.menuUI:show(false)
	self.gameUI:show(false)

	local var_35_0 = self:getChapter()
	local var_35_1 = BeachGuardConst.chapater_enemy[var_35_0].init_goods
	local var_35_2 = BeachGuardConst.chapter_data[var_35_0]

	BeachGuardConst.enemy_bullet_width = BeachGuardConst.chapter_data[var_35_0].fog and BeachGuardConst.enemy_bullet_fog or BeachGuardConst.enemy_bullet_defaut
	self.runningData = {
		scoreNum = 0,
		stepTime = 0,
		gameStepTime = 0,
		gameTime = self.gameData.game_time,
		chapter = var_35_0,
		goodsNum = var_35_1 or 0,
		sceneChars = {},
		fog = var_35_2.fog
	}

	self.sceneMgr:setData(self.runningData)

	return
end

function GameRoomGuardView:getChapter()
	return 9
end

function GameRoomGuardView:gameStart()
	self.readyStartFlag = false
	self.gameStartFlag = true
	self.sendSuccessFlag = false

	setActive(self.sceneContainer, true)
	setActive(self.bg, false)
	self.beachGuardUI:popCountUI(false)
	self.gameUI:firstUpdate(self.runningData)
	self.gameUI:show(true)
	self.sceneMgr:start()
	self:timerStart()

	return
end

function GameRoomGuardView:changeSpeed(arg_38_1)
	return
end

function GameRoomGuardView:onTimer()
	self:gameStep()

	return
end

function GameRoomGuardView:gameStep()
	self:stepRunTimeData()
	self.sceneMgr:step()
	self.gameUI:update(self.runningData)

	if self.runningData.gameTime <= 0 then
		self:onGameOver()
	end

	return
end

function GameRoomGuardView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function GameRoomGuardView:timerResume()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function GameRoomGuardView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function GameRoomGuardView:stepRunTimeData()
	local var_44_0 = Time.deltaTime

	if Time.deltaTime > 0.016 then
		var_44_0 = 0.016
	end

	self.runningData.gameTime = self.runningData.gameTime - var_44_0
	self.runningData.gameStepTime = self.runningData.gameStepTime + var_44_0
	self.runningData.deltaTime = var_44_0

	return
end

function GameRoomGuardView:changeRecycles(arg_45_1)
	self.runningData.recycles = arg_45_1

	self.sceneMgr:changeRecycles(arg_45_1)
	self:runningUpdate()

	return
end

function GameRoomGuardView:addScore(arg_46_1)
	self.runningData.scoreNum = self.runningData.scoreNum + arg_46_1

	return
end

function GameRoomGuardView:pullSceneChar(arg_47_1)
	table.insert(self.runningData.sceneChars, arg_47_1)
	self:runningUpdate()

	return
end

function GameRoomGuardView:removeSceneChar(arg_48_1)
	for iter_48_0 = #self.runningData.sceneChars, 1, -1 do
		if self.runningData.sceneChars[iter_48_0] == arg_48_1 then
			table.remove(self.runningData.sceneChars, iter_48_0)
		end
	end

	return
end

function GameRoomGuardView:goodsUpdate(arg_49_1)
	self.runningData.goodsNum = self.runningData.goodsNum + arg_49_1

	self.gameUI:updateGoods(arg_49_1)

	return
end

function GameRoomGuardView:runningUpdate()
	return
end

function GameRoomGuardView:onGameOver()
	if self.settlementFlag then
		return
	end

	self:timerStop()
	self:clearGame()

	self.settlementFlag = true

	setActive(self.clickMask, true)
	LeanTween.delayedCall(go(self._tf), 0.1, System.Action(function()
		self.settlementFlag = false
		self.gameStartFlag = false

		setActive(self.clickMask, false)
		self.beachGuardUI:updateSettlementUI(self:GetMGData(), self:GetMGHubData(), self.runningData)
		self.beachGuardUI:openSettlementUI(true)

		return
	end))

	return
end

function GameRoomGuardView:OnApplicationPaused()
	if not self.gameStartFlag then
		return
	end

	if self.readyStartFlag then
		return
	end

	if self.settlementFlag then
		return
	end

	self:pauseGame()
	self.beachGuardUI:popPauseUI()

	return
end

function GameRoomGuardView:clearGame()
	self.sceneMgr:clear()

	return
end

function GameRoomGuardView:pauseGame()
	self.gameStop = true

	self:changeSpeed(0)
	self:timerStop()

	return
end

function GameRoomGuardView:resumeGame()
	self.gameStop = false

	self:changeSpeed(1)
	self:timerStart()

	return
end

function GameRoomGuardView:onBackPressed()
	if self.readyStartFlag then
		return
	end

	if not self.gameStartFlag then
		self:emit(GameRoomGuardView.ON_BACK_PRESSED)
	else
		if self.settlementFlag then
			return
		end

		self.beachGuardUI:backPressed()
	end

	return
end

function GameRoomGuardView:OnSendMiniGameOPDone(arg_58_1)
	return
end

function GameRoomGuardView:willExit()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	if self._tf and LeanTween.isTweening(go(self._tf)) then
		LeanTween.cancel(go(self._tf))
	end

	if self.timer and self.timer.running then
		self.timer:Stop()
	end

	Time.timeScale = 1
	self.timer = nil

	self:destroyController()
	BeachGuardAsset.clear()

	return
end

function GameRoomGuardView:destroyController()
	return
end

return GameRoomGuardView
