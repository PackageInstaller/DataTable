local EasterEggFeedBackComp = class("EasterEggFeedBackComp", require("app.fairyGUI.easterEgg.UI_EasterEggFeedBackComp"))

function EasterEggFeedBackComp:setElemView(arg_1_1)
	self:setTitle(arg_1_1)

	self._spineEffect = nil
	self._callBack = nil

	self.m_inTransition:play()
end

function EasterEggFeedBackComp:playExit(arg_2_1)
	self._callBack = arg_2_1

	self.m_outTransition:play(handler(self, self._onPlayEnd))
end

function EasterEggFeedBackComp:_onPlayEnd()
	if self._callBack then
		self._callBack()

		self._callBack = nil
	else
		self:removeSelf()
	end
end

return EasterEggFeedBackComp
