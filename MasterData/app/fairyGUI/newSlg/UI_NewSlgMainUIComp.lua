local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9mitv37"

function var_0_0:__ctor()
	self.m_Comp_b = self:getChild("Comp_b")
	self.m_Comp_gather = self:getChild("Comp_gather")
	self.m_Comp_gather2 = self:getChild("Comp_gather2")
	self.m_Comp_attackCityBubble = self:getChild("Comp_attackCityBubble")
	self.m_Txt_end_tips = self:getChild("Txt_end_tips")
	self.m_Txt_endTime = self:getChild("Txt_endTime")
	self.m_Group_right = self:getChild("Group_right")
	self.m_Btn_battlePass = self:getChild("Btn_battlePass")
	self.m_Comp_period = self:getChild("Comp_period")
	self.m_Comp_mini = self:getChild("Comp_mini")
	self.m_Comp_settle = self:getChild("Comp_settle")
	self.m_Btn_countDown = self:getChild("Btn_countDown")
	self.m_noticeComp = self:getChild("noticeComp")
	self.m_farmS2 = self:getChild("farmS2")
	self.m_Comp_team_info = self:getChild("Comp_team_info")
	self.m_Comp_search = self:getChild("Comp_search")
	self.m_enterTransition = self:getTransition("enter")
	self.m_sousuo_enterTransition = self:getTransition("sousuo_enter")
	self.m_sousuo_backTransition = self:getTransition("sousuo_back")
end

return var_0_0
