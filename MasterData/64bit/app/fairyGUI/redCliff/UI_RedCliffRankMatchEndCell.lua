local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2sddye3r"

function var_0_0:__ctor()
	self.m_isSelfController = self:getController("isSelf")
	self.m_rankComp = self:getChild("rankComp")
	self.m_headIcon = self:getChild("headIcon")
	self.m_name = self:getChild("name")
	self.m_fightValue = self:getChild("fightValue")
	self.m_score = self:getChild("score")
end

return var_0_0
