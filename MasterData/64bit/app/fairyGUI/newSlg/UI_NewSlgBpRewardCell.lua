local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9qdqe80"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_showController = self:getController("show")
	self.m_Txt_level = self:getChild("Txt_level")
	self.m_Comp_normalIcon = self:getChild("Comp_normalIcon")
	self.m_Comp_payIcon1 = self:getChild("Comp_payIcon1")
	self.m_Comp_payIcon2 = self:getChild("Comp_payIcon2")
	self.m_img_mask1 = self:getChild("img_mask1")
	self.m_img_mask2 = self:getChild("img_mask2")
end

return var_0_0
