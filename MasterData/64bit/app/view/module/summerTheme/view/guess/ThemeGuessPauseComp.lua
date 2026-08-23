local ThemeGuessPauseComp = class("ThemeGuessPauseComp", require("app.fairyGUI.summerThemeGame.UI_ThemeGuessPauseComp"))

function ThemeGuessPauseComp:ctor()
	self.m_continueBtn:addClickListener(handler(self, self._onClickContinueGameBtn))
	self.m_quitBtn:addClickListener(handler(self, self._onClickQuitBtn))
end

function ThemeGuessPauseComp:_onClickContinueGameBtn()
	self:dispatchCompEvent("PAUSE_GAME", {
		isPause = false
	})
end

function ThemeGuessPauseComp:_onClickQuitBtn()
	self:dispatchCompEvent("THEME_GUESS_PAUSE_OVER")
end

return ThemeGuessPauseComp
