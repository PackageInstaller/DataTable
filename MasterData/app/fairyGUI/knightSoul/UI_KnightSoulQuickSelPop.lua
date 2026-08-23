local var_0_0 = {}

var_0_0.URL = "ui://kwpkf9ult79858"

function var_0_0:__ctor()
	self.m_cardSelController = self:getController("cardSel")
	self.m_popPanel = self:getChild("popPanel")
	self.m_cardList = self:getChild("cardList")
	self.m_tipsText = self:getChild("tipsText")
	self.m_bagList = self:getChild("bagList")
	self.m_useBtn = self:getChild("useBtn")
	self.m_content = self:getChild("content")
end

return var_0_0
