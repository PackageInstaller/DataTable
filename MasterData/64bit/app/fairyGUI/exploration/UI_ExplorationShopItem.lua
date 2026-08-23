local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25rxjj66"

function var_0_0:__ctor()
	self.m_isBetterController = self:getController("isBetter")
	self.m_isSoldOutController = self:getController("isSoldOut")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_itemPicComp = self:getChild("itemPicComp")
	self.m_qualityEffect = self:getChild("qualityEffect")
	self.m_kuangLoader = self:getChild("kuangLoader")
	self.m_starLoader1 = self:getChild("starLoader1")
	self.m_starLoader2 = self:getChild("starLoader2")
	self.m_starLoader3 = self:getChild("starLoader3")
	self.m_starLoader4 = self:getChild("starLoader4")
	self.m_starLoader5 = self:getChild("starLoader5")
	self.m_starLoader6 = self:getChild("starLoader6")
	self.m_starLoader7 = self:getChild("starLoader7")
	self.m_betterEffect = self:getChild("betterEffect")
	self.m_nameText = self:getChild("nameText")
	self.m_elementLoader = self:getChild("elementLoader")
	self.m_costComp = self:getChild("costComp")
	self.m_buyLoader = self:getChild("buyLoader")
	self.m_switchTransition = self:getTransition("switch")
end

var_0_0.IsBetterCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsSoldOutCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
