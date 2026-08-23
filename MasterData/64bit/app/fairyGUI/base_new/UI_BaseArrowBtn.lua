local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepo8klkk30y"

function var_0_0:__ctor()
	self.m_directionController = self:getController("direction")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.DirectionCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page3 = 3
}

return var_0_0
