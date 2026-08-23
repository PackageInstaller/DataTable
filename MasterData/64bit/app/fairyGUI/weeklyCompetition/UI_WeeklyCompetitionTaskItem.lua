local var_0_0 = {}

var_0_0.URL = "ui://b3ojz34oiurhk"

function var_0_0:__ctor()
	self.m_drawStateController = self:getController("drawState")
	self.m_typeController = self:getController("type")
	self.m_isShowBgController = self:getController("isShowBg")
	self.m_finTypeController = self:getController("finType")
	self.m_descText = self:getChild("descText")
	self.m_valueNumText = self:getChild("valueNumText")
	self.m_rewardIcon = self:getChild("rewardIcon")
	self.m_rewardNumText = self:getChild("rewardNumText")
end

return var_0_0
