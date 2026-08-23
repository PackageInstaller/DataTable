local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mlydfm5n"

function var_0_0:__ctor()
	self.m_emptyController = self:getController("empty")
	self.m_indexController = self:getController("index")
	self.m_userIcon = self:getChild("userIcon")
	self.m_hpProgress = self:getChild("hpProgress")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
	self.m_nameTxt = self:getChild("nameTxt")
end

var_0_0.EmptyCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.IndexCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
