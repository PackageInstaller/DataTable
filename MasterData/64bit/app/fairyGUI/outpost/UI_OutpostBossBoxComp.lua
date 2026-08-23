local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5twfcx7i1"

function var_0_0:__ctor()
	self.m_isFirstController = self:getController("isFirst")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_destroyTime = self:getChild("destroyTime")
	self.m_name = self:getChild("name")
	self.m_dropTransition = self:getTransition("drop")
	self.m_shakeTransition = self:getTransition("shake")
end

return var_0_0
