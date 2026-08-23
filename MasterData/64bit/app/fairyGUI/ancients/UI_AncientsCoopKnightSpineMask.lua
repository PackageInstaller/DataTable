local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2tr4050"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_knightPH = self:getChild("knightPH")
	self.m_knightPH2 = self:getChild("knightPH2")
	self.m_Img1 = self:getChild("Img1")
	self.m_Img2 = self:getChild("Img2")
	self.m_Img3 = self:getChild("Img3")
	self.m_petImg = self:getChild("petImg")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
