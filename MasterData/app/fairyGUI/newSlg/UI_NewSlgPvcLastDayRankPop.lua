local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt99bkz6y"

function var_0_0:__ctor()
	self.m_bigTabController = self:getController("bigTab")
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_Comp_union = self:getChild("Comp_union")
	self.m_Comp_user = self:getChild("Comp_user")
	self.m_Btn_close = self:getChild("Btn_close")
	self.m_titleTxt = self:getChild("titleTxt")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.BigTabCtrl = {
	page0 = 1,
	page1 = 0
}

return var_0_0
