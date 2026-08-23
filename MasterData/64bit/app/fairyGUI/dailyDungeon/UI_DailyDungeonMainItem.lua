local var_0_0 = {}

var_0_0.URL = "ui://7nx6gocgbmx92m"

function var_0_0:__ctor()
	self.m_isLockController = self:getController("isLock")
	self.m_isZeroController = self:getController("isZero")
	self.m_linePosController = self:getController("linePos")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_effLedLoop = self:getChild("effLedLoop")
	self.m_explorCurText = self:getChild("explorCurText")
	self.m_explorMaxText = self:getChild("explorMaxText")
	self.m_nameTextCopy = self:getChild("nameTextCopy")
	self.m_nameText = self:getChild("nameText")
	self.m_timeTxtCopy = self:getChild("timeTxtCopy")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_redPoint = self:getChild("redPoint")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsLockCtrl = {
	lock = 1,
	normal = 0
}
var_0_0.IsZeroCtrl = {
	zero = 1,
	normal = 0
}

return var_0_0
