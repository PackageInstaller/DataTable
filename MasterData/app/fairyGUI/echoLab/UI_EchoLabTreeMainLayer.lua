local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1d50t1n"

function var_0_0:__ctor()
	self.m_isShowInfoController = self:getController("isShowInfo")
	self.m_scrollComp = self:getChild("scrollComp")
	self.m_infoTouch = self:getChild("infoTouch")
	self.m_infoComp = self:getChild("infoComp")
	self.m_attrBtn = self:getChild("attrBtn")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsShowInfoCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
