local var_0_0 = {}

var_0_0.URL = "ui://kwpkf9ulv2wr3z"

function var_0_0:__ctor()
	self.m_qualityController = self:getController("quality")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_sellList = self:getChild("sellList")
	self.m_content = self:getChild("content")
end

return var_0_0
