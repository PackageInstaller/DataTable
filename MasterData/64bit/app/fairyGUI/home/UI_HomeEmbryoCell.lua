local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgmlvb5ibm8"

function var_0_0:__ctor()
	self.m_isDevelopController = self:getController("isDevelop")
	self.m_isUnLockController = self:getController("isUnLock")
	self.m_peiziBg = self:getChild("peiziBg")
	self.m_icon = self:getChild("icon")
	self.m_effEnter = self:getChild("effEnter")
	self.m_funcName = self:getChild("funcName")
	self.m_unlockTxt = self:getChild("unlockTxt")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsDevelopCtrl = {
	是 = 1,
	否 = 0
}
var_0_0.IsUnLockCtrl = {
	是 = 1,
	否 = 0
}

return var_0_0
