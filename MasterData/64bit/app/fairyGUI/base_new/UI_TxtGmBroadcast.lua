local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepabjwkk2q6"

function var_0_0:__ctor()
	self.m_showBtnController = self:getController("showBtn")
	self.m_label = self:getChild("label")
	self.m_closeBtn = self:getChild("closeBtn")
end

var_0_0.ShowBtnCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
