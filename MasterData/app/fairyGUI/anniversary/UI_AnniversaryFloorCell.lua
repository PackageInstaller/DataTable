local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiqt2we17"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_indexController = self:getController("index")
	self.m_bg = self:getChild("bg")
	self.m_nameText = self:getChild("nameText")
	self.m_indexLoader = self:getChild("indexLoader")
	self.m_rewardList = self:getChild("rewardList")
	self.m_getAwardBtn = self:getChild("getAwardBtn")
	self.m_getEffLoader = self:getChild("getEffLoader")
	self.m_getAwardTxt = self:getChild("getAwardTxt")
	self.m_zhezhao = self:getChild("zhezhao")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_limitNumText = self:getChild("limitNumText")
end

return var_0_0
