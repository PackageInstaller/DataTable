local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jt0v62"

function var_0_0:__ctor()
	self.m_boss_team_emptyController = self:getController("boss_team_empty")
	self.m_contentComp = self:getChild("contentComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.Boss_team_emptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
