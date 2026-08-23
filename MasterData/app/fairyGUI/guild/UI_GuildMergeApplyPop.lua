local var_0_0 = {}

var_0_0.URL = "ui://h35b870bbpqe5n"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_applyList = self:getChild("applyList")
	self.m_content = self:getChild("content")
end

return var_0_0
