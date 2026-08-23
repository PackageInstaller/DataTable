local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wngeye7"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_clickLoader = self:getChild("clickLoader")
	self.m_playEffect = self:getChild("playEffect")
	self.m_showList = self:getChild("showList")
	self.m_descText = self:getChild("descText")
	self.m_numText = self:getChild("numText")
	self.m_itemLoader = self:getChild("itemLoader")
end

var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
