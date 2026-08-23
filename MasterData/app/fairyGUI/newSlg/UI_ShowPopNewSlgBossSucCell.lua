local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9i6qs68lu"

function var_0_0:__ctor()
	self.m_show_bgController = self:getController("show_bg")
	self.m_is_selfController = self:getController("is_self")
	self.m_Comp_rank = self:getChild("Comp_rank")
	self.m_Txt_level = self:getChild("Txt_level")
	self.m_Comp_name = self:getChild("Comp_name")
	self.m_Txt_authority = self:getChild("Txt_authority")
	self.m_Txt_troop = self:getChild("Txt_troop")
	self.m_Txt_score = self:getChild("Txt_score")
end

var_0_0.Show_bgCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_selfCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
