local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mkdkj12"

function var_0_0:__ctor()
	self.m_isShowBgController = self:getController("isShowBg")
	self.m_indexRank = self:getChild("indexRank")
	self.m_iconList = self:getChild("iconList")
end

var_0_0.IsShowBgCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
