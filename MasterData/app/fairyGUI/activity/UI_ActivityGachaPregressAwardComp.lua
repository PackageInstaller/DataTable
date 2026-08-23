local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wm6mjgm"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_eff = self:getChild("eff")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_itemIconMask = self:getChild("itemIconMask")
	self.m_numTxt = self:getChild("numTxt")
	self.m_timesTxt = self:getChild("timesTxt")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
