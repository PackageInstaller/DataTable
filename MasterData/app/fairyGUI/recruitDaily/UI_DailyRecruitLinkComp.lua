local var_0_0 = {}

var_0_0.URL = "ui://3w60uerptdy2i"

function var_0_0:__ctor()
	self.m_qualityController = self:getController("quality")
	self.m_isPetLinkController = self:getController("isPetLink")
	self.m_knightComp = self:getChild("knightComp")
end

return var_0_0
