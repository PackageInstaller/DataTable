local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9sz9268f7"

function var_0_0:__ctor()
	self.m_bannerController = self:getController("banner")
	self.m_isCityController = self:getController("isCity")
	self.m_Comp_place = self:getChild("Comp_place")
end

var_0_0.BannerCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsCityCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
