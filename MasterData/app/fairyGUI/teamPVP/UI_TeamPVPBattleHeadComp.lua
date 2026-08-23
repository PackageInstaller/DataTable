local var_0_0 = {}

var_0_0.URL = "ui://akds0szatrxs4t"

function var_0_0:__ctor()
	self.m_deadController = self:getController("dead")
	self.m_campController = self:getController("camp")
	self.m_isHelpController = self:getController("isHelp")
	self.m_isBattleController = self:getController("isBattle")
	self.m_effidle = self:getChild("effidle")
	self.m_redBg = self:getChild("redBg")
	self.m_blueBg = self:getChild("blueBg")
	self.m_headComp = self:getChild("headComp")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_playNum = self:getChild("playNum")
	self.m_effplay = self:getChild("effplay")
end

return var_0_0
