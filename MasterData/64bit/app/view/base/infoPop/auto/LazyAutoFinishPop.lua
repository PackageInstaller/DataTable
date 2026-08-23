local LazyAutoFinishPop = class("LazyAutoFinishPop", require("app.fairyGUI.infoPop.UI_LazyAutoFinishPop"))

function LazyAutoFinishPop:ctor()
	self.m_closePanel:addClickListener(handler(self, self._onCloseClick))
end

function LazyAutoFinishPop:updateAutoReason(arg_2_1)
	self.m_levelTxt:setText(arg_2_1.levelTxt)
	self.m_resDescTxt:setText(arg_2_1.desc)
	self.m_enterTransition:setHook("enter", function()
		self.m_autoDiskComp:playEnterAni()
	end)
	self.m_enterTransition:setHook("loop", function()
		self.m_autoDiskComp:playTurnAroundAni()
	end)
	self.m_enterTransition:play()
	self.m_effDi:addEffectSpine({
		remove = false,
		name = "eff_ui_peakArena_di",
		isLoop = true
	})
end

function LazyAutoFinishPop:_onCloseClick()
	self:removeFromParent()
end

return LazyAutoFinishPop
