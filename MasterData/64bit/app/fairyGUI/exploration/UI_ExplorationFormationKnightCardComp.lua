local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25nbgf7u"

function var_0_0:__ctor()
	self.m_hasPlayerController = self:getController("hasPlayer")
	self.m_index1 = self:getChild("index1")
	self.m_qualityLine = self:getChild("qualityLine")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_knightLoader = self:getChild("knightLoader")
	self.m_index0 = self:getChild("index0")
	self.m_starComp = self:getChild("starComp")
	self.m_knightNameTxt = self:getChild("knightNameTxt")
end

var_0_0.HasPlayerCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
