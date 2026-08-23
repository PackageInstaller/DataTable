local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfkte81"

function var_0_0:__ctor()
	self.m_isSharedController = self:getController("isShared")
	self.m_rotateController = self:getController("rotate")
	self.m_monsterComp = self:getChild("monsterComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_enterRotateTransition = self:getTransition("enterRotate")
end

return var_0_0
