local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepuhfxibmf"

function var_0_0:__ctor()
	self.m_hideIconController = self:getController("hideIcon")
	self.m_attrNumController = self:getController("attrNum")
	self.m_grayController = self:getController("gray")
	self.m_firstValueSizeController = self:getController("firstValueSize")
	self.m_isShowBgController = self:getController("isShowBg")
	self.m_iconScaleController = self:getController("iconScale")
	self.m_bg = self:getChild("bg")
	self.m_customBg = self:getChild("customBg")
	self.m_customBg2 = self:getChild("customBg2")
	self.m_icon = self:getChild("icon")
	self.m_attName = self:getChild("attName")
	self.m_firstAttValue = self:getChild("firstAttValue")
	self.m_arrow = self:getChild("arrow")
	self.m_secondAttrValue = self:getChild("secondAttrValue")
end

var_0_0.HideIconCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.AttrNumCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.GrayCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.FirstValueSizeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsShowBgCtrl = {
	是 = 1,
	否 = 0
}
var_0_0.IconScaleCtrl = {
	["100"] = 0,
	["15"] = 1
}

return var_0_0
