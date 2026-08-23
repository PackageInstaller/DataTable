local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnofg6giby2"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_isVitController = self:getController("isVit")
	self.m_placeComp = self:getChild("placeComp")
	self.m_popPanel = self:getChild("popPanel")
	self.m_buyItemIconBg = self:getChild("buyItemIconBg")
	self.m_buyItemIcon = self:getChild("buyItemIcon")
	self.m_buyItemNameBg = self:getChild("buyItemNameBg")
	self.m_buyItemNameTxt = self:getChild("buyItemNameTxt")
	self.m_buyItemLeftNumTxt = self:getChild("buyItemLeftNumTxt")
	self.m_addTimesNameTxt = self:getChild("addTimesNameTxt")
	self.m_addTimesTxt = self:getChild("addTimesTxt")
	self.m_addNumComp = self:getChild("addNumComp")
	self.m_purchaseLimitTxt = self:getChild("purchaseLimitTxt")
	self.m_currencyComp = self:getChild("currencyComp")
	self.m_useBtn = self:getChild("useBtn")
	self.m_vitResItemComp = self:getChild("vitResItemComp")
	self.m_content = self:getChild("content")
end

var_0_0.TabCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsVitCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
