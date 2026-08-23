local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnk1qqrcm"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_timesController = self:getController("times")
	self.m_popPanel = self:getChild("popPanel")
	self.m_awardList = self:getChild("awardList")
	self.m_backBtnComp = self:getChild("backBtnComp")
	self.m_content = self:getChild("content")
	self.m_touchComp = self:getChild("touchComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.TimesCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
