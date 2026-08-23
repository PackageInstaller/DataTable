local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9l84a1k"

function var_0_0:__ctor()
	self.m_has_bgController = self:getController("has_bg")
	self.m_is_baseController = self:getController("is_base")
	self.m_Txt_type = self:getChild("Txt_type")
	self.m_Txt_star_num = self:getChild("Txt_star_num")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Comp_star = self:getChild("Comp_star")
	self.m_Txt_stage_num = self:getChild("Txt_stage_num")
	self.m_starImg = self:getChild("starImg")
	self.m_Comp_army = self:getChild("Comp_army")
	self.m_Txt_level = self:getChild("Txt_level")
	self.m_Txt_rule = self:getChild("Txt_rule")
end

var_0_0.Has_bgCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_baseCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
