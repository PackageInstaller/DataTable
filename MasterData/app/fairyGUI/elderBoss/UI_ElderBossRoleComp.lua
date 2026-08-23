local var_0_0 = {}

var_0_0.URL = "ui://8cx1i074f98327"

function var_0_0:__ctor()
	self.m_emptyPosController = self:getController("emptyPos")
	self.m_footBg = self:getChild("footBg")
	self.m_placeHolderComp = self:getChild("placeHolderComp")
end

var_0_0.EmptyPosCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
