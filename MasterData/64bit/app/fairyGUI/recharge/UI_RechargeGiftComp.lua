local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52wr5cx3m"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_giftList = self:getChild("giftList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
