local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiqa85l4f"

function var_0_0:__ctor()
	self.m_emptyTypeController = self:getController("emptyType")
	self.m_popPanel = self:getChild("popPanel")
	self.m_bg = self:getChild("bg")
	self.m_title = self:getChild("title")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_memberList = self:getChild("memberList")
	self.m_content = self:getChild("content")
end

return var_0_0
