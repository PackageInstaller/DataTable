local var_0_0 = {}

var_0_0.URL = "ui://aeavo6obldv71"

function var_0_0:__ctor()
	self.m_isShowInfoController = self:getController("isShowInfo")
	self.m_scrollComp = self:getChild("scrollComp")
	self.m_resetBtn = self:getChild("resetBtn")
	self.m_attrBtn = self:getChild("attrBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_infoComp = self:getChild("infoComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_switchInTransition = self:getTransition("switchIn")
	self.m_switchOutTransition = self:getTransition("switchOut")
end

var_0_0.IsShowInfoCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
