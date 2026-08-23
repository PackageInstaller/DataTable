local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5sih57f4"

function var_0_0:__ctor()
	self.m_numController = self:getController("num")
	self.m_styleController = self:getController("style")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_descComp = self:getChild("descComp")
	self.m_content = self:getChild("content")
end

return var_0_0
