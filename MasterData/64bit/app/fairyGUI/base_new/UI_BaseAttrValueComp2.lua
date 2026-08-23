local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepuhfxibmg"

function var_0_0:__ctor()
	self.m_attrNumController = self:getController("attrNum")
	self.m_grayController = self:getController("gray")
	self.m_customBg = self:getChild("customBg")
	self.m_customBg2 = self:getChild("customBg2")
	self.m_attName = self:getChild("attName")
	self.m_firstAttValue = self:getChild("firstAttValue")
	self.m_arrow = self:getChild("arrow")
	self.m_secondAttrValue = self:getChild("secondAttrValue")
	self.m_txt_leftInTransition = self:getTransition("txt_leftIn")
	self.m_txt_downInTransition = self:getTransition("txt_downIn")
end

var_0_0.AttrNumCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.GrayCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
