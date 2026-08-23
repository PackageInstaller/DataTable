local SpireTransformationComp = class("SpireTransformationComp", require("app.fairyGUI.spire.UI_SpireTransformationComp"))

function SpireTransformationComp:ctor()
	self._playCallback = nil

	self:setHook("end", handler(self, self._onPlayAnimEnd))
end

function SpireTransformationComp:setHook(arg_2_1, arg_2_2)
	self.m_enterTransition:setHook(arg_2_1, arg_2_2)
end

function SpireTransformationComp:play(arg_3_1)
	self._playCallback = arg_3_1

	self.m_enterTransition:play()
end

function SpireTransformationComp:_onPlayAnimEnd()
	if self._playCallback then
		self._playCallback()
	end

	self._playCallback = nil
end

return SpireTransformationComp
