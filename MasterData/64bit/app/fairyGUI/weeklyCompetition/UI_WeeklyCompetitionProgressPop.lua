local var_0_0 = {}

var_0_0.URL = "ui://b3ojz34ou53x20"

function var_0_0:__ctor()
	self.m_isGetController = self:getController("isGet")
	self.m_popPanel = self:getChild("popPanel")
	self.m_tipText = self:getChild("tipText")
	self.m_awardList = self:getChild("awardList")
	self.m_content = self:getChild("content")
end

return var_0_0
