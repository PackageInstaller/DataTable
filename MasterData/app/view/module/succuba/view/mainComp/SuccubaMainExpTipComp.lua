local SuccubaMainExpTipComp = class("SuccubaMainExpTipComp", require("app.fairyGUI.succuba.UI_SuccubaMainExpTipComp"))

function SuccubaMainExpTipComp:ctor()
	self:setPosition(display.width / 2, display.height / 2)

	self._inWait = true

	if self.m_enterTransition then
		self.m_enterTransition:play(handler(self, self._onCloseSelf))
	end

	self:setTouchable(false)
end

function SuccubaMainExpTipComp:setTipText(arg_2_1)
	self:setTitle(arg_2_1 or "")
end

function SuccubaMainExpTipComp:_onCloseSelf()
	self:getParent():removeSelf()
end

return SuccubaMainExpTipComp
