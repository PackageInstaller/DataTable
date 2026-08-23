local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9vl5qqag"

function var_0_0:__ctor()
	self.m_lockController = self:getController("lock")
	self.m_showNameController = self:getController("showName")
	self.m_iconShow = self:getChild("iconShow")
	self.m_effLock = self:getChild("effLock")
	self.m_iconMask = self:getChild("iconMask")
	self.m_lock_2 = self:getChild("lock")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
