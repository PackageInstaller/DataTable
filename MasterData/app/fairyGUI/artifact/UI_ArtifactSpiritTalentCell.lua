local var_0_0 = {}

var_0_0.URL = "ui://nhmdbbcvn5hhgic57"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_hasLevelChangeController = self:getController("hasLevelChange")
	self.m_nameTitle = self:getChild("nameTitle")
	self.m_levelChangeTxt = self:getChild("levelChangeTxt")
	self.m_talentUnLockTxt = self:getChild("talentUnLockTxt")
	self.m_talentNameText = self:getChild("talentNameText")
	self.m_descText = self:getChild("descText")
end

return var_0_0
