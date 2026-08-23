local var_0_0 = {}

var_0_0.URL = "ui://vpe6pr94mmem8u"

function var_0_0:__ctor()
	self.m_isSellOutController = self:getController("isSellOut")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_moneyText = self:getChild("moneyText")
end

var_0_0.IsSellOutCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
