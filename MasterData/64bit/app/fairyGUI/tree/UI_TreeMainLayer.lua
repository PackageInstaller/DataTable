local var_0_0 = {}

var_0_0.URL = "ui://d5b3cu3gt62o0"

function var_0_0:__ctor()
	self.m_isShowInfoController = self:getController("isShowInfo")
	self.m_mapComp = self:getChild("mapComp")
	self.m_infoComp = self:getChild("infoComp")
	self.m_attrBtn = self:getChild("attrBtn")
	self.m_headBtn = self:getChild("headBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_switchTransition = self:getTransition("switch")
end

return var_0_0
