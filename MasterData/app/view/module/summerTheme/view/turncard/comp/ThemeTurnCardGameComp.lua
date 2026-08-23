local var_0_0 = g.core.model.User.themeData
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.ThemeConst
local var_0_3 = g.core.common.ServerTime
local ThemeTurnCardGameComp = class("ThemeTurnCardGameComp", require("app.fairyGUI.summerThemeGame.UI_ThemeTurnCardGameComp"))

function ThemeTurnCardGameComp:ctor()
	self._endTime = 0
	self._countDownTime = 0

	self.m_pauseBtn:addClickListener(handler(self, self._onClickPauseGameBtn))
end

function ThemeTurnCardGameComp:updateGameView(arg_2_1)
	self._turnCardData = var_0_0:getThemeData(arg_2_1):getTurnCardData()

	local var_2_0 = self._turnCardData:getCurTurnCardPhase()
	local var_2_1 = self._turnCardData:getCurTurnCardWave()

	self._phaseInfo = self._turnCardData:getPhaseCardInfo(var_2_0)
	self._waveInfo = self._turnCardData:getWaveInfoByPhase(var_2_0, var_2_1)
	self._canUseTime = self._turnCardData:getWaveCanUseTime()

	self.m_timeTxt:stopAllFGActions()
	self.m_timeTxt:setScale(1)
	self.m_timeTxt:setText(self._canUseTime)
	self.m_timeTxt:setColor(g.core.common.Color.A6)

	if self._waveInfo then
		if self._phaseInfo.game_mode == var_0_2.TURN_CARD_MODEL.ENDLESS then
			self.m_curWaveTxt:setText((self._turnCardData:getEndlessWaveNum()))
			self.m_maxWaveTxt:setVisible(false)
		else
			self.m_curWaveTxt:setText(var_2_1)
			self.m_maxWaveTxt:setText("/" .. self._turnCardData:getWaveCountByPhase(var_2_0))
			self.m_maxWaveTxt:setVisible(true)
		end

		self.m_awardTimeComp:setDescText(g.core.lang:get(405802, {
			time = self._waveInfo.bonus_time
		}))
	end

	self:updateGameScore()
end

function ThemeTurnCardGameComp:updateGameScore()
	self.m_curScoreTxt:setDescText(self._turnCardData:getScoreNum() + self._turnCardData:getTimeScoreNum())
end

function ThemeTurnCardGameComp:startGame()
	self:cancelContDownSchedule()

	self._endTime = var_0_3:getTime() + self._canUseTime
	self._countDownTime = var_0_3:getLeftSeconds(self._endTime)
	self._schedule = self:newSchedule(handler(self, self._onUpdateCountDown), 1)
end

function ThemeTurnCardGameComp:_onClickPauseGameBtn()
	if g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.THEME_TURN_CARD_LIMITPAUSE).parameter >= self._turnCardData:getLimitPauseTime() then
		self:cancelContDownSchedule()
		self:dispatchCompEvent("PAUSE_GAME", {
			isPasue = true
		})
		self._turnCardData:addOncePauseTime()
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(405811))
	end
end

function ThemeTurnCardGameComp:contiueGame()
	self._endTime = var_0_3:getTime() + self._countDownTime
	self._schedule = self._schedule or self:newSchedule(handler(self, self._onUpdateCountDown), 1)
end

function ThemeTurnCardGameComp:_onUpdateCountDown()
	self._countDownTime = var_0_3:getLeftSeconds(self._endTime)

	if self._countDownTime >= 0 then
		self.m_timeTxt:setText(self._countDownTime)
		self.m_timeTxt:stopAllFGActions()
		self.m_timeTxt:setScale(1)

		if self._countDownTime <= 10 then
			self.m_timeTxt:setColor(g.core.common.Color.A7)
			g.core.sound.SoundManager:playSound(var_0_1.SoundConst.Sound.TURN_CARD_TIMELESS)
			g.core.utils.Action.playScaleAction(self.m_timeTxt, 0.7)
		else
			self.m_timeTxt:setColor(g.core.common.Color.A6)
		end
	else
		self.m_timeTxt:stopAllFGActions()
		self.m_timeTxt:setScale(1)
		self:cancelContDownSchedule()

		self._countDownTime = 0

		self:dispatchCompEvent("TIME_IS_OVER")
	end
end

function ThemeTurnCardGameComp:getSurplusTime()
	return (var_0_3:getLeftSeconds(self._endTime))
end

function ThemeTurnCardGameComp:reportTimeScoreNum()
	self._turnCardData:setTimeScoreNum(self._countDownTime * 1000)
end

function ThemeTurnCardGameComp:cancelContDownSchedule()
	if self._schedule then
		self:cancelSchedule(self._schedule)

		self._schedule = nil
	end
end

function ThemeTurnCardGameComp:refreshNextWaveAni(arg_11_1)
	self.m_refreshTransition:setHook("change", arg_11_1)
	self.m_refreshTransition:play()
end

function ThemeTurnCardGameComp:onUnload()
	self:cancelContDownSchedule()
end

return ThemeTurnCardGameComp
