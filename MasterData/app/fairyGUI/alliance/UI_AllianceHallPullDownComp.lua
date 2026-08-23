local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcmq562i"

function var_0_0:__ctor()
	self.m_orderController = self:getController("order")
	self.m_isExpandController = self:getController("isExpand")
	self.m_orderBtn = self:getChild("orderBtn")
	self.m_title = self:getChild("title")
	self.m_expandBtn = self:getChild("expandBtn")
	self.m_memberBtn = self:getChild("memberBtn")
	self.m_powerBtn = self:getChild("powerBtn")
	self.m_contribBtn = self:getChild("contribBtn")
	self.m_totalBtn = self:getChild("totalBtn")
end

var_0_0.OrderCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsExpandCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
