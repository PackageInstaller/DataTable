local var_0_0 = {}

var_0_0.URL = "ui://whf5j5b58llx18"

function var_0_0:__ctor()
	self.m_isBigController = self:getController("isBig")
	self.m_boxTypeController = self:getController("boxType")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_itemNum = self:getChild("itemNum")
end

return var_0_0
