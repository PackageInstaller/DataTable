local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wgech3m"

function var_0_0:__ctor()
	self.m_hasCanGetController = self:getController("hasCanGet")
	self.m_typeController = self:getController("type")
	self.m_popPanel = self:getChild("popPanel")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_nameBg = self:getChild("nameBg")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_rechargeBtn = self:getChild("rechargeBtn")
	self.m_priceTxt = self:getChild("priceTxt")
	self.m_allCanGetList = self:getChild("allCanGetList")
	self.m_nowGetList = self:getChild("nowGetList")
	self.m_content = self:getChild("content")
end

var_0_0.HasCanGetCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.TypeCtrl = {
	page2 = 2,
	page3 = 3,
	page1 = 1,
	page0 = 0
}

return var_0_0
