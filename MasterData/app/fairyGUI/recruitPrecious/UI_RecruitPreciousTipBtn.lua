local var_0_0 = {}

var_0_0.URL = "ui://hw835jy1s4k4f"

function var_0_0:__ctor()
	self.m_rotateController = self:getController("rotate")
	self.m_isURController = self:getController("isUR")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_titleRight = self:getChild("titleRight")
	self.m_titleDesText = self:getChild("titleDesText")
	self.m_preciousComp1 = self:getChild("preciousComp1")
	self.m_preciousComp2 = self:getChild("preciousComp2")
	self.m_preciousComp3 = self:getChild("preciousComp3")
end

return var_0_0
