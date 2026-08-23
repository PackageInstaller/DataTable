local var_0_0 = {}

var_0_0.URL = "ui://gz20sz1bnvd3d"

function var_0_0:__ctor()
	self.m_hasTimeController = self:getController("hasTime")
	self.m_showBgController = self:getController("showBg")
	self.m_skinViewStateController = self:getController("skinViewState")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_skinBgLoader = self:getChild("skinBgLoader")
	self.m_shadowLoader = self:getChild("shadowLoader")
	self.m_skinShadowLoader = self:getChild("skinShadowLoader")
	self.m_roleLoader = self:getChild("roleLoader")
	self.m_skinRoleLoader = self:getChild("skinRoleLoader")
	self.m_showTouch = self:getChild("showTouch")
	self.m_day1 = self:getChild("day1")
	self.m_day2 = self:getChild("day2")
	self.m_day3 = self:getChild("day3")
	self.m_goBtn = self:getChild("goBtn")
	self.m_btnEffect = self:getChild("btnEffect")
	self.m_showIcon = self:getChild("showIcon")
	self.m_showList = self:getChild("showList")
	self.m_showName = self:getChild("showName")
	self.m_loaderBtn = self:getChild("loaderBtn")
	self.m_showGroup = self:getChild("showGroup")
	self.m_timeText = self:getChild("timeText")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_effectComp = self:getChild("effectComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
