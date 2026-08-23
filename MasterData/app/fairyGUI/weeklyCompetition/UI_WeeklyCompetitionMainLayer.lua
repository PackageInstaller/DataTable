local var_0_0 = {}

var_0_0.URL = "ui://b3ojz34oiurha"

function var_0_0:__ctor()
	self.m_isShowTipController = self:getController("isShowTip")
	self.m_rankComp = self:getChild("rankComp")
	self.m_awardTipBg = self:getChild("awardTipBg")
	self.m_tipText = self:getChild("tipText")
	self.m_tipRewardIcon = self:getChild("tipRewardIcon")
	self.m_tipRewardNumText = self:getChild("tipRewardNumText")
	self.m_proComp = self:getChild("proComp")
	self.m_taskList = self:getChild("taskList")
	self.m_nameText = self:getChild("nameText")
	self.m_timeText = self:getChild("timeText")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_giftBtn = self:getChild("giftBtn")
	self.m_tipScoreComp = self:getChild("tipScoreComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
