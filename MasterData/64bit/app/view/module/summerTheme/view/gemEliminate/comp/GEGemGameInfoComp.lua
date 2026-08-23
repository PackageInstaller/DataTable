local var_0_0 = g.core.model.User.themeData
local var_0_1 = g.core.const.ConstMgr.ThemeConst
local GEGemGameInfoComp = class("GEGemGameInfoComp", require("app.fairyGUI.summerThemeGame.UI_GEGemGameInfoComp"))

function GEGemGameInfoComp:ctor()
	self._runTime = 0
	self._lastPauseTime = -1
	self._inGame = false
	self._inPause = false
	self._activeThemeValue = var_0_1.THEME_VALUE.GRYPH
	self._defaultColor = g.core.common.Color.A6

	self.m_pauseBtn:addClickListener(handler(self, self._onPauseClick))
end

function GEGemGameInfoComp:onReset()
	self.m_timeTxt:setColor(g.core.common.Color.A6)
	self.m_timeTxt:setText(self._baseTime)

	self._runTime = 0
	self._lastPauseTime = -1
	self._inGame = false
	self._inPause = false
end

function GEGemGameInfoComp:updateInfoView(arg_3_1)
	self._activeThemeValue = arg_3_1

	local var_3_0 = var_0_0:getThemeData(arg_3_1):getGemEliminateData():getCurPhaseCfg()

	self._CDColor = var_0_1.THEME_ACTIVITY_GEM_COUNT_DOWN_COLOR[self._activeThemeValue] or self._defaultColor
	self._baseTime = var_3_0.base_time

	self.m_timeTxt:setColor(self._CDColor)
	self.m_timeTxt:setText(var_3_0.base_time)
end

function GEGemGameInfoComp:setScore(arg_4_1)
	self.m_curScoreTxt:setDescText(arg_4_1)
end

function GEGemGameInfoComp:setCombo(arg_5_1)
	self.m_awardTimeComp:setDescText(arg_5_1)
end

function GEGemGameInfoComp:setStart()
	self._inGame = true

	if self._inGame then
		self:setScore(0)
		self:setCombo(0)
	end
end

function GEGemGameInfoComp:setPause(arg_7_1)
	self._inPause = arg_7_1

	if arg_7_1 then
		if self._runTime == self._lastPauseTime then
			self._runTime = self._runTime + 1
			self._lastPauseTime = -1
		else
			self._lastPauseTime = self._runTime
		end
	else
		local var_7_0 = self._baseTime - self._runTime

		if self._baseTime - self._runTime < 10 then
			self.m_timeTxt:setColor(g.core.common.Color.A7)
		else
			self.m_timeTxt:setColor(self._CDColor)
		end

		self.m_timeTxt:setText(var_7_0)

		if var_7_0 <= 0 then
			self:_onTimeOver()
		end
	end
end

function GEGemGameInfoComp:onCD()
	if self._inPause then
		return
	end

	if self._inGame then
		self._runTime = self._runTime + 1

		local var_8_0 = self._baseTime - self._runTime

		if self._baseTime - self._runTime < 10 then
			self.m_timeTxt:setColor(g.core.common.Color.A7)
		else
			self.m_timeTxt:setColor(self._CDColor)
		end

		if var_8_0 <= 0 then
			self.m_timeTxt:setText(0)
			self:_onTimeOver()
		else
			self.m_timeTxt:setText(var_8_0)
		end
	end
end

function GEGemGameInfoComp:_onTimeOver()
	self._inGame = false

	self:dispatchCompEvent("ON_GAME_TIME_OVER")
end

function GEGemGameInfoComp:_onPauseClick()
	self:dispatchCompEvent("PAUSE_GAME", {
		isPasue = true
	})
end

function GEGemGameInfoComp:onUnload()
	return
end

return GEGemGameInfoComp
