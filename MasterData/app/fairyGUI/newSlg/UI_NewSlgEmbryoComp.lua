local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9ewxk3r"

function var_0_0:__ctor()
	self.m_is_reverseController = self:getController("is_reverse")
	self.m_card_typeController = self:getController("card_type")
	self.m_statusController = self:getController("status")
	self.m_Img_icon = self:getChild("Img_icon")
	self.m_ComRedPoint = self:getChild("ComRedPoint")
	self.m_List_point = self:getChild("List_point")
	self.m_Img_activate = self:getChild("Img_activate")
	self.m_Txt_tips = self:getChild("Txt_tips")
	self.m_Img_new = self:getChild("Img_new")
	self.m_Txt_authority = self:getChild("Txt_authority")
	self.m_Txt_authority_left = self:getChild("Txt_authority_left")
	self.m_Comp_effect = self:getChild("Comp_effect")
end

return var_0_0
