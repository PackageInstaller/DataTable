local var_0_0 = {}

var_0_0.URL = "ui://1q5ehb83n9b9w"

function var_0_0:__ctor()
	self.m_colorTypeController = self:getController("colorType")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_iconBgLoader = self:getChild("iconBgLoader")
	self.m_itemLoader = self:getChild("itemLoader")
	self.m_lineLoader = self:getChild("lineLoader")
	self.m_textLoader = self:getChild("textLoader")
	self.m_rewardBtn = self:getChild("rewardBtn")
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_timeDiGraph = self:getChild("timeDiGraph")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_freeRewardBgLoader = self:getChild("freeRewardBgLoader")
	self.m_freeRewardList = self:getChild("freeRewardList")
	self.m_freeRewardTxt = self:getChild("freeRewardTxt")
	self.m_rewardBgLoader = self:getChild("rewardBgLoader")
	self.m_payRewardList = self:getChild("payRewardList")
	self.m_payRewardTxt = self:getChild("payRewardTxt")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
