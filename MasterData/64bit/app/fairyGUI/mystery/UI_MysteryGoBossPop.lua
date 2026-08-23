local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8e6vvb21"

function var_0_0:__ctor()
	self.m_touchArea = self:getChild("touchArea")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_awardList = self:getChild("awardList")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_goBattleBtn = self:getChild("goBattleBtn")
	self.m_bossNameTxt = self:getChild("bossNameTxt")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
