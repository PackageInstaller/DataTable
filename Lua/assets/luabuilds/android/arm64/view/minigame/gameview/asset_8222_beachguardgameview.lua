local BeachGuardGameView = class("BeachGuardGameView", import("..BaseMiniGameView"))

BeachGuardGameView.LEVEL_GAME = "leavel game"
BeachGuardGameView.PAUSE_GAME = "pause game "
BeachGuardGameView.OPEN_PAUSE_UI = "open pause ui"
BeachGuardGameView.OPEN_LEVEL_UI = "open leave ui"
BeachGuardGameView.BACK_MENU = "back menu"
BeachGuardGameView.CLOSE_GAME = "close game"
BeachGuardGameView.SHOW_RULE = "show rule"
BeachGuardGameView.READY_START = "ready start"
BeachGuardGameView.COUNT_DOWN = "count down"
BeachGuardGameView.STORE_SERVER = "store server"
BeachGuardGameView.SUBMIT_GAME_SUCCESS = "submit game success"
BeachGuardGameView.OPEN_BOOK = "open book"
BeachGuardGameView.RECYCLES_CHAR = "RECYCLES CHAR"
BeachGuardGameView.RECYCLES_CHAR_CANCEL = "RECYCLES CHAR CANCEL"
BeachGuardGameView.DRAG_CHAR = "DRAG CHAR"
BeachGuardGameView.PULL_CHAR = "PULL CHAR"
BeachGuardGameView.USE_SKILL = "USE SKILL"
BeachGuardGameView.ADD_CRAFT = "ADD CRAFT"
BeachGuardGameView.ADD_ENEMY = "ADD ENEMY"
BeachGuardGameView.CREATE_CHAR_DAMAGE = "create char damage"
BeachGuardGameView.REMOVE_CHAR = "REMOVE CHAR"
BeachGuardGameView.BULLET_DAMAGE = "BULLET DAMAGE"
BeachGuardGameView.GAME_OVER = "GAME OVER"
BeachGuardGameView.ENEMY_COMMING = "enemy comming"

local var_0_4 = 6000
local var_0_5 = "pvzminigame_help"
local var_0_6 = Application.targetFrameRate or 60

function BeachGuardGameView:getUIName()
	return "BeachGuardGameUI"
end

function BeachGuardGameView:didEnter()
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

function BeachGuardGameView:PlayGuider(arg_3_1)
	if not pg.NewStoryMgr.GetInstance():IsPlayed(arg_3_1) then
		pg.NewGuideMgr.GetInstance():Play(arg_3_1)
		pg.m02:sendNotification(GAME.STORY_UPDATE, {
			storyId = arg_3_1
		})
	end

	return
end

function BeachGuardGameView:initData()
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
	var_4_0.rule_tip = var_0_5
	var_4_0.asset = BeachGuardAsset.New(self._tf)
	self.gameData = var_4_0

	return
end

function BeachGuardGameView:initEvent()
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
			helps = pg.gametip[var_0_5].tip
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
	self:bind(BeachGuardGameView.RECYCLES_CHAR, function(arg_20_0, arg_20_1, arg_20_2)
		self:changeRecycles(arg_20_1)

		return
	end)
	self:bind(BeachGuardGameView.RECYCLES_CHAR_CANCEL, function(arg_21_0, arg_21_1, arg_21_2)
		self.gameUI:cancelRecycle()
		self:changeRecycles(false)

		return
	end)
	self:bind(BeachGuardGameView.DRAG_CHAR, function(arg_22_0, arg_22_1, arg_22_2)
		self.sceneMgr:setDrag(arg_22_1)

		return
	end)
	self:bind(BeachGuardGameView.PULL_CHAR, function(arg_23_0, arg_23_1, arg_23_2)
		if self.runningData.goodsNum < BeachGuardConst.char_card[arg_23_1.card_id].cost then
			return
		end

		if BeachGuardConst.char_card[arg_23_1.card_id].once and table.contains(self.runningData.sceneChars, BeachGuardConst.char_card[arg_23_1.card_id].char_id) then
			return
		end

		if self.sceneMgr:pullChar(BeachGuardConst.char_card[arg_23_1.card_id].char_id, arg_23_1.line_index, arg_23_1.grid_index) then
			self:goodsUpdate(-1 * math.abs(BeachGuardConst.char_card[arg_23_1.card_id].cost))
			self:pullSceneChar(BeachGuardConst.char_card[arg_23_1.card_id].char_id)
		end

		return
	end)
	self:bind(BeachGuardGameView.USE_SKILL, function(arg_24_0, arg_24_1, arg_24_2)
		self.sceneMgr:useSkill(arg_24_1)

		return
	end)
	self:bind(BeachGuardGameView.ADD_CRAFT, function(arg_25_0, arg_25_1, arg_25_2)
		self:goodsUpdate(arg_25_1.num)

		return
	end)
	self:bind(BeachGuardGameView.ADD_ENEMY, function(arg_26_0, arg_26_1, arg_26_2)
		self.sceneMgr:addEnemy(arg_26_1)

		return
	end)
	self:bind(BeachGuardGameView.CREATE_CHAR_DAMAGE, function(arg_27_0, arg_27_1, arg_27_2)
		self.sceneMgr:craeteCharDamage(arg_27_1)

		return
	end)
	self:bind(BeachGuardGameView.REMOVE_CHAR, function(arg_28_0, arg_28_1, arg_28_2)
		self:removeSceneChar(arg_28_1:getId())
		self.sceneMgr:removeChar(arg_28_1)

		if arg_28_1 and arg_28_1:getCamp() == 2 then
			self:addScore(arg_28_1:getScore())
		end

		return
	end)
	self:bind(BeachGuardGameView.BULLET_DAMAGE, function(arg_29_0, arg_29_1, arg_29_2)
		self.sceneMgr:bulletDamage(arg_29_1)

		return
	end)

	return
end

function BeachGuardGameView:onEventHandle(arg_30_1)
	return
end

function BeachGuardGameView:initUI()
	self.sceneMask = findTF(self._tf, "sceneMask")
	self.sceneContainer = findTF(self._tf, "sceneMask/sceneContainer")
	self.clickMask = findTF(self._tf, "clickMask")
	self.bg = findTF(self._tf, "bg")
	self.beachGuardUI = BeachGuardUI.New(self._tf, self.gameData, self)
	self.gameUI = BeachGuardGameUI.New(self._tf, self.gameData, self)
	self.menuUI = BeachGuardMenuUI.New(self._tf, self.gameData, self)

	return
end

function BeachGuardGameView:initController()
	self.sceneMgr = BeachGuardSceneMgr.New(self.sceneMask, self.gameData, self)

	return
end

function BeachGuardGameView:Update()
	if self.gameStop or self.settlementFlag then
		return
	end

	if IsUnityEditor and Input.GetKeyDown(KeyCode.S) then
		-- block empty
	end

	return
end

function BeachGuardGameView:readyStart()
	self.readyStartFlag = true

	self.beachGuardUI:readyStart()
	self.menuUI:show(false)
	self.gameUI:show(false)

	local var_34_0 = self:getChapter()
	local var_34_1 = BeachGuardConst.chapater_enemy[var_34_0].init_goods
	local var_34_2 = BeachGuardConst.chapter_data[var_34_0]

	BeachGuardConst.enemy_bullet_width = BeachGuardConst.chapter_data[var_34_0].fog and BeachGuardConst.enemy_bullet_fog or BeachGuardConst.enemy_bullet_defaut
	self.runningData = {
		scoreNum = 0,
		stepTime = 0,
		gameStepTime = 0,
		gameTime = self.gameData.game_time,
		chapter = var_34_0,
		goodsNum = var_34_1 or 0,
		sceneChars = {},
		fog = var_34_2.fog
	}

	self.sceneMgr:setData(self.runningData)

	return
end

function BeachGuardGameView:getChapter()
	local var_35_0 = (not self:GetMGHubData().usedtime or self:GetMGHubData().usedtime == 0) and 1 or self:GetMGHubData().count > 0 and self:GetMGHubData().usedtime + 1 or self:GetMGHubData().usedtime

	print("return chapter is " .. var_35_0)

	return var_35_0
end

function BeachGuardGameView:gameStart()
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

function BeachGuardGameView:changeSpeed(arg_37_1)
	return
end

function BeachGuardGameView:onTimer()
	self:gameStep()

	return
end

function BeachGuardGameView:gameStep()
	self:stepRunTimeData()
	self.sceneMgr:step()
	self.gameUI:update(self.runningData)

	if self.runningData.gameTime <= 0 then
		self:onGameOver()
	end

	return
end

function BeachGuardGameView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function BeachGuardGameView:timerResume()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function BeachGuardGameView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function BeachGuardGameView:stepRunTimeData()
	local var_43_0 = Time.deltaTime

	if Time.deltaTime > 0.016 then
		var_43_0 = 0.016
	end

	self.runningData.gameTime = self.runningData.gameTime - var_43_0
	self.runningData.gameStepTime = self.runningData.gameStepTime + var_43_0
	self.runningData.deltaTime = var_43_0

	return
end

function BeachGuardGameView:changeRecycles(arg_44_1)
	self.runningData.recycles = arg_44_1

	self.sceneMgr:changeRecycles(arg_44_1)
	self:runningUpdate()

	return
end

function BeachGuardGameView:addScore(arg_45_1)
	self.runningData.scoreNum = self.runningData.scoreNum + arg_45_1

	return
end

function BeachGuardGameView:pullSceneChar(arg_46_1)
	table.insert(self.runningData.sceneChars, arg_46_1)
	self:runningUpdate()

	return
end

function BeachGuardGameView:removeSceneChar(arg_47_1)
	for iter_47_0 = #self.runningData.sceneChars, 1, -1 do
		if self.runningData.sceneChars[iter_47_0] == arg_47_1 then
			table.remove(self.runningData.sceneChars, iter_47_0)
		end
	end

	return
end

function BeachGuardGameView:goodsUpdate(arg_48_1)
	self.runningData.goodsNum = self.runningData.goodsNum + arg_48_1

	self.gameUI:updateGoods(arg_48_1)

	return
end

function BeachGuardGameView:runningUpdate()
	return
end

function BeachGuardGameView:onGameOver()
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

function BeachGuardGameView:OnApplicationPaused()
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

function BeachGuardGameView:clearGame()
	self.sceneMgr:clear()

	return
end

function BeachGuardGameView:pauseGame()
	self.gameStop = true

	self:changeSpeed(0)
	self:timerStop()

	return
end

function BeachGuardGameView:resumeGame()
	self.gameStop = false

	self:changeSpeed(1)
	self:timerStart()

	return
end

function BeachGuardGameView:onBackPressed()
	if self.readyStartFlag then
		return
	end

	if not self.gameStartFlag then
		self:emit(BeachGuardGameView.ON_BACK_PRESSED)
	else
		if self.settlementFlag then
			return
		end

		self.beachGuardUI:backPressed()
	end

	return
end

function BeachGuardGameView:OnSendMiniGameOPDone(arg_57_1)
	return
end

function BeachGuardGameView:willExit()
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

function BeachGuardGameView:destroyController()
	return
end

return BeachGuardGameView
