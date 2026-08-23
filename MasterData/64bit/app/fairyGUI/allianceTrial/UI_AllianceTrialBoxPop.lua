local var_0_0 = {}

var_0_0.URL = "ui://whf5j5b58llx13"

function var_0_0:__ctor()
	self.m_boxStateController = self:getController("boxState")
	self.m_popPanel = self:getChild("popPanel")
	self.m_levelList = self:getChild("levelList")
	self.m_previewBtn = self:getChild("previewBtn")
	self.m_boxList = self:getChild("boxList")
	self.m_lastCount = self:getChild("lastCount")
	self.m_openBtn = self:getChild("openBtn")
	self.m_content = self:getChild("content")
end

return var_0_0
