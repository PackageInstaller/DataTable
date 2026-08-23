local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2sj2ge29"

function var_0_0:__ctor()
	self.m_isOpenController = self:getController("isOpen")
	self.m_poolTypeController = self:getController("poolType")
	self.m_upgradeStateController = self:getController("upgradeState")
	self.m_isSelectController = self:getController("isSelect")
	self.m_poolName = self:getChild("poolName")
	self.m_poolState = self:getChild("poolState")
	self.m_enterTransition = self:getTransition("enter")
	self.m_openTransition = self:getTransition("open")
	self.m_closeTransition = self:getTransition("close")
end

return var_0_0
