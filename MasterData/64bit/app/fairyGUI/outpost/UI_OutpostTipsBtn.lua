local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5rcut2a"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_showTimeController = self:getController("showTime")
	self.m_bg = self:getChild("bg")
	self.m_tipsTxt = self:getChild("tipsTxt")
	self.m_effHolder = self:getChild("effHolder")
	self.m_timeStr = self:getChild("timeStr")
end

return var_0_0
