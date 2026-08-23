local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9kual9697q"

function var_0_0:__ctor()
	self.m_isUserController = self:getController("isUser")
	self.m_hasElemController = self:getController("hasElem")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_elemBtn = self:getChild("elemBtn")
	self.m_Txt_hp = self:getChild("Txt_hp")
	self.m_Txt_authority = self:getChild("Txt_authority")
	self.m_Comp_icon1 = self:getChild("Comp_icon1")
	self.m_Comp_icon2 = self:getChild("Comp_icon2")
	self.m_Comp_icon3 = self:getChild("Comp_icon3")
	self.m_Comp_icon4 = self:getChild("Comp_icon4")
	self.m_Comp_icon5 = self:getChild("Comp_icon5")
	self.m_Comp_icon6 = self:getChild("Comp_icon6")
	self.m_Comp_army = self:getChild("Comp_army")
end

var_0_0.IsUserCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasElemCtrl = {
	has = 1,
	normal = 0
}

return var_0_0
