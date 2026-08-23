local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mhkv0m6m"

function var_0_0:__ctor()
	self.m_highlightController = self:getController("highlight")
	self.m_timeTxt = self:getChild("timeTxt")
end

var_0_0.HighlightCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
