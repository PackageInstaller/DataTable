local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepqzb6kk2nq"

function var_0_0:__ctor()
	self.m_hideIconController = self:getController("hideIcon")
	self.m_grayController = self:getController("gray")
	self.m_firstValueSizeController = self:getController("firstValueSize")
	self.m_isShowBgController = self:getController("isShowBg")
	self.m_nameColorController = self:getController("nameColor")
	self.m_bg = self:getChild("bg")
	self.m_icon = self:getChild("icon")
	self.m_attName = self:getChild("attName")
	self.m_firstAttValue = self:getChild("firstAttValue")
	self.m_arrow = self:getChild("arrow")
end

var_0_0.HideIconCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.GrayCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.FirstValueSizeCtrl = {
	["20"] = 0,
	["22"] = 1
}
var_0_0.IsShowBgCtrl = {
	是 = 1,
	否 = 0
}
var_0_0.NameColorCtrl = {
	白 = 0,
	黑 = 1
}

return var_0_0
