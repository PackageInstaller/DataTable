local var_0_0 = {}

var_0_0.URL = "ui://sap1qcktxaylb"

function var_0_0:__ctor()
	self.m_styleController = self:getController("style")
	self.m_nameTitle = self:getChild("nameTitle")
	self.m_talentNameText = self:getChild("talentNameText")
	self.m_talentUnLockTxt = self:getChild("talentUnLockTxt")
	self.m_descText = self:getChild("descText")
	self.m_passiveNameText = self:getChild("passiveNameText")
	self.m_skillUnLockTxt = self:getChild("skillUnLockTxt")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_levelGroup = self:getChild("levelGroup")
	self.m_skillDescTxt = self:getChild("skillDescTxt")
	self.m_skillGroup = self:getChild("skillGroup")
end

return var_0_0
