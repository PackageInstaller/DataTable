local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7osjsp"

function var_0_0:__ctor()
	self.m_emptyController = self:getController("empty")
	self.m_bgImg = self:getChild("bgImg")
	self.m_tabList = self:getChild("tabList")
	self.m_treasureList = self:getChild("treasureList")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_emptyComp = self:getChild("emptyComp")
	self.m_goToBtn = self:getChild("goToBtn")
end

var_0_0.EmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
