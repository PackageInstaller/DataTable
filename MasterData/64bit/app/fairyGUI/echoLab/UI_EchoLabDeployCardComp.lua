local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1hlay3l"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isSelectController = self:getController("isSelect")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_qualityLoader1 = self:getChild("qualityLoader1")
	self.m_picComp = self:getChild("picComp")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_starComp = self:getChild("starComp")
	self.m_descTxt = self:getChild("descTxt")
	self.m_addEff = self:getChild("addEff")
	self.m_lockText = self:getChild("lockText")
	self.m_cardEff = self:getChild("cardEff")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}
var_0_0.IsSelectCtrl = {
	page1 = 3,
	page0 = 2
}

return var_0_0
