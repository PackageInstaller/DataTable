local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgc8pw5iboc"

function var_0_0:__ctor()
	self.m_bgStyleController = self:getController("bgStyle")
	self.m_iconStyleController = self:getController("iconStyle")
	self.m_nTxt = self:getChild("nTxt")
end

var_0_0.BgStyleCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}
var_0_0.IconStyleCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}

return var_0_0
