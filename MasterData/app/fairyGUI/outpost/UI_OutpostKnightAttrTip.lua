local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5r6dc7dk"

function var_0_0:__ctor()
	self.m_isShowExpandController = self:getController("isShowExpand")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_attrComp = self:getChild("attrComp")
	self.m_content = self:getChild("content")
end

return var_0_0
