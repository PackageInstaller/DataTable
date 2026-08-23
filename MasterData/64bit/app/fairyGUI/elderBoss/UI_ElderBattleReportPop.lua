local var_0_0 = {}

var_0_0.URL = "ui://8cx1i074vtmo25"

function var_0_0:__ctor()
	self.m_emptyController = self:getController("empty")
	self.m_reportList = self:getChild("reportList")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.EmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
