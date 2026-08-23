local DebugPubg2 = class("DebugPubg2", require("app.fairyGUI.debug.UI_DebugPubg2"))

function DebugPubg2:ctor()
	self.m_scaleSlide:addEventListener(fgui.UIEventType.Changed, handler(self, self._onScaleChange))
	self.m_scaleSlide:setValue(100)
end

function DebugPubg2:_onScaleChange()
	self.m_viewComp:setScale(math.floor(self.m_scaleSlide:getValue()) * 0.01)
end

return DebugPubg2
