local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9tvpg68eo"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_mask = self:getChild("mask")
	self.m_Comp_reward = self:getChild("Comp_reward")
	self.m_Comp_task = self:getChild("Comp_task")
	self.m_Comp_level = self:getChild("Comp_level")
	self.m_Btn_oneKey = self:getChild("Btn_oneKey")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
