local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qroto34m"

function var_0_0:__ctor()
	self.m_isWearController = self:getController("isWear")
	self.m_iconComp = self:getChild("iconComp")
	self.m_selectIcon = self:getChild("selectIcon")
	self.m_knightIcon = self:getChild("knightIcon")
end

var_0_0.IsWearCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
