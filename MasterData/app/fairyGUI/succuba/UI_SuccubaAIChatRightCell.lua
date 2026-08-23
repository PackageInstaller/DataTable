local var_0_0 = {}

var_0_0.URL = "ui://qzlsgbi1uhvyx"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_userIcon = self:getChild("userIcon")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_content = self:getChild("content")
	self.m_sizeLabel = self:getChild("sizeLabel")
end

return var_0_0
