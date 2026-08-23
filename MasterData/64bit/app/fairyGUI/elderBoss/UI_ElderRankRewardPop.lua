local var_0_0 = {}

var_0_0.URL = "ui://8cx1i074vtmo21"

function var_0_0:__ctor()
	self.m_tabIndexController = self:getController("tabIndex")
	self.m_rewardShowList = self:getChild("rewardShowList")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.TabIndexCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
