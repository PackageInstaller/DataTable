local var_0_0 = {}

var_0_0.URL = "ui://gntkqnnjrwctbny"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_skillNameTxt = self:getChild("skillNameTxt")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_skillDescTxt = self:getChild("skillDescTxt")
	self.m_unLockTxt = self:getChild("unLockTxt")
end

var_0_0.IsActiveCtrl = {
	未激活 = 0,
	激活 = 1
}

return var_0_0
