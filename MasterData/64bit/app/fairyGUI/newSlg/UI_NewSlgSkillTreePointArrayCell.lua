local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9k1jb969k4"

function var_0_0:__ctor()
	self.m_has_bgController = self:getController("has_bg")
	self.m_Txt_star_num = self:getChild("Txt_star_num")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_starImg = self:getChild("starImg")
	self.m_Txt_rule = self:getChild("Txt_rule")
end

var_0_0.Has_bgCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
