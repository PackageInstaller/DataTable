local var_0_0 = {}

var_0_0.URL = "ui://akds0szaf470h"

function var_0_0:__ctor()
	self.m_isMyselfController = self:getController("isMyself")
	self.m_isMvpController = self:getController("isMvp")
	self.m_headComp = self:getChild("headComp")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_serverName = self:getChild("serverName")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_featTxt = self:getChild("featTxt")
	self.m_powerTxt = self:getChild("powerTxt")
	self.m_rankLoader = self:getChild("rankLoader")
	self.m_mvpEff = self:getChild("mvpEff")
end

return var_0_0
