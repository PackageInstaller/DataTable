local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgd85e5ibhn"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_redPointTypeController = self:getController("redPointType")
	self.m_activityTimeStateController = self:getController("activityTimeState")
	self.m_bg = self:getChild("bg")
	self.m_effectComp = self:getChild("effectComp")
	self.m_timeLoader = self:getChild("timeLoader")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_newRedPointComp = self:getChild("newRedPointComp")
	self.m_pushGiftIdleTransition = self:getTransition("pushGiftIdle")
end

var_0_0.TypeCtrl = {
	普通类型 = 0,
	限时类型 = 1
}
var_0_0.RedPointTypeCtrl = {
	newType = 1,
	normal = 0
}
var_0_0.ActivityTimeStateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
