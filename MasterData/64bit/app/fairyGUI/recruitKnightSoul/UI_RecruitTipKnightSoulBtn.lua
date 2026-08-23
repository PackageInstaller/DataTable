local var_0_0 = {}

var_0_0.URL = "ui://cw1w6t2bwczdg"

function var_0_0:__ctor()
	self.m_hideIconController = self:getController("hideIcon")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_qualityTextLoader = self:getChild("qualityTextLoader")
	self.m_knightBtnGroup = self:getChild("knightBtnGroup")
end

return var_0_0
