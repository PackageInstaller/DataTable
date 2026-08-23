local var_0_0 = {}

var_0_0.URL = "ui://c3jvi0x1nlkcv"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_srvTypeController = self:getController("srvType")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_rankTab = self:getChild("rankTab")
	self.m_curSvrTab = self:getChild("curSvrTab")
	self.m_crossSrvTab = self:getChild("crossSrvTab")
	self.m_rankList = self:getChild("rankList")
	self.m_rankRewardList = self:getChild("rankRewardList")
	self.m_numTxt = self:getChild("numTxt")
	self.m_topBarComp = self:getChild("topBarComp")
end

return var_0_0
