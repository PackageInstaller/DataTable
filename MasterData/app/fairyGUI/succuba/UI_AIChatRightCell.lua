local var_0_0 = {}

var_0_0.URL = "ui://qzlsgbi1npac8"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_userIcon = self:getChild("userIcon")
	self.m_clickBg = self:getChild("clickBg")
	self.m_text2 = self:getChild("text2")
	self.m_chatText = self:getChild("chatText")
	self.m_serverName = self:getChild("serverName")
	self.m_nameText = self:getChild("nameText")
	self.m_levelText = self:getChild("levelText")
end

return var_0_0
