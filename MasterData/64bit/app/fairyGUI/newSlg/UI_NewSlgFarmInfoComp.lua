local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9icy368mo"

function var_0_0:__ctor()
	self.m_Comp_btnPlace = self:getChild("Comp_btnPlace")
	self.m_Comp_top = self:getChild("Comp_top")
	self.m_Comp_bottom = self:getChild("Comp_bottom")
	self.m_tipsComp = self:getChild("tipsComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
