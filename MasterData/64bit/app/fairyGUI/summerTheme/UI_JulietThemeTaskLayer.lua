local var_0_0 = {}

var_0_0.URL = "ui://99hn3059emj01spemeg"

function var_0_0:__ctor()
	self.m_showCDController = self:getController("showCD")
	self.m_taskList = self:getChild("taskList")
	self.m_tabList = self:getChild("tabList")
	self.m_oneKeyBtn = self:getChild("oneKeyBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_cooldown = self:getChild("cooldown")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ShowCDCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
