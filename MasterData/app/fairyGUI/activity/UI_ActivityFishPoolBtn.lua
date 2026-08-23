local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wmpj7ba"

function var_0_0:__ctor()
	self.m_fishChangeController = self:getController("fishChange")
	self.m_isTenController = self:getController("isTen")
	self.m_fish1 = self:getChild("fish1")
	self.m_fish2 = self:getChild("fish2")
	self.m_fish3 = self:getChild("fish3")
	self.m_fishNumTxt1 = self:getChild("fishNumTxt1")
	self.m_fishNumTxt2 = self:getChild("fishNumTxt2")
	self.m_fishNumTxt3 = self:getChild("fishNumTxt3")
	self.m_fishCostText1 = self:getChild("fishCostText1")
	self.m_fishCostText2 = self:getChild("fishCostText2")
	self.m_fishCostText3 = self:getChild("fishCostText3")
	self.m_fishCostTransition = self:getTransition("fishCost")
	self.m_fishCostTenTransition = self:getTransition("fishCostTen")
end

var_0_0.FishChangeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.IsTenCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
