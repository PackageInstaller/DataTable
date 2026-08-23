local var_0_0 = {}

var_0_0.URL = "ui://kvb3znephjpc1emigb0"

function var_0_0:__ctor()
	self.m_emptyController = self:getController("empty")
	self.m_urStageAddController = self:getController("urStageAdd")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_effDadComp = self:getChild("effDadComp")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_starNumTxt = self:getChild("starNumTxt")
	self.m_emptyBgLoader = self:getChild("emptyBgLoader")
	self.m_addBtn = self:getChild("addBtn")
	self.m_redPointComp1 = self:getChild("redPointComp1")
	self.m_spiritComp = self:getChild("spiritComp")
end

var_0_0.EmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.UrStageAddCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
