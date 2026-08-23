local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnklzqgic2i"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_priceNumController = self:getController("priceNum")
	self.m_popPanel = self:getChild("popPanel")
	self.m_emptyComp = self:getChild("emptyComp")
	self.m_fragList = self:getChild("fragList")
	self.m_tabList = self:getChild("tabList")
	self.m_sellBtn = self:getChild("sellBtn")
	self.m_sellRewardComp = self:getChild("sellRewardComp")
	self.m_sellRewardComp2 = self:getChild("sellRewardComp2")
	self.m_content = self:getChild("content")
end

var_0_0.IsEmptyCtrl = {
	empty = 1,
	normal = 0
}
var_0_0.PriceNumCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
