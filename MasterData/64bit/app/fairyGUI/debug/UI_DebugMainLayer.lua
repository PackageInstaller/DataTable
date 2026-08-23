local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7ypcau3q"

function var_0_0:__ctor()
	self.m_isHideTabController = self:getController("isHideTab")
	self.m_holderComp = self:getChild("holderComp")
	self.m_tabList = self:getChild("tabList")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_switchBtn = self:getChild("switchBtn")
end

var_0_0.IsHideTabCtrl = {
	hide = 1,
	show = 0
}

return var_0_0
