local WaitGameInfoComp = class("WaitGameInfoComp", require("app.fairyGUI.upgrade.UI_WaitGameInfoComp"))

function WaitGameInfoComp:ctor()
	self.m_startGameBtn:addClickListener(handler(self, self._onStartGameClick))
end

function WaitGameInfoComp:setScore(arg_2_1)
	self.m_curScoreTxt:setDescText(arg_2_1)
end

function WaitGameInfoComp:setCombo(arg_3_1)
	self.m_comboTxt:setDescText(arg_3_1)
end

function WaitGameInfoComp:_onStartGameClick()
	self.m_startGameBtn:setVisible(false)
	self:dispatchCompEvent("ON_GAME_START_CLICK")
end

return WaitGameInfoComp
