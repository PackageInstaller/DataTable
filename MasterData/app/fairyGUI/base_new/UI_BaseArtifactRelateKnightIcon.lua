local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepkgs6gic2p"

function var_0_0:__ctor()
	self.m_lineDirectionController = self:getController("lineDirection")
	self.m_isShowBgController = self:getController("isShowBg")
	self.m_isLinkController = self:getController("isLink")
	self.m_maskKnightIcon = self:getChild("maskKnightIcon")
end

var_0_0.LineDirectionCtrl = {
	左 = 0,
	右 = 1
}
var_0_0.IsShowBgCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsLinkCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
