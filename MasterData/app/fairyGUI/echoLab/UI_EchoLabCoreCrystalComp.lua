local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1hlay3j"

function var_0_0:__ctor()
	self.m_moreAttrController = self:getController("moreAttr")
	self.m_eff = self:getChild("eff")
	self.m_lvTxt = self:getChild("lvTxt")
	self.m_attrIconLoader1 = self:getChild("attrIconLoader1")
	self.m_descTxt1 = self:getChild("descTxt1")
	self.m_upEff = self:getChild("upEff")
	self.m_attrIconLoader2 = self:getChild("attrIconLoader2")
	self.m_descTxt2 = self:getChild("descTxt2")
	self.m_lookBtn = self:getChild("lookBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.MoreAttrCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
