local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9icy368n2"

function var_0_0:__ctor()
	self.m_is_selfController = self:getController("is_self")
	self.m_is_occupiedController = self:getController("is_occupied")
	self.m_Comp_icon1 = self:getChild("Comp_icon1")
	self.m_Comp_icon2 = self:getChild("Comp_icon2")
	self.m_Comp_icon3 = self:getChild("Comp_icon3")
	self.m_Comp_icon4 = self:getChild("Comp_icon4")
	self.m_Comp_name = self:getChild("Comp_name")
	self.m_Txt_hp = self:getChild("Txt_hp")
	self.m_Txt_authority = self:getChild("Txt_authority")
	self.m_Comp_playerIcon = self:getChild("Comp_playerIcon")
	self.m_Comp_army = self:getChild("Comp_army")
	self.m_Txt_armyLevel = self:getChild("Txt_armyLevel")
	self.m_Img_allianceBg = self:getChild("Img_allianceBg")
	self.m_Txt_alliance = self:getChild("Txt_alliance")
	self.m_Txt_stateDesc = self:getChild("Txt_stateDesc")
end

return var_0_0
