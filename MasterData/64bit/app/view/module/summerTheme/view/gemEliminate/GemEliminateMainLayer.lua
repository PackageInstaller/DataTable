local var_0_0 = g.core.const.ConstMgr.ThemeConst
local var_0_1 = 1
local var_0_2 = g.core.model.User.themeData
local var_0_3 = g.core.module.ModuleManager
local var_0_4 = g.core.common.ServerTime
local var_0_5 = g.core.config.activity_theme_display_info
local GemEliminateMainLayer = class("GemEliminateMainLayer", require("app.fairyGUI.summerThemeGame.UI_GemEliminateMainLayer"), function()
	local var_1_1 = {
		pkgName = "summerThemeGame",
		pkgPath = "ui/summerThemeGame/summerThemeGame",
		isFullScreen = true
	}

	var_1_1.resName = var_0_0.THEME_ACTIVITY_GEM_LAYER[({
		...
	})[1].themeValue or var_0_0.THEME_VALUE.SUMMER] or var_0_0.THEME_ACTIVITY_GEM_LAYER[1]

	return fgui.GComponent:create(var_1_1)
end)

function GemEliminateMainLayer:ctor(arg_2_1)
	if arg_2_1 then
		self._activeThemeValue = arg_2_1.themeValue or var_0_0.THEME_VALUE.GRYPH
	end

	self._displayInfo = var_0_5.get(self._activeThemeValue)
	self._exeTimerLastTime = 0
	self._theGameEndTime = 0
	self._phase = 0
	self._cdTimer = nil
	self._playing = false
	self._gemEliminateData = var_0_2:getThemeData(self._activeThemeValue):getGemEliminateData()

	self:_initRegisterUI()
end

function GemEliminateMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_THEME_RESET_GEM_ELIMINATE_GAME, self._onEventResetGemEliminateGame, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ELIMINATE_GETINFO, self._onGemEliminateGetInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ELIMINATE_RESULT, self._onGemEliminateResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	self:updateView()
	self._gemEliminateData:saveGemEliminateNewPhase()
	g.core.network.GameNetProxy:send_C2S_Eliminate_GetInfo({
		id = self._activeThemeValue
	})

	if self.m_enterTransition then
		self.m_enterTransition:play()
	end

	var_0_2:changeSmallGameBGM(self._activeThemeValue)
end

function GemEliminateMainLayer:_initRegisterUI()
	self.m_topBarComp:setResInfoById(self._displayInfo.minigame_top_bar)
	self.m_topBarComp:setTitle(self._displayInfo.minigame_name)
	self:addBg("bg/theme/" .. (var_0_0.THEME_ACTIVITY_GEM_BG[self._activeThemeValue] or var_0_0.THEME_ACTIVITY_GEM_BG[1]), false, nil, 1)
end

function GemEliminateMainLayer:updateView()
	self._phase = self._gemEliminateData:getPhaseId()

	self.m_inGameComp:updateInfoView(self._activeThemeValue)
	self.m_infoComp:updateInfoView(self._activeThemeValue)

	local var_5_0 = self._gemEliminateData:getCurPhaseCfg()

	if var_5_0.toObject then
		self.m_chessboardComp:updateWithInfo(var_5_0, self._activeThemeValue)
	end
end

function GemEliminateMainLayer:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "COMP_EVENT_COMBO_CHANGE" then
		self._gemEliminateData:refreshCombo(arg_6_2.comboNum)
		self.m_chessboardComp:playComboAni(arg_6_2.comboNum)
		self.m_inGameComp:setCombo(self._gemEliminateData:getMaxComboNum())
		self.m_inGameComp:setScore(self._gemEliminateData:getTotalScore())
	elseif arg_6_1 == "PAUSE_GAME" then
		if self._playing then
			if arg_6_2.isPasue then
				self.m_inGameComp:setPause(true)
				self.m_pauseGameController:setSelectedIndex(1)
				self:_stopCD()
			else
				self.m_inGameComp:setPause(false)
				self.m_pauseGameController:setSelectedIndex(0)
				self:_startCD()
			end
		end
	elseif arg_6_1 == "QUIT_TURN_CARD_GAME" then
		self:_gameOver()
	elseif arg_6_1 == "ON_GAME_TIME_OVER" then
		self:_onDrawCurtainByStringText(g.core.lang:get(405808), false, handler(self, function()
			self:_gameOver()
		end))
	elseif arg_6_1 == "ON_GAME_START_CLICK" then
		self:onGameStart()
	elseif arg_6_1 == "ON_SHOW_RANK_CLICK" then
		var_0_3:pushModule(g.view.entrance.THEME_GEM_ELIMINATE_RANK, {
			themeValue = self._activeThemeValue
		})
	end
end

function GemEliminateMainLayer:onGameStart()
	self.m_inGameComp:onReset()
	self:_onDrawCurtainByStringText(g.core.lang:get(var_0_0.THEME_LANG_GEM_ID[self._activeThemeValue]), true, handler(self, function()
		self:_startGame()
	end))
end

function GemEliminateMainLayer:_onDrawCurtainByStringText(arg_10_1, arg_10_2, arg_10_3)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.summerTheme.view.gemEliminate.GemEliminateTipsLinePop").new({
		title = tostring(arg_10_1),
		isCountDown = arg_10_2,
		callBack = handler(self, function()
			if arg_10_3 then
				arg_10_3()
			end
		end)
	}), {
		blackOpacity = 1,
		ignoreTouch = true
	})
end

function GemEliminateMainLayer:_gameOver(arg_12_1)
	self._playing = false

	self:_stopCD()
	self.m_chessboardComp:onGameOver()

	local var_12_0 = self._gemEliminateData:getTotalScore()

	self.m_infoComp:updateInfoView(self._activeThemeValue)

	if not arg_12_1 then
		g.core.network.GameNetProxy:send_C2S_Eliminate_Result({
			id = self._activeThemeValue,
			game_id = self._gemEliminateData:getGameId(),
			phase = self._gemEliminateData:getPhaseId(),
			score = var_12_0,
			state = var_12_0 > self._gemEliminateData:getCurPhaseCfg().effpoint and 1 or 0
		})
	end
end

function GemEliminateMainLayer:_startCD()
	self._cdTimer = self._cdTimer or self:newSchedule(handler(self, self._onCD), var_0_1)
end

function GemEliminateMainLayer:_stopCD()
	if self._cdTimer then
		self:cancelSchedule(self._cdTimer)

		self._cdTimer = nil
	end
end

function GemEliminateMainLayer:_onCD()
	local var_15_0 = var_0_4:getTime()

	if var_15_0 - self._exeTimerLastTime < var_0_1 then
		return
	end

	self._exeTimerLastTime = var_15_0

	self.m_inGameComp:onCD()
end

function GemEliminateMainLayer:_onEventResetGemEliminateGame()
	g.core.model.User.themeData:setGemEliminateResetGame(false)
	self:onGameStart()
end

function GemEliminateMainLayer:_onGemEliminateGetInfo()
	self:updateView()
end

function GemEliminateMainLayer:_onGemEliminateResult()
	self.m_infoComp:updateInfoView(self._activeThemeValue)
	self.m_pauseGameController:setSelectedIndex(0)
	self.m_isGameController:setSelectedIndex(0)
	self.m_inGameComp:onReset()
end

function GemEliminateMainLayer:_onCrossDayUpdate()
	self._gemEliminateData:resetGetRewardState()

	if self._gemEliminateData:getGemEliminateEndTime() < g.core.common.ServerTime:getTime() then
		g.core.module.ModuleManager:popModule()

		return
	else
		g.core.network.GameNetProxy:send_C2S_Eliminate_GetInfo({
			id = self._activeThemeValue
		})
	end

	if self._playing then
		self:_gameOver(true)
		self:_onGemEliminateResult()
	end
end

function GemEliminateMainLayer:_onCloseSelf()
	var_0_3:popModule({
		popScene = true
	})
end

function GemEliminateMainLayer:_startGame()
	self._playing = true

	self._gemEliminateData:clearDataOnStartGame()
	self.m_isGameController:setSelectedIndex(1)
	self.m_pauseGameController:setSelectedIndex(0)
	self.m_chessboardComp:onStartGame()
	self.m_inGameComp:updateInfoView(self._activeThemeValue)
	self.m_inGameComp:setStart()
	self:_startCD()
end

function GemEliminateMainLayer:onUnload()
	self:_stopCD()
end

return GemEliminateMainLayer
