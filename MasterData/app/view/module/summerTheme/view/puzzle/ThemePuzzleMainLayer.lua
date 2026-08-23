local var_0_0 = g.core.const.ConstMgr.ThemeConst
local ThemePuzzleMainLayer = class("ThemePuzzleMainLayer", require("app.fairyGUI.summerThemeGame.UI_ThemePuzzleMainLayer"), function()
	local var_1_0 = {
		pkgPath = "ui/summerThemeGame/summerThemeGame",
		isFullScreen = true,
		pkgName = "summerThemeGame"
	}

	var_1_0.resName = var_0_0.THEME_PUZZLE_MAIN_LAYER[({
		...
	})[1].themeValue] or var_0_0.THEME_PUZZLE_MAIN_LAYER[10]

	return fgui.GComponent:create(var_1_0, ...)
end)
local var_0_2 = g.core.model.User.themeData
local var_0_3 = g.core.config.activity_theme_display_info
local var_0_4 = g.core.config.game_puzzle_wave_info

function ThemePuzzleMainLayer:ctor(arg_2_1)
	if arg_2_1 then
		self._activeThemeValue = arg_2_1.themeValue or var_0_0.THEME_VALUE.GRYPH
	end

	self._displayInfo = var_0_3.get(self._activeThemeValue)
	self._themePuzzleData = var_0_2:getThemeData(self._activeThemeValue):getThemePuzzleData()

	self:_initRegisterUI()
end

function ThemePuzzleMainLayer:_initRegisterUI()
	self:addBg(var_0_0.THEME_PUZZLE_BG[self._activeThemeValue] or var_0_0.THEME_PUZZLE_BG[10])

	if self._displayInfo.minigame_top_bar > 0 then
		self.m_topBarComp:setResInfoById(self._displayInfo.minigame_top_bar)
	end

	self.m_topBarComp:setTitle(self._displayInfo.minigame_name)
	self.m_puzzleInfoComp:updateView({
		themeValue = self._activeThemeValue
	})

	self._randPicId = self._themePuzzleData:getRandPicId()
	self._miniGameId = self._themePuzzleData:getMiniGameId()

	self.m_showPicComp:updatePic({
		groupPic = var_0_4.get(self._randPicId).group_pic
	})
end

function ThemePuzzleMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUZZLE_GETINFO, handler(self, self._onPuzzleGetInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_THEME_RESET_PUZZLE_GAME, self._onEventResetPuzzleGame, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	g.core.network.GameNetProxy:send_C2S_Puzzle_GetInfo({
		id = self._activeThemeValue
	})
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_PUZZLE_BGM)
end

function ThemePuzzleMainLayer:_onEventResetPuzzleGame()
	var_0_2:setThemePuzzleResetGame(false)
	self:receiveCompEvent("ThemePuzzle_start")
end

function ThemePuzzleMainLayer:_onPuzzleGetInfo(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self:_updateView()
end

function ThemePuzzleMainLayer:_onCrossDayUpdate()
	if g.core.common.ServerTime:getTime() > self._themePuzzleData:getPuzzleEndTime() then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	else
		g.core.network.GameNetProxy:send_C2S_Puzzle_GetInfo({
			id = self._activeThemeValue
		})
	end
end

function ThemePuzzleMainLayer:receiveCompEvent(arg_8_1, arg_8_2)
	arg_8_2 = arg_8_2 or {}

	if arg_8_1 == "ThemePuzzle_rank" then
		g.core.module.ModuleManager:pushModule(g.view.entrance.THEME_PUZZLE_RANK, {
			themeValue = self._activeThemeValue
		})

		return true
	elseif arg_8_1 == "ThemePuzzle_start" then
		if self._themePuzzleData and self._themePuzzleData:isProcess() then
			g.core.module.ModuleManager:pushModule(g.view.entrance.THEME_GAME_PUZZLE_PLAY, {
				themeValue = self._activeThemeValue,
				miniGameId = self._miniGameId,
				randPicId = self._randPicId
			})
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(1005))
		end

		return true
	end

	return false
end

function ThemePuzzleMainLayer:onUnload()
	return
end

function ThemePuzzleMainLayer:_updateView()
	self.m_puzzleInfoComp:updateView({
		themeValue = self._activeThemeValue
	})

	self._randPicId = self._themePuzzleData:getRandPicId()

	self.m_showPicComp:updatePic({
		groupPic = var_0_4.get(self._randPicId).group_pic
	})

	local var_10_0 = self._themePuzzleData:getPhasePuzzleInfo((self._themePuzzleData:getCurPhase()))

	if self._themePuzzleData:hasNewPhase() and var_10_0 and var_10_0.plot > 0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
			id = var_10_0.plot
		})
	end

	self._themePuzzleData:savePuzzleNewPhase()
end

return ThemePuzzleMainLayer
