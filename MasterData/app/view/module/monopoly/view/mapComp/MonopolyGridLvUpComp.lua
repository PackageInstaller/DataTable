local MonopolyGridLvUpComp = class("MonopolyGridLvUpComp", require("app.fairyGUI.monopoly.UI_MonopolyGridLvUpComp"))

function MonopolyGridLvUpComp:updateLevelShow(arg_1_1)
	self._cb = arg_1_1.cb

	if arg_1_1.good then
		self.m_itemLoader:setURL(arg_1_1.good.icon_mini)
		self.m_beforeNum:setText("X" .. arg_1_1.oldSize)
		self.m_afterNum:setText("X" .. arg_1_1.newSize)
	end

	self.m_showTransition:play(handler(self, self._onShowFinish))
end

function MonopolyGridLvUpComp:_onShowFinish()
	if self._cb then
		self._cb()
	end

	self:removeFromParent()
end

return MonopolyGridLvUpComp
