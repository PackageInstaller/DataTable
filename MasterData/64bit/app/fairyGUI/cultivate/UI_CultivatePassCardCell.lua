local var_0_0 = {}

var_0_0.URL = "ui://1q5ehb83e4001v"

function var_0_0:__ctor()
	self.m_indexController = self:getController("index")
	self.m_freeItem = self:getChild("freeItem")
	self.m_itemList = self:getChild("itemList")
	self.m_rewardBtn = self:getChild("rewardBtn")
	self.m_lineGraph1 = self:getChild("lineGraph1")
	self.m_lineGraph2 = self:getChild("lineGraph2")
	self.m_limitTxt = self:getChild("limitTxt")
	self.m_indexLoader = self:getChild("indexLoader")
	self.m_indexTxt = self:getChild("indexTxt")
	self.m_indexTxt2 = self:getChild("indexTxt2")
end

return var_0_0
