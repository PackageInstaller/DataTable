local var_0_0 = {}

var_0_0.URL = "ui://3g2xiq47c6983y"

function var_0_0:__ctor()
	self.m_isCaptainController = self:getController("isCaptain")
	self.m_knightCard = self:getChild("knightCard")
	self.m_index = self:getChild("index")
	self.m_professionBg = self:getChild("professionBg")
	self.m_professionIcon = self:getChild("professionIcon")
	self.m_elementIcon = self:getChild("elementIcon")
	self.m_artifactIcon = self:getChild("artifactIcon")
	self.m_knightName = self:getChild("knightName")
end

var_0_0.IsCaptainCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
