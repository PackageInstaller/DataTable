local var_0_0 = {}

var_0_0.URL = "ui://nz3msl46nqhjgibw0"

function var_0_0:__ctor()
	self.m_isLockController = self:getController("isLock")
	self.m_imgBg = self:getChild("imgBg")
	self.m_wishList = self:getChild("wishList")
	self.m_lockTempText = self:getChild("lockTempText")
	self.m_lockTipText = self:getChild("lockTipText")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsLockCtrl = {
	normal = 0,
	lock = 1
}

return var_0_0
