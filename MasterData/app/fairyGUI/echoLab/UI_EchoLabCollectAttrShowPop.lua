local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1abvq3r"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_listComp = self:getChild("listComp")
	self.m_content = self:getChild("content")
end

var_0_0.IsEmptyCtrl = {
	empty = 1,
	normal = 0
}

return var_0_0
