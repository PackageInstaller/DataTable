local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88opq25du"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_itemLoader = self:getChild("itemLoader")
	self.m_numTxt = self:getChild("numTxt")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
