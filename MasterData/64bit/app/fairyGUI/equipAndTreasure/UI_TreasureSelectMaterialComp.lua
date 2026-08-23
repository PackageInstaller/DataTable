local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7rhsd2v"

function var_0_0:__ctor()
	self.m_showResNumController = self:getController("showResNum")
	self.m_emptyController = self:getController("empty")
	self.m_materialList = self:getChild("materialList")
	self.m_resNumComp = self:getChild("resNumComp")
	self.m_strengthBtn = self:getChild("strengthBtn")
end

var_0_0.ShowResNumCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.EmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
