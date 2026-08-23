local var_0_0 = {}

var_0_0.URL = "ui://dpzp8jmrdhw3e"

function var_0_0:__ctor()
	self.m_regionController = self:getController("region")
	self.m_effBg = self:getChild("effBg")
	self.m_awardList = self:getChild("awardList")
	self.m_linkTxt = self:getChild("linkTxt")
	self.m_copyBtn = self:getChild("copyBtn")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.RegionCtrl = {
	国服 = 1,
	欧美 = 0
}

return var_0_0
