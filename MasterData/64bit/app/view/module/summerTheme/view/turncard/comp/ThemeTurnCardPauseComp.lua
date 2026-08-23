local ThemeTurnCardPauseComp = class("ThemeTurnCardPauseComp", require("app.fairyGUI.summerThemeGame.UI_ThemeTurnCardPauseComp"))

function ThemeTurnCardPauseComp:ctor()
	self.m_continueBtn:addClickListener(handler(self, self._onClickContinueGameBtn))
	self.m_quitBtn:addClickListener(handler(self, self._onClickQuitBtn))
end

function ThemeTurnCardPauseComp:_onClickContinueGameBtn()
	self:dispatchCompEvent("PAUSE_GAME", {
		isPasue = false
	})
end

function ThemeTurnCardPauseComp:_onClickQuitBtn()
	self:dispatchCompEvent("QUIT_TURN_CARD_GAME")
end

return ThemeTurnCardPauseComp
