local var_0_0 = {}

var_0_0.URL = "ui://fu6pxbhwjxns6k"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_typeController = self:getController("type")
	self.m_rewardBtn = self:getChild("rewardBtn")
	self.m_itemList = self:getChild("itemList")
	self.m_descTxt = self:getChild("descTxt")
	self.m_progressTxt = self:getChild("progressTxt")
end

return var_0_0
