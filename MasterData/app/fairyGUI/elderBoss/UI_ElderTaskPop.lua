local var_0_0 = {}

var_0_0.URL = "ui://8cx1i074vtmo23"

function var_0_0:__ctor()
	self.m_tabIndexController = self:getController("tabIndex")
	self.m_tab1 = self:getChild("tab1")
	self.m_tab2 = self:getChild("tab2")
	self.m_rewardShowList = self:getChild("rewardShowList")
	self.m_progressTxt = self:getChild("progressTxt")
	self.m_oneKeyRewardBtn = self:getChild("oneKeyRewardBtn")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.TabIndexCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
