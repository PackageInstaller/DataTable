local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5sp297d4"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isShowSweepController = self:getController("isShowSweep")
	self.m_isShowTimeController = self:getController("isShowTime")
	self.m_isFirstBattleController = self:getController("isFirstBattle")
	self.m_bossHolder = self:getChild("bossHolder")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_rewardList = self:getChild("rewardList")
	self.m_leftBtn = self:getChild("leftBtn")
	self.m_rightBtn = self:getChild("rightBtn")
	self.m_sweepBtn = self:getChild("sweepBtn")
	self.m_callBtn = self:getChild("callBtn")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_timeDescTxt = self:getChild("timeDescTxt")
	self.m_unlockStr = self:getChild("unlockStr")
	self.m_timeTxt = self:getChild("timeTxt")
end

return var_0_0
