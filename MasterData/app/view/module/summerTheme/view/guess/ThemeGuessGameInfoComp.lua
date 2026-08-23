local DebugCommon = require("app.view.module.debug.common.DebugCommon")
local ThemeGuessGameInfoComp = class("ThemeGuessGameInfoComp", require("app.fairyGUI.summerThemeGame.UI_ThemeGuessGameInfoComp"))

function ThemeGuessGameInfoComp:ctor()
	self.m_pauseBtn:addClickListener(handler(self, self._onPause))
end

function ThemeGuessGameInfoComp:onStartGame(arg_2_1, arg_2_2)
	self._hasPauseTimes = 3
	self._inPause = false
	self._rightNum = 0
	self._errorDecTime = arg_2_1.fault_time
	self._baseTime = arg_2_1.base_time

	if DebugCommon.getDebugGlobalValueByKey("guess_set_time_99999") then
		self._baseTime = 99999
	end

	self.m_timeTxt:setText(self._baseTime)
	self.m_curScoreTxt:setDescText(self._rightNum)
	self.m_errorDecTimeComp:setDescText(g.core.lang:get(405802, {
		time = self._errorDecTime
	}))

	self.m_titleTxt = self:getChild("titleTxt")

	if self.m_titleTxt then
		self.m_titleTxt:setText(g.core.config.activity_theme_display_info.get(arg_2_2).minigame_name)
	end
end

function ThemeGuessGameInfoComp:onCD(arg_3_1)
	self:onTimeChange(-1)
end

function ThemeGuessGameInfoComp:onTimeChange(arg_4_1, arg_4_2)
	if self._inPause then
		return
	end

	self._baseTime = math.max(0, self._baseTime + arg_4_1)

	if arg_4_2 then
		self.m_decTxt:setText(arg_4_1 .. "s")
		self.m_decAnimTransition:play()
	end

	self.m_timeTxt:setText(self._baseTime)

	if self._baseTime < 10 then
		self.m_timeTxt:setColor(g.core.common.Color.A7)
	end

	if self._baseTime <= 0 then
		self:dispatchCompEvent("THEME_GUESS_TIME_OVER")
	end
end

function ThemeGuessGameInfoComp:onErrorSelection()
	if DebugCommon.getDebugGlobalValueByKey("guess_default_not_des") then
		return
	end

	self:onTimeChange(-self._errorDecTime, true)
end

function ThemeGuessGameInfoComp:onRightSelection()
	self._rightNum = self._rightNum + 1

	self.m_curScoreTxt:setDescText(self._rightNum)
end

function ThemeGuessGameInfoComp:setPause(arg_7_1)
	self._inPause = arg_7_1
end

function ThemeGuessGameInfoComp:_onPause()
	if self._hasPauseTimes > 0 then
		self._hasPauseTimes = self._hasPauseTimes - 1

		self:dispatchCompEvent("PAUSE_GAME", {
			isPause = true
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(405908))
	end
end

return ThemeGuessGameInfoComp
