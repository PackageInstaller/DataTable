local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wm6mjgi"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_itemIconMask = self:getChild("itemIconMask")
	self.m_numTxt = self:getChild("numTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_lastTxt = self:getChild("lastTxt")
	self.m_selectBtn = self:getChild("selectBtn")
	self.m_changeBtn = self:getChild("changeBtn")
	self.m_fragImg = self:getChild("fragImg")
	self.m_eff = self:getChild("eff")
end

var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}

return var_0_0
