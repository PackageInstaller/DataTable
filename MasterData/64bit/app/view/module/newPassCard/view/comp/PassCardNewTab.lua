local PassCardNewTab = class("PassCardNewTab", require("app.fairyGUI.newPassCard.UI_PassCardNewTab"))

function PassCardNewTab:onLoad()
	self:checkRedPoint()
end

function PassCardNewTab:checkRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

return PassCardNewTab
