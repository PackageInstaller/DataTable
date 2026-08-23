local var_0_0 = {}

var_0_0.URL = "ui://qzlsgbi1nc3mr"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_nameComp = self:getChild("nameComp")
	self.m_touchRect = self:getChild("touchRect")
	self.m_fragIcon = self:getChild("fragIcon")
	self.m_fragNameText = self:getChild("fragNameText")
	self.m_progText = self:getChild("progText")
	self.m_progBar = self:getChild("progBar")
	self.m_addBtn = self:getChild("addBtn")
end

return var_0_0
