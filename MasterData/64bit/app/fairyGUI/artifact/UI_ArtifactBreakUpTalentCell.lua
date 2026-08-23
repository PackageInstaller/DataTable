local var_0_0 = {}

var_0_0.URL = "ui://nhmdbbcvw7z3gic59"

function var_0_0:__ctor()
	self.m_unlockController = self:getController("unlock")
	self.m_nameTitle = self:getChild("nameTitle")
	self.m_talentNameText = self:getChild("talentNameText")
	self.m_talentUnLockTxt = self:getChild("talentUnLockTxt")
	self.m_descText = self:getChild("descText")
end

return var_0_0
