local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5116r740"

function var_0_0:__ctor()
	self.m_knightComp = self:getChild("knightComp")
	self.m_itemList = self:getChild("itemList")
	self.m_callBtn = self:getChild("callBtn")
	self.m_outTransition = self:getTransition("out")
	self.m_upTransition = self:getTransition("up")
end

return var_0_0
