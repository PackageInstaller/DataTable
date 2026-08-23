local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wf97s1y"

function var_0_0:__ctor()
	self.m_isCanOneKeyController = self:getController("isCanOneKey")
	self.m_hasWeekCardController = self:getController("hasWeekCard")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_gift4 = self:getChild("gift4")
	self.m_gift3 = self:getChild("gift3")
	self.m_gift2 = self:getChild("gift2")
	self.m_gift1 = self:getChild("gift1")
	self.m_allDiscount = self:getChild("allDiscount")
	self.m_oneKeyBuyBtn = self:getChild("oneKeyBuyBtn")
	self.m_oneKeyGroup = self:getChild("oneKeyGroup")
	self.m_weekCardDiscount = self:getChild("weekCardDiscount")
	self.m_weekCardBuyBtn = self:getChild("weekCardBuyBtn")
	self.m_weekCardGroup = self:getChild("weekCardGroup")
	self.m_proAwardComp = self:getChild("proAwardComp")
	self.m_stepComp = self:getChild("stepComp")
	self.m_gameComp = self:getChild("gameComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsCanOneKeyCtrl = {
	是 = 0,
	否 = 1
}
var_0_0.HasWeekCardCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
