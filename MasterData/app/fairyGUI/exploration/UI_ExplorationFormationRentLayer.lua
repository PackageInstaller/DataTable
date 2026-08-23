local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25btyd3b"

function var_0_0:__ctor()
	self.m_tabTypeController = self:getController("tabType")
	self.m_campController = self:getController("camp")
	self.m_isUsingController = self:getController("isUsing")
	self.m_knightNumText = self:getChild("knightNumText")
	self.m_maxNumText = self:getChild("maxNumText")
	self.m_cardComp1 = self:getChild("cardComp1")
	self.m_cardComp2 = self:getChild("cardComp2")
	self.m_cardComp3 = self:getChild("cardComp3")
	self.m_knightList = self:getChild("knightList")
	self.m_emptyComp = self:getChild("emptyComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.TabTypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.CampCtrl = {
	page2 = 2,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}
var_0_0.IsUsingCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
