local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9qi4p2x"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_seasonController = self:getController("season")
	self.m_isFarmEmptyController = self:getController("isFarmEmpty")
	self.m_buildComp = self:getChild("buildComp")
	self.m_btnClose = self:getChild("btnClose")
	self.m_receiveBtn = self:getChild("receiveBtn")
	self.m_callBtn = self:getChild("callBtn")
	self.m_supplyTip = self:getChild("supplyTip")
	self.m_supplyList = self:getChild("supplyList")
	self.m_progBar = self:getChild("progBar")
	self.m_supplyLimit = self:getChild("supplyLimit")
	self.m_gen = self:getChild("gen")
	self.m_farmCountTxt = self:getChild("farmCountTxt")
	self.m_farmList = self:getChild("farmList")
	self.m_farm = self:getChild("farm")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.TabCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.SeasonCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsFarmEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
