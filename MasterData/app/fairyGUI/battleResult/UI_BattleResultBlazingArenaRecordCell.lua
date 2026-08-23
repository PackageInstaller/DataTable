local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nkv3rkmibyv"

function var_0_0:__ctor()
	self.m_resultController = self:getController("result")
	self.m_myTeamList = self:getChild("myTeamList")
	self.m_roundTxt = self:getChild("roundTxt")
	self.m_rivalTeamList = self:getChild("rivalTeamList")
	self.m_recordBtn = self:getChild("recordBtn")
end

return var_0_0
