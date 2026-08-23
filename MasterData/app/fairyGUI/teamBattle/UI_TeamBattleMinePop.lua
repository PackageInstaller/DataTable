local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8le3d04f"

function var_0_0:__ctor()
	self.m_enoughController = self:getController("enough")
	self.m_closePnl = self:getChild("closePnl")
	self.m_eff = self:getChild("eff")
	self.m_title = self:getChild("title")
	self.m_mineLoader = self:getChild("mineLoader")
	self.m_descTxt = self:getChild("descTxt")
	self.m_mineBtn = self:getChild("mineBtn")
	self.m_todayNoTip = self:getChild("todayNoTip")
	self.m_costLoader = self:getChild("costLoader")
	self.m_costNumTxt = self:getChild("costNumTxt")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.EnoughCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
