local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1p5qx43"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_coreComp = self:getChild("coreComp")
	self.m_clickLoader = self:getChild("clickLoader")
	self.m_slotComp = self:getChild("slotComp")
	self.m_bgImage = self:getChild("bgImage")
	self.m_cardList = self:getChild("cardList")
	self.m_filterBtn = self:getChild("filterBtn")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
