local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qrgmyr4u"

function var_0_0:__ctor()
	self.m_infoBaseComp = self:getChild("infoBaseComp")
	self.m_haveTxt = self:getChild("haveTxt")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_useBtn = self:getChild("useBtn")
	self.m_scrollTxtComp = self:getChild("scrollTxtComp")
	self.m_limitedTimeTxt = self:getChild("limitedTimeTxt")
	self.m_limitTimeIcon = self:getChild("limitTimeIcon")
	self.m_infoBtn = self:getChild("infoBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
