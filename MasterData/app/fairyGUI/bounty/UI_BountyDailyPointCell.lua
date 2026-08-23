local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfblkv24"

function var_0_0:__ctor()
	self.m_getAwardController = self:getController("getAward")
	self.m_rankComp = self:getChild("rankComp")
	self.m_userIconComp = self:getChild("userIconComp")
	self.m_userNameText = self:getChild("userNameText")
	self.m_powerText = self:getChild("powerText")
	self.m_userGroup = self:getChild("userGroup")
	self.m_itemLoader1 = self:getChild("itemLoader1")
	self.m_numText1 = self:getChild("numText1")
	self.m_itemLoader2 = self:getChild("itemLoader2")
	self.m_numText2 = self:getChild("numText2")
	self.m_awardBtn = self:getChild("awardBtn")
end

return var_0_0
