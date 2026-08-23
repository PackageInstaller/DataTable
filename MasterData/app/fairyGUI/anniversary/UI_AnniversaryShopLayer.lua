local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiq9hnm2k"

function var_0_0:__ctor()
	self.m_selGroupController = self:getController("selGroup")
	self.m_shopTabList = self:getChild("shopTabList")
	self.m_itemList = self:getChild("itemList")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
