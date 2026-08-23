local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qrjy7ckk307"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_selAllController = self:getController("selAll")
	self.m_closeComp = self:getChild("closeComp")
	self.m_filterList = self:getChild("filterList")
	self.m_allBtn = self:getChild("allBtn")
	self.m_sortList = self:getChild("sortList")
	self.m_defaultBtn = self:getChild("defaultBtn")
	self.m_scoreBtn = self:getChild("scoreBtn")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.SelAllCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
