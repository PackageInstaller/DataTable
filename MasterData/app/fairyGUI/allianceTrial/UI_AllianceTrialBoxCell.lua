local var_0_0 = {}

var_0_0.URL = "ui://whf5j5b58llx16"

function var_0_0:__ctor()
	self.m_isSelfController = self:getController("isSelf")
	self.m_isBigController = self:getController("isBig")
	self.m_isOpenController = self:getController("isOpen")
	self.m_icon = self:getChild("icon")
	self.m_userName = self:getChild("userName")
	self.m_itemNum = self:getChild("itemNum")
	self.m_clickLoader = self:getChild("clickLoader")
	self.m_eff = self:getChild("eff")
	self.m_effBig = self:getChild("effBig")
end

return var_0_0
