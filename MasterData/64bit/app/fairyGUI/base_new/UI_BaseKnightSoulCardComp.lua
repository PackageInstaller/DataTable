local var_0_0 = {}

var_0_0.URL = "ui://kvb3zneped0j1emigfh"

function var_0_0:__ctor()
	self.m_isOwnController = self:getController("isOwn")
	self.m_typeController = self:getController("type")
	self.m_unShowNameController = self:getController("unShowName")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_knightCutComp = self:getChild("knightCutComp")
	self.m_qualityFg = self:getChild("qualityFg")
	self.m_eff = self:getChild("eff")
	self.m_group = self:getChild("group")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_act = self:getChild("act")
	self.m_act2 = self:getChild("act2")
	self.m_activateTransition = self:getTransition("activate")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsOwnCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.UnShowNameCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
