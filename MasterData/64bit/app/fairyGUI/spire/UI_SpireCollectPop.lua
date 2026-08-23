local var_0_0 = {}

var_0_0.URL = "ui://q8j59504n6sm2y"

function var_0_0:__ctor()
	self.m_isFreeController = self:getController("isFree")
	self.m_tipText = self:getChild("tipText")
	self.m_lastTimeText = self:getChild("lastTimeText")
	self.m_rewardList = self:getChild("rewardList")
	self.m_resComp = self:getChild("resComp")
	self.m_collectBtn = self:getChild("collectBtn")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsFreeCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
