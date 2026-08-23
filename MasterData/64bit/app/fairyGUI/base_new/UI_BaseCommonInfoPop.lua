local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepxlerrcr"

function var_0_0:__ctor()
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_leftComp = self:getChild("leftComp")
	self.m_placeHolderItemComp = self:getChild("placeHolderItemComp")
	self.m_tabList = self:getChild("tabList")
	self.m_placeHolderComp = self:getChild("placeHolderComp")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_lightLoader = self:getChild("lightLoader")
	self.m_placeHolderNameComp = self:getChild("placeHolderNameComp")
	self.m_placeHolderIconComp = self:getChild("placeHolderIconComp")
	self.m_openTransition = self:getTransition("open")
	self.m_closeTransition = self:getTransition("close")
end

return var_0_0
