local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5c3h27bv"

function var_0_0:__ctor()
	self.m_dragStateController = self:getController("dragState")
	self.m_qualityLine = self:getChild("qualityLine")
	self.m_icon = self:getChild("icon")
	self.m_numTxt = self:getChild("numTxt")
	self.m_centerNode = self:getChild("centerNode")
	self.m_wayBtn = self:getChild("wayBtn")
end

return var_0_0
