local var_0_0 = {}

var_0_0.URL = "ui://0xhekt5ief2w14"

function var_0_0:__ctor()
	self.m_effPoint = self:getChild("effPoint")
	self.m_gameComp = self:getChild("gameComp")
	self.m_effSSR = self:getChild("effSSR")
	self.m_effTitle = self:getChild("effTitle")
	self.m_luckText = self:getChild("luckText")
	self.m_effRefresh = self:getChild("effRefresh")
	self.m_skipBox = self:getChild("skipBox")
	self.m_giftBtn = self:getChild("giftBtn")
	self.m_taskBtn = self:getChild("taskBtn")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_wishBtn = self:getChild("wishBtn")
	self.m_timeText = self:getChild("timeText")
	self.m_proList = self:getChild("proList")
	self.m_timesText = self:getChild("timesText")
	self.m_oneBtn = self:getChild("oneBtn")
	self.m_tenBtn = self:getChild("tenBtn")
	self.m_mask = self:getChild("mask")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_hideTransition = self:getTransition("hide")
	self.m_revertTransition = self:getTransition("revert")
end

return var_0_0
