local var_0_0 = {}

var_0_0.URL = "ui://7ex6tye9now7g"

function var_0_0:__ctor()
	self.m_rankController = self:getController("rank")
	self.m_isSweepController = self:getController("isSweep")
	self.m_picComp = self:getChild("picComp")
	self.m_rankBgLoader = self:getChild("rankBgLoader")
	self.m_rankText = self:getChild("rankText")
	self.m_lvText = self:getChild("lvText")
	self.m_serverNameText = self:getChild("serverNameText")
	self.m_powerNumText = self:getChild("powerNumText")
	self.m_nameText = self:getChild("nameText")
	self.m_sweepBtn = self:getChild("sweepBtn")
end

return var_0_0
