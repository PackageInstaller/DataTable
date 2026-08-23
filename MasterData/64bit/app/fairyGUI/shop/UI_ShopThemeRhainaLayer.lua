local var_0_0 = {}

var_0_0.URL = "ui://454a48jpouuz14bnnh0"

function var_0_0:__ctor()
	self.m_knightComp = self:getChild("knightComp")
	self.m_childComp = self:getChild("childComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_jumpShopBtn = self:getChild("jumpShopBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
