local var_0_0 = {}

var_0_0.URL = "ui://akds0szalevb2l"

function var_0_0:__ctor()
	self.m_haveBgController = self:getController("haveBg")
	self.m_hasRankController = self:getController("hasRank")
	self.m_rankIndexComp = self:getChild("rankIndexComp")
	self.m_headComp = self:getChild("headComp")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_serverName = self:getChild("serverName")
	self.m_honorNum = self:getChild("honorNum")
	self.m_rankLoader = self:getChild("rankLoader")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
end

return var_0_0
