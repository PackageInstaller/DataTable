local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mprkcm6i"

function var_0_0:__ctor()
	self.m_highlightController = self:getController("highlight")
	self.m_timeTxt = self:getChild("timeTxt")
end

var_0_0.HighlightCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
