local var_0_0 = {}

var_0_0.URL = "ui://p5u2oelkbdr80"

function var_0_0:__ctor()
	self.m_showBtnController = self:getController("showBtn")
	self.m_emptyController = self:getController("empty")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_tabList = self:getChild("tabList")
	self.m_oneKeyReceiveBtn = self:getChild("oneKeyReceiveBtn")
	self.m_oneKeyDeleteBtn = self:getChild("oneKeyDeleteBtn")
	self.m_mailContent = self:getChild("mailContent")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ShowBtnCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page3 = 3
}
var_0_0.EmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
