local var_0_0 = {}

var_0_0.URL = "ui://1q5ehb83ijb635"

function var_0_0:__ctor()
	self.m_drawStateController = self:getController("drawState")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_name = self:getChild("name")
	self.m_descText = self:getChild("descText")
	self.m_destinNumText = self:getChild("destinNumText")
	self.m_curProgressText = self:getChild("curProgressText")
	self.m_awardList = self:getChild("awardList")
	self.m_receiveBtn = self:getChild("receiveBtn")
	self.m_lockDesc = self:getChild("lockDesc")
end

return var_0_0
