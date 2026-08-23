local var_0_0 = {}

var_0_0.URL = "ui://pbd24silf49a5p"

function var_0_0:__ctor()
	self.m_showDescCompController = self:getController("showDescComp")
	self.m_userIcon = self:getChild("userIcon")
	self.m_hpComp = self:getChild("hpComp")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_levelProgressBar = self:getChild("levelProgressBar")
	self.m_buff1 = self:getChild("buff1")
	self.m_buff2 = self:getChild("buff2")
	self.m_buff3 = self:getChild("buff3")
	self.m_buff4 = self:getChild("buff4")
	self.m_buff5 = self:getChild("buff5")
	self.m_airDropBuff1 = self:getChild("airDropBuff1")
	self.m_airDropBuff2 = self:getChild("airDropBuff2")
	self.m_airDropBuff3 = self:getChild("airDropBuff3")
	self.m_descComp = self:getChild("descComp")
end

return var_0_0
