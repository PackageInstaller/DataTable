local var_0_0 = {}

var_0_0.URL = "ui://1b29hdofhh9b2n"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_isPayController = self:getController("isPay")
	self.m_taskTypeController = self:getController("taskType")
	self.m_tabGift = self:getChild("tabGift")
	self.m_tabTask = self:getChild("tabTask")
	self.m_newmalIcon = self:getChild("newmalIcon")
	self.m_payIcon = self:getChild("payIcon")
	self.m_payIcon2 = self:getChild("payIcon2")
	self.m_nextBigFreeReward = self:getChild("nextBigFreeReward")
	self.m_nextBigPayReward = self:getChild("nextBigPayReward")
	self.m_itemList = self:getChild("itemList")
	self.m_previewBtn = self:getChild("previewBtn")
	self.m_nextLvTxt = self:getChild("nextLvTxt")
	self.m_discountTxt = self:getChild("discountTxt")
	self.m_award = self:getChild("award")
	self.m_taskList = self:getChild("taskList")
	self.m_taskTimeTxt = self:getChild("taskTimeTxt")
	self.m_tab1 = self:getChild("tab1")
	self.m_tab2 = self:getChild("tab2")
	self.m_tab3 = self:getChild("tab3")
	self.m_task = self:getChild("task")
	self.m_upgradeBtn = self:getChild("upgradeBtn")
	self.m_oneKeyRewardBtn = self:getChild("oneKeyRewardBtn")
	self.m_rewardTransition = self:getTransition("reward")
	self.m_task_2Transition = self:getTransition("task")
end

var_0_0.TabCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsPayCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.TaskTypeCtrl = {
	page0 = 2,
	page2 = 1,
	page1 = 0
}

return var_0_0
