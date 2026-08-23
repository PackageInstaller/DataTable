local BaseShowFeedBackComp = class("BaseShowFeedBackComp", require("app.fairyGUI.base_new.UI_BaseShowFeedBackComp"))

function BaseShowFeedBackComp:setElemView(arg_1_1)
	self:setTitle(arg_1_1)

	self._spineEffect = nil
	self._callBack = nil
	self._spineEffect = self.m_placeHolderComp:addEffectSpine({
		name = "eff_ui_common_feedback",
		isLoop = false,
		remove = true,
		anim = "play_enter"
	})

	self._spineEffect:setAnchorPoint(1, 0.5)
	self.m_inTransition:play()
end

function BaseShowFeedBackComp:playExit(arg_2_1)
	self._callBack = arg_2_1

	self.m_outTransition:play(handler(self, self._onPlayEnd))
end

function BaseShowFeedBackComp:_onPlayEnd()
	if self._callBack then
		self._callBack()

		self._callBack = nil
	else
		self:removeSelf()
	end
end

return BaseShowFeedBackComp
