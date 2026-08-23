local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oj8cxfd"

function var_0_0:__ctor()
	self.m_showTipController = self:getController("showTip")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_pointList = self:getChild("pointList")
	self.m_resetBtn = self:getChild("resetBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_infoTipComp = self:getChild("infoTipComp")
	self.m_btnAddition = self:getChild("btnAddition")
	self.m_talentTab = self:getChild("talentTab")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ShowTipCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
