local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9mitv36"

function var_0_0:__ctor()
	self.m_Comp_chat = self:getChild("Comp_chat")
	self.m_seasonTaskBtn = self:getChild("seasonTaskBtn")
	self.m_Btn_find = self:getChild("Btn_find")
	self.m_BtnFirstKill = self:getChild("BtnFirstKill")
	self.m_Btn_pass = self:getChild("Btn_pass")
	self.m_Btn_team = self:getChild("Btn_team")
	self.m_Btn_attack_city = self:getChild("Btn_attack_city")
	self.m_Comp_attackCityBubble = self:getChild("Comp_attackCityBubble")
	self.m_Btn_rank = self:getChild("Btn_rank")
	self.m_Btn_shop = self:getChild("Btn_shop")
	self.m_Btn_report = self:getChild("Btn_report")
	self.m_Btn_bag = self:getChild("Btn_bag")
	self.m_Btn_last_report = self:getChild("Btn_last_report")
	self.m_Btn_mail = self:getChild("Btn_mail")
	self.m_Btn_home = self:getChild("Btn_home")
	self.m_Btn_gather = self:getChild("Btn_gather")
	self.m_effGather = self:getChild("effGather")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
