local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb9693q"

function var_0_0:__ctor()
	self.m_Comp_top = self:getChild("Comp_top")
	self.m_Comp_bottom = self:getChild("Comp_bottom")
	self.m_Btn_add = self:getChild("Btn_add")
	self.m_additionComp = self:getChild("additionComp")
	self.m_tipsComp = self:getChild("tipsComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
