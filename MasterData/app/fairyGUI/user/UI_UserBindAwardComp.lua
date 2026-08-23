local var_0_0 = {}

var_0_0.URL = "ui://2r646maytj702s"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_numTxt = self:getChild("numTxt")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
