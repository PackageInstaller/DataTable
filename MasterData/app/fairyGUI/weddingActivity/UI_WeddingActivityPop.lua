local var_0_0 = {}

var_0_0.URL = "ui://fqn2vo16mt0bf"

function var_0_0:__ctor()
	self.m_taskStateController = self:getController("taskState")
	self.m_mask = self:getChild("mask")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_leftIconLoader = self:getChild("leftIconLoader")
	self.m_leftTxtBgLoader = self:getChild("leftTxtBgLoader")
	self.m_leftTxtLoader = self:getChild("leftTxtLoader")
	self.m_leftTxt = self:getChild("leftTxt")
	self.m_itemList = self:getChild("itemList")
	self.m_taskBgLoader = self:getChild("taskBgLoader")
	self.m_taskList = self:getChild("taskList")
	self.m_awardList = self:getChild("awardList")
	self.m_taskBtn = self:getChild("taskBtn")
	self.m_timeBgLoader = self:getChild("timeBgLoader")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_effBg = self:getChild("effBg")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
