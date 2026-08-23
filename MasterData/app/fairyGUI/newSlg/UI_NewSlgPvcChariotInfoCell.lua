local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9z25j3i"

function var_0_0:__ctor()
	self.m_hasElemController = self:getController("hasElem")
	self.m_Comp_icon1 = self:getChild("Comp_icon1")
	self.m_Comp_icon2 = self:getChild("Comp_icon2")
	self.m_Comp_icon3 = self:getChild("Comp_icon3")
	self.m_Comp_icon4 = self:getChild("Comp_icon4")
	self.m_Comp_icon5 = self:getChild("Comp_icon5")
	self.m_Comp_icon6 = self:getChild("Comp_icon6")
	self.m_Comp_name = self:getChild("Comp_name")
	self.m_elemBtn = self:getChild("elemBtn")
	self.m_Txt_hp = self:getChild("Txt_hp")
	self.m_Txt_authority = self:getChild("Txt_authority")
	self.m_Comp_army = self:getChild("Comp_army")
	self.m_alliNameTxt = self:getChild("alliNameTxt")
end

var_0_0.HasElemCtrl = {
	elem = 1,
	normal = 0
}

return var_0_0
