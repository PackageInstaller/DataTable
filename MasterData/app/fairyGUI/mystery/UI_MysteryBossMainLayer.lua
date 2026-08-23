local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8eohqs4b"

function var_0_0:__ctor()
	self.m_returnBtn = self:getChild("returnBtn")
	self.m_bossMapComp = self:getChild("bossMapComp")
	self.m_bossHpComp = self:getChild("bossHpComp")
	self.m_challengePosComp = self:getChild("challengePosComp")
	self.m_hurtRankComp = self:getChild("hurtRankComp")
	self.m_lookAwardBtn = self:getChild("lookAwardBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
