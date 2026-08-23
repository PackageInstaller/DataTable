local var_0_0 = {}

var_0_0.URL = "ui://p5u2oelkbdr82t"

function var_0_0:__ctor()
	self.m_mailOperateController = self:getController("mailOperate")
	self.m_translateController = self:getController("translate")
	self.m_mailDes = self:getChild("mailDes")
	self.m_titleText = self:getChild("titleText")
	self.m_mailSourceText = self:getChild("mailSourceText")
	self.m_rewardList = self:getChild("rewardList")
	self.m_deleteBtn = self:getChild("deleteBtn")
	self.m_receiveBtn = self:getChild("receiveBtn")
	self.m_translateBtn = self:getChild("translateBtn")
	self.m_expireTimeTxt = self:getChild("expireTimeTxt")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.MailOperateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.TranslateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
