local ActivityTapWelfareComp = class("ActivityTapWelfareComp", require("app.fairyGUI.activity.UI_ActivityTapWelfareComp"))

function ActivityTapWelfareComp:ctor()
	self:addClickListener(handler(self, self._onClickSelf))
	self.m_gotoBtn:addClickListener(handler(self, self._onClickSelf))
	g.core.model.User.activityTapWelfareData:saveRedPointStatus()
end

function ActivityTapWelfareComp:updateComp()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.TAP_WELFARE_RED_POINT, false)
	self.m_enterTransition:play()
end

function ActivityTapWelfareComp:_onClickSelf()
	g.core.platform.PlatformProxy:openURL("https://l.taptap.cn/qd5gUo4Y?channel=rep-rep_2qpgea59isi_h5url2658")
end

return ActivityTapWelfareComp
