local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jgu4969i7"

function var_0_0:__ctor()
	self.m_isShowInfoController = self:getController("isShowInfo")
	self.m_scrollComp = self:getChild("scrollComp")
	self.m_attrBtn = self:getChild("attrBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_pointComp = self:getChild("pointComp")
	self.m_resetBtn = self:getChild("resetBtn")
	self.m_infoComp = self:getChild("infoComp")
	self.m_eff = self:getChild("eff")
	self.m_enterTransition = self:getTransition("enter")
	self.m_switchInTransition = self:getTransition("switchIn")
	self.m_switchOutTransition = self:getTransition("switchOut")
end

var_0_0.IsShowInfoCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
