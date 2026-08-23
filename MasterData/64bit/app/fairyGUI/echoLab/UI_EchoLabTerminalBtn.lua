local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1xku32q"

function var_0_0:__ctor()
	self.m_isLockController = self:getController("isLock")
	self.m_effEnter = self:getChild("effEnter")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsLockCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
