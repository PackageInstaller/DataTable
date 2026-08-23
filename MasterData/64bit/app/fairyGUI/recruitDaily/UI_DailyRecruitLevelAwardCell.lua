local var_0_0 = {}

var_0_0.URL = "ui://3w60uerptdy224"

function var_0_0:__ctor()
	self.m_rewardStateController = self:getController("rewardState")
	self.m_rewardTitle = self:getChild("rewardTitle")
	self.m_curNumText = self:getChild("curNumText")
	self.m_itemList = self:getChild("itemList")
	self.m_progressText = self:getChild("progressText")
end

return var_0_0
