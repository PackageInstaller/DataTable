local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.ThemeConst
local var_0_2 = g.core.model.User.themeData
local var_0_3 = g.core.config.activity_theme_display_info
local var_0_4 = 3
local ThemeTurnCardMainLayer = class("ThemeTurnCardMainLayer", require("app.fairyGUI.summerThemeGame.UI_ThemeTurnCardMainLayer"), function()
	local var_1_1 = {
		pkgPath = "ui/summerThemeGame/summerThemeGame",
		isFullScreen = true,
		pkgName = "summerThemeGame"
	}

	var_1_1.resName = var_0_1.THEME_ACTIVITY_TURNCARD_LAYER[({
		...
	})[1].themeValue or var_0_1.THEME_VALUE.SUMMER] or var_0_1.THEME_ACTIVITY_TURNCARD_LAYER[1]

	return fgui.GComponent:create(var_1_1)
end)

function ThemeTurnCardMainLayer:ctor(arg_2_1)
	if arg_2_1 then
		self._activeThemeValue = arg_2_1.themeValue or var_0_1.THEME_VALUE.GRYPH
	end

	self._displayInfo = var_0_3.get(self._activeThemeValue)
	self._fristCard = nil
	self._secondCard = nil
	self._startGuideCalc = false
	self._guideTimeRunner = 0

	self:_initRegisterUI()
	self.m_enterTransition:play()
end

function ThemeTurnCardMainLayer:_initRegisterUI()
	self.m_topBarComp:setResInfoById(self._displayInfo.minigame_top_bar)
	self.m_topBarComp:setTitle(self._displayInfo.minigame_name)
	self:addBg(var_0_1.THEME_ACVITY_TURNCARD_BG[self._activeThemeValue], nil, nil, 1)
	self.m_typeController:setSelectedIndex(math.max(0, self._activeThemeValue - 1))
end

function ThemeTurnCardMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TURN_CARD_RESULT, self._S2CTurnCardResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_THEME_RESET_TURN_CARD_GAME, self._onEventResetTurnCardGame, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onRcvGetCommonRank, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TURN_CARD_GETINFO, self._S2CTurnCardGetInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	self:_updateMainView()
end

function ThemeTurnCardMainLayer:_updateMainView()
	self._turnCardData = var_0_2:getThemeData(self._activeThemeValue):getTurnCardData()
	self._phaseId = self._turnCardData:getCurTurnCardPhase()
	self._phaseInfo = self._turnCardData:getPhaseCardInfo(self._phaseId)

	self._turnCardData:resetScore()
	self._turnCardData:resetTurnCardWave()

	self._isStartGame = false

	self.m_pauseGameController:setSelectedIndex(0)
	self.m_isGameController:setSelectedIndex(0)
	self.m_infoComp:updateInfoView(self._activeThemeValue)
	self.m_inGameComp:updateGameView(self._activeThemeValue)
	self.m_cardConsoleComp:refreshConsoleView(self._activeThemeValue)
	self.m_cardConsoleComp:playEnterAnimation()

	if self._turnCardData:isHaveTurnCardNewPhase() and self._phaseInfo.plot > 0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
			id = self._phaseInfo.plot
		})
	end

	self._turnCardData:saveTurnCardNewPhase()
	self._turnCardData:sendTurnCardCommonRankInfo()
end

function ThemeTurnCardMainLayer:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "ON_CLICK_RANK_BUTTON" then
		g.core.module.ModuleManager:pushModule(g.view.entrance.THEME_TURNCARD_RANK, {
			themeValue = self._activeThemeValue
		})
	elseif arg_6_1 == "START_TURN_CARD_GAME" then
		self:_startTurnCardGame()
	elseif arg_6_1 == "QUIT_TURN_CARD_GAME" then
		self:_endTurnCardGame()
	elseif arg_6_1 == "PAUSE_GAME" then
		self._startGuideCalc = false

		self.m_pauseGameController:setSelectedIndex(arg_6_2.isPasue and 1 or 0)

		if not arg_6_2.isPasue then
			self.m_inGameComp:contiueGame()
		end
	elseif arg_6_1 == "GUESS_CARD" then
		self._guideTimeRunner = 0

		self:_judgeCardsIsSame(arg_6_2.cardTag, arg_6_2.index)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
	elseif arg_6_1 == "UPDATE_NEXT_WAVE" then
		self:_updateNextWaveGame()
	elseif arg_6_1 == "TIME_IS_OVER" and self._isStartGame then
		self._isStartGame = false
		self._startGuideCalc = false

		g.core.sound.SoundManager:playSound(var_0_0.SoundConst.Sound.TURN_CARD_TIMEOVER)
		self:_onDrawCurtainByStringText(g.core.lang:get(405808), false, handler(self, function()
			if self._phaseInfo.game_mode == var_0_1.TURN_CARD_MODEL.ENDLESS then
				self:reportGameResult((self._turnCardData:isEndlessModelWin()))
			else
				self:reportGameResult(false)
			end
		end))
	end
end

function ThemeTurnCardMainLayer:_onDrawCurtainByStringText(arg_8_1, arg_8_2, arg_8_3)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.summerTheme.view.turncard.ThemeTurnCardTipsLinePop").new({
		title = tostring(arg_8_1),
		isCountDown = arg_8_2,
		isEndless = self._phaseInfo.game_mode == var_0_1.TURN_CARD_MODEL.ENDLESS,
		callBack = handler(self, function()
			if arg_8_3 then
				arg_8_3()
			end
		end)
	}), {
		blackOpacity = 1,
		ignoreTouch = true
	})
end

function ThemeTurnCardMainLayer:_judgeCardsIsSame(arg_10_1, arg_10_2)
	if not self._isStartGame then
		return
	end

	if self._fristCard == arg_10_1 and self._fristIdx == arg_10_2 then
		self.m_cardConsoleComp:getCardCompByIdx(var_0_1.TURN_CARD_NAME .. self._fristIdx):setCardState(var_0_1.TURNCARD_STATE.BACK)

		self._fristCard = nil
		self._fristIdx = nil

		return
	end

	if not self._fristCard and not self._fristIdx then
		self._fristCard = arg_10_1
		self._fristIdx = arg_10_2

		self.m_cardConsoleComp:getCardCompByIdx(var_0_1.TURN_CARD_NAME .. self._fristIdx):playFrontAnimation()
		g.core.sound.SoundManager:playSound(var_0_0.SoundConst.Sound.TURN_CARD_PLAY)
	elseif not self._secondCard then
		self._secondCard = arg_10_1
		self._secondIdx = arg_10_2

		self.m_cardConsoleComp:getCardCompByIdx(var_0_1.TURN_CARD_NAME .. self._secondIdx):playFrontAnimation()
		g.core.sound.SoundManager:playSound(var_0_0.SoundConst.Sound.TURN_CARD_PLAY)
	end

	if self._fristCard and self._secondCard then
		local var_10_0 = self.m_cardConsoleComp:getCardCompByIdx(var_0_1.TURN_CARD_NAME .. self._fristIdx)
		local var_10_1 = self.m_cardConsoleComp:getCardCompByIdx(var_0_1.TURN_CARD_NAME .. self._secondIdx)

		if self._fristCard == self._secondCard and self._fristIdx ~= self._secondIdx then
			self:newScheduleOnce(handler(self, function()
				g.core.sound.SoundManager:playSound(var_0_0.SoundConst.Sound.TURN_CARD_SUCCESS)
				var_10_0:setCardState(var_0_1.TURNCARD_STATE.RIGHT)
				var_10_1:setCardState(var_0_1.TURNCARD_STATE.RIGHT)
				self.m_cardConsoleComp:checkCurWaveTurnCardIsEnd()
				self._turnCardData:addScoreNum(var_0_1.TURN_CARD_SCORE_RATIO * 2)
				self.m_inGameComp:updateGameScore()
			end), 0.5)
		else
			self:newScheduleOnce(handler(self, function()
				var_10_0:playWrongAnimation()
				var_10_1:playWrongAnimation()
				g.core.sound.SoundManager:playSound(var_0_0.SoundConst.Sound.TURN_CARD_ERROR)
			end), 0.5)
		end

		self._fristIdx = nil
		self._secondIdx = nil
		self._fristCard = nil
		self._secondCard = nil
	end
end

function ThemeTurnCardMainLayer:_startTurnCardGame()
	if not self._isStartGame then
		self._isStartGame = true
		self._fristIdx = nil
		self._secondIdx = nil
		self._fristCard = nil
		self._secondCard = nil

		self._turnCardData:resetScore()
		self.m_isGameController:setSelectedIndex(1)
		self.m_inGameComp:updateGameView(self._activeThemeValue)

		local var_13_0 = g.core.lang:get(405806)

		self:_onDrawCurtainByStringText((self._phaseInfo.game_mode == var_0_1.TURN_CARD_MODEL.ENDLESS or nil) and g.core.lang:get(405809), true, handler(self, function()
			self.m_inGameComp:startGame()

			self._startGuideCalc = true
			self._guideTimer = self:newSchedule(handler(self, self._onGuideTimer), 1)
		end))
	end
end

function ThemeTurnCardMainLayer:_updateNextWaveGame()
	if self._isStartGame then
		self._turnCardData:setPassWaveSurplusTime((self.m_inGameComp:getSurplusTime()))
		self._turnCardData:goToNextTurnCardWave()

		self._fristIdx = nil
		self._secondIdx = nil
		self._fristCard = nil
		self._secondCard = nil

		if self._turnCardData:getCurTurnCardWave() == 0 then
			self._isStartGame = false

			g.core.sound.SoundManager:playSound(var_0_0.SoundConst.Sound.TURN_CARD_CLEARANCE)
			self:_onDrawCurtainByStringText(g.core.lang:get(405807), false, handler(self, function()
				self:reportGameResult(true)
			end))
		else
			self.m_inGameComp:refreshNextWaveAni(handler(self, self._refreshNextWave))
		end
	end
end

function ThemeTurnCardMainLayer:_endTurnCardGame()
	if self._isStartGame then
		self._isStartGame = false

		self.m_pauseGameController:setSelectedIndex(0)
		self.m_isGameController:setSelectedIndex(0)
		self.m_cardConsoleComp:refreshConsoleView(self._activeThemeValue)

		if self._phaseInfo.game_mode == var_0_1.TURN_CARD_MODEL.ENDLESS then
			self:reportGameResult(self._turnCardData:isEndlessModelWin(), true)
		else
			self:reportGameResult(false)
		end

		self._startGuideCalc = false

		if self._guideTimer then
			self:cancelSchedule(self._guideTimer)

			self._guideTimer = nil
		end
	end
end

function ThemeTurnCardMainLayer:_onGuideTimer()
	if not self._startGuideCalc then
		return
	end

	self._guideTimeRunner = self._guideTimeRunner + 1

	if self._guideTimeRunner > var_0_4 then
		self._startGuideCalc = false

		if self._guideTimer then
			self:cancelSchedule(self._guideTimer)

			self._guideTimer = nil
		end

		self._guideTimeRunner = 0

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUILD_THEME_TURN_CARD_TOUCH",
			targetBtn = self.m_cardConsoleComp:getCanTurnCardComp()
		})
	end
end

function ThemeTurnCardMainLayer:_refreshNextWave()
	self.m_cardConsoleComp:refreshConsoleView(self._activeThemeValue)
	self.m_inGameComp:updateGameView(self._activeThemeValue)
	self.m_inGameComp:startGame()

	local var_19_0 = var_0_1.TURNCARD_REFRESH_EFF[self._activeThemeValue] or var_0_1.TURNCARD_REFRESH_EFF[1]

	self.m_effRefresh:addEffectSpine({
		remove = true,
		isLoop = false,
		name = var_19_0
	})
	self.m_cardConsoleComp:playEnterAnimation()
end

function ThemeTurnCardMainLayer:reportGameResult(arg_20_1, arg_20_2)
	if self._guideTimer then
		self:cancelSchedule(self._guideTimer)

		self._guideTimer = nil
	end

	self._startGuideCalc = false

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)

	if arg_20_2 then
		self._turnCardData:resetTimeScore()
	else
		self.m_inGameComp:reportTimeScoreNum()
	end

	self.m_inGameComp:cancelContDownSchedule()
	self._turnCardData:requestTurnCardResult(arg_20_1)
end

function ThemeTurnCardMainLayer:_S2CTurnCardResult()
	self._isStartGame = false

	self._turnCardData:resetTurnCardWave()
	self.m_pauseGameController:setSelectedIndex(0)
	self.m_isGameController:setSelectedIndex(0)
	self.m_infoComp:updateInfoView(self._activeThemeValue)
	self.m_inGameComp:updateGameView(self._activeThemeValue)
	self.m_cardConsoleComp:refreshConsoleView(self._activeThemeValue)
end

function ThemeTurnCardMainLayer:_S2CTurnCardGetInfo()
	if not self._isStartGame then
		self:_updateMainView()
	end
end

function ThemeTurnCardMainLayer:_onEventResetTurnCardGame()
	self:_startTurnCardGame()
end

function ThemeTurnCardMainLayer:_onRcvGetCommonRank(arg_24_1, arg_24_2, arg_24_3)
	g.core.model.User.themeData:getThemeData(self._activeThemeValue):getTurnCardData():onS2CTurnCardCommonRank(arg_24_3)
end

function ThemeTurnCardMainLayer:_onCrossDayUpdate()
	if g.core.common.ServerTime:getTime() > self._turnCardData:getTurnCardEndTime() then
		g.core.module.ModuleManager:popModule()

		return
	end
end

function ThemeTurnCardMainLayer:onUnload()
	self._isStartGame = false

	self.m_inGameComp:cancelContDownSchedule()

	if self._guideTimer then
		self:cancelSchedule(self._guideTimer)

		self._guideTimer = nil
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

return ThemeTurnCardMainLayer
