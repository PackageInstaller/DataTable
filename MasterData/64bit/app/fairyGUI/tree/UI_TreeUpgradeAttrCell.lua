local var_0_0 = {}

var_0_0.URL = "ui://d5b3cu3gwzpi3o"

function var_0_0:__ctor()
	self.m_hasNewController = self:getController("hasNew")
	self.m_hideArrowController = self:getController("hideArrow")
	self.m_desc = self:getChild("desc")
	self.m_curValue = self:getChild("curValue")
	self.m_afterValue = self:getChild("afterValue")
end

return var_0_0
