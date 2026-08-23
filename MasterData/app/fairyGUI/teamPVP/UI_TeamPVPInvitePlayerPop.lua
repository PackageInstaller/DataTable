local var_0_0 = {}

var_0_0.URL = "ui://akds0szasmfh1d"

function var_0_0:__ctor()
	self.m_tabTypeController = self:getController("tabType")
	self.m_emptyTypeController = self:getController("emptyType")
	self.m_popPanel = self:getChild("popPanel")
	self.m_oneKeyInviteBtn = self:getChild("oneKeyInviteBtn")
	self.m_oneKeyCallBtn = self:getChild("oneKeyCallBtn")
	self.m_memberList = self:getChild("memberList")
	self.m_content = self:getChild("content")
end

return var_0_0
