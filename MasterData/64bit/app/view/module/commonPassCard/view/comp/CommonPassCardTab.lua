local CommonPassCardTab = class("CommonPassCardTab", require("app.fairyGUI.commonPassCard.UI_CommonPassCardTab"))

function CommonPassCardTab:onLoad()
	self:checkRedPoint()
end

function CommonPassCardTab:checkRedPoint(arg_2_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			activityId = arg_2_1
		}
	})
end

return CommonPassCardTab
