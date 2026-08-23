local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8ebwsw3u"

function var_0_0:__ctor()
	self.m_canBattleController = self:getController("canBattle")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_bossNameTxt = self:getChild("bossNameTxt")
	self.m_recommendTxt = self:getChild("recommendTxt")
	self.m_challengeNumTxt = self:getChild("challengeNumTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_battleCountTxt = self:getChild("battleCountTxt")
	self.m_battleBtn = self:getChild("battleBtn")
	self.m_unlockDesc = self:getChild("unlockDesc")
	self.m_recordComp = self:getChild("recordComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
