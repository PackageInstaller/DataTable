local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o9j768p9"

function var_0_0:__ctor()
	self.m_statusController = self:getController("status")
	self.m_buildTypeController = self:getController("buildType")
	self.m_buildComp = self:getChild("buildComp")
	self.m_btnClose = self:getChild("btnClose")
	self.m_upgradeBtn = self:getChild("upgradeBtn")
	self.m_unlockTip = self:getChild("unlockTip")
	self.m_mainCityTip = self:getChild("mainCityTip")
	self.m_upgradeList = self:getChild("upgradeList")
	self.m_costList = self:getChild("costList")
	self.m_supplyTip = self:getChild("supplyTip")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.StatusCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.BuildTypeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 5
}

return var_0_0
