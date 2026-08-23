local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52wwk0fcv"

function var_0_0:__ctor()
	self.m_buttonController = self:getController("button")
	self.m_canBuyController = self:getController("canBuy")
	self.m_effHolder = self:getChild("effHolder")
end

var_0_0.ButtonCtrl = {
	down = 0,
	up = 1
}
var_0_0.CanBuyCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 4
}

return var_0_0
