local ActivityBlackFiveComp = class("ActivityBlackFiveComp", require("app.fairyGUI.activity.UI_ActivityBlackFiveComp"))

function ActivityBlackFiveComp:ctor()
	self:addClickListener(handler(self, self._onClickSelf))
	self.m_gotoBtn:addClickListener(handler(self, self._onClickSelf))
	g.core.model.User.activityBlackFiveData:saveRedPointStatus()
end

function ActivityBlackFiveComp:updateComp()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.BLACK_FIVE_RED_POINT, false)
	self.m_enterTransition:play()
end

function ActivityBlackFiveComp:_onClickSelf()
	g.core.platform.PlatformProxy:openURL("https://case.gtarcade.com/en/blackfriday2024/2013002")
end

return ActivityBlackFiveComp
