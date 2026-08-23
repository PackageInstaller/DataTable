local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lzqgm2r"

function var_0_0:__ctor()
	self.m_isBetterController = self:getController("isBetter")
	self.m_isSoldOutController = self:getController("isSoldOut")
	self.m_itemPicComp = self:getChild("itemPicComp")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_starComp = self:getChild("starComp")
	self.m_costComp = self:getChild("costComp")
	self.m_elementLoader = self:getChild("elementLoader")
	self.m_switchTransition = self:getTransition("switch")
end

var_0_0.IsBetterCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsSoldOutCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
