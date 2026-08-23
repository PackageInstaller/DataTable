local BaseLeftTab = class("BaseLeftTab", require("app.fairyGUI.base_new.UI_BaseLeftTab"))

function BaseLeftTab:ctor()
	self.m_buttonController = self:getController("button")

	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onClickChanged))
end

function BaseLeftTab:_onClickChanged()
	return
end

return BaseLeftTab
