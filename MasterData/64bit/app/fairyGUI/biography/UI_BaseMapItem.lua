local var_0_0 = {}

var_0_0.URL = "ui://kgq5r794c8pwibue"

function var_0_0:__ctor()
	self.m_onfocusController = self:getController("onfocus")
	self.m_chapterLoader = self:getChild("chapterLoader")
	self.m_lockIcon = self:getChild("lockIcon")
	self.m_chapterNumText = self:getChild("chapterNumText")
	self.m_line = self:getChild("line")
end

return var_0_0
