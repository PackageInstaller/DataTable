local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgelha5ibmt"

function var_0_0:__ctor()
	self.m_isUnLockController = self:getController("isUnLock")
	self.m_icon = self:getChild("icon")
	self.m_effEnter = self:getChild("effEnter")
	self.m_funcName = self:getChild("funcName")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_redpointLoader = self:getChild("redpointLoader")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsUnLockCtrl = {
	是 = 1,
	否 = 0
}

return var_0_0
