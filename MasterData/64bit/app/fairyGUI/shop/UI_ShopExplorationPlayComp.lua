local var_0_0 = {}

var_0_0.URL = "ui://454a48jpphovwkk37w"

function var_0_0:__ctor()
	self.m_tabList = self:getChild("tabList")
	self.m_itemList = self:getChild("itemList")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
