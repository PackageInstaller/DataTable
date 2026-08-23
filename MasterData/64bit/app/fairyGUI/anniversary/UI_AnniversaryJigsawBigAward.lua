local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiq9hnm2e"

function var_0_0:__ctor()
	self.m_isGetController = self:getController("isGet")
	self.m_bg = self:getChild("bg")
	self.m_bigNameTxt = self:getChild("bigNameTxt")
	self.m_effLoop = self:getChild("effLoop")
	self.m_awardIconLoader = self:getChild("awardIconLoader")
	self.m_numTxt = self:getChild("numTxt")
	self.m_awardTxt = self:getChild("awardTxt")
end

return var_0_0
