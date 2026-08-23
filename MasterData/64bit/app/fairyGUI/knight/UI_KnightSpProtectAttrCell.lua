local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivqoiyfrf5"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_attrDescTxt = self:getChild("attrDescTxt")
end

var_0_0.IsActiveCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
