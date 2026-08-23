local DebugNavmesh2D = class("DebugNavmesh2D", require("app.fairyGUI.debug.UI_DebugNavmesh2D"))

function DebugNavmesh2D:ctor()
	self.m_scaleSlide:addEventListener(fgui.UIEventType.Changed, handler(self, self._onScaleChange))
	self.m_scaleSlide:setValue(100)
end

function DebugNavmesh2D:_onScaleChange()
	self.m_viewComp:setScale(math.floor(self.m_scaleSlide:getValue()) * 0.01)
end

return DebugNavmesh2D
