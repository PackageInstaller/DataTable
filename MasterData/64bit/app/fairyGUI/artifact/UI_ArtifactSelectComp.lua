local var_0_0 = {}

var_0_0.URL = "ui://nhmdbbcvlu7agic2b"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_emptyController = self:getController("empty")
	self.m_bgImg = self:getChild("bgImg")
	self.m_tab1 = self:getChild("tab1")
	self.m_tab6 = self:getChild("tab6")
	self.m_tab5 = self:getChild("tab5")
	self.m_tab2 = self:getChild("tab2")
	self.m_tab3 = self:getChild("tab3")
	self.m_tab4 = self:getChild("tab4")
	self.m_topTab = self:getChild("topTab")
	self.m_artifactList = self:getChild("artifactList")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_goToBtn = self:getChild("goToBtn")
end

return var_0_0
