local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9vl5qqbs"

function var_0_0:__ctor()
	self.m_chapterController = self:getController("chapter")
	self.m_picComp = self:getChild("picComp")
	self.m_nameComp = self:getChild("nameComp")
	self.m_touch = self:getChild("touch")
end

return var_0_0
