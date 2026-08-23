local RedCliffPoolComp = class("RedCliffPoolComp", require("app.fairyGUI.redCliff.UI_RedCliffPoolComp"))

function RedCliffPoolComp:ctor()
	self.m_buttonController = self:getController("button")
end

function RedCliffPoolComp:_onChanged()
	if self.m_buttonController:getSelectedIndex() == 1 then
		self.m_frontComp:playOpenTransition(handler(self, self._onOpenTransitionEnd))
	else
		self.m_frontComp:playCloseTransition(handler(self, self._onCloseTransitionEnd))
	end
end

function RedCliffPoolComp:updatePoolComp(arg_3_1)
	if not arg_3_1.poolInfo then
		self:setVisible(false)

		return
	end

	self:setVisible(true)
	self.m_frontComp:updatePoolComp(arg_3_1)
	self.m_backComp:updatePoolComp(arg_3_1)

	if arg_3_1.isSel then
		self.m_openStateTransition:play()
	else
		self.m_closeTransition:play()
	end
end

return RedCliffPoolComp
