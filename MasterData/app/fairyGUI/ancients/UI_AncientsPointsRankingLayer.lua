local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2t1g244"

function var_0_0:__ctor()
	self.m_Comp_points_rank = self:getChild("Comp_points_rank")
	self.m_Txt_team_ranking = self:getChild("Txt_team_ranking")
	self.m_Txt_points = self:getChild("Txt_points")
	self.m_Txt_award = self:getChild("Txt_award")
	self.m_Btn_prize = self:getChild("Btn_prize")
	self.m_Btn_check_rewards = self:getChild("Btn_check_rewards")
	self.m_Comp_top_bar = self:getChild("Comp_top_bar")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
