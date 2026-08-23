local var_0_0 = {}

var_0_0.URL = "ui://n47h6oagjgxu0"

function var_0_0:__ctor()
	self.m_tabSelController = self:getController("tabSel")
	self.m_rankList = self:getChild("rankList")
	self.m_dayAwardList = self:getChild("dayAwardList")
	self.m_seasonAwardList = self:getChild("seasonAwardList")
	self.m_rankPreText = self:getChild("rankPreText")
	self.m_rankText = self:getChild("rankText")
	self.m_tipsText = self:getChild("tipsText")
	self.m_dayTipsText = self:getChild("dayTipsText")
	self.m_topBarComp = self:getChild("topBarComp")
end

var_0_0.TabSelCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
