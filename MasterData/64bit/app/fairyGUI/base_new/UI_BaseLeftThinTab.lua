local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepku6zibk6"

function var_0_0:__ctor()
	self.m_styleController = self:getController("style")
	self.m_loader = self:getChild("loader")
	self.m_iconDown = self:getChild("iconDown")
	self.m_effectComp = self:getChild("effectComp")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_up_enterTransition = self:getTransition("up_enter")
	self.m_down_enterTransition = self:getTransition("down_enter")
	self.m_up_enter1Transition = self:getTransition("up_enter1")
	self.m_down_enter1Transition = self:getTransition("down_enter1")
end

var_0_0.StyleCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
