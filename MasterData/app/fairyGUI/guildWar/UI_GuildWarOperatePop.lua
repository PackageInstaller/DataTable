local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mjwtua"

function var_0_0:__ctor()
	self.m_colorController = self:getController("color")
	self.m_canOpeController = self:getController("canOpe")
	self.m_selectController = self:getController("select")
	self.m_showListController = self:getController("showList")
	self.m_numController = self:getController("num")
	self.m_noMemberController = self:getController("noMember")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_progressTxt = self:getChild("progressTxt")
	self.m_progressBaseTxt = self:getChild("progressBaseTxt")
	self.m_buildIcon = self:getChild("buildIcon")
	self.m_buildHpProgress = self:getChild("buildHpProgress")
	self.m_touchComp = self:getChild("touchComp")
	self.m_compBtn1 = self:getChild("compBtn1")
	self.m_compBtn2 = self:getChild("compBtn2")
	self.m_memberList = self:getChild("memberList")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.ColorCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.CanOpeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.SelectCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.ShowListCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.NumCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.NoMemberCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
