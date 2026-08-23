local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oj8cxez"

function var_0_0:__ctor()
	self.m_hasSuitController = self:getController("hasSuit")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_suitDetailText = self:getChild("suitDetailText")
	self.m_tabList = self:getChild("tabList")
	self.m_itemList = self:getChild("itemList")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.HasSuitCtrl = {
	none = 0,
	has = 1
}

return var_0_0
