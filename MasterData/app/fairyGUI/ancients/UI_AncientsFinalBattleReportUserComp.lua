local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2rh5q6g"

function var_0_0:__ctor()
	self.m_atk_user_countController = self:getController("atk_user_count")
	self.m_def_user_countController = self:getController("def_user_count")
	self.m_Comp_atk_icon1 = self:getChild("Comp_atk_icon1")
	self.m_Comp_atk_icon2 = self:getChild("Comp_atk_icon2")
	self.m_Comp_atk_icon3 = self:getChild("Comp_atk_icon3")
	self.m_Comp_def_icon1 = self:getChild("Comp_def_icon1")
	self.m_Comp_def_icon2 = self:getChild("Comp_def_icon2")
	self.m_Comp_def_icon3 = self:getChild("Comp_def_icon3")
	self.m_Comp_atk_name1 = self:getChild("Comp_atk_name1")
	self.m_Comp_atk_name2 = self:getChild("Comp_atk_name2")
	self.m_Comp_atk_name3 = self:getChild("Comp_atk_name3")
	self.m_Comp_def_name1 = self:getChild("Comp_def_name1")
	self.m_Comp_def_name2 = self:getChild("Comp_def_name2")
	self.m_Comp_def_name3 = self:getChild("Comp_def_name3")
end

var_0_0.Atk_user_countCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}
var_0_0.Def_user_countCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}

return var_0_0
