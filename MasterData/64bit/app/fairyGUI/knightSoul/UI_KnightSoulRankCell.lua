local var_0_0 = {}

var_0_0.URL = "ui://kwpkf9ulj2cj4d"

function var_0_0:__ctor()
	self.m_haveBgController = self:getController("haveBg")
	self.m_hasRankController = self:getController("hasRank")
	self.m_rankIndexComp = self:getChild("rankIndexComp")
	self.m_headComp = self:getChild("headComp")
	self.m_bookNum = self:getChild("bookNum")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_belongNameTxt = self:getChild("belongNameTxt")
	self.m_honorNum = self:getChild("honorNum")
end

return var_0_0
