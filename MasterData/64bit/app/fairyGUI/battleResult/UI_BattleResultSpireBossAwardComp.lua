local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nku9hbmibz5"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_showUpScoreController = self:getController("showUpScore")
	self.m_showUpDamageController = self:getController("showUpDamage")
	self.m_showUpRatioController = self:getController("showUpRatio")
	self.m_scoreBTxt = self:getChild("scoreBTxt")
	self.m_upScoreBTxt = self:getChild("upScoreBTxt")
	self.m_scoreTxt = self:getChild("scoreTxt")
	self.m_upScoreTxt = self:getChild("upScoreTxt")
	self.m_damageTxt = self:getChild("damageTxt")
	self.m_ratioTxt = self:getChild("ratioTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
