local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepvspw1emigg9"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
