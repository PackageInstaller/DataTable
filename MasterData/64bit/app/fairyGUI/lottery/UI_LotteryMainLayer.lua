local var_0_0 = {}

var_0_0.URL = "ui://kdymz22pd17pg"

function var_0_0:__ctor()
	self.m_rewardStateController = self:getController("rewardState")
	self.m_isMaxRoundController = self:getController("isMaxRound")
	self.m_layerIdle = self:getChild("layerIdle")
	self.m_layoutComp = self:getChild("layoutComp")
	self.m_timeText = self:getChild("timeText")
	self.m_bigRewardIcon = self:getChild("bigRewardIcon")
	self.m_bigRewardNumText = self:getChild("bigRewardNumText")
	self.m_nextTipText = self:getChild("nextTipText")
	self.m_nextMiniIcon = self:getChild("nextMiniIcon")
	self.m_nextTipNumText = self:getChild("nextTipNumText")
	self.m_turnBtn = self:getChild("turnBtn")
	self.m_tipText = self:getChild("tipText")
	self.m_miniIcon = self:getChild("miniIcon")
	self.m_tipNumText = self:getChild("tipNumText")
	self.m_taskBtn = self:getChild("taskBtn")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_roundText = self:getChild("roundText")
	self.m_mask = self:getChild("mask")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_oneKeyBtn = self:getChild("oneKeyBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_qiehuanTransition = self:getTransition("qiehuan")
end

return var_0_0
