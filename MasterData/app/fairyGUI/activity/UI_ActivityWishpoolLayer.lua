local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wrqeoe8"

function var_0_0:__ctor()
	self.m_inFishingController = self:getController("inFishing")
	self.m_havFishController = self:getController("havFish")
	self.m_skipAnimController = self:getController("skipAnim")
	self.m_bottomBg = self:getChild("bottomBg")
	self.m_center = self:getChild("center")
	self.m_topBgHolder = self:getChild("topBgHolder")
	self.m_topBg = self:getChild("topBg")
	self.m_fishingBtn = self:getChild("fishingBtn")
	self.m_fishingTenBtn = self:getChild("fishingTenBtn")
	self.m_fishPoolBtn = self:getChild("fishPoolBtn")
	self.m_animDaily1 = self:getChild("animDaily1")
	self.m_animDaily3 = self:getChild("animDaily3")
	self.m_animDaily2 = self:getChild("animDaily2")
	self.m_dailyRewardBtn = self:getChild("dailyRewardBtn")
	self.m_fishNumTxt = self:getChild("fishNumTxt")
	self.m_yuerIcon = self:getChild("yuerIcon")
	self.m_yuerNumTxt = self:getChild("yuerNumTxt")
	self.m_yuerIcon2 = self:getChild("yuerIcon2")
	self.m_yuerNumTxt2 = self:getChild("yuerNumTxt2")
	self.m_clickFishTxt = self:getChild("clickFishTxt")
	self.m_lastTimeTxt = self:getChild("lastTimeTxt")
	self.m_progressComp = self:getChild("progressComp")
	self.m_fishingClickHandler = self:getChild("fishingClickHandler")
	self.m_fishingRodHolder = self:getChild("fishingRodHolder")
	self.m_invaildClickComp = self:getChild("invaildClickComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_skipAnimBtn = self:getChild("skipAnimBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_finishTransition = self:getTransition("finish")
	self.m_rewardTransition = self:getTransition("reward")
end

var_0_0.InFishingCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HavFishCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.SkipAnimCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
