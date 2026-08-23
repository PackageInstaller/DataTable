local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9qdqe7w"

function var_0_0:__ctor()
	self.m_is_emptyController = self:getController("is_empty")
	self.m_typeController = self:getController("type")
	self.m_tabController = self:getController("tab")
	self.m_Comp_main = self:getChild("Comp_main")
	self.m_Tab_reward = self:getChild("Tab_reward")
	self.m_Tab_task = self:getChild("Tab_task")
	self.m_Btn_preview = self:getChild("Btn_preview")
	self.m_Comp_effect_1 = self:getChild("Comp_effect_1")
	self.m_Comp_effect_2 = self:getChild("Comp_effect_2")
	self.m_Btn_recharge = self:getChild("Btn_recharge")
	self.m_Btn_help = self:getChild("Btn_help")
	self.m_Txt_actTime = self:getChild("Txt_actTime")
	self.m_ComTopBar = self:getChild("ComTopBar")
	self.m_Comp_Eff = self:getChild("Comp_Eff")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
