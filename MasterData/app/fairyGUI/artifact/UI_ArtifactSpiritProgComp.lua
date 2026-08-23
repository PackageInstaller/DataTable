local var_0_0 = {}

var_0_0.URL = "ui://nhmdbbcvn5hhgic51"

function var_0_0:__ctor()
	self.m_stageNumTxt = self:getChild("stageNumTxt")
	self.m_curLvTxt = self:getChild("curLvTxt")
	self.m_fullLvTxt = self:getChild("fullLvTxt")
	self.m_tipsBtn = self:getChild("tipsBtn")
	self.m_curDescTxt = self:getChild("curDescTxt")
	self.m_tipGroup = self:getChild("tipGroup")
	self.m_effHolder = self:getChild("effHolder")
	self.m_enterTransition = self:getTransition("enter")
	self.m_advanceTransition = self:getTransition("advance")
end

return var_0_0
