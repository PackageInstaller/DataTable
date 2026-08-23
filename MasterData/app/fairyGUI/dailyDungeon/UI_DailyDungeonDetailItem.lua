local var_0_0 = {}

var_0_0.URL = "ui://7nx6gocgkc651w"

function var_0_0:__ctor()
	self.m_isCompletedController = self:getController("isCompleted")
	self.m_lockController = self:getController("lock")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_lockTxt = self:getChild("lockTxt")
	self.m_effLock = self:getChild("effLock")
	self.m_effTab = self:getChild("effTab")
	self.m_redPoint = self:getChild("redPoint")
	self.m_unlockTransition = self:getTransition("unlock")
end

var_0_0.IsCompletedCtrl = {
	continue = 0,
	completed = 1
}
var_0_0.LockCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
