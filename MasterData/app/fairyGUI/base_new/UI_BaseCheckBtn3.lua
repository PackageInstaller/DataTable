local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepkrx71emigcs"

function var_0_0:__ctor()
	self.m_isShowTxtController = self:getController("isShowTxt")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_clickComp = self:getChild("clickComp")
end

var_0_0.IsShowTxtCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
