local var_0_0 = {}

var_0_0.URL = "ui://a2qtbzwvc8pw2o"

function var_0_0:__ctor()
	self.m_showRedController = self:getController("showRed")
	self.m_valueTxtColorController = self:getController("valueTxtColor")
	self.m_bgIcon = self:getChild("bgIcon")
	self.m_barPic = self:getChild("barPic")
	self.m_name = self:getChild("name")
	self.m_currentValueText = self:getChild("currentValueText")
	self.m_totalValueText = self:getChild("totalValueText")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
